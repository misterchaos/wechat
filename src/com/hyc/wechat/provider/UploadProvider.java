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
import com.hyc.wechat.service.UploadService;
import com.hyc.wechat.service.impl.UploadServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;

import static com.hyc.wechat.util.ControllerUtils.returnJsonObject;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责上传文件流程
 * @date 2019-05-06 02:38
 */
@ActionProvider(path = "/upload")
public class UploadProvider extends Provider {
    private final UploadService uploadService = (UploadService) new ServiceProxyFactory().getProxyInstance(new UploadServiceImpl());

    @Action(method = RequestMethod.UPLOADPHOTO_DO)
    public void uploadPhoto(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Part part = req.getPart("photo");
        Object id = req.getParameter("id");
        String tableName = req.getParameter("table");
        ServiceResult result;
        result = uploadService.uploadPhoto(part, id, tableName);
        returnJsonObject(resp, result);
    }

    @Action(method = RequestMethod.BACKGROUND_DO)
    public void uploadBackground(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Part part = req.getPart("photo");
        Object id = req.getParameter("id");
        ServiceResult result;
        result = uploadService.uploadBackground(part, id);
        returnJsonObject(resp, result);
    }
}
