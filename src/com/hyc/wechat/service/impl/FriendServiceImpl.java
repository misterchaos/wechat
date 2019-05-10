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

import com.hyc.wechat.dao.FriendDao;
import com.hyc.wechat.dao.UserDao;
import com.hyc.wechat.exception.DaoException;
import com.hyc.wechat.factory.DaoProxyFactory;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.Friend;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.service.FriendService;
import com.hyc.wechat.service.constants.ServiceMessage;
import com.hyc.wechat.service.constants.Status;

import java.util.LinkedList;
import java.util.List;

import static com.hyc.wechat.service.constants.ServiceMessage.*;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责提供好友相关服务
 * @date 2019-05-06 07:07
 */
public class FriendServiceImpl implements FriendService {
    private final FriendDao friendDao = (FriendDao) DaoProxyFactory.getInstance().getProxyInstance(FriendDao.class);
    private final UserDao userDao = (UserDao) DaoProxyFactory.getInstance().getProxyInstance(UserDao.class);

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
    @Override
    synchronized public ServiceResult addFriend(Friend friend) {
        if (friend == null) {
            return new ServiceResult(Status.ERROR, PARAMETER_NOT_ENOUGHT.message, friend);
        }
        //检查是否是2个用户
        if(friend.getFriendId().equals(friend.getUserId())){
            return new ServiceResult(Status.ERROR, CANNOT_ADD_YOURSELF.message, friend);
        }
        //检查是否已经是好友
        if(isFriend(friend)){
            return new ServiceResult(Status.ERROR, ALREADY_FRIEND.message, friend);
        }
        try {
            //检查是否添加过好友，不可重复添加
            if (friendDao.gerFriendByUIDAndFriendId(friend.getUserId(), friend.getFriendId()) != null) {
                return new ServiceResult(Status.ERROR, ALREADY_ADD_FRIEND.message, friend);
            }
            //检查好友是否存在
            if (userDao.getUserById(friend.getFriendId()) == null) {
                return new ServiceResult(Status.ERROR, FRIEND_NOT_EXIST.message, friend);
            }
            //检查用户是否存在
            if (userDao.getUserById(friend.getUserId()) == null) {
                return new ServiceResult(Status.ERROR, ACCOUNT_NOT_FOUND.message, friend);
            }
            //设置好友默认备注为好友昵称
            if (friend.getAlias() == null) {
                User friendUser = userDao.getUserById(friend.getFriendId());
                friend.setAlias(friendUser.getName());
            }
            //添加好友
            if (friendDao.insert(friend) != 1) {
                return new ServiceResult(Status.ERROR, DATABASE_ERROR.message, friend);
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, DATABASE_ERROR.message, friend);
        }
        return new ServiceResult(Status.SUCCESS, ADD_FRIEND_SUCCESS.message, friend);
    }

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
    @Override
    public ServiceResult listFriend(Object userId) {
        if (userId == null) {
            return new ServiceResult(Status.ERROR, PARAMETER_NOT_ENOUGHT.message, null);
        }
        List<Friend> friendList=new LinkedList<>();
        try {
            List<Friend> list = friendDao.listByUserId(userId);
            //只返回双向添加为好友的关系
            for (Friend friend:list) {
                if(isFriend(friend)){
                    friendList.add(friend);
                }
            }
            if (friendList == null || friendList.size() == 0) {
                return new ServiceResult(Status.SUCCESS, ServiceMessage.NO_FRIEND_NOW.message, userId);
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, userId);
        }
        return new ServiceResult(Status.SUCCESS, null, friendList);
    }

    /**
     * 更新好友信息
     *
     * @param friend 朋友
     * @name updateFriend
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    @Override
    public ServiceResult updateFriend(Friend friend) {
        if (friend == null) {
            return new ServiceResult(Status.ERROR, PARAMETER_NOT_ENOUGHT.message, null);
        }
        try {
            //检查成员是否存在
            if (friendDao.getFriendById(friend.getId()) == null) {
                return new ServiceResult(Status.ERROR, FRIEND_NOT_EXIST.message, friend);
            }
            if (friendDao.update(friend) != 1) {
                return new ServiceResult(Status.ERROR, DATABASE_ERROR.message, friend);
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, friend);
        }
        return new ServiceResult(Status.SUCCESS, UPDATE_FRIEND_SUCCESS.message, friend);
    }

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
    @Override
   synchronized public ServiceResult removeFriend(Friend friend) {
        if (friend == null) {
            return new ServiceResult(Status.ERROR, PARAMETER_NOT_ENOUGHT.message, friend);
        }
        try {
            //检查成员是否存在
            if (friendDao.gerFriendByUIDAndFriendId(friend.getUserId(), friend.getFriendId()) != null) {
                //将该成员从聊天中移除
                if (friendDao.delete(friend) != 1) {
                    return new ServiceResult(Status.ERROR, DATABASE_ERROR.message, friend);
                }
                //将对方的的朋友记录也删除
                friend = friendDao.gerFriendByUIDAndFriendId(friend.getFriendId(), friend.getUserId());
                if (friendDao.delete(friend) != 1) {
                    return new ServiceResult(Status.ERROR, DATABASE_ERROR.message, friend);
                }
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, friend);
        }
        return new ServiceResult(Status.SUCCESS, ServiceMessage.DELETE_FRIEND_SUCCESS.message, friend);
    }

    /**
     * 判断是否存在一条这样的朋友记录
     *
     * @param friend 判断该朋友关系是否是双向的
     * @name isFriend
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    @Override
    public boolean isFriend(Friend friend) {

        try {
            Friend reverseFriend = friendDao.gerFriendByUIDAndFriendId(friend.getFriendId(), friend.getUserId());
            if (reverseFriend == null) {
                //反向查询没有结果则是单向的
                return false;
            }
        } catch (DaoException e) {
            e.printStackTrace();
        }
        return true;
    }

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
    @Override
    public Friend getByUidAndFriendId(Object uid, Object friendId) {
        Friend friend = null;
        try {
            friend = friendDao.gerFriendByUIDAndFriendId(uid, friendId);
        } catch (DaoException e) {
            e.printStackTrace();
        }
        return friend;
    }
}
