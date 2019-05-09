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

import com.hyc.wechat.dao.ChatDao;
import com.hyc.wechat.dao.MessageDao;
import com.hyc.wechat.dao.MomentDao;
import com.hyc.wechat.dao.UserDao;
import com.hyc.wechat.factory.DaoProxyFactory;
import com.hyc.wechat.model.po.Moment;
import com.hyc.wechat.model.po.News;
import com.hyc.wechat.model.po.User;

import java.math.BigInteger;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 测试SQLHandler
 * @date 2019-05-01 17:50
 */
public class TestDao {
    public static void main(String[] args) {
        UserDao userDao = (UserDao) DaoProxyFactory.getInstance().getProxyInstance(UserDao.class);
        User user = new User();
        user.setName("testasdf中文");
        userDao.insert(user);
        user = userDao.getUserById("50");
        List list = userDao.listLikeName("%昵称%");
        System.out.println("查询到记录：" + list.size() + "条");
        ChatDao chatDao = (ChatDao) DaoProxyFactory.getInstance().getProxyInstance(ChatDao.class);
        chatDao.toFriendChat("4", "123");
        Moment moment = new Moment();
        moment.setOwnerId(BigInteger.valueOf(0));
        moment.setContent("一条朋友圈");
        moment.setLove(10L);
        MomentDao momentDao = (MomentDao) DaoProxyFactory.getInstance().getProxyInstance(MomentDao.class);
        momentDao.insert(moment);

        MessageDao messageDao = (MessageDao) DaoProxyFactory.getInstance().getProxyInstance(MessageDao.class);
        messageDao.listMessageByUserIdAndChatId("0","0",10,1000);

        News news = new News();
    }
}
