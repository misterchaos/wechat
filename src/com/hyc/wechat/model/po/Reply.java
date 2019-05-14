package com.hyc.wechat.model.po;

import com.alibaba.fastjson.annotation.JSONField;
import com.hyc.wechat.dao.annotation.Table;
import com.hyc.wechat.model.po.abs.BaseEntity;

import java.math.BigInteger;
import java.sql.Time;
import java.sql.Timestamp;

@Table(name = "reply")
public class Reply extends BaseEntity {


    @JSONField(name = "user_id")
    private BigInteger userId;
    @JSONField(name = "to_uid")
    private BigInteger toUid;
    @JSONField(name = "remark_id")
    private BigInteger remarkId;
    private Timestamp time;
    private String content;
    private long love;
    private long collect;

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public BigInteger getUserId() {
        return userId;
    }

    public void setUserId(BigInteger userId) {
        this.userId = userId;
    }


    public BigInteger getToUid() {
        return toUid;
    }

    public void setToUid(BigInteger toUid) {
        this.toUid = toUid;
    }


    public BigInteger getRemarkId() {
        return remarkId;
    }

    public void setRemarkId(BigInteger remarkId) {
        this.remarkId = remarkId;
    }


    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }


    public long getLove() {
        return love;
    }

    public void setLove(long love) {
        this.love = love;
    }


    public long getCollect() {
        return collect;
    }

    public void setCollect(long collect) {
        this.collect = collect;
    }




}
