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
public class DaoProxyFactory implements InvocationHandler {

    private static SQLRunner executor = new SQLRunnerImpl();
    private static DaoProxyFactory instance= new DaoProxyFactory();

    public Object getProxyInstance(Class interfaces) {
        return Proxy.newProxyInstance(interfaces.getClassLoader(), new Class[]{interfaces}, this);
    }

    private DaoProxyFactory() {

    }

    public static DaoProxyFactory getInstance(){
        return instance;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        if (method.getAnnotation(Insert.class) != null) {
            //默认没有sql语句，使用直接插入对象的方法
            if ("".equalsIgnoreCase(method.getAnnotation(Insert.class).value())) {
                Object obj = args[0];
                return executor.insert(obj, obj.getClass().getAnnotation(Table.class).name());
            } else {
                return executor.executeUpdate(method.getDeclaredAnnotation(Insert.class).value(), args);
            }
        }
        if (method.getAnnotation(Update.class) != null) {
            //默认没有sql语句，使用直接更新对象的方法
            if ("".equalsIgnoreCase(method.getAnnotation(Update.class).value())) {
                Object obj = args[0];
                return executor.update(obj, obj.getClass().getAnnotation(Table.class).name());
            } else {
                return executor.executeUpdate(method.getDeclaredAnnotation(Update.class).value(), args);
            }
        }
        if (method.getAnnotation(Delete.class) != null) {
            //默认没有sql语句，使用直接删除对象的方法
            if ("".equalsIgnoreCase(method.getAnnotation(Delete.class).value())) {
                Object obj = args[0];
                return executor.delete(obj, obj.getClass().getAnnotation(Table.class).name());
            } else {
                return executor.executeUpdate(method.getDeclaredAnnotation(Delete.class).value(), args);
            }
        }
        if (method.getAnnotation(Query.class) != null) {
            ResultType type = method.getAnnotation(Result.class).returns();
            switch (type) {
                case OBJECT:
                    return executor.queryObject(method.getAnnotation(Query.class).value(), args, method.getAnnotation(Result.class).entity());
                case LIST:
                    return executor.queryList(method.getAnnotation(Query.class).value(), args, method.getAnnotation(Result.class).entity());
                case VALUE:
                    return executor.queryValue(method.getAnnotation(Query.class).value(), args);
                default:
            }
        }
        return method.invoke(proxy, args);
    }


}
