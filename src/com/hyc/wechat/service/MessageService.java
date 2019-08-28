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

package com.hyc.wechat.service;

import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.Message;

import java.math.BigInteger;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责提供消息保存，聊天记录管理的服务
 * @date 2019-05-07 11:15
 */
public interface MessageService {

    /**
     * 将一条消息存入数据库，同时给聊天中的所有成员生成一份聊天记录
     *
     * @param message 要插入的消息
     * @name insertMessage
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    void insertMessage(Message message);

    /**
     * 获取一个用户在一个聊天中的所有消息记录，不包括被删除的消息记录
     *
     * @param userId 用户id
     * @param chatId 聊天id
     * @param page   页数
     * @return
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult listAllMessage(Object userId, Object chatId, int page);

    /**
     * 获取一个用户在一个聊天中的所有未读的消息
     *
     * @param userId 用户id
     * @param chatId 聊天id
     * @param page   页数
     * @name listUnreadMessage
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult listUnreadMessage(Object userId, Object chatId, int page);


    /**
     * 获取一个用户的所有未读的消息
     *
     * @param userId 用户id
     * @param page   页数
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult listAllUnreadMessage(Object userId, int page);

    /**
     * 将一条消息从一个用户的消息记录中移除，并不会删除这条消息
     *
     * @param userId    用户id
     * @param messageId 要移除的消息记录id
     * @name removeMessage
     * @notice 本方法没有将消息删除，只是将该用户的对应这条消息的记录删除，</br>
     * 其他拥有这条消息的记录的用户依然可以访问这条消息
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult removeMessage(BigInteger userId, BigInteger messageId);


    /**
     * 删除一个用户在一个聊天中的所有记录
     *
     * @param userId 用户id
     * @param chatId 要移除的消息记录的聊天id
     * @name removeAllMessage
     * @notice 本方法没有将消息删除，只是将该用户的对应这条消息的记录删除，</br>
     * 其他拥有这条消息的记录的用户依然可以访问这条消息
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult removeAllMessage(BigInteger userId, BigInteger chatId);

    /**
     * 导出一个用户在一个聊天中的所有消息记录，返回文件名
     *
     * @param userId 用户id
     * @param chatId 聊天id
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult exportMessage(Object userId, Object chatId);


    /**
     * 撤回一条消息
     *
     * @param userId    用户id
     * @param messageId 消息id
     * @name drawMessage
     * @notice 这个方法会将消息删除
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult drawBackMessage(BigInteger userId, BigInteger messageId);




    /**
     * 将一个用户在一个聊天中收到的消息记录设置为已读
     *
     * @param userId 用户id
     * @param chatId 聊天id
     * @name setAlreadyRead
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    void setAlreadyRead(Object userId, Object chatId);
}
