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
import com.hyc.wechat.model.po.Moment;
import com.hyc.wechat.model.po.Remark;
import com.hyc.wechat.provider.annotation.Action;
import com.hyc.wechat.provider.annotation.ActionProvider;
import com.hyc.wechat.service.RemarkService;
import com.hyc.wechat.service.impl.RemarkServiceImpl;
import com.sun.org.apache.bcel.internal.generic.BIPUSH;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigInteger;

import static com.hyc.wechat.util.BeanUtils.jsonToJavaObject;
import static com.hyc.wechat.util.ControllerUtils.returnJsonObject;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责评论的业务流程
 * @date 2019-05-14 01:38
 */
@ActionProvider(path = "/remark")
public class RemarkProvider extends Provider {

    RemarkService remarkService = (RemarkService) new ServiceProxyFactory().getProxyInstance(new RemarkServiceImpl());
    /**
     * 提供发布评论的业务流程
     *
     * @name postRemark
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/14
     */
    @Action(method = RequestMethod.ADD_DO)
    public void postRemark(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Remark remark = (Remark) jsonToJavaObject(req.getInputStream(), Remark.class);
        ServiceResult result;
        result = remarkService.addRemark(remark);
        returnJsonObject(resp, result);
    }

    /**
     * 提供获取朋友圈评论的业务流程
     *
     * @name listRemark
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/14
     */
    @Action(method = RequestMethod.LIST_DO)
    public void listRemark(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String momentId = req.getParameter("moment_id");
        String page = req.getParameter("page");
        ServiceResult result;
        result = remarkService.listRemark(new BigInteger(momentId), Integer.parseInt(page));
        returnJsonObject(resp, result);
    }
}
