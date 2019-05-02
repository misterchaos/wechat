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

import com.hyc.wechat.controller.UserProvider;
import com.hyc.wechat.controller.UserProviderImpl;
import com.hyc.wechat.controller.annotation.ActionProvider;
import com.hyc.wechat.factory.proxy.ProviderProxyFactory;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description
 * @date 2019-05-02 12:45
 */
public class TestActionProviderProxy {
    public static void main(String[] args) {
        ProviderProxyFactory factory = new ProviderProxyFactory();
        factory.setTarget(new UserProviderImpl());
        UserProvider provider = (UserProvider) factory.getProxyInstance(UserProvider.class, new UserProviderImpl());
        System.out.println(provider.getTarget().getClass().getAnnotation(ActionProvider.class));
    }
}
