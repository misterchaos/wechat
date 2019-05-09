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
import com.hyc.wechat.model.po.Moment;

import java.math.BigInteger;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责提供朋友圈相关的服务
 * @date 2019-05-07 13:13
 */
public interface MomentService {

    /**
     * 插入一条朋友圈
     *
     * @param moment 朋友圈
     * @name insertMoment
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult insertMoment(Moment moment);

    /**
     * 删除一条朋友圈
     *
     * @param momentId 朋友圈id
     * @name removeMoment
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult removeMoment(BigInteger momentId);

    /**
     * 更新一条朋友圈
     *
     * @param moment 要更新的朋友圈
     * @name updateMoment
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult updateMoment(Moment moment);

    /**
     * 查询一个用户所发的所有朋友圈
     *
     * @param page   页数
     * @param userId 用户id
     * @name listNews
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult listMyMoment(BigInteger userId, int page);

    /**
     * 查询一个用户可见的所有朋友圈，包括自己的和朋友的
     *
     * @param userId 用户id
     * @param page   页数
     * @name listNews
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    ServiceResult listNews(BigInteger userId, int page);

    /**
     * 更新一个用户对一条朋友圈的点赞状态
     *
     * @param userId   用户id
     * @param momentId 朋友圈id
     * @name love
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/8
     */
    ServiceResult love(BigInteger userId, BigInteger momentId);



}
