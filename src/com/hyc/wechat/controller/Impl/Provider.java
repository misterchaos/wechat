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

package com.hyc.wechat.controller.Impl;

import com.hyc.wechat.controller.annotation.Action;
import com.hyc.wechat.controller.annotation.ActionProvider;
import com.hyc.wechat.controller.constant.RequestMethod;
import com.hyc.wechat.util.ControllerUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 所有ActionProvider的父类，提供共有的doAction方法
 * @date 2019-05-02 11:39
 */
public abstract class Provider {


    /**
     * 负责将请求转发到对应的Action
     *
     * @param req  请求
     * @param resp 响应
     * @name doAction
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    public void doAction(HttpServletRequest req, HttpServletResponse resp) {
        try {
            RequestMethod requestMethod = ControllerUtils.valueOf(req.getParameter("method"));
            Method[] methods = this.getClass().getMethods();
            for (Method m : methods) {
                Action action = m.getAnnotation(Action.class);
                if (action != null && action.method().equals(requestMethod)) {
                    m.invoke(this, req, resp);
                }
            }
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }
    }


    /**
     * 返回这个Provider的url映射路径
     *
     * @name getPath
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    public String getPath() {
        return this.getClass().getAnnotation(ActionProvider.class).path();
    }
}
