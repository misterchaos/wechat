/*
 * Copyright (c) 2019.  黄钰朝
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.hyc.wechat.server;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hyc.wechat.dao.*;
import com.hyc.wechat.factory.DaoProxyFactory;
import com.hyc.wechat.factory.ServiceProxyFactory;
import com.hyc.wechat.model.builder.MessageVOBuilder;
import com.hyc.wechat.model.po.Chat;
import com.hyc.wechat.model.po.Member;
import com.hyc.wechat.model.po.Message;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.model.vo.MessageVO;
import com.hyc.wechat.service.MessageService;
import com.hyc.wechat.service.impl.MessageServiceImpl;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import static com.hyc.wechat.util.StringUtils.toLegalText;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 用于提供实时聊天服务
 * @date 2019-05-04 00:28
 */
@ServerEndpoint("/server/chat/{user}")
public class ChatServer {

    /*
     **************************************************************
     *              静态类变量，负责记录系统数据
     **************************************************************
     */

    private static final MessageService MESSAGE_SERVICE = (MessageService) new ServiceProxyFactory().getProxyInstance(new MessageServiceImpl());
    private static final UserDao USER_DAO = (UserDao) DaoProxyFactory.getInstance().getProxyInstance(UserDao.class);
    private static final ChatDao CHAT_DAO = (ChatDao) DaoProxyFactory.getInstance().getProxyInstance(ChatDao.class);
    private static final MessageDao MESSAGE_DAO = (MessageDao) DaoProxyFactory.getInstance().getProxyInstance(MessageDao.class);
    private static final MemberDao MEMBER_DAO = (MemberDao) DaoProxyFactory.getInstance().getProxyInstance(MemberDao.class);
    private static final RecordDao RECORD_DAO = (RecordDao) DaoProxyFactory.getInstance().getProxyInstance(RecordDao.class);
    private static final Map<String, ChatServer> SERVER_MAP = new HashMap<>();
    /**
     * 用于记录当前系统在线用户人数
     */
    private static int onlineCount = 0;


    /*
     **************************************************************
     *              负责记录连接用户的数据
     **************************************************************
     */

    private Session session;
    private User user;

    /**
     * 这个集合装载所有与该用户具有聊天关系的用户成员集合，onOpen方法执行时装载
     */
    private final Map<String, Member> memberMap = new HashMap<>();
    /**
     * 负责定时将用户的消息队列存入数据库
     */
    private final MessageTask messageTask = new MessageTask();

    @OnOpen
    public void onOpen(Session session, @PathParam("user") String userId) {
        //装载用户数据，作为缓存
        this.session = session;
        this.user = USER_DAO.getUserById(userId);
        if (user == null) {
            try {
                this.session.getBasicRemote().sendText("当前用户不存在");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        //启动一个消息队列缓存
        ScheduledExecutorService service = new ScheduledThreadPoolExecutor(1);
        service.scheduleAtFixedRate(this.messageTask, 0,3, TimeUnit.SECONDS);
        //加载用户所在的所有聊天中的所有成员
        List<Chat> chatList = CHAT_DAO.listByUserId(userId);
        for (Chat chat : chatList) {
            List<Member> list = MEMBER_DAO.listMemberByChatId(chat.getId());
            for (Member member : list) {
                if (!String.valueOf(member.getUserId()).equals(userId)) {
                    //将除了自己的所有成员加入容器
                    memberMap.put(String.valueOf(member.getUserId()), member);
                }
            }
        }
        //将用户id对应的对象装载到Map容器
        SERVER_MAP.put(userId, this);
        onlineCount++;
        System.out.println("有新连接加入！当前在线人数为" + onlineCount);
        System.out.println("当前系统用户：" + userId);
    }

    @OnMessage
    public void onMessage(String msg, Session session) throws IOException {
        System.out.println("来自客户端的消息:" + msg);

        //客户段上传到服务器是Message,服务器发送到客户端是MessageVo
        Message message = JSON.toJavaObject(JSON.parseObject(msg), Message.class);
        //先过滤消息内容
        message.setContent(toLegalText(message.getContent()));
        if(message.getContent().trim().isEmpty()){
            return;
        }
        //向消息的接收者发送消息
        sendMessage(message);
        //将po对象加入消息存储队列
        this.messageTask.enQueue(message);
    }


    @OnClose
    public void onClose() {
        //关闭时先将消息队列存入数据库
        this.messageTask.run();
        //将用户从Map容器移除
        SERVER_MAP.remove(this.user.getId());
        onlineCount--;
        System.out.println("有一连接关闭！当前在线人数为" + onlineCount);
    }

    @OnError
    public void onError(Session session, Throwable error) {
        //先将消息队列存入数据库
        this.messageTask.run();
        System.out.println("发生错误");
        error.printStackTrace();
    }


    /**
     * 将用户的消息定时插入到数据库，同时插入生成的消息记录
     *
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @notice none
     * @date 2019/5/7
     */
    private class MessageTask extends TimerTask {
        /**
         * 消息队列，用户发送的消息先缓存在这里，连接关闭时插入数据库
         */
        private Queue<Message> messageQueue = new ConcurrentLinkedQueue<>();

        /**
         * 将一条消息加入到队列中
         *
         * @param message
         * @name enQueue
         * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
         * @date 2019/5/7
         */
        public void enQueue(Message message) {
            this.messageQueue.add(message);
        }

        @Override
        public void run() {
            for (Message message : this.messageQueue) {
                //将消息插入数据库，并从队列移除
                MESSAGE_SERVICE.insertMessage(message);
                this.messageQueue.remove();
            }
        }
    }

    /**
     * 向与用户处于同一个聊天中的成员包括用户自己发送一条消息
     *
     * @param message 消息
     * @name sendMessage
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    private void sendMessage(Message message) throws IOException {
        //创建vo对象(使用建造者模式的链式调用)
        MessageVO messageVo = new MessageVOBuilder().setSenderId(this.user.getId())
                .setSenderName(this.user.getName()).setChatId(message.getChatId())
                .setContent(message.getContent()).setSenderPhoto(this.user.getPhoto())
                .setTime(message.getTime()).setType(message.getType()).build();
        String jsonString = JSONObject.toJSONString(messageVo);
        //先发给自己
        this.session.getBasicRemote().sendText(jsonString);
        //遍历与用户具有聊天关系的集合，将消息发给指定用户，如果在线则发送消息
        Set<String> keys = memberMap.keySet();
        for (String key : keys) {
            Member member = memberMap.get(key);
            //当该成员处于消息对应的聊天中时给他发送消息
            if (member.getChatId().equals(message.getChatId())) {
                ChatServer server = SERVER_MAP.get(String.valueOf(member.getUserId()));
                if (server != null) {
                    try {
                        server.session.getBasicRemote().sendText(jsonString);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }


}
