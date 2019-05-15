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

import com.hyc.wechat.exception.DaoException;
import com.hyc.wechat.exception.ServiceException;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.Moment;
import com.hyc.wechat.model.po.News;
import com.hyc.wechat.model.po.Remark;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.model.vo.MomentVO;
import com.hyc.wechat.service.constants.ServiceMessage;
import com.hyc.wechat.service.constants.Status;

import java.math.BigInteger;
import java.util.LinkedList;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责评论服务
 * @date 2019-05-14 01:14
 */
public interface RemarkService {
    /**添加一条评论
     * @name addRemark
     * @param remark 评论
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/14
     */
    ServiceResult addRemark(Remark remark);
    /**
     * 查询一条朋友圈的评论
     *
     * @param momentId 朋友圈id
     * @param page   页数
     * @name listRemark
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/14
     */
    ServiceResult listRemark(BigInteger momentId, int page);

    /**
     * 删除一条评论
     *
     * @param remarkId 评论id
     * @name removeRemark
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/14
     */
    ServiceResult removeRemark(BigInteger remarkId);


}
