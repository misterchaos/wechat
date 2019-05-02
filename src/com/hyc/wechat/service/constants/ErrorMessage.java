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

package com.hyc.wechat.service.constants;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 用于描述错误信息
 * @date 2019-05-02 22:27
 */
public enum ErrorMessage{
    /**
     * 邮箱格式不合法
     */
    EMAIL_FORMAT_INCORRECT("您输入的邮箱格式不正确，邮箱只能由英文字母/数字组成,且域名符合规则"),
    /**
     * 邮箱已被注册
     */
    EMAIL_ALREADY_USED("该邮箱已被注册！"),
    /**
     * 密码不符合要求
     */
    INVALID_PASSWORD("您的密码不符合要求，密码必须是6~20位英文字母/数字/下划线组成");

    public String message;

    ErrorMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    private void setMessage(String message) {
        this.message = message;
    }
}