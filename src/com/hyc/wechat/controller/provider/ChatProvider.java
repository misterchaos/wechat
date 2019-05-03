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

package com.hyc.wechat.controller.provider;

import com.hyc.wechat.controller.annotation.Action;
import com.hyc.wechat.controller.annotation.ActionProvider;
import com.hyc.wechat.controller.constant.RequestMethod;
import com.hyc.wechat.controller.constant.WebPage;
import com.hyc.wechat.factory.ServiceProxyFactory;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.Chat;
import com.hyc.wechat.model.po.Member;
import com.hyc.wechat.service.ChatService;
import com.hyc.wechat.service.Impl.ChatServiceImpl;
import com.hyc.wechat.service.constants.Status;
import com.hyc.wechat.util.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责控制聊天服务流程
 * @date 2019-05-03 15:04
 */
@ActionProvider(path = "/chat")
public class ChatProvider extends Provider {

    ChatService chatService = (ChatService) new ServiceProxyFactory().getProxyInstance(new ChatServiceImpl());

    @Action(method = RequestMethod.ADD_DO)
    public void createChat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Chat chat = (Chat) BeanUtils.toObject(req.getParameterMap(), Chat.class);
        ServiceResult result;
        result = chatService.createChat(chat);
        if (Status.ERROR.equals(result.getStatus())) {
            req.setAttribute("message", result.getMessage());
            req.getRequestDispatcher(WebPage.ERROR_JSP.toString()).forward(req, resp);
            return;
        } else {
            resp.getWriter().write(result.getMessage());
        }
    }

    @Action(method = RequestMethod.JOIN_DO)
    public void joinChat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member member = (Member) BeanUtils.toObject(req.getParameterMap(), Member.class);
        ServiceResult result;
        result = chatService.joinChat(new Member[]{member});
        if (Status.ERROR.equals(result.getStatus())) {
            req.setAttribute("message", result.getMessage());
            req.getRequestDispatcher(WebPage.ERROR_JSP.toString()).forward(req, resp);
            return;
        } else {
            resp.getWriter().write(result.getMessage());
        }
    }
    @Action(method = RequestMethod.QUIT_DO)
    public void quitChat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member member = (Member) BeanUtils.toObject(req.getParameterMap(), Member.class);
        ServiceResult result;


        result = chatService.quitChat(new Member[]{member});
        if (Status.ERROR.equals(result.getStatus())) {
            req.setAttribute("message", result.getMessage());
            req.getRequestDispatcher(WebPage.ERROR_JSP.toString()).forward(req, resp);
            return;
        } else {
            resp.getWriter().write(result.getMessage());
        }
    }
}
