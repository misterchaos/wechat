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

package com.hyc.wechat.model.builder;

import com.hyc.wechat.model.vo.MomentVO;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.List;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责朋友圈视图层对象的建造
 * @date 2019-05-07 20:32
 */
public class MomentVOBuilder {
    private MomentVO momentVO;

    public MomentVOBuilder() {
        this.momentVO = new MomentVO();
    }

    public MomentVO build() {
        return this.momentVO;
    }


    public MomentVOBuilder setTime(Timestamp time){
        this.momentVO.setTime(time);
        return this;
    }

    public MomentVOBuilder setUserPhoto(String userPhoto){
        this.momentVO.setUserPhoto(userPhoto);
        return this;
    }


    public MomentVOBuilder setPhoto(String photo){
        this.momentVO.setPhoto(photo);
        return this;
    }

    public MomentVOBuilder setUserName(String userName){
        this.momentVO.setUserName(userName);
        return this;
    }

    public MomentVOBuilder setId(BigInteger id) {
        this.momentVO.setId(id);
        return this;
    }

    public MomentVOBuilder setUserId(BigInteger userId) {
        this.momentVO.setUserId(userId);
        return this;
    }

    public MomentVOBuilder setContent(String content) {
        this.momentVO.setContent(content);
        return this;
    }

    public MomentVOBuilder setShare(Long share) {
        this.momentVO.setShare(share);
        return this;
    }

    public MomentVOBuilder setLove(Long love) {
        this.momentVO.setLove(love);
        return this;
    }
    public MomentVOBuilder setRemark(Long remark) {
        this.momentVO.setRemark(remark);
        return this;
    }

    public MomentVOBuilder setView(Long view) {
        this.momentVO.setView(view);
        return this;
    }

    public MomentVOBuilder setCollect(Long collect) {
        this.momentVO.setCollect(collect);
        return this;
    }

    public MomentVOBuilder setLoved(Boolean loved) {
        this.momentVO.setLoved(loved);
        return this;
    }

    public MomentVOBuilder setShared(Boolean shared) {
        this.momentVO.setShared(shared);
        return this;
    }

    public MomentVOBuilder setViewed(Boolean viewed) {
        this.momentVO.setViewed(viewed);
        return this;

    }
    public MomentVOBuilder setCollected(Boolean collected) {
        this.momentVO.setCollected(collected);
        return this;

    }
}
