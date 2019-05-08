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

package com.hyc.wechat.service.impl;

import com.hyc.wechat.dao.FriendDao;
import com.hyc.wechat.dao.MomentDao;
import com.hyc.wechat.dao.NewsDao;
import com.hyc.wechat.dao.UserDao;
import com.hyc.wechat.exception.DaoException;
import com.hyc.wechat.exception.ServiceException;
import com.hyc.wechat.factory.DaoProxyFactory;
import com.hyc.wechat.model.builder.MomentVOBuilder;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.Friend;
import com.hyc.wechat.model.po.Moment;
import com.hyc.wechat.model.po.News;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.model.vo.MomentVO;
import com.hyc.wechat.service.MomentService;
import com.hyc.wechat.service.constants.ServiceMessage;
import com.hyc.wechat.service.constants.Status;

import java.math.BigInteger;
import java.util.LinkedList;
import java.util.List;

import static com.hyc.wechat.util.StringUtils.toLegalText;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责提供朋友圈相关的服务
 * @date 2019-05-07 19:19
 */
public class MomentServiceImpl implements MomentService {

    private MomentDao momentDao = (MomentDao) DaoProxyFactory.getInstance().getProxyInstance(MomentDao.class);
    private NewsDao newsDao = (NewsDao) DaoProxyFactory.getInstance().getProxyInstance(NewsDao.class);
    private UserDao userDao = (UserDao) DaoProxyFactory.getInstance().getProxyInstance(UserDao.class);
    private FriendDao friendDao = (FriendDao) DaoProxyFactory.getInstance().getProxyInstance(FriendDao.class);

