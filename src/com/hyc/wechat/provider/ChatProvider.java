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

import com.alibaba.fastjson.JSON;
import com.hyc.wechat.controller.constant.RequestMethod;
import com.hyc.wechat.controller.constant.WebPage;
import com.hyc.wechat.factory.ServiceProxyFactory;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.Chat;
import com.hyc.wechat.model.po.Member;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.provider.annotation.Action;
import com.hyc.wechat.provider.annotation.ActionProvider;
import com.hyc.wechat.service.ChatService;
import com.hyc.wechat.service.constants.ServiceMessage;
import com.hyc.wechat.service.constants.Status;
import com.hyc.wechat.service.impl.ChatServiceImpl;
import com.hyc.wechat.util.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;

import static com.hyc.wechat.util.BeanUtils.jsonToJavaObject;
import static com.hyc.wechat.util.ControllerUtils.returnJsonObject;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责控制聊天服务流程
 * @date 2019-05-03 15:04
 */
@ActionProvider(path = "/chat")
public class ChatProvider extends Provider {

    private final ChatService chatService = (ChatService) new ServiceProxyFactory().getProxyInstance(new ChatServiceImpl());

    /**
     * 提供用户创建群聊的服务流程，不提供创建个人私聊
     *
     * @name createChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    @Action(method = RequestMethod.ADD_DO)
    public void createGroupChat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Chat chat = (Chat) jsonToJavaObject(req.getInputStream(), Chat.class);
        ServiceResult result;
        //创建一个群聊
        result = chatService.createChat(chat, true);
        if (Status.ERROR.equals(result.getStatus())) {
            returnJsonObject(resp, result);
            return;
        }
        //从chatService中重新获取chat的信息
        chat = (Chat) result.getData();
        //将用户加入群聊
        Member member = new Member();
        member.setUserId(chat.getOwnerId());
        member.setChatId(chat.getId());
        result = chatService.joinChat(new Member[]{member});
        if (Status.ERROR.equals(result.getStatus())) {
            returnJsonObject(resp, result);
            return;
        }
        //如果两个操作都成功，返回创建群聊成功和群号，覆盖下层service的消息
        result.setMessage(ServiceMessage.CREATE_GROUP_CHAT_SUCCESS.message + chat.getNumber() + ServiceMessage.PLEASE_JOIN_CHAT.message);
        returnJsonObject(resp, result);
    }

    /**
     * 提供用户加入群聊的服务
     *
     * @name joinChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    @Action(method = RequestMethod.JOIN_DO)
    public void joinGroupChat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String number = req.getParameter("number");
        String userId = req.getParameter("user_id");
        ServiceResult result;
        result = chatService.joinChatByNumber(new BigInteger(userId), number);
        returnJsonObject(resp, result);
    }

    /**
     * 提供退出群聊的服务
     *
     * @name quitChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    @Action(method = RequestMethod.QUIT_DO)
    public void quitChat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Member member = (Member)jsonToJavaObject(req.getInputStream(), Member.class);
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

    /**
     * 提供获取一个用户的聊天列表的服务
     *
     * @name listChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    @Action(method = RequestMethod.LIST_DO)
    public void listChat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) BeanUtils.toObject(req.getParameterMap(), User.class);
        ServiceResult result;
        result = chatService.listChat(user);
        if (Status.ERROR.equals(result.getStatus())) {
            req.setAttribute("message", result.getMessage());
            req.getRequestDispatcher(WebPage.ERROR_JSP.toString()).forward(req, resp);
            return;
        } else {
            JSON json = (JSON) JSON.toJSON(result);
            resp.getWriter().write(json.toJSONString());
        }
    }
}
