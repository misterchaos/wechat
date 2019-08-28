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
 * @description 用于枚举消息的类型
 * @date 2019-05-13 11:29
 */
public enum MessageType {
    /**
     * 用户之间的文本消息
     */
    USER,
    /**
     * 图片消息
     */
    IMG,
    /**
     * 文件消息
     */
    FILE,
    /**
     * 加好友通知
     */
    FRIEND;
    @Override
    public String toString() {
        return super.toString().toLowerCase();
    }

    }
