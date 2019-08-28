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

import com.hyc.wechat.dao.annotation.*;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 提供Dao的基础方法接口
 * @date 2019-05-01 17:11
 */
public interface BaseDao {

    String BASE_FIELD = "id,status,gmt_create,gmt_modified";

    /*
     **************************************************************
     *          负责数据库insert,update,delete等功能
     **************************************************************
     */


    /**
     * 把一个对象插入一张表
     *
     * @param obj 要插入的对象
     * @name insert
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/1
     */
    @Insert()
    int insert(Object obj);



    /**
     * 根据传入的表名和id，从该表中更新一条记录
     *
     * @param obj 要更新的记录对应的实体类对象
     * @name update
     * @notice 请注意此方法默认更新该对象中所有不为null的属性到数据库<br>
     * 如果不希望更新某些字段，请将其设置为null
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/1
     */
    @Update()
    int update(Object obj);

    /**
     * 将一个对象从表中删除
     *
     * @param obj 要删除的对象
     * @name delete
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/1
     */
    @Delete()
    int delete(Object obj);

}
