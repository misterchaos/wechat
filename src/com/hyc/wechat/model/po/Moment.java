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
import java.sql.Timestamp;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 朋友圈实体类
 * @date 2019-05-07 11:36
 */
@Table(name = "moment")
public class Moment extends BaseEntity {
    @JSONField(name = "user_id")
    private BigInteger userId;
    private String content;
    private String photo;
    private Timestamp time;
    private Long love;
    private Long remark;
    private Long share;
    private Long view;
    private Long collect;


    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public BigInteger getUserId() {
        return userId;
    }

    public void setUserId(BigInteger userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getLove() {
        return love;
    }

    public void setLove(Long love) {
        this.love = love;
    }

    public Long getRemark() {
        return remark;
    }

    public void setRemark(Long remark) {
        this.remark = remark;
    }

    public Long getShare() {
        return share;
    }

    public void setShare(Long share) {
        this.share = share;
    }

    public Long getView() {
        return view;
    }

    public void setView(Long view) {
        this.view = view;
    }

    public Long getCollect() {
        return collect;
    }

    public void setCollect(Long collect) {
        this.collect = collect;
    }
}
