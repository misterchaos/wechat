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
import com.hyc.wechat.model.po.Friend;

import java.math.BigInteger;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 负责朋友表CRUD
 * @date 2019-05-02 01:59
 */
public interface FriendDao extends BaseDao {

    String ALL_FIELD = "user_id,friend_id,chat_id,group_id,photo,alias,description," + BASE_FIELD;
    String TABLE = "friend";

    /**
     * 通过用户id和朋友id获取一条好友记录
     *
     * @param userId   用户id
     * @param friendId 朋友id
     * @return
     * @name gerFriendByUIDAndFriendId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    @Result(entity = Friend.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where user_id = ? and friend_id = ? ")
    Friend gerFriendByUIDAndFriendId(Object userId, Object friendId);


    /**
     * 通过用户id查询好友列表
     *
     * @param userId 用户id
     * @return
     * @name listByUserId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    @Result(entity = Friend.class, returns = ResultType.LIST)
    @Query(value = "select f.id,f.user_id,f.friend_id,f.chat_id,f.group_id,f.alias,f.description,u.photo as photo,f.status,f.gmt_create,f.gmt_modified " +
            "from " + TABLE + " as f,user as u where f.user_id = ? and u.id = f.friend_id ")
    List listByUserId(Object userId);
}
