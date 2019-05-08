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

import com.hyc.wechat.model.po.Message;
import com.hyc.wechat.model.po.Moment;
import com.hyc.wechat.service.MessageService;
import com.hyc.wechat.service.MomentService;
import com.hyc.wechat.service.UserService;
import com.hyc.wechat.service.impl.MessageServiceImpl;
import com.hyc.wechat.service.impl.MomentServiceImpl;
import com.hyc.wechat.service.impl.UserServiceImpl;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 测试服务层
 * @date 2019-05-06 06:43
 */
public class TestService {
    public static void main(String[] args) {
        UserService userService = new UserServiceImpl();
        List list = (List) userService.listUserLikeName("昵称").getData();
        System.out.println("查询到："+list.size());

        MessageService messageService = new MessageServiceImpl();
        Message message = new Message();
        message.setChatId(BigInteger.valueOf(44));
        message.setSenderId(BigInteger.valueOf(0));
        message.setContent("测试");
        Timestamp timestamp = new Timestamp(1234);
        message.setTime(new Timestamp(1111111111));
        messageService.insertMessage(message);
        messageService.listAllMessage(0,40,1);
        messageService.listUnreadMessage(0,40,1);
        messageService.setAlreadyRead(0,40);

        MomentService momentService = new MomentServiceImpl();
        Moment moment =new Moment();
        moment.setUserId(BigInteger.valueOf(0));
        moment.setContent("第一条朋友圈");
        momentService.insertMoment(moment);
        momentService.removeMoment(BigInteger.valueOf(8));
        momentService.listMyMoment(BigInteger.valueOf(0),1);
        momentService.listNews(BigInteger.valueOf(184),1);

    }
}
