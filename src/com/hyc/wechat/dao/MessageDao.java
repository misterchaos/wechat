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

package com.hyc.wechat.dao;

import com.hyc.wechat.dao.annotation.Query;
import com.hyc.wechat.dao.annotation.Result;
import com.hyc.wechat.dao.annotation.ResultType;
import com.hyc.wechat.model.po.Message;
import com.hyc.wechat.model.po.User;

import java.math.BigInteger;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 用于message表的CRUD
 * @date 2019-05-03 13:06
 */
public interface MessageDao extends BaseDao {

    String TABLE = "message";
    String ALL_FIELD = "sender_id,chat_id,content,type,time," + BASE_FIELD;

    /**
     * 通过发送id和聊天id查询一个消息
     *
     * @param senderId 发送者id
     * @param chatId   聊天id
     * @return 成员对象
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Result(entity = Message.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where sender_id = ? and chat_id = ? and time = ? ")
    Message getMessageBySenderIdAndChatIdAndTime(BigInteger senderId, BigInteger chatId,Object time);



    /**
     * 查询最近插入的一个用户
     *
     * @return 用户对象
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Result(entity = User.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where id = last_insert_id()  ")
    User getLastInsert();


    /**
     * 通过用户id和聊天id并按时间顺序查询用户的所有消息记录
     *
     * @param userId 用户id
     * @param chatId 聊天id
     * @param limit 每页查询记录数
     * @param offset 起始记录数
     * @name listMessageByUserIdAndChatId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Result(entity = Message.class, returns = ResultType.LIST)
    @Query(value = "select m.id, m.sender_id, m.chat_id, m.content , m.type , m.time ,m.status , " +
            "m.gmt_create, m.gmt_modified from " + TABLE + " as m , record as r where m.id = r.message_id" +
            " and r.user_id = ? and m.chat_id = ? order by m.time limit ? offset ?  ")
    List<Message> listMessageByUserIdAndChatId(Object userId, Object chatId,int limit,int offset);


    /**
     * 通过用户id和聊天id并按时间顺序查询用户的所有消息记录
     *
     * @param userId 用户id
     * @param chatId 聊天id
     * @param limit 每页查询记录数
     * @param offset 起始记录数
     * @name listMessageByUserIdAndChatId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Result(entity = Message.class, returns = ResultType.LIST)
    @Query(value = "select m.id, m.sender_id, m.chat_id, m.content , m.type , m.time ,m.status , " +
            "m.gmt_create, m.gmt_modified from " + TABLE + " as m , record as r where m.id = r.message_id" +
            " and r.user_id = ? and m.chat_id = ? order by m.time desc limit ? offset ?  ")
    List<Message> listMessageByUserIdAndChatIdDesc(Object userId, Object chatId,int limit,int offset);

    /**
     * 通过用户id和聊天id查询用户的所有未读消息记录
     *
     * @param userId 用户id
     * @param chatId 聊天id
     * @param limit 每页查询记录数
     * @param offset 起始记录数
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Result(entity = Message.class, returns = ResultType.LIST)
    @Query(value = "select m.id, m.sender_id, m.chat_id, m.content , m.type , m.time ,m.status , " +
            "m.gmt_create, m.gmt_modified from " + TABLE + " as m , record as r where m.id = r.message_id" +
            " and r.user_id = ? and m.chat_id = ? and r.status = 0 order by m.time limit ? offset ?  ")
    List<Message> listUnreadMessage(Object userId, Object chatId,int limit,int offset);



    /**
     * 通过用户id查询用户的所有未读消息记录
     *
     * @param userId 用户id
     * @param limit 每页查询记录数
     * @param offset 起始记录数
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Result(entity = Message.class, returns = ResultType.LIST)
    @Query(value = "select m.id, m.sender_id, m.chat_id, m.content , m.type , m.time ,m.status , " +
            "m.gmt_create, m.gmt_modified from " + TABLE + " as m , record as r where m.id = r.message_id" +
            " and r.user_id = ?  and r.status = 0  order by m.time desc  limit ? offset ? ")
    List<Message> listUnreadMessageByUserId(Object userId,int limit,int offset);

}
