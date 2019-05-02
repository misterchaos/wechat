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

import com.hyc.wechat.controller.Controller;
import com.hyc.wechat.controller.provider.Provider;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class ControllerImpl implements Controller {

    /**
     * 用来装载provider的容器
     */
    private Map<String, Provider> providerMap = new HashMap<>();
    private static ControllerImpl ourInstance = new ControllerImpl();

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
    public void doPost(HttpServletRequest req, HttpServletResponse resp) {
        String url = req.getRequestURI();
        Set<String> keys = providerMap.keySet();
        for (String key : keys) {
            //解析注解中的path信息，匹配ActionProvider
            String path = providerMap.get(key).getPath();
            if (url.equalsIgnoreCase(path)) {
                providerMap.get(key).doAction(req, resp);
            }
        }
    }

    /**
     * 用于将一个provider注册到Controller中
     *
     * @param name     provider的名字
     * @param provider provider对象
     * @name registerProvider
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Override
    public Provider registerProvider(String name, Provider provider) {
        return providerMap.put(name, provider);
    }

    /**
     * 用于将一个provider从controller中移除
     *
     * @param name provider的名字
     * @name registerProvider
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Override
    public Provider removeProvider(String name) {
        return providerMap.remove(name);
    }

    public static ControllerImpl getInstance() {
        return ourInstance;
    }

    private ControllerImpl() {
    }

    public Map<String, Provider> getProviderMap() {
        return providerMap;
    }

    public void setProviderMap(Map<String, Provider> providerMap) {
        this.providerMap = providerMap;
    }


}
