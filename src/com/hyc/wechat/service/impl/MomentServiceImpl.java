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

    private final MomentDao momentDao = (MomentDao) DaoProxyFactory.getInstance().getProxyInstance(MomentDao.class);
    private final NewsDao newsDao = (NewsDao) DaoProxyFactory.getInstance().getProxyInstance(NewsDao.class);
    private final UserDao userDao = (UserDao) DaoProxyFactory.getInstance().getProxyInstance(UserDao.class);
    private final FriendDao friendDao = (FriendDao) DaoProxyFactory.getInstance().getProxyInstance(FriendDao.class);

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
        StringBuilder message = new StringBuilder();
        try {
            //判空
            if (moment == null) {
                throw new ServiceException(ServiceMessage.NOT_NULL.message);
            }
            //检查长度
            if(moment.getContent().length()>800){
                return new ServiceResult(Status.ERROR, ServiceMessage.CONTENT_TOO_LONG.message, moment);
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
            moment = momentDao.getMomentByOwnerIdAndStatus(moment.getOwnerId(), 1);
            //查找用户的所有朋友，给他们插入news记录
            List<Friend> friendList = friendDao.listByUserId(moment.getOwnerId());
            for (Friend friend : friendList) {
                News news = new News();
                news.setMomentId(moment.getId());
                news.setUserId(friend.getFriendId());
                newsDao.insert(news);
            }
            //给用户自己插入news记录
            News news = new News();
            news.setMomentId(moment.getId());
            news.setUserId(moment.getOwnerId());
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
        return new ServiceResult(Status.SUCCESS, message.append(ServiceMessage.POST_MOMENT_SUCCESS.message).toString(), moment);
    }

    /**
     * 给好友双方初始化朋友圈，互相添加动态
     *
     * @param friend 好友
     * @return
     * @name initNews
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/18
     */
    @Override
    public ServiceResult initNews(Friend friend) {
        if(friend==null|friend.getFriendId()==null||friend.getUserId()==null){
            return new ServiceResult(Status.ERROR, ServiceMessage.PARAMETER_NOT_ENOUGHT.message, null);
        }
        try{
        List<Moment> momentList = momentDao.listMyMomentByOwnerIdDesc(friend.getUserId(), 1000, 0);
        for (Moment moment : momentList) {
            News news = new News();
            news.setMomentId(moment.getId());
            news.setUserId(friend.getFriendId());
            newsDao.insert(news);
        }
        momentList =momentDao.listMyMomentByOwnerIdDesc(friend.getFriendId(), 1000, 0);
        for (Moment moment : momentList) {
            News news = new News();
            news.setMomentId(moment.getId());
            news.setUserId(friend.getUserId());
            newsDao.insert(news);
        }}catch (DaoException e){
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, null);
        }
        return new ServiceResult(Status.SUCCESS,null,null);
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

        List<MomentVO> momentVOList = new LinkedList<>();
        //根据页数信息生成查询参数
        int limit = 10;
        int offset = (page - 1) * limit;
        if (offset < 0) {
            return new ServiceResult(Status.ERROR, ServiceMessage.PAGE_INVALID.message, null);
        }
        try {
            List<Moment> momentList = momentDao.listMyMomentByOwnerIdDesc(userId, limit, offset);
            if (momentList == null || momentList.size() == 0) {
                return new ServiceResult(Status.SUCCESS, ServiceMessage.NO_MOMENT.message, momentList);
            }
            User user = userDao.getUserById(userId);
            //将朋友圈和用户信息转化成朋友圈视图层对象
            for (Moment moment : momentList) {
                News news = null;
                try {
                    news = newsDao.getNewsByMomentIdAndUserId(moment.getId(), userId);
                } catch (DaoException e) {
                    e.printStackTrace();
                }
                if (news == null) {
                    return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, null);
                }
                toMomentVOObject(momentVOList, news, moment, user);
            }
        } catch (DaoException e) {
            e.printStackTrace();
        }
        return new ServiceResult(Status.SUCCESS,null, momentVOList);
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
            return new ServiceResult(Status.ERROR, ServiceMessage.PAGE_INVALID.message, null);
        }
        List<MomentVO> momentVOList = new LinkedList<>();
        try {
            List<News> newsList;
            newsList = newsDao.listNewsByUserId(userId, limit, offset);
            //查找朋友圈动态
            if (newsList == null || newsList.size() == 0) {
                if(page==1){
                    return new ServiceResult(Status.SUCCESS, ServiceMessage.NO_NEWS.message, momentVOList);
                }
                return new ServiceResult(Status.SUCCESS, ServiceMessage.NO_MORE.message, momentVOList);
            }
            //根据动态中的朋友圈id获取朋友圈数据
            for (News news : newsList) {
                Moment moment = momentDao.getMomentById(news.getMomentId());
                //获取朋友圈的发布者的用户信息
                User user = userDao.getUserById(moment.getOwnerId());
                if(user==null){
                    return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, momentVOList);
                }
                //将朋友圈和动态信息转化成朋友圈视图层对象
                toMomentVOObject(momentVOList, news, moment, user);
                //统计浏览量
                if(!news.getViewed()){
                    moment.setView(moment.getView()+1L);
                    momentDao.update(moment);
                    news.setViewed(true);
                    newsDao.update(news);
                }
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, momentVOList);
        }
        return new ServiceResult(Status.SUCCESS,null, momentVOList);
    }

    /**
     * 更新一个用户对一条朋友圈的点赞状态
     *
     * @param userId   用户id
     * @param momentId 朋友圈id
     * @name love
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/8
     */
    @Override
    synchronized  public ServiceResult love(BigInteger userId, BigInteger momentId) {
        if (userId == null || momentId == null) {
            throw new ServiceException(ServiceMessage.NOT_NULL.message);
        }
        News news;
        try {
            news = newsDao.getNewsByMomentIdAndUserId(momentId, userId);
            //检查news是否存在
            if (news == null) {
                return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, null);
            }
            Moment moment = momentDao.getMomentById(news.getMomentId());
            if (moment == null) {
                return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, null);
            }
            //从非点赞到点赞状态，该朋友圈点赞数加一,否则减一
            moment.setLove(!news.getLoved() ? moment.getLove() + 1 : moment.getLove() - 1);
            momentDao.update(moment);
            //修改状态,如果是ture则改为false,是false则改为ture
            news.setLoved(!news.getLoved());
            newsDao.update(news);
        } catch (DaoException e) {
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, null);
        }
        return new ServiceResult(Status.SUCCESS,null, news.getLoved());
    }

    /**
     * 查询一个用户朋友圈中的所有图片
     *
     * @param userId 用户id
     * @param page   页数
     * @name loadPhoto
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/10
     */
    @Override
    public ServiceResult listPhoto(BigInteger userId, int page) {

        //根据页数信息生成查询参数
        int limit = 10;
        int offset = (page - 1) * limit;
        if (offset < 0) {
            return new ServiceResult(Status.ERROR, ServiceMessage.PAGE_INVALID.message, null);
        }
        //判空
        if (userId == null) {
            throw new ServiceException(ServiceMessage.NOT_NULL.message);
        }
        List<String> photoList = new LinkedList<>();
        try {
                List<Moment> momentList = momentDao.listPhoto(userId,limit,offset);
                if(momentList==null||momentList.size()==0){
                    return new ServiceResult(Status.ERROR, ServiceMessage.NO_MOMENT.message, null);
                }
            for (Moment moment:momentList) {
                photoList.add(moment.getPhoto());
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.DATABASE_ERROR.message, photoList);
        }
        return new ServiceResult(Status.SUCCESS, null, photoList);
    }

    /**
     * 建造一个朋友圈试图层对象集合，需要一个持久化对象集合，和一条动态记录，和该用户的信息
     *
     * @param momentVOList 试图层对象集合
     * @param news         动态记录
     * @param moment       朋友圈
     * @param user         该用户的信息
     * @name toMomentVOObject
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/8
     */
    private void toMomentVOObject(List<MomentVO> momentVOList, News news, Moment moment, User user) {
        MomentVO momentVO = new MomentVOBuilder().setContent(moment.getContent()).setUserId(moment.getOwnerId())
                .setId(moment.getId()).setRemark(moment.getRemark()).setShare(moment.getShare()).setUserName(user.getName())
                .setView(moment.getView()).setCollect(moment.getCollect()).setLove(moment.getLove()).setUserPhoto(user.getPhoto())
                .setShared(news.getShared()).setViewed(news.getViewed()).setCollected(news.getCollected()).setPhoto(moment.getPhoto())
                .setLoved(news.getLoved()).setTime(moment.getTime()).build();
        momentVOList.add(momentVO);
    }

    /**
     * 检查一段内容是否合法
     *
     * @param content 朋友圈内容
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
