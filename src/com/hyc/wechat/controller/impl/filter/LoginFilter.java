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

package com.hyc.wechat.controller.impl.filter;

import com.hyc.wechat.controller.constant.ControllerMessage;
import com.hyc.wechat.controller.constant.RequestMethod;
import com.hyc.wechat.controller.constant.WebPage;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.provider.UserProvider;
import com.hyc.wechat.service.constants.Status;
import com.hyc.wechat.service.impl.UserServiceImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static com.hyc.wechat.util.ControllerUtils.returnJsonObject;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 负责过滤需要登陆的页面的请求
 * @date 2019-05-09 15:41
 */
@WebFilter(
        filterName = "LoginFilter",
        urlPatterns = {"/*"}, servletNames = {"/*"},
        initParams = {
                @WebInitParam(name = "ENCODING", value = "UTF-8")
        })
public class LoginFilter implements Filter {

    private final UserProvider userProvider = new UserProvider();

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        String method = req.getParameter("method");
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());
        HttpSession sess = req.getSession(false);

        //尝试自动登陆
        userProvider.autoLogin(req);
        sess=req.getSession();
        //放行登陆注册
        if (sess == null || sess.getAttribute("login") == null) {
            if (WebPage.LOGIN_JSP.toString().equalsIgnoreCase(path) ||
                    (WebPage.REGISTER_JSP.toString()).equalsIgnoreCase(path) ||
                    (RequestMethod.LOGIN_DO.toString()).equalsIgnoreCase(method) ||
                    (RequestMethod.REGISTER_DO.toString()).equalsIgnoreCase(method) ||
                    path.endsWith("logo.png") || path.endsWith(".js") || path.endsWith("agreement.html")) {
                filterChain.doFilter(req, resp);
                return;
            } else {
                //检查session是否有'login'属性,没有则重定向到登陆界面
                if (sess == null || sess.getAttribute("login") == null) {
                    req.getRequestDispatcher(WebPage.LOGIN_JSP.toString()).forward(req, resp);
                    return;
                }
            }
        }else {
            //已登陆用户检查登陆身份
            if (path.startsWith("/wechat/moment") || path.startsWith("/wechat/friend")) {
                //检查登陆身份
                User user = (User) sess.getAttribute("login");
                if (user != null && UserServiceImpl.VISITOR_EMAIL.equals(user.getEmail())) {
                    //游客不可使用
                    returnJsonObject(resp, new ServiceResult(Status.ERROR, ControllerMessage.YOU_ARE_VISITOR.message, null));
                    return;
                }
            }
        }

        filterChain.doFilter(req, resp);
    }


}
