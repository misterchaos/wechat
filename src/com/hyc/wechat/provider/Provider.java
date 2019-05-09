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

package com.hyc.wechat.provider;

import com.hyc.wechat.controller.constant.RequestMethod;
import com.hyc.wechat.controller.constant.WebPage;
import com.hyc.wechat.exception.ServiceException;
import com.hyc.wechat.provider.annotation.Action;
import com.hyc.wechat.provider.annotation.ActionProvider;
import com.hyc.wechat.util.ControllerUtils;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 所有ActionProvider的父类，提供共有的doAction方法
 * @date 2019-05-02 11:39
 */
public class Provider {


    /**
     * 负责将请求分发到对应的Action方法
     *
     * @param req  请求
     * @param resp 响应
     * @name doAction
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    public void doAction(HttpServletRequest req, HttpServletResponse resp) {
        //获取请求中的method参数，转换成对应的枚举类型
        try {
            RequestMethod requestMethod = ControllerUtils.valueOf(req.getParameter("method"));
            if (RequestMethod.INVALID_REQUEST.equals(requestMethod)) {
                toErrorPage("无效的访问链接，系统无法识别您的请求指向的服务内容：" + req.getRequestURI(), req, resp);
            } else {
                //根据方法上的注解找到对应的Action方法并执行
                Method[] methods = this.getClass().getMethods();
                for (Method m : methods) {
                    Action action = m.getAnnotation(Action.class);
                    if (action != null && action.method().equals(requestMethod)) {
                        try {
                            m.invoke(this, req, resp);
                        } catch (ServiceException e) {
                            //服务层抛出的异常信息与用户的操作有关，不包含底层细节，可以向用户输出
                            e.printStackTrace();
                            toErrorPage(e.getMessage(), req, resp);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger logger  =Logger.getLogger(Provider.class);
            logger.debug(e.getStackTrace());
            //此处的异常包含细节信息，对客户端隐藏
            toErrorPage("您的请求参数不足或错误，系统无法处理您的请求", req, resp);
        }
    }

    /**
     * 转发到错误界面，向客户端输出错误信息
     *
     * @param message 异常描述信息
     * @name toErrorPage
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    private void toErrorPage(String message, HttpServletRequest req, HttpServletResponse resp) {
        req.setAttribute("message", message);
        try {
            req.getRequestDispatcher(WebPage.ERROR_JSP.toString()).forward(req, resp);
        } catch (ServletException | IOException e) {
            e.printStackTrace();
            try {
                resp.getWriter().write("服务器异常");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    /**
     * 返回这个Provider的url映射路径
     *
     * @name getPath
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    public String getPath() {
        return this.getClass().getAnnotation(ActionProvider.class).path();
    }
}
