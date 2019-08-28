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

package com.hyc.wechat.model.po;

import com.alibaba.fastjson.JSONObject;
import com.hyc.wechat.dao.annotation.Table;
import com.hyc.wechat.model.po.abs.BaseEntity;

import java.math.BigInteger;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责记录消息记录
 * @date 2019-05-06 21:29
 */
@Table(name = "record")
public class Record extends BaseEntity {
    private BigInteger userId;
    private BigInteger messageId;

    public BigInteger getUserId() {
        return userId;
    }

    public void setUserId(BigInteger userId) {
        this.userId = userId;
    }

    public BigInteger getMessageId() {
        return messageId;
    }

    public void setMessageId(BigInteger messageId) {
        this.messageId = messageId;
    }


}
