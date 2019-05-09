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
import com.hyc.wechat.model.po.Message;
import com.hyc.wechat.model.po.Moment;

import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责朋友圈的CRUD
 * @date 2019-05-07 11:55
 */
public interface MomentDao extends BaseDao {
    String TABLE = "moment";
    String ALL_FIELD = "owner_id,content,photo,time,love,remark,share,view,collect," + BASE_FIELD;

    /**
     * 通过朋友圈id查询一个朋友圈
     *
     * @param id 朋友圈id
     * @name geMomentById
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/2
     */
    @Result(entity = Moment.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where id = ? ")
    Moment getMomentById(Object id);

    /**
     * 通过用户id和状态查询一个朋友圈
     *
     * @param ownerId 用户id
     * @param stauts 状态
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/8
     */
    @Result(entity = Moment.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where owner_id = ? and status = ? ")
    Moment getMomentByOwnerIdAndStatus(Object ownerId, Object stauts);


    /**
     * 通过用户id逆序查询所有自己发布的朋友圈
     *
     * @param ownerId 用户id
     * @param limit  每页查询记录数
     * @param offset 起始记录数
     * @name listMyMomentByOwnerIdDesc
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Result(entity = Moment.class, returns = ResultType.LIST)
    @Query("select " + ALL_FIELD + " from " + TABLE + " where owner_id = ?  order by time desc limit ? offset ?  ")
    List<Moment> listMyMomentByOwnerIdDesc(Object ownerId, int limit, int offset);

    /**
     * 通过用户id查询所有自己发布的朋友圈
     *
     * @param ownerId 用户id
     * @param limit  每页查询记录数
     * @param offset 起始记录数
     * @name listMyMomentByOwnerId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Result(entity = Moment.class, returns = ResultType.LIST)
    @Query("select " + ALL_FIELD + " from " + TABLE + " where owner_id = ?  order by time limit ? offset ?  ")
    List<Moment> listMyMomentByOwnerId(Object ownerId, int limit, int offset);


}
