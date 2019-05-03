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
public enum ServiceMessage {

    /*
     **************************************************************
     *              用户服务错误消息
     **************************************************************
     */


    /**
     * 邮箱格式不合法
     */
    EMAIL_FORMAT_INCORRECT("您输入的邮箱格式不正确，邮箱只能由英文字母/数字组成,且域名符合规则"),
    /**
     * 邮箱已被注册
     */
    EMAIL_ALREADY_USED("该邮箱已被注册！"),
    /**
     * 密码不正确
     */
    PASSWORD_INCORRECT("您输入的密码不正确，请重新输入或尝试找回密码"),

    /**
     * 账号不存在
     */
    ACCOUNT_NOT_FOUND("该微信账号不存在，请检查您的输入是否正确"),
    /**
     * 微信号已存在
     */
    WECHAT_ID_USED("您输入的微信号已被占用，请重新输入"),
    /**
     * 微信号不合法
     */
    WECHAT_ID_INVALID("您输入的微信号不符合要求，请重新输入"),
    /**
     * 密码不符合要求
     */
    INVALID_PASSWORD("您的密码不符合要求，密码必须是6~20位英文字母/数字/下划线组成"),
    /**
     * 找不到用户信息
     */
    NO_USER_INFO("找不到该用户的信息，请检查该用户是否登陆"),
    /**
     * 更新用户信息失败
     */
    UPDATE_USER_FAILED("更新用户信息失败，请重试"),

    /*
     **************************************************************
     *              用户服务成功消息
     **************************************************************
     */
    /**
     * 注册信息符合要求
     */
    REGISTER_INFO_VALID("您的注册信息符合要求，可以继续注册"),
    /**
     * 注册成功
     */
    REGISTER_SUCCESS("您已经注册成功，请记住您的密码，使用邮箱号进行登陆"),

    /**
     * 登陆成功
     */
    LOGIN_SUCCESS("登陆成功，欢迎回来"),

    /**
     * 用户名有效
     */
    WECHAT_ID_VALID("该微信号有效且未被占用"),
    /**
     * 获取个人信息成功
     */
    GET_INFO_SUCCESS("获取个人信息成功"),
    /**
     * 更新个人信息成功
     */
    UPDATE_INFO_SUCCESS("更新个人信息成功"),


    /*
     **************************************************************
     *              聊天服务失败消息
     **************************************************************
     */
    /**
     * 发起聊天失败
     */
    CREATE_CHAT_FAILED("发起聊天失败，您无法与对方进行聊天"),
    /**
     * 加入聊天失败
     */
    JOIN_CHAT_FAILED("加入聊天失败"),
    /**
     * 聊天不存在
     */
    CHAT_NOT_FOUND("该聊天不存在"),
    /**
     * 用户已存在于聊天
     */
    MEMBER_ALREADY_EXIST("该成员已经在此聊天中，不可重复添加"),
    /**
     * 聊天中没有该成员
     */
    MEMBER_NOT_FOUND("此聊天中没有该成员"),
    /**
     * 退出聊天失败
     */
    QUIT_CHAT_FAILED("退出聊天失败，请重试"),
    /*
     **************************************************************
     *              聊天服务成功消息
     **************************************************************
     */
    /**
     * 创建聊天成功
     */
    CREATE_CHAT_SUCCESS("发起聊天成功，快向对方打个招呼吧！"),
    /**
     * 加入聊天成功
     */
    JOIN_CHAT_SUCCESS("加入聊天成功"),
    /**
     * 退出聊天成功
     */
    QUIT_CHAT_SUCCESS("退出聊天成功，以后你将收不到该聊天的任何信息"),
    /*
     **************************************************************
     *              系统消息
     **************************************************************
     */
    /**
     * 系统故障
     */
    SYSTEM_EXECEPTION("系统发生了故障，无法正常提供服务");

    public String message;

    ServiceMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    private void setMessage(String message) {
        this.message = message;
    }
}