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

package com.hyc.wechat.service.Impl;

import com.hyc.wechat.dao.ChatDao;
import com.hyc.wechat.dao.MemberDao;
import com.hyc.wechat.dao.MessageDao;
import com.hyc.wechat.dao.UserDao;
import com.hyc.wechat.exception.DaoException;
import com.hyc.wechat.factory.DaoProxyFactory;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.Chat;
import com.hyc.wechat.model.po.Member;
import com.hyc.wechat.service.ChatService;
import com.hyc.wechat.service.constants.ServiceMessage;
import com.hyc.wechat.service.constants.Status;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @description 负责提供聊天相关服务
 * @date 2019-05-03 13:52
 */
public class ChatServiceImpl implements ChatService {

    UserDao userDao = (UserDao) DaoProxyFactory.getInstance().getProxyInstance(UserDao.class);
    ChatDao chatDao = (ChatDao) DaoProxyFactory.getInstance().getProxyInstance(ChatDao.class);
    MemberDao memberDao = (MemberDao) DaoProxyFactory.getInstance().getProxyInstance(MemberDao.class);
    MessageDao messageDao = (MessageDao) DaoProxyFactory.getInstance().getProxyInstance(MessageDao.class);

    /**
     * 创建一个聊天
     *
     * @param chat 要创建的聊天对象
     * @return 返回传入的聊天对象
     * @name createChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/3
     */
    @Override
    public ServiceResult createChat(Chat chat) {
        try{
            //阻止插入id
            chat.setId(null);
            //检查创建用户是否存在
            if(userDao.getUserById(chat.getOwnerId())==null){
                return new ServiceResult(Status.ERROR, ServiceMessage.ACCOUNT_NOT_FOUND.message,chat);
            }
            //将该聊天插入数据库
            if(chatDao.insert(chat)!=1){
                return new ServiceResult(Status.ERROR, ServiceMessage.CREATE_CHAT_FAILED.message,chat);
            }
        }catch (DaoException e){
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.SYSTEM_EXECEPTION.message,chat);
        }
        return new ServiceResult(Status.SUCCESS, ServiceMessage.CREATE_CHAT_SUCCESS.message,chat);
    }

    /**
     * 把用户添加到聊天中
     *
     * @param members 要添加的成员对象
     * @return 返回传入的成员对象
     * @name joinChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/3
     */
    @Override
    public ServiceResult joinChat(Member[] members) {
        try{
            for (Member member:members) {
                //阻止插入id
                member.setId(null);
                //检查聊天是否存在
                if(chatDao.getChatById(member.getChatId())==null){
                    return new ServiceResult(Status.ERROR, ServiceMessage.CHAT_NOT_FOUND.message,members);
                }
                //检查用户是否存在
                if(userDao.getUserById(member.getUserId())==null){
                    return new ServiceResult(Status.ERROR, ServiceMessage.ACCOUNT_NOT_FOUND.message,members);
                }
                //检查该用户是否已在此聊天
                if(memberDao.getMemberByUIdAndChatId(member.getUserId(),member.getChatId())!=null){
                    return new ServiceResult(Status.ERROR, ServiceMessage.MEMBER_ALREADY_EXIST.message,members);
                }
                //将该成员插入到此聊天
                if(memberDao.insert(member)!=1){
                    return new ServiceResult(Status.ERROR, ServiceMessage.JOIN_CHAT_FAILED.message,members);
                }
            }
        }catch (DaoException e){
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.SYSTEM_EXECEPTION.message,members);
        }
        return new ServiceResult(Status.SUCCESS, ServiceMessage.JOIN_CHAT_SUCCESS.message,members);
    }

    /**
     * 把成员从聊天中移除，如果该成员是聊天的最后一个成员</br>
     * 就将该聊天一并删除
     *
     * @param members 要移除的成员对象
     * @return 返回移除的成员对象
     * @name quitChat
     * @notice none
     * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
     * @date 2019/5/3
     */
    @Override
    public ServiceResult quitChat(Member[] members) {
        try {
            for (Member member:members) {
                //检查成员是否存在
                if(memberDao.getMemberByUIdAndChatId(member.getUserId(),member.getChatId())==null){
                    return new ServiceResult(Status.ERROR, ServiceMessage.MEMBER_NOT_FOUND.message,members);
                }
                //将该成员从聊天中移除
                if(memberDao.delete(member)!=1){
                    return new ServiceResult(Status.ERROR, ServiceMessage.QUIT_CHAT_FAILED.message,members);
                }
            }
        }catch (DaoException e){
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, ServiceMessage.SYSTEM_EXECEPTION.message,members);
        }
        return new ServiceResult(Status.SUCCESS, ServiceMessage.QUIT_CHAT_SUCCESS.message,members);
    }
}
