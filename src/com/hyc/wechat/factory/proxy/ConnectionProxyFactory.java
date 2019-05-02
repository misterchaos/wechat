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

import com.hyc.wechat.dao.DataSource;
import com.hyc.wechat.exception.DaoException;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 用于代理数据库连接对象
 * @date 2019-05-01 17:52
 */
public class ConnectionProxyFactory implements InvocationHandler {

    private Connection target;
    private DataSource dataSource;

    public Connection getProxyInstance(Connection target){
        this.target= target;
        return (Connection) Proxy.newProxyInstance(Connection.class.getClassLoader(),new Class[]{Connection.class},this);
    }

    public ConnectionProxyFactory(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) {
        if ("close".equals(method.getName())) {
            //调用代理对象的close方法时，将目标对象放回数据库连接池
            dataSource.freeConnection(target);
            return null;
        }
        try {
            return method.invoke(target, args);
        } catch (IllegalAccessException | InvocationTargetException e) {
            throw new DaoException("无法调用目标对象的方法", e);
        }
    }

    public Connection getTarget() {
        return target;
    }

    public void setTarget(Connection target) {
        this.target = target;
    }

    public DataSource getDataSource() {
        return dataSource;
    }

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }
}
