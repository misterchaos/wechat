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

package com.hyc.wechat.factory.proxy;

import com.hyc.wechat.controller.annotation.ActionProvider;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.LinkedList;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 用于代理controller
 * @date 2019-05-02 09:40
 */
public class ControllerProxyFactory implements InvocationHandler {

    private List<com.hyc.wechat.controller.Provider> providers = new LinkedList();

    public void addProvider(com.hyc.wechat.controller.Provider provider){
        this.providers.add(provider);
    }

    public Object getProxyInstance(Class targetInterface) {
        return Proxy.newProxyInstance(targetInterface.getClassLoader(),
                new Class[]{Servlet.class, ServletConfig.class, Serializable.class, targetInterface}, this);
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        if ("getProvider".equalsIgnoreCase(method.getName())) {
            HttpServletRequest req = (HttpServletRequest) args[0];
            HttpServletResponse resp = (HttpServletResponse) args[1];
            //TODO
            System.out.println("请求参数"+req.getQueryString()+" 请求："+req.getRequestURI());
            String url = req.getRequestURI();
            if(url.equalsIgnoreCase("/user")){
                for (com.hyc.wechat.controller.Provider provider: providers) {
                    ActionProvider actionProvider1 = provider.getClass().getAnnotation(ActionProvider.class);
                    String path = provider.getTarget().getClass().getAnnotation(ActionProvider.class).path();
                    System.out.println("provider路径："+path);
                    if(url.equalsIgnoreCase(path)){
                        provider.doAction(req,resp);
                    }
                }
            return null;
            }
        }
        return null;
    }

}
