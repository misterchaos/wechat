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

import com.hyc.wechat.dao.UserDao;
import com.hyc.wechat.exception.DaoException;
import com.hyc.wechat.factory.DaoProxyFactory;
import com.hyc.wechat.model.dto.ServiceResult;
import com.hyc.wechat.model.po.User;
import com.hyc.wechat.service.UserService;
import com.hyc.wechat.service.constants.Status;

import static com.hyc.wechat.service.constants.ErrorMessage.*;

/**
 * @author <a href="mailto:kobe524348@gmail.com">黄钰朝</a>
 * @program wechat
 * @description 负责提供用户相关服务
 * @date 2019-05-02 03:19
 */
public class UserServiceImpl implements UserService {

    private UserDao userDao = (UserDao) DaoProxyFactory.getInstance().getProxyInstance(UserDao.class);

    @Override
    public ServiceResult checkRegister(User user) {
        try {
            //防止插入id
            user.setId(null);
            //检查邮箱格式
            if(!isValidEmail(user.getEmail())){
                return new ServiceResult(Status.ERROR, EMAIL_FORMAT_INCORRECT.message, user);
            }
            //检查邮箱是否已被注册
            if (userDao.getUserByEmail(user.getEmail()) != null) {
                return new ServiceResult(Status.ERROR, EMAIL_ALREADY_USED.message, user);
            }
            //检查密码是否合法
            if (!isValidPassword(user.getPassword())) {
                return new ServiceResult(Status.ERROR, INVALID_PASSWORD.message, user);
            }
        } catch (DaoException e) {
            e.printStackTrace();
            return new ServiceResult(Status.ERROR, "系统异常，注册失败！", user);
        }
        return new ServiceResult(Status.SUCCESS, "注册信息符合要求！", user);
    }

    @Override
    public ServiceResult insertUser(User user) {
        try {
            if (userDao.insert(user) == 1) {
                return new ServiceResult(Status.SUCCESS, "注册成功！", user);
            }
        } catch (DaoException e) {
            e.printStackTrace();
        }
        return new ServiceResult(Status.ERROR, "注册失败！", user);
    }

    @Override
    public ServiceResult login(User user) {
        return null;
    }



    /*
     **************************************************************
     *               检查用户信息
     **************************************************************
     */

    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        String regex = "\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}";
        return email.matches(regex);
    }


    private boolean isValidUserName(String userName) {
        if (userName == null || userName.trim().isEmpty()) {
            return false;
        }
        String regex = "[\\w_]{6,20}$";
        return userName.matches(regex);
    }

    private boolean isValidPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            return false;
        }
        String regex = "[\\w_]{6,20}$";
        return password.matches(regex);
    }

    private boolean isValidPhoneNum(String number) {
        if (number == null || number.trim().isEmpty()) {
            return false;
        }
        String regex = "0?(13|14|15|17|18|19)[0-9]{9}";
        return number.matches(regex);
    }

    private boolean isValidIdNumber(String number) {
        if (number == null || number.trim().isEmpty()) {
            return false;
        }
        String regex = "\\d{17}[\\d|x]|\\d{15}";
        return number.matches(regex);
    }

    private boolean isValidNickName(String name) {
        if (name == null || name.trim().isEmpty() || name.length() > 20) {
            return false;
        }
        return true;
    }


}
