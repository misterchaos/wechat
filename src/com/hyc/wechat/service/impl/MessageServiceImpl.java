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

package com.hyc.wechat.service.impl;

import com.hyc.wechat.dao.ChatDao;
import com.hyc.wechat.dao.MemberDao;
import com.hyc.wechat.dao.MessageDao;
import com.hyc.wechat.dao.RecordDao;
import com.hyc.wechat.exception.DaoException;
import com.hyc.wechat.exception.ServiceException;
import com.hyc.wechat.factory.DaoProxyFactory;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.*;
import com.hyc.wechat.service.MessageService;

import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责提供消息和聊天记录的服务
 * @date 2019-05-07 14:35
 */
public class MessageServiceImpl implements MessageService {


    ChatDao chatDao = (ChatDao) DaoProxyFactory.getInstance().getProxyInstance(ChatDao.class);
    MessageDao messageDao = (MessageDao) DaoProxyFactory.getInstance().getProxyInstance(MessageDao.class);
    RecordDao recordDao = (RecordDao) DaoProxyFactory.getInstance().getProxyInstance(RecordDao.class);
    MemberDao memberDao = (MemberDao) DaoProxyFactory.getInstance().getProxyInstance(MemberDao.class);

    /**
     * 将一条消息存入数据库，同时给聊天中的所有成员生成一份聊天记录
     *
     * @param message 要插入的消息
     * @name insertMessage
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public void insertMessage(Message message) {
        try {
            //将消息插入数据库
            if (messageDao.insert(message) != 1) {
                throw new ServiceException("无法将消息插入数据库：" + message.toString());
            }
            message = messageDao.getMessageBySenderIdAndChatId(message.getSenderId(), message.getChatId());
            //对每条消息给聊天中所有成员产生消息记录

            //加载用户所在的所有聊天中的所有成员,给所有成员插入记录
            List<Member> memberList = memberDao.listMemberByChatId(message.getChatId());
            for (Member member : memberList) {
                Record record = new Record();
                record.setMessageId(message.getId());
                record.setUserId(member.getUserId());
                if (recordDao.insert(record) != 1) {
                    throw new ServiceException("无法将记录插入数据库：" + record.toString());
                }
            }
        } catch (DaoException e) {
            e.printStackTrace();
            throw new ServiceException(e);
        }
    }

    /**
     * 获取一个用户在一个聊天中的所有消息记录，不包括被删除的消息记录
     *
     * @param user 用户
     * @param chat 聊天
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult listAllMessage(User user, Chat chat) {
        return null;
    }

    /**
     * 获取一个用户在一个聊天中的所有未读的消息
     *
     * @param user
     * @param chat
     * @name listUnreadMessage
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult listUnreadMessage(User user, Chat chat) {
        return null;
    }

    /**
     * 将一条消息从一个用户的消息记录中移除，并不会删除这条消息
     *
     * @param message 要移除的消息记录
     * @param user
     * @name removeMessage
     * @notice 本方法没有将消息删除，只是将该用户的对应这条消息的记录删除，</br>
     * 其他拥有这条消息的记录的用户依然可以访问这条消息
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult removeMessage(Message message, User user) {
        return null;
    }

    /**
     * 将一个用户在一个聊天中收到的消息记录设置为已读
     *
     * @param user 用户
     * @param chat 记录所在聊天
     * @name setAlreadyRead
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult setAlreadyRead(User user, Chat chat) {
        return null;
    }
}
