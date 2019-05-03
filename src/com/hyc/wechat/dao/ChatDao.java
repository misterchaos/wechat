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
import com.hyc.wechat.model.po.Chat;
import com.hyc.wechat.model.po.User;

import java.math.BigInteger;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责聊天表的CRUD
 * @date 2019-05-03 02:18
 */
public interface ChatDao extends BaseDao{

    String TABLE = "chat";
    String ALL_FIELD = "owner_id,name,member,"+BASE_FIELD;

    /**
     * 通过聊天id查询一个聊天
     *
     * @param id 聊天id
     * @return 聊天对象
     * @name getChatById
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Result(entity = Chat.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where id = ? ")
    Chat getChatById(BigInteger id);
}
