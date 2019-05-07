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

import com.hyc.wechat.service.UserService;
import com.hyc.wechat.service.impl.UserServiceImpl;

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

    }
}
