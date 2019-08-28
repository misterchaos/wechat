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

import com.alibaba.fastjson.annotation.JSONField;
import com.hyc.wechat.dao.annotation.Table;
import com.hyc.wechat.model.po.abs.BaseEntity;

import java.math.BigInteger;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 动态表的实体类
 * @date 2019-05-07 18:44
 */
@Table(name = "news")
public class News extends BaseEntity {
    @JSONField(name = "user_id")
    private BigInteger userId;
    @JSONField(name = "moment_Id")
    private BigInteger momentId;
    private Boolean loved;
    private Boolean shared;
    private Boolean viewed;
    private Boolean collected;

    public BigInteger getUserId() {
        return userId;
    }

    public void setUserId(BigInteger userId) {
        this.userId = userId;
    }

    public BigInteger getMomentId() {
        return momentId;
    }

    public void setMomentId(BigInteger momentId) {
        this.momentId = momentId;
    }

    public Boolean getLoved() {
        return loved;
    }

    public void setLoved(Boolean loved) {
        this.loved = loved;
    }

    public Boolean getShared() {
        return shared;
    }

    public void setShared(Boolean shared) {
        this.shared = shared;
    }

    public Boolean getViewed() {
        return viewed;
    }

    public void setViewed(Boolean viewed) {
        this.viewed = viewed;
    }

    public Boolean getCollected() {
        return collected;
    }

    public void setCollected(Boolean collected) {
        this.collected = collected;
    }
}
