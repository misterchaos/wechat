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

import com.alibaba.fastjson.JSONObject;
import com.hyc.wechat.dao.impl.SQLRunnerImpl;
import com.hyc.wechat.model.po.User;
import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.util.LinkedList;
import java.util.Map;

import static com.hyc.wechat.util.ReflectUtils.getFields;
import static com.hyc.wechat.util.ReflectUtils.getMethods;
import static com.hyc.wechat.util.StringUtils.toLegalText;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 用于将请求参数映射为Javabean对象
 * @date 2019-04-15 00:47
 */
public class BeanUtils {

    /**
     * 负责将request中的parameterMap映射成为一个对象
     *
     * @param map   request中的getParameterMap返回的Map
     * @param clazz 映射的目标类，将返回该类的一个实例
     * @return java.lang.Object
     * @name toObject
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/4/15
     */
    public static Object toObject(Map<String, String[]> map, Class clazz) {
        /**
         * 本方法仅用来将request中的参数映射为对象，并不承担<br>
         * 数据检查的职责，因此本方法中产生的异常没有打印堆栈信息
         */

        LinkedList<Method> methods = null;
        LinkedList<Field> fields = null;
        Object obj;
        try {
            obj = clazz.newInstance();
            methods = getMethods(obj);
            fields = getFields(obj);
        } catch (InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
            throw new RuntimeException("无法实例化类：" + clazz.getName());
        }


        for (Field f : fields) {
            /**
             * 获取每个属性的String类型参数的构造器
             */
            Constructor cons = null;
            try {
                cons = f.getType().getConstructor(String.class);
            } catch (Exception e) {
                /**
                 * 某些属性确实没有这种构造器，在这里不需要处理这个问题
                 */
                Logger logger = Logger.getLogger(BeanUtils.class);
                logger.debug("从请求参数转化成对象时缺少String类型的构造器 ： " +f.getName() );
            }
            /**
             * 构造属性
             */
            String[] param = map.get(f.getName());
            if (param != null && param[0] != null) {
                Object value = null;
                try {
                    if (cons != null) {
                        /**
                         * 编码格式转换
                         */
                        param[0] = new String(param[0].getBytes(), StandardCharsets.UTF_8);
                        /**
                         * 过滤非法字符
                         */
                        param[0] = toLegalText(param[0]);
                        value = cons.newInstance(param[0]);
                    }
                    for (Method m : methods) {

                        if (m.getName().equalsIgnoreCase(StringUtils.field2SetMethod(f.getName()))) {

                            m.invoke(obj, value);
                        }
                    }
                } catch (InstantiationException | IllegalAccessException | InvocationTargetException e) {
                    /**
                     * 某些属性可能由于非法输入而无法初始化，这里无需处理
                     */
                    Logger logger = Logger.getLogger(BeanUtils.class);
                    logger.debug("从请求参数转化成对象时无法初始化[属性] ： " +f.getName()+ " [属性值]：" + param[0] );
                }
            }
        }
        return obj;
    }


    public static Object jsonToJavaObject(InputStream inputStream,Class targetClass) {
    /**
     * 将输入流中的json数据转化成java对象
    * @name jsonToJavaObject
    * @param inputStream 输入json数据的输入流
    * @notice none
    * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
    * @date 2019/5/5
    */    JSONObject jsonObject = null;
        try {
            BufferedReader streamReader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
            StringBuilder builder = new StringBuilder();
            String jsonData;
            while ((jsonData = streamReader.readLine()) != null) {
                builder.append(jsonData);
            }
            jsonObject = JSONObject.parseObject(builder.toString());
            Logger logger = Logger.getLogger(BeanUtils.class);
            logger.info("从请求中获得json数据："+jsonObject.toJSONString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return JSONObject.toJavaObject(jsonObject, targetClass);
    }


}
