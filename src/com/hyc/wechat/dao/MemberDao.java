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
import com.hyc.wechat.model.po.Member;

import java.math.BigInteger;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 用于user_chat表的CRUD
 * @date 2019-05-03 13:05
 */
public interface MemberDao extends BaseDao {
    String TABLE = "member";
    String ALL_FIELD = "user_id,chat_id,group_alias,background,level," + BASE_FIELD;

    /**
     * 通过成员id查询一个成员
     *
     * @param id 成员id
     * @return 成员对象
     * @name getMemberById
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Result(entity = Member.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where id = ? ")
    Member getMemberById(Object id);

    /**
     * 通过用户id和聊天id查询一个成员
     *
     * @param userId 用户id
     * @param chatId 聊天id
     * @return 成员对象
     * @name getMemberByUIdAndChatId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Result(entity = Member.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where user_id = ? and chat_id = ? ")
    Member getMemberByUIdAndChatId(BigInteger userId, BigInteger chatId);


    /**
     * 返回一个聊天中的所有成员
     * @name listMemberByChatId
     * @param chatId 聊天id
     * @return
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/5
     */
    @Result(entity = Member.class, returns = ResultType.LIST)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where chat_id = ? ")
    List<Member> listMemberByChatId(Object chatId);

}
