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

import java.math.BigInteger;

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
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where sender_id = ? and chat_id = ? ")
    Message getMessageBySenderIdAndChatId(BigInteger senderId, BigInteger chatId);


}
