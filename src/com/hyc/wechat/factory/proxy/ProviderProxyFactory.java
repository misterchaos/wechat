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

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Serializable;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 用于代理controller
 * @date 2019-05-02 09:40
 */
public class ProviderProxyFactory implements InvocationHandler {

    private Object target;



    public Object getProxyInstance(Class targetInterface,Object target) {
        this.target=target;
        return Proxy.newProxyInstance(target.getClass().getClassLoader(),
                new Class[]{Servlet.class, ServletConfig.class, Serializable.class, targetInterface}, this);
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        if ("doAction".equalsIgnoreCase(method.getName())) {
            HttpServletRequest req = (HttpServletRequest) args[0];
            //TODO
            System.out.println("请求参数"+req.getQueryString()+" 请求："+req.getRequestURI());
            String action = req.getParameter("method");
            Method actions = target.getClass().getMethod(action, HttpServletRequest.class, HttpServletResponse.class);
            return actions.invoke(target, args);
        }
        if("getTarget".equalsIgnoreCase(method.getName())){
            return this.target;
        }

        return method.invoke(target, args);
    }

    public Object getTarget() {
        return target;
    }

    public void setTarget(Object target) {
        this.target = target;
    }
}
