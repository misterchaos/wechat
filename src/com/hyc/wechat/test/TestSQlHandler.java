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

package com.hyc.wechat.test;

import com.hyc.wechat.dao.FriendDao;
import com.hyc.wechat.dao.UserDao;
import com.hyc.wechat.factory.proxy.DaoProxyFactory;
import com.hyc.wechat.model.po.Friend;
import com.hyc.wechat.model.po.User;

import java.math.BigInteger;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 测试SQLHandler
 * @date 2019-05-01 17:50
 */
public class TestSQlHandler {
    public static void main(String[] args) {
        UserDao userDao = (UserDao) new DaoProxyFactory().getProxyInstance(UserDao.class);
        User user = new User();
        user.setName("test");
        userDao.insert(user);
        user= userDao.getUserById("50");
        List list = userDao.listByName("test");
        System.out.println(list);

        FriendDao friendDao = (FriendDao) new DaoProxyFactory().getProxyInstance(FriendDao.class);
        Friend friend  = new Friend();
        friend.setAlias("test");
        friend.setUserId(new BigInteger("13"));
        friend.setFriendId(new BigInteger("13"));
        friend.setGroupId(new BigInteger("0"));

        friendDao.insert(friend);
    }
}
