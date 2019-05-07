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


import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 用于字符串的转换
 * @date 2019-04-15 17:28
 */
public class StringUtils {

    /**
     * 返回一个关键词的各种模糊搜索数组
     *
     * @param keyWord
     * @return
     * @name toLikeSql
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    public static String[] toLikeSql(String keyWord) {
        //TODO 添加每个字符的模糊搜索
        ArrayList<String> list = new ArrayList<>();
        String sql = "%" + keyWord + "%";
        list.add(sql);
        String[] strings = new String[list.size()];
        return list.toArray(strings);
    }

    /**
     * 将属性名转成get方法名
     *
     * @param field 属性名
     * @return
     * @name field2GetMethod
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    public static String field2GetMethod(String field) {
        StringBuilder method = new StringBuilder("get" + field);
        method.setCharAt(3, (char) (method.charAt(3) - 32));
        return method.toString();
    }

    /**
     * 将java变量名转化成mysql的属性名，在每个大写字母的前面加上'_'
     *
     * @param field java属性
     * @return mysql属性名
     * @name field2SqlField
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/3
     */
    public static String field2SqlField(String field) {
        byte[] bytes = field.getBytes();
        StringBuilder name = new StringBuilder();
        for (byte aByte : bytes) {
            if (aByte >= 'A' && aByte <= 'Z') {
                name.append('_');
            }
            name.append((char) aByte);
        }
        return name.toString();
    }

    public static String field2SetMethod(String field) {
        StringBuilder method = new StringBuilder("set" + field);
        method.setCharAt(3, (char) (method.charAt(3) - 32));
        return method.toString();
    }

    /**
     * 去除输入中的不合法字符，防止标签注入
     *
     * @param str 需要被过滤的字符
     * @return
     * @name
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/4/23
     */
    public static String toLegalText(String str) {
        if (str == null || str.trim().isEmpty()) {
            return "";
        }
        String styleLabel = "<style[^>]*?>[\\s\\S]*?<\\/style>";
        String scriptLabel = "<script[^>]*?>[\\s\\S]*?<\\/script>";
        String htmlLabel = "<[^>]+>";
        str = str.replaceAll(styleLabel, "");
        str = str.replaceAll(scriptLabel, "");
        str = str.replaceAll(htmlLabel, "");
        str = str.replaceAll("\\s*|\t|\r|\n", "");
        str = str.replace("\"", "");
        return str.trim();
    }
}
