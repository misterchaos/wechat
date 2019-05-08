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
import com.hyc.wechat.model.po.News;

import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责动态表的CRUD
 * @date 2019-05-07 18:47
 */
public interface NewsDao extends BaseDao {
    String TABLE = "news";
    String ALL_FIELD = "user_id,moment_id,loved,shared,viewed,collected," + BASE_FIELD;

    /**
     * 通过用户id查询所有自己可见的所有朋友圈动态
     *
     * @param userId 用户id
     * @param limit  每页查询记录数
     * @param offset 起始记录数
     * @name listNewsByUserId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Result(entity = News.class, returns = ResultType.LIST)
    @Query("select " + ALL_FIELD + " from " + TABLE + " where user_id = ?  limit ? offset ?  ")
    List<News> listNewsByUserId(Object userId, int limit, int offset);


    /**
     * 通过朋友圈id查询一个朋友圈动态
     *
     * @param id 朋友圈id
     * @name geNewsByMomentId
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Result(entity = News.class, returns = ResultType.OBJECT)
    @Query(value = "select " + ALL_FIELD + " from " + TABLE + " where moment_id = ? ")
    News getNewsByMomentId(Object id);
}
