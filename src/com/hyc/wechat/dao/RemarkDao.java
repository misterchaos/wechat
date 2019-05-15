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

package com.hyc.wechat.dao;

import com.hyc.wechat.dao.annotation.Query;
import com.hyc.wechat.dao.annotation.Result;
import com.hyc.wechat.dao.annotation.ResultType;
import com.hyc.wechat.model.po.Moment;
import com.hyc.wechat.model.po.Remark;

import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description
 * @date 2019-05-14 01:12
 */
public interface RemarkDao extends BaseDao{
    String TABLE = "remark";
    String ALL_FIELD = "user_id,moment_id,content,time,love,collect,reply," + BASE_FIELD;

    /**
     * 通过用户id逆序查询所有自己发布的朋友圈
     *
     * @param momentId 朋友圈id
     * @param limit  每页查询记录数
     * @param offset 起始记录数
     * @name listRemarkDesc
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/14
     */
    @Result(entity = Remark.class, returns = ResultType.LIST)
    @Query("select " + ALL_FIELD + " from " + TABLE + " where moment_id = ?  order by time desc limit ? offset ?  ")
    List<Remark> listRemarkDesc(Object momentId, int limit, int offset);

    /**
     * 通过评论id查询一个评论
     *
     * @param id 评论id
     * @name geRemarkById
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/14
     */
    @Result(entity = Remark.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where id = ? ")
    Remark getRemarkById(Object id);
}
