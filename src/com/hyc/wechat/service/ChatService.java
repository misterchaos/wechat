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
import com.hyc.wechat.model.po.Chat;
import com.hyc.wechat.model.po.Member;
import com.hyc.wechat.model.po.User;

import java.math.BigInteger;

/**
 * @author <a href="mailto:kobe5243 48@gmail.com">黄钰朝</a>
 * @description 提供聊天相关的服务
 * @date 2019-05-03 13:26
 */
public interface ChatService {

    /**
     * 创建一个聊天,如果是群聊，必须指定外部唯一标识（群号），如果是私聊则自动使用uuid作为唯一标识
     *
     * @param isGroupChat 是否为群聊
     * @param chat        要创建的聊天对象
     * @return 返回传入的聊天对象
     * @name createChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/3
     */
    ServiceResult createChat(Chat chat, boolean isGroupChat);

    /**
     * 把用户添加到聊天中
     *
     * @param members 要添加的成员对象
     * @return 返回传入的成员对象
     * @name joinChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/3
     */
    ServiceResult joinChat(Member[] members);

    /**
     * 通过群号将一个用户添加到群聊中
     *
     * @param userId 用户id
     * @param number 群号
     * @name joinChatByNumber
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    ServiceResult joinChatByNumber(BigInteger userId, String number);

    /**
     * 把成员从聊天中移除，如果该成员是聊天的最后一个成员</br>
     * 就将该聊天一并删除
     *
     * @param members 要移除的成员对象
     * @return 返回移除的成员对象
     * @name quitChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/3
     */
    ServiceResult quitChat(Member[] members);

    /**
     * 返回一个用户的所有聊天
     *
     * @param user 用户对象
     * @return 该用户的所有聊天
     * @name listChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/3
     */
    ServiceResult listChat(User user);

    /**
     * 删除一个聊天
     *
     * @param chat
     * @return
     * @name removeChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    void removeChat(Chat chat);

    /**
     * 通过聊天编号查询聊天
     *
     * @param number 聊天编号
     * @name getChatByNumber
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    void getChatByNumber(Object number);

    /**
     * 查询一个聊天中所有成员的信息
     *
     * @param chatId 聊天id
     * @name listMember
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/10
     */
    ServiceResult listMember(BigInteger chatId);

}
