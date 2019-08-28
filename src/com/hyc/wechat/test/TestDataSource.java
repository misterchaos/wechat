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

package com.hyc.wechat.test;

import com.hyc.wechat.dao.DataSource;
import com.hyc.wechat.dao.impl.DataSourceImpl;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.model.po.abs.BaseEntity;
import com.hyc.wechat.util.JdbcUtils;
import com.mysql.cj.x.protobuf.MysqlxDatatypes;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 测试数据源
 * @date 2019-05-01 16:49
 */
public class TestDataSource {
    public static void main(String[] args) throws SQLException {
        System.out.println("测试直接从数据源获取连接");
        DataSource dataSource = DataSourceImpl.getInstance();
        Connection conn = dataSource.getConnection();
        System.out.println("获取一个连接\n");
        System.out.println(conn);
        System.out.println("当前已创建连接数 = " + dataSource.getCurrentCount());
        System.out.println("当前空闲连接数 = " + dataSource.getfreeCount());
        System.out.println("释放一个连接");
        dataSource.freeConnection(conn);
        for (int i = 0; i < 10; i++) {
            conn = dataSource.getConnection();
            System.out.println(conn);
            JdbcUtils.close(conn);
        }
        System.out.println("释放一个连接");
        dataSource.freeConnection(conn);
        System.out.println("当前已创建连接数 = " + dataSource.getCurrentCount());
        System.out.println("当前空闲连接数 = " + dataSource.getfreeCount());

    }


}
