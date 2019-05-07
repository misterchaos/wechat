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

package com.hyc.wechat.test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hyc.wechat.model.po.Message;
import com.hyc.wechat.model.po.User;

import java.util.Date;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 测试Json
 * @date 2019-05-04 01:02
 */
public class TestJson {
    public static void main(String[] args) {
        JSON json = JSONObject.parseObject(
          "{\"id\":\"2\", " +
                  "\"wechat___id\":\"s\"}"
        );
        User user = JSONObject.toJavaObject(json,User.class);
        System.out.println(user.getId());
        System.out.println(user.getWechatId());
        System.out.println(new Date(1309237).toString());

        System.out.println(user.toString());
    }
}
