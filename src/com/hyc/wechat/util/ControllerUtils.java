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

package com.hyc.wechat.util;

import com.hyc.wechat.controller.constant.RequestMethod;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 控制层工具类
 * @date 2019-05-02 17:35
 */
public class ControllerUtils {


    /**
     * 返回请求中method对应的RequestMethod枚举项
     * @param name 请求中的method参数值
     * @name valueOf
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/4/20
     * @see RequestMethod
     */
    public static RequestMethod valueOf(String name) {
            name=name.toUpperCase().replaceAll("\\.", "_");
            try {
                return RequestMethod.valueOf(name);
            }catch (IllegalArgumentException|NullPointerException e){
                //此处异常表明请求参数没有匹配到任何服务,为无效请求
                return RequestMethod.INVALID_REQUEST;
            }
    }
}

