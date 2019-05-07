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

package com.hyc.wechat.controller.constant;

/**
 * request中method的枚举常量
 *
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program XHotel
 * @description
 * @date 2019-04-18 12:45
 */

public enum RequestMethod {

    /**
     * 显示主页
     */
    INDEX_VIEW,

    /**
     * 无效请求
     */

    INVALID_REQUEST,
    /*
     **************************************************************
     *               用户功能模块
     **************************************************************
     */
    /**
     * 执行登陆方法
     */
    LOGIN_DO,
    /**
     * 执行注册方法
     */
    REGISTER_DO,
    /**
     * 执行退出登陆方法
     */
    LOGOUT_DO,

    /*
     **************************************************************
     *               聊天功能模块
     **************************************************************
     */
    /**
     * 加入聊天
     */
    JOIN_DO,
    /**
     * 退出聊天
     */
    QUIT_DO,



    /*
     **************************************************************
     *               好友功能模块
     **************************************************************
     */


    /*
     **************************************************************
     *               通用操作方法
     **************************************************************
     */
    /**
     * 上传
     */
    UPLOADPHOTO_DO,
    /**
     * 添加
     */
    ADD_DO,
    /**
     * 删除
     */
    DELETE_DO,
    /**
     * 更新
     */
    UPDATE_DO,
    /**
     * 查找一个对象
     */
    GET_DO,
    /**
     * 查找对象集合
     *
     */
    LIST_DO;

    @Override
    public String toString() {
        return super.toString().toLowerCase().replaceAll("_", ".");
    }


}

