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
import com.hyc.wechat.factory.ServiceProxyFactory;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.provider.annotation.Action;
import com.hyc.wechat.provider.annotation.ActionProvider;
import com.hyc.wechat.service.MessageService;
import com.hyc.wechat.service.constants.ServiceMessage;
import com.hyc.wechat.service.impl.MessageServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;

import static com.hyc.wechat.util.ControllerUtils.returnJsonObject;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 提供消息记录的服务流程控制
 * @date 2019-05-08 02:32
 */
@ActionProvider(path = "/message")
public class MessageProvider extends Provider {
    private final MessageService messageService = (MessageService) new ServiceProxyFactory().getProxyInstance(new MessageServiceImpl());


    /**
     * 提供获取一个聊天的所有聊天记录的服务
     *
     * @name listMessage
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    @Action(method = RequestMethod.LIST_DO)
    public void listMessage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("user_id");
        String chatId = req.getParameter("chat_id");
        String page = req.getParameter("page");
        ServiceResult result = null;
        result = messageService.listAllMessage(new BigInteger(userId), new BigInteger(chatId), new Integer(page));
        returnJsonObject(resp, result);
    }


    /**
     * 提供获取所有未读消息的服务
     *
     * @name listUnreadMessage
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    @Action(method = RequestMethod.UNREAD_DO)
    public void listUnreadMessage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("user_id");
        String page = req.getParameter("page");
        ServiceResult result = null;
        result = messageService.listAllUnreadMessage(new BigInteger(userId), new Integer(page));
        returnJsonObject(resp, result);
    }


    /**
     * 提供将一个聊天中的消息设置为已读的服务
     *
     * @name read
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    @Action(method = RequestMethod.READ_DO)
    public void read(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("user_id");
        String chatId = req.getParameter("chat_id");
        ServiceResult result = new ServiceResult();
        result.setMessage(ServiceMessage.ALREADY_READ.message);
        messageService.setAlreadyRead(new BigInteger(userId), new BigInteger(chatId));
        returnJsonObject(resp, result);
    }


}
