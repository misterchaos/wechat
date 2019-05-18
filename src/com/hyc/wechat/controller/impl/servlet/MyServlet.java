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

package com.hyc.wechat.controller.impl.servlet;

import com.hyc.wechat.controller.annotation.ControllerConfig;
import com.hyc.wechat.controller.constant.ControllerMessage;
import com.hyc.wechat.provider.Provider;
import com.hyc.wechat.util.ControllerUtils;
import org.apache.log4j.Logger;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.Set;

import static com.hyc.wechat.provider.Provider.toErrorPage;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 接收客户端请求，将其转发到controller
 * @date 2019-05-02 03:28
 */
@MultipartConfig(location = "/home/pan/tomcat/webapps/wechat/upload")
//@MultipartConfig(location = "C:\\Users\\Misterchaos\\Documents\\Java Develop Workplaces\\IDEA workspace\\wechat\\out\\artifacts\\wechat_war_exploded\\upload")
@WebServlet("/wechat/*")
public class MyServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        this.doPost(req, resp);
    }

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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Map<String, Provider>providerMap = (Map<String, Provider>) getServletContext().getAttribute("providerMap");
        String url = req.getRequestURI();
        Set<String> keys = providerMap.keySet();
        Logger logger = Logger.getLogger(MyServlet.class);
        logger.info("[请求url:]"+url+"[匹配provider]:"+url.substring(14));
        boolean isMatch=false;
        for (String key : keys) {
            //解析注解中的path信息，匹配ActionProvider
            String path =providerMap.get(key).getPath();
            if (url.substring(14).equalsIgnoreCase(path)) {
                providerMap.get(key).doAction(req, resp);
                logger.info("provider 分发完毕");
                isMatch=true;
            }
        }
        if(!isMatch){
            toErrorPage(ControllerMessage.REQUEST_INVALID.message,req,resp);
            logger.info("该请求没有匹配provider :"+url.substring(14));
            return;
        }
//        logger.info("响应结果 "+resp.getOutputStream());
    }


}


