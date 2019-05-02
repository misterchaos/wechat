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
     * @return 返沪传入的用户的对象
     */
    ServiceResult insertUser(User user);

    /**
     * @param user
     * @return
     */
    ServiceResult login(User user);
}
