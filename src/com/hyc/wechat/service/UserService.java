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
import com.hyc.wechat.model.po.User;

import java.math.BigInteger;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 负责提供用户服务
 * @date 2019-05-02 02:18
 */
public interface UserService {
    /**
     * 检查注册用户的信息是否有效
     *
     * @param user 用户对象
     * @return 返回传入时的对象
     */
    ServiceResult checkRegister(User user);

    /**
     * 添加一个用户账号
     *
     * @param user 用户对象
     * @return 返回传入的用户的对象
     */
    ServiceResult insertUser(User user);

    /**
     * 校验用户的密码
     *
     * @param user 用户对象
     * @return 返回传入的用户对象
     */
    ServiceResult checkPassword(User user);

    /**
     * 校验用户名（微信号），是否合法，是否已被占用
     *
     * @param wechatId 微信号
     * @return 返回传入的用户名
     */
    ServiceResult checkWechatId(String wechatId);

    /**
     * 通过用户id获取用户个人信息
     *
     * @param id 用户id
     * @return 返回用户的个人信息
     */
    ServiceResult getUser(Object id);


    /**
     * 更新用户的个人信息,不包括密码，邮箱
     *
     * @param user 用户对象
     * @return 返回传入的用户对象，如果由密码信息/邮箱信息，将被清空
     */
    ServiceResult updateUser(User user);

    /**
     * 更新用户的个人密码
     *
     * @param oldPwd 旧密码
     * @param newPwd 新密码
     * @param userId 用户id
     * @return 返回传入的用户对象，如果由密码信息/邮箱信息，将被清空
     */
    ServiceResult updatePwd(String oldPwd, String newPwd , BigInteger userId);

    /**
     * 返回昵称与传入参数相似的用户列表
     *
     * @param name 用户昵称
     * @return
     * @name listUserLikeName
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    ServiceResult listUserLikeName(String name);

    /**
     * 创建一个游客账号，并自动通过登陆
     *
     * @name visitorLogin
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    ServiceResult visitorLogin();



}
