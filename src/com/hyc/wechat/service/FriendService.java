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
import com.hyc.wechat.model.po.Friend;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责好友相关服务
 * @date 2019-05-06 05:57
 */
public interface FriendService {
    /**
     * 添加好友关系
     *
     * @param friend 要添加的好友关系
     * @return
     * @name addFriend
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    ServiceResult addFriend(Friend friend);

    /**
     * 返回一个用户的好友列表
     *
     * @param userId 用户id
     * @return
     * @name listFriend
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    ServiceResult listFriend(Object userId);

    /**
     * 更新好友信息
     *
     * @param friend 朋友
     * @name updateFriend
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    ServiceResult updateFriend(Friend friend);



    /**
     * 移除好友
     *
     * @param friend 要移除的好友关系
     * @return
     * @name removeFriend
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    ServiceResult removeFriend(Friend friend);

    /**
     * 判断是否存在一条这样的朋友记录
     *
     * @param friend 判断该朋友关系是否是双向的
     * @name isFriend
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    boolean isFriend(Friend friend);

    /**
     * 通过用户id和朋友id查询朋友关系
     *
     * @param uid      用户id
     * @param friendId 朋友id
     * @return
     * @name getByUidAndFriendId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    Friend getByUidAndFriendId(Object uid, Object friendId);

}
