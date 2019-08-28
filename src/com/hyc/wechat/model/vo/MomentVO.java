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

package com.hyc.wechat.model.vo;

import com.alibaba.fastjson.annotation.JSONField;
import com.hyc.wechat.model.po.Moment;

import java.math.BigInteger;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 朋友圈的视图层对象
 * @date 2019-05-07 20:12
 */
public class MomentVO extends Moment {

    @JSONField(name = "user_name")
    private String userName;
    private Boolean loved;
    private Boolean shared;
    private Boolean viewed;
    private Boolean collected;
    @JSONField(name = "user_photo")
    private String userPhoto;

    public String getUserPhoto() {
        return userPhoto;
    }

    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public boolean getLoved() {
        return loved;
    }

    public void setLoved(boolean loved) {
        this.loved = loved;
    }

    public boolean getShared() {
        return shared;
    }

    public void setShared(boolean shared) {
        this.shared = shared;
    }

    public boolean getViewed() {
        return viewed;
    }

    public void setViewed(boolean viewed) {
        this.viewed = viewed;
    }

    public boolean getCollected() {
        return collected;
    }

    public void setCollected(boolean collected) {
        this.collected = collected;
    }
}
