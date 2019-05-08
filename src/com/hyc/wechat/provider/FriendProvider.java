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

package com.hyc.wechat.provider;

import com.hyc.wechat.controller.constant.RequestMethod;
import com.hyc.wechat.factory.ServiceProxyFactory;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.Chat;
import com.hyc.wechat.model.po.Friend;
import com.hyc.wechat.model.po.Member;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.provider.annotation.Action;
import com.hyc.wechat.provider.annotation.ActionProvider;
import com.hyc.wechat.service.ChatService;
import com.hyc.wechat.service.FriendService;
import com.hyc.wechat.service.constants.ServiceMessage;
import com.hyc.wechat.service.constants.Status;
import com.hyc.wechat.service.impl.ChatServiceImpl;
import com.hyc.wechat.service.impl.FriendServiceImpl;
import com.hyc.wechat.util.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;

import static com.hyc.wechat.service.constants.Status.ERROR;
import static com.hyc.wechat.util.BeanUtils.jsonToJavaObject;
import static com.hyc.wechat.util.ControllerUtils.returnJsonObject;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责好友相关业务流程
 * @date 2019-05-06 07:11
 */
@ActionProvider(path = "/friend")
public class FriendProvider extends Provider {
    FriendService friendService = (FriendService) new ServiceProxyFactory().getProxyInstance(new FriendServiceImpl());
    ChatService chatService = (ChatService) new ServiceProxyFactory().getProxyInstance(new ChatServiceImpl());

    @Action(method = RequestMethod.ADD_DO)
    public void addFriend(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Friend friend = (Friend) jsonToJavaObject(req.getInputStream(),Friend.class);
        ServiceResult result;
        //如果重复添加，这里将插入失败
        result = friendService.addFriend(friend);
        if (ERROR.equals(result.getStatus())) {
            returnJsonObject(resp, result);
            return;
        }
        if (friendService.isFriend(friend)) {
            //添加好友后判断是否对方也将自己添加为好友，如果双向添加，则建立聊天关系
            Chat chat = new Chat();
            //这里查到双向添加好友说明对方先加我为好友，聊天所有者为对方
            chat.setOwnerId(friend.getFriendId());
            chat = (Chat) chatService.createChat(chat).getData();
            //创建两个成员，将双方加入聊天中
            Member member1 = new Member();
            member1.setUserId(friend.getUserId());
            member1.setChatId(chat.getId());
            Member member2 = new Member();
            member2.setUserId(friend.getFriendId());
            member2.setChatId(chat.getId());
            chatService.joinChat(new Member[]{member1, member2});
        }
        returnJsonObject(resp, result);
    }

    @Action(method = RequestMethod.LIST_DO)
    public void listFriend(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("user_id");
        ServiceResult result;
        result = friendService.listFriend(new BigInteger(userId));
        returnJsonObject(resp, result);
    }

    @Action(method = RequestMethod.DELETE_DO)
    public void deleteFriend(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String friendId = req.getParameter("friend_id");
        String userId = req.getParameter("user_id");
        ServiceResult result;
        //删除好友之前将聊天关系移除,请求中的好友对象只含有userId和friendId，所以需要重新获取
        Friend friend = friendService.getByUidAndFriendId(new BigInteger(userId) ,new BigInteger(friendId));
        if(friend==null){
            result= new ServiceResult();
            result.setMessage(ServiceMessage.FRIEND_NOT_EXIST.message);
            result.setStatus(ERROR);
            returnJsonObject(resp,result);
            return;
        }
        //调用聊天服务将聊天关系解除
        Chat chat = new Chat();
        chat.setId(friend.getChatId());
        chatService.removeChat(chat);
        result = friendService.removeFriend(friend);
        returnJsonObject(resp, result);
    }

}
