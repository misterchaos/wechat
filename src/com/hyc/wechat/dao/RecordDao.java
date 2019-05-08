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

import com.hyc.wechat.dao.annotation.Update;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责消息记录CRUD
 * @date 2019-05-06 21:41
 */
public interface RecordDao extends BaseDao {
    String TABLE = "record";
    String ALL_FIELD = "user_id,message_id," + BASE_FIELD;


    /**
     * 一次性更新一个用户在一个聊天中所有记录的状态
     *
     * @param status 记录状态
     * @param userId 用户id
     * @param chatId 聊天id
     * @name updateStatusInChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Update("update " + TABLE + " as r inner join message as m set r.status = ? where r.user_id = ? and m.chat_id = ?")
    void updateStatusInChat(Object status, Object userId ,Object chatId);
}
