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

package com.hyc.wechat.factory;

import com.hyc.wechat.dao.SQLRunner;
import com.hyc.wechat.dao.annotation.*;
import com.hyc.wechat.dao.impl.SQLRunnerImpl;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 用于解析Dao接口中的sql语句，并执行
 * @date 2019-05-01 11:01
 */
public class ServiceProxyFactory implements InvocationHandler {

    private static ServiceProxyFactory instance= new ServiceProxyFactory();

    public Object getProxyInstance(Class interfaces) {
        return Proxy.newProxyInstance(interfaces.getClassLoader(), new Class[]{interfaces}, this);
    }

    private ServiceProxyFactory() {

    }

    public static ServiceProxyFactory getInstance(){
        return instance;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {

        return method.invoke(proxy, args);
    }


}
