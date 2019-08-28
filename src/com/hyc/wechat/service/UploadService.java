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

package com.hyc.wechat.service;

import com.hyc.wechat.model.dto.ServiceResult;

import javax.servlet.http.Part;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责提供文件上传服务
 * @date 2019-05-06 02:23
 */
public interface UploadService {

    /**
     * 负责将文件写入文件，并将数据库表对应的记录上的photo属性值修改为文件名
     *
     * @param part      文件
     * @param id        记录id
     * @param tableName 表名
     * @return
     * @name uploadPhoto
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/6
     */
    ServiceResult uploadPhoto(Part part, Object id, String tableName);

    /**
     * 负责将文件写入文件，并将数据库表对应聊天背景属性值修改为文件名
     *
     * @param part      文件
     * @param id        记录id
     * @return
     * @name uploadBackground
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/9
     */
    ServiceResult uploadBackground(Part part, Object id);


    /**
     * 负责将文件写入文件，并返回文件名
     *
     * @param part      文件
     * @name uploadFile
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/14
     */
    ServiceResult uploadFile(Part part);


}