    /**
     * 插入一条朋友圈
     *
     * @param moment 朋友圈
     * @name insertMoment
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult insertMoment(Moment moment) {
        StringBuilder message=new StringBuilder();
        try {
            //判空
            if (moment == null) {
                throw new ServiceException(ServiceMessage.NOT_NULL.message);
            }
            //检查内容
            if (!isValidContent(moment.getContent())) {
                message.append(ServiceMessage.CONTENT_ILLEGAL.message);
            }
            //过滤非法字符
            moment.setContent(toLegalText(moment.getContent()));
            //插入数据库
            //先把状态值设置为1，插入后查出状态为1的，返回给前端，并且对News表插入动态记录之后，再更新状态为0
            moment.setStatus(1);
            if (momentDao.insert(moment) != 1) {
                return new ServiceResult(Status.ERROR, ServiceMessage.PLEASE_REDO.message, moment);
            }
            //获取朋友圈记录，返回id值,
            moment = momentDao.getMomentByUserIdAndStatus(moment.getUserId(), 1);
            //查找用户的所有朋友，给他们插入news记录
            List<Friend> friendList = friendDao.listByUserId(moment.getUserId());
            for (Friend friend : friendList) {
                News news = new News();
                news.setMomentId(moment.getId());
                news.setUserId(friend.getFriendId());
                newsDao.insert(news);
            }
            //给用户自己插入news记录
            News news = new News();
            news.setMomentId(moment.getId());
            news.setUserId(moment.getUserId());
            newsDao.insert(news);
            //创建一个新对象用于更新状态为0，表示该朋友圈处理完毕
            Moment updateStatus = new Moment();
            updateStatus.setId(moment.getId());
            updateStatus.setStatus(0);
            momentDao.update(updateStatus);
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, moment);
        }
        return new ServiceResult(Status.SUCCESS, message.append(ServiceMessage.POST_SUCCESS.message).toString(), moment);
    }

    /**
     * 删除一条朋友圈
     *
     * @param momentId 朋友圈id
     * @name removeMoment
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult removeMoment(BigInteger momentId) {
        try {
            //判空
            if (momentId == null) {
                throw new ServiceException(ServiceMessage.NOT_NULL.message);
            }
            //检查是否存在
            if (momentDao.getMomentById(momentId) == null) {
                return new ServiceResult(Status.ERROR, ServiceMessage.NOT_FOUND.message, momentId);
            }
            //删除
            Moment moment = new Moment();
            moment.setId(momentId);
            if (momentDao.delete(moment) != 1) {
                return new ServiceResult(Status.ERROR, ServiceMessage.PLEASE_REDO.message, moment);
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, momentId);
        }
        return new ServiceResult(Status.SUCCESS, ServiceMessage.OPERATE_SUCCESS.message, momentId);
    }

    /**
     * 更新一条朋友圈
     *
     * @param moment 要更新的朋友圈
     * @name updateMoment
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult updateMoment(Moment moment) {
        try {
            //判空
            if (moment == null) {
                throw new ServiceException(ServiceMessage.NOT_NULL.message);
            }
            //检查是否存在
            if (momentDao.getMomentById(moment.getId()) == null) {
                return new ServiceResult(Status.ERROR, ServiceMessage.NOT_FOUND.message, moment);
            }
            //删除
            if (momentDao.update(moment) != 1) {
                return new ServiceResult(Status.ERROR, ServiceMessage.PLEASE_REDO.message, moment);
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, moment);
        }
        return new ServiceResult(Status.SUCCESS, ServiceMessage.OPERATE_SUCCESS.message, moment);
    }

    /**
     * 查询一个用户所发的所有朋友圈
     *
     * @param userId 用户id
     * @param page   页数
     * @name listNews
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult listMyMoment(BigInteger userId, int page) {
        //判空
        if (userId == null) {
            throw new ServiceException(ServiceMessage.NOT_NULL.message);
        }
        List<Moment> list = null;
        //根据页数信息生成查询参数
        int limit = 10;
        int offset = (page - 1) * limit;
        if (offset < 0) {
            return new ServiceResult(Status.SUCCESS, ServiceMessage.PAGE_INVALID.message, list);
        }
        try {
            list = momentDao.listMyMomentByUserId(userId, limit, offset);
            if (list == null || list.size() == 0) {
                return new ServiceResult(Status.SUCCESS, ServiceMessage.NO_MOMENT.message, list);
            }
        } catch (DaoException e) {
            e.printStackTrace();
        }
        return new ServiceResult(Status.SUCCESS, ServiceMessage.OPERATE_SUCCESS.message, list);
    }

    /**
     * 查询一个用户可见的所有朋友圈，包括自己的和朋友的
     *
     * @param userId 用户id
     * @param page   页数
     * @name listNews
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/7
     */
    @Override
    public ServiceResult listNews(BigInteger userId, int page) {
        //判空
        if (userId == null) {
            throw new ServiceException(ServiceMessage.NOT_NULL.message);
        }
        //根据页数信息生成查询参数
        int limit = 10;
        int offset = (page - 1) * limit;
        if (offset < 0) {
            return new ServiceResult(Status.SUCCESS, ServiceMessage.PAGE_INVALID.message, null);
        }
        List<MomentVO> momentVOList = new LinkedList<>();
        try {
            List<News> newsList;
            newsList = newsDao.listNewsByUserId(userId, limit, offset);
            //查找朋友圈动态
            if (newsList == null || newsList.size() == 0) {
                return new ServiceResult(Status.SUCCESS, ServiceMessage.NO_NEWS.message, momentVOList);
            }
            //根据动态中的朋友圈id获取朋友圈数据
            for (News n : newsList) {
                Moment moment = momentDao.getMomentById(n.getMomentId());
                User user = userDao.getUserById(n.getUserId());
                //将朋友圈和动态信息转化成朋友圈视图层对象
                MomentVO momentVO = new MomentVOBuilder().setContent(moment.getContent()).setUserId(moment.getUserId())
                        .setId(moment.getId()).setRemark(moment.getRemark()).setShare(moment.getShare()).setUserName(user.getName())
                        .setView(moment.getView()).setCollect(moment.getCollect()).setLove(moment.getLove()).setUserPhoto(user.getPhoto())
                        .setShared(n.getShared()).setViewed(n.getViewed()).setCollected(n.getCollected()).setPhoto(moment.getPhoto())
                        .setLoved(n.getLoved()).setTime(moment.getTime()).build();
                momentVOList.add(momentVO);
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, momentVOList);
        }
        return new ServiceResult(Status.SUCCESS, ServiceMessage.OPERATE_SUCCESS.message, momentVOList);
    }

    /**
     * 检查一段内容是否合法
     *
     * @param content
     * @return
     */
    private boolean isValidContent(String content) {
        if (content == null || content.trim().isEmpty()) {
            return false;
        }
        //如果内容经过过滤后与原来不一样，说明含有非法内容
        String legalText = toLegalText(content);
        if (content.equals(legalText)) {
            return true;
        }
        return false;
    }
}
