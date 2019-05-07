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

package com.hyc.wechat.controller.impl.servlet;

import com.hyc.wechat.controller.annotation.ControllerConfig;
import com.hyc.wechat.provider.Provider;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.Set;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 接收客户端请求，将其转发到controller
 * @date 2019-05-02 03:28
 */
@ControllerConfig(path = "/wechat")
public class MyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        this.doPost(req, resp);
    }

    /**
     * 负责将请求转发到url对应的Provider
     *
     * @param req  请求
     * @param resp 响应
     * @name doPost
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Provider>providerMap = (Map<String, Provider>) getServletContext().getAttribute("providerMap");
        String url = req.getRequestURI();
        String contextPath = this.getClass().getAnnotation(ControllerConfig.class).path();
        Set<String> keys = providerMap.keySet();
        for (String key : keys) {
            //解析注解中的path信息，匹配ActionProvider
            String path = contextPath + providerMap.get(key).getPath();
            if (url.equalsIgnoreCase(path)) {
                providerMap.get(key).doAction(req, resp);
            }
        }
    }


}


