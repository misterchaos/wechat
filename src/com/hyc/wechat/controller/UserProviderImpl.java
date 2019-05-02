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

package com.hyc.wechat.controller;

import com.hyc.wechat.controller.annotation.Action;
import com.hyc.wechat.controller.annotation.ActionProvider;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.service.Impl.UserServiceImpl;
import com.hyc.wechat.service.UserService;
import com.hyc.wechat.util.BeanUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 用于处理用户相关业务流程
 * @date 2019-05-02 10:07
 */
@ActionProvider(path = "/user")
public class UserProviderImpl implements UserProvider {

    @Override
    @Action(method = "register.do")
    public void register(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) BeanUtils.toObject(req.getParameterMap(),User.class);
        UserService userService = new UserServiceImpl();
        userService.register(user);
        resp.getWriter().write("注册成功");
    }

}
