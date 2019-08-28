<%--
  ~ Copyright (c) 2019.  黄钰朝
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~      http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>

<%--
  Created by IntelliJ IDEA.
  User: Misterchaos
  Date: 2019/5/1
  Time: 15:55
 To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="host" value="localhost:8080/wechat"/>
<%--设置主机名--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <title>wechat</title>
    <link rel="shortcut icon" type=image/x-icon href=https://res.wx.qq.com/a/wx_fed/assets/res/NTI4MWU5.ico>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js"></script>
    <!--BEGIN——发送请求脚本-->
    <script>
        //post方法
        function postRequest(url, request, callback) {
            $.post(url, request, function (data, status) {
                if (status === 'error') {
                    alert("请求发送失败，请刷新浏览器重试或检查网络");
                }
                var result = eval("(" + data + ")");
                if (result.message != null && result.message !== '') {
                    alert("系统提示：" + result.message);
                }
                callback(result);

            });
        }

        //ajax方法
        function ajaxJsonRequest(url, data, callback) {
            $.ajax({
                url: url,
                type: 'POST',
                data: data,
                dataType: 'json',
                contentType: 'application/json',
                success: function (data) {
                    if (data.message != null && data.message !== '') {
                        alert("系统提示：" + data.message);
                    }
                    callback(data);
                },
                Error: function (xhr, error, exception) {
                    alert("请求发送失败，请刷新浏览器重试或检查网络");
                    alert(exception.toString());
                    callback(data);
                }
            });
        }


    </script>
    <!--END——发送请求脚本-->
</head>
<body>
<div class="page-body" style="background-color: #eee;">
    <img id="background" src="${pageContext.request.contextPath}/upload/photo/${sessionScope.login.chatBackground}"
         style="position: absolute;height: 100%;width: 100%">


    <!--BEGIN——菜单列表-->
    <div class="menu">
        <div class="menu-head">
            <div class="menu-head-photo">
                <img src="${pageContext.request.contextPath}/upload/photo/${sessionScope.login.photo}"
                     class="menu-head-img"
                     onclick="showWindowOnRight('user-info-box')">
            </div>
            <div class="menu-head-info">
                <h3 class="menu-head-nickname">${sessionScope.login.name}</h3>
            </div>
        </div>
        <div class="menu-search">
            <i class="menu-search-icon"></i>
            <input id="keyword" type="text" placeholder="搜索用户" class="menu-search-bar" oninput="enterClick('search')">
            <div id="search" onclick="searchUser()" class="search-button">搜索</div>
        </div>
        <div class="menu-option">
            <div class="menu-option-item">
                <div id="chat" onclick="showWindowOnLeft('chat-list')" class="menu-option-button">聊天</div>
            </div>
            <div class="menu-option-item">
                <div id="friend" onclick="showWindowOnLeft('friend-list')" class="menu-option-button">通讯录</div>
            </div>
            <div class="menu-option-item">
                <div id="setting" onclick="showWindowOnLeft('setting-list')" class="menu-option-button">设置</div>
            </div>
            <div class="menu-option-item">
                <div id="moment" onclick="showWindowOnLeft('moment-list')" class="menu-option-button">朋友圈</div>
            </div>

        </div>
        <!--BEGIN——功能列表-->
        <div id="menu-body" class="menu-body" data-window="chat-list" onload="document.getElementById('chat').click()">
            <div id="chat-list" style="display: block"></div>
            <div id="friend-list" style="display: none">
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="document.getElementById('search').click()">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">添加好友</h3>
                                <p class="my-message">搜索并添加系统中的用户为好友</p>
                            </div>
                        </div>
                    </div>
                </button>
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="createChat()">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">创建群聊</h3>
                                <p class="my-message">创建一个群聊，邀请好友加入</p>
                            </div>
                        </div>
                    </div>
                </button>
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="joinChat()">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">加入群聊</h3>
                                <p class="my-message">通过群号加入一个群聊</p>
                            </div>
                        </div>
                    </div>
                </button>
            </div>
            <div id="article-list" style="display: none"></div>
            <div id="moment-list" style="display: none">
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="showWindowOnRight('post-moment-box')">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">发朋友圈</h3>
                                <p class="my-message">发布一条自己的朋友圈分享自己的动态</p>
                            </div>
                        </div>
                    </div>
                </button>
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="loadNews(document.getElementById('news-box').dataset.page)">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">查看朋友圈</h3>
                                <p class="my-message">查看自己和朋友发的朋友圈</p>
                            </div>
                        </div>
                    </div>
                </button>
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="loadMyMoment(document.getElementById('moment-box').dataset.page)">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">我的朋友圈</h3>
                                <p class="my-message">查看自己发布的朋友圈</p>
                            </div>
                        </div>
                    </div>
                </button>
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="loadPhoto(document.getElementById('photo-box').dataset.page)">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">朋友圈相册</h3>
                                <p class="my-message">查看自己朋友圈中的照片</p>
                            </div>
                        </div>
                    </div>
                </button>
            </div>
            <div id="setting-list" style="display: none">
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="showWindowOnRight('user-info-box')">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">更新个人信息</h3>
                                <p class="my-message">更新昵称/头像/个性签名/微信号/...</p>
                            </div>
                        </div>
                    </div>
                </button>
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="updatePassword()">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">更新登陆密码</h3>
                                <p class="my-message">更新账户的登陆密码</p>
                            </div>
                        </div>
                    </div>
                </button>
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="document.getElementById('background-upload').click()">
                    <input type="file" name="file" id="background-upload"
                           accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"
                           oninput="updateBackground()"
                           style="display: none">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">更换聊天背景</h3>
                                <p class="my-message">上传一张自己的图片作为聊天窗口的背景图</p>
                            </div>
                        </div>
                    </div>
                </button>
                <button class="user-list-block-href" onmouseover="this.style.backgroundColor='#3A3F45'"
                        onmouseout="this.style.backgroundColor='#2e3238';"
                        onclick="logout()">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">退出登陆</h3>
                                <p class="my-message">注销当前账号在此浏览器上的登陆</p>
                            </div>
                        </div>
                    </div>
                </button>

            </div>
        </div>
        <!--END——功能列表-->

    </div>
    <!--END——菜单列表-->

    <!--BEGIN——右边窗口-->
    <div id="right-page" data-window="-1">

        <!--BEGIN——聊天窗口-->
        <div id="-1" class="chat-box" style="display:block;background: transparent;">
            <div id="${param.chat_id}accept-message" class="chat-output-box" style="padding-top: 20px;">
                   

                <div class="chat-output-content-left">       
                    <img src="${pageContext.request.contextPath}/upload/photo/系统.jpg" alt="头像"
                         class="chat-output-head-photo-left">     
                    <h4 class="chat-output-meta-left">系统账号</h4>
                    <div class="chat-output-bubble-left">
                        <pre class="chat-output-bubble-pre-left">系统消息：这是一个在线聊天系统，左侧是功能列表，点击头像可以查看您的个人信息，您可以搜索并向系统中的用户发出好友申请，可以创建自己的聊天群组，可以发布自己的朋友圈，在朋友圈下方写评论，更多功能，等你探索！


开发者信息
开发者：黄钰朝
联系邮箱：<a href="mailto:kobe524348@gmail.com">kobe524348@gmail.com</a>
项目启动时间：2019-05-01
版本号：1.0
发布时间：2019-05-15
开源许可：<a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License 2.0  Copyright 黄钰朝</a></pre>
                    </div>
                </div>
            </div>
        </div>
        <!--END——聊天窗口-->
        <!--BEGIN——用户信息窗口-->
        <div id="user-info-box" class="info-box" style="display: none">
            <div class="info-box-head">   
                <div class="info-box-title">       
                    <div class="info-box-title-box"><a class="info-box-title-text">个人信息</a></div>

                    <button id="update-user" onclick="updateUserInfo()"
                            style="float: right" class="button" contenteditable="false">更新
                    </button>


                </div>
            </div>
            <div id="${sessionScope.login.id}info" class="info-detail-box" onclick="enterClick('update-user')">
                   
                <div class="info-outline">
                    <div class="info-head-photo">
                        <img id="user-preview"
                             src="${pageContext.request.contextPath}/upload/photo/${sessionScope.login.photo}"
                             class="info-head-img"
                             onclick="document.getElementById('user-photo').click()">
                        <input type="file" name="file" id="user-photo"
                               accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"
                               oninput="imgPreview(document.getElementById('user-photo'),'user-preview')"
                               style="display: none">

                    </div>
                    <div class="info-head-info">
                        <h3 class="info-head-nickname">${sessionScope.login.name}</h3>
                    </div>
                </div>
                <div class="info-detail">
                    <div class="info-detail-block">
                        <div class="info-detail-item" contenteditable="false">昵称:</div>
                        <div class="info-detail-value" id="name" contenteditable="true">${sessionScope.login.name}</div>
                    </div>
                    <div class="info-detail-block">
                        <div class="info-detail-item">个性签名:</div>
                        <div class="info-detail-value" id="signature"
                             contenteditable="true">${sessionScope.login.signature}</div>
                    </div>
                    <div class="info-detail-block">
                        <div class="info-detail-item">微信号:</div>
                        <div class="info-detail-value" id="wechat_id"
                             contenteditable="true">${sessionScope.login.wechatId}</div>
                    </div>
                    <div class="info-detail-block">
                        <div class="info-detail-item">性别:</div>
                        <div class="info-detail-value" id="gender"
                             contenteditable="true">${sessionScope.login.gender}</div>
                    </div>
                    <div class="info-detail-block">
                        <div class="info-detail-item">地区:</div>
                        <div class="info-detail-value" id="location"
                             contenteditable="true">${sessionScope.login.location}</div>
                    </div>
                </div>
            </div>
        </div>
        <!--END——用户信息窗口-->
        <!--BEGIN——搜索结果列表窗口-->
        <div id="search-result-box" class="info-box" style="display: none"></div>
        <!--END——搜索结果列表窗口-->
        <!--BEGIN——发朋友圈窗口-->
        <div id="post-moment-box" class="info-box" style="display: none">
            <div class="info-box-head">   
                <div class="info-box-title">       
                    <div class="info-box-title-box"><a class="info-box-title-text">写朋友圈</a></div>
                    <button id="post-moment" onclick="postMoment()" style="float: right;
                   border: solid 1px;width: 72px;"
                            contenteditable="false">发布
                    </button>
                </div>
            </div>
            <div id="${sessionScope.login.id}info" class="info-detail-box">
                <div class="info-outline">
                    <div class="info-head-photo">
                        <img id="moment-preview" src="${pageContext.request.contextPath}/upload/photo/upload.jpg"
                             class="info-head-img"
                             onclick="document.getElementById('moment-photo').click()">
                        <input type="file" name="file" id="moment-photo"
                               accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"
                               oninput="imgPreview(document.getElementById('moment-photo'),'moment-preview')"
                               style="display: none">
                    </div>
                    <div class="info-head-info">
                        <h3 class="info-head-nickname" style="font-size: 30px">单击左侧上传图片</h3>
                    </div>
                </div>
                <div class="info-detail">
                    <div class="info-detail-block" style="margin-left: 20px">
                        <label for="moment-content"></label>
                        <textarea class="input-text-content" style="width: 70%" id="moment-content" autofocus="autofocus" cols="100"
                                  contenteditable="true" onchange="enterClick('post-moment')" placeholder="分享自己的动态..."
                                  required="required" maxlength="800" oninput="enterClick('post-moment')"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <!--END——发朋友圈窗口-->
        <!--BEGIN——查看朋友圈窗口-->
        <div id="news-box" data-page="1" class="info-box" style="display: none">
            <div class="info-box-head">   
                <div class="info-box-title">       
                    <div class="info-box-title-box"><a class="info-box-title-text">朋友圈</a></div>
                    <button onclick="loadNews(++document.getElementById('news-box').dataset.page)"
                            class="button" contenteditable="false">下页
                    </button>
                    <button onclick="loadNews(--document.getElementById('news-box').dataset.page<1?
                    ++document.getElementById('news-box').dataset.page:document.getElementById('news-box').dataset.page)"
                            class="button" contenteditable="false">上页
                    </button>
                </div>
            </div>
            <div id="${sessionScope.login.id}info" class="info-detail-box">
                <div id="news-box-content" class="info-detail">
                </div>
            </div>
        </div>
        <!--END——查看朋友圈窗口-->
        <!--BEGIN——查看我的朋友圈窗口-->
        <div id="moment-box" data-page="1" class="info-box" style="display: none">
            <div class="info-box-head">   
                <div class="info-box-title">       
                    <div class="info-box-title-box"><a class="info-box-title-text">朋友圈</a></div>
                    <button onclick="loadMyMoment(++document.getElementById('moment-box').dataset.page)"
                            class="button" contenteditable="false">下页
                    </button>
                    <button onclick="loadMyMoment(--document.getElementById('moment-box').dataset.page<1?
                    ++document.getElementById('moment-box').dataset.page:document.getElementById('moment-box').dataset.page)"
                            class="button" contenteditable="false">上页
                    </button>
                </div>
            </div>
            <div id="${sessionScope.login.id}info" class="info-detail-box">
                <div id="moment-box-content" class="info-detail">
                </div>
            </div>
        </div>
        <!--END——查看我的朋友圈窗口-->
        <!--BEGIN——查看相册窗口-->
        <div id="photo-box" data-page="1" class="info-box" style="display: none">
            <div class="info-box-head">   
                <div class="info-box-title">       
                    <div class="info-box-title-box"><a class="info-box-title-text">朋友圈</a></div>
                    <button onclick="loadPhoto(++document.getElementById('photo-box').dataset.page)"
                            class="button" contenteditable="false">下页
                    </button>
                    <button onclick="loadPhoto(--document.getElementById('photo-box').dataset.page<1?
                   ++document.getElementById('photo-box').dataset.page:document.getElementById('photo-box').dataset.page)"
                            class="button" contenteditable="false">上页
                    </button>
                </div>
            </div>
            <div id="${sessionScope.login.id}info" class="info-detail-box">
                <div id="photo-box-content" class="info-detail">
                </div>
            </div>
        </div>
        <!--END——查看相册窗口-->
        <!--BEGIN——查看朋友圈详情窗口-->
        <div id="news-detail-box" class="info-box" style="display: none">
            <div class="info-box-head">   
                <div class="info-box-title">       
                    <div class="info-box-title-box"><a class="info-box-title-text">朋友圈</a></div>
                    <button onclick="loadNews(document.getElementById('news-box').dataset.page)"
                            class="button" contenteditable="false">返回
                    </button>
                </div>
            </div>
            <div id="${sessionScope.login.id}info" class="info-detail-box">
                <div id="news-detail-box-content" class="info-detail">
                </div>
            </div>
        </div>

        <!--END——查看朋友圈详情窗口-->

    </div>

    <!--END——右边窗口-->

</div>
<!--BEGIN——监听键盘-->
<script>
    function enterClick(button_id) {
        document.onkeydown = function (event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode === 13) {
                event.cancelBubble = true;
                event.preventDefault();
                event.stopPropagation();
                document.getElementById(button_id).click();
            }
        };
    }
</script>
<!--END——监听键盘-->

<!--BEGIN——程序执行脚本-->
<script>


    //创建群聊
    function createChat() {
        var name = prompt("请输入群聊名称", "广工夸夸群");
        if (name == null) {
            return;
        }
        if (name === '') {
            alert("您没有设置群聊名称，将使用默认名称");
        }
        var number = prompt("请输入群号", "");
        if (number == null) {
            return;
        }
        if (number === '') {
            alert("群号不可为空，必须由6-20位数字组成");
            return;
        }

        var url = "http://${host}/wechat/chat?method=add.do";
        var request = JSON.stringify({
            owner_id: "${sessionScope.login.id}",
            name: name,
            number: number
        });
        ajaxJsonRequest(url, request, function (result) {
            if (result.status === "SUCCESS") {
                addChat(number);
            }
        })
    }

    //修改好友信息
    function updateFriend(id) {
        var alias = prompt("请输入好友昵称", "蔡徐坤");
        if (alias == null) {
            return;
        }
        if (alias === '') {
            alert("昵称不能为空");
            return;
        }
        var description = prompt("请输入好友描述", "灵魂篮球练习生");
        var url = "http://${host}/wechat/friend?method=update.do";
        var request = JSON.stringify({
            id: id,
            alias: alias,
            description: description
        });
        ajaxJsonRequest(url, request, function (result) {
            if (result.status === "SUCCESS") {
                loadFriendList();
            }
        })
    }

    //加入群聊
    function joinChat() {
        var number = prompt("请输入群号", "");
        if (number == null) {
            return;
        }
        if (number === '') {
            alert("群号不可为空");
            return;
        }
        var apply = prompt("请输入加群申请(加群申请会作为你的第一条消息发送到群聊中)", "");
        if (confirm("是否确定发送加群申请？")) {
            var url = "http://${host}/wechat/chat";
            var request = {
                method: "join.do",
                user_id: ${sessionScope.login.id},
                number: number,
                apply: apply
            };
            postRequest(url, request, function (result) {
                if (result.status === "SUCCESS") {
                    addChat(number);
                }
            });
        } else {
            return;
        }
    }

    //加载一个聊天
    function addChat(number) {
        var url = "http://${host}/wechat/chat";
        var request = {
            method: "get.do",
            user_id: ${sessionScope.login.id},
            number: number
        };
        postRequest(url, request, function (result) {
            var chat = result.data;
            if (result.status === "SUCCESS") {
                loadChatListOnMenu(chat);
                loadChatBox(chat);
                loadUnReadMessageInAChat(chat.id, 1);
            }
        });
    }

    //更新密码
    function updatePassword() {
        var old_password = prompt("请输入旧密码", "");
        if (old_password == null) {
            return;
        }
        var new_password = prompt("请输入新密码", "");
        if (new_password == null) {
            return;
        }
        if (new_password === '') {
            alert("密码必须为6-20位英文字母，数字或下划线组成");
            return;
        }
        var url = "http://${host}/wechat/user";
        var request = {
            method: "updatepassword.do",
            user_id: ${sessionScope.login.id},
            old_password: old_password,
            new_password: new_password
        };
        postRequest(url, request, function (result) {
        });
    }

    //注销登陆
    function logout() {
        if (confirm("是否确定要退出登陆？注销之后你需要重新登陆")) {
            var url = 'http://${host}/wechat/user';
            var request = {
                method: "logout.do",
                user_id: ${sessionScope.login.id},
            };
            alert("正在退出登陆，请稍后...");
            postRequest(url, request, function (result) {
                if (result.status === 'SUCCESS') {
                    window.location.href = '${pageContext.request.contextPath}/login.jsp';
                }
            });
        } else {
            return;
        }
    }


    //请求搜索用户结果
    function searchUser() {
        var name = document.getElementById("keyword").value;
        if (name === '') {
            alert("请在输入框输入用户的昵称进行搜索");
            document.getElementById('keyword').focus();
            return;
        }
        var url = "http://${host}/wechat/user";
        var request = {
            method: "list.do",
            name: name
        };
        postRequest(url, request, function (result) {
            var users = result.data;
            if (users.length == 0) {
                return;
            }
            loadSearchResult();
            for (var i = 0; i < users.length; i++) {
                addSearchUserResultHtml(users[i]);
            }
        })
    }

    //显示群成员
    function showChatMember(chat_id) {
        alert("正在加载聊天信息，请稍后...");
        var url = "http://${host}/wechat/chat";
        var request = {
            method: "member.do",
            chat_id: chat_id
        };
        postRequest(url, request, function (result) {
            var members = result.data;
            if (members.length === 0) {
                return;
            }
            loadChatInfoHead(chat_id);
            for (var i = 0; i < members.length; i++) {
                addMemberHtml(members[i]);
            }
        })
    }

    //清除聊天记录
    function deleteChatMessage(chat_id) {
        var url = "http://${host}/wechat/message";
        var request = {
            method: "clear.do",
            chat_id: chat_id,
            user_id: "${sessionScope.login.id}"
        };
        postRequest(url, request, function (result) {
        })
    }

    //显示聊天窗口
    function showChatBox(chat_id) {
        showWindowOnRight(chat_id);

        var url = "http://${host}/wechat/message";
        var request = {
            method: "read.do",
            user_id: ${sessionScope.login.id},
            chat_id: chat_id
        };
        postRequest(url, request, function (result) {

        })
    }

    //加载聊天列表，并且每个聊天加载隐藏的聊天窗口
    function loadChatListAndBox() {
        var url = "http://${host}/wechat/chat";
        var request = {
            method: "list.do",
            id: "${sessionScope.login.id}"
        };
        postRequest(url, request, function (result) {
            var chats = result.data;
            console.log("查询到聊天窗口数量：" + chats.length);
            for (var i = 0; i < chats.length; i++) {
                loadChatListOnMenu(chats[i]);
                loadChatBox(chats[i]);
            }
            loadUnReadMessage(1);
        });
    }


    //加载加载好友列表
    function loadFriendList() {
        var url = "http://${host}/wechat/friend";
        var request = {
            method: "list.do",
            user_id: "${sessionScope.login.id}"
        };
        postRequest(url, request, function (result) {
            document.getElementById("friend-list").innerHTML = ' <button class="user-list-block-href" onmouseover="this.style.backgroundColor=\'#3A3F45\'"\n' +
                '                        onmouseout="this.style.backgroundColor=\'#2e3238\';"\n' +
                '                        onclick="document.getElementById(\'search\').click()">\n' +
                '                    <div class="user-list-block">\n' +
                '                        <div class="user-box">\n' +
                '                            <div class="user-info">\n' +
                '                                <h3 class="my-name">添加好友</h3>\n' +
                '                                <p class="my-message">搜索并添加系统中的用户为好友</p>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </button>\n' +
                '                <button class="user-list-block-href" onmouseover="this.style.backgroundColor=\'#3A3F45\'"\n' +
                '                        onmouseout="this.style.backgroundColor=\'#2e3238\';"\n' +
                '                        onclick="createChat()">\n' +
                '                    <div class="user-list-block">\n' +
                '                        <div class="user-box">\n' +
                '                            <div class="user-info">\n' +
                '                                <h3 class="my-name">创建群聊</h3>\n' +
                '                                <p class="my-message">创建一个群聊，邀请好友加入</p>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </button>\n' +
                '                <button class="user-list-block-href" onmouseover="this.style.backgroundColor=\'#3A3F45\'"\n' +
                '                        onmouseout="this.style.backgroundColor=\'#2e3238\';"\n' +
                '                        onclick="joinChat()">\n' +
                '                    <div class="user-list-block">\n' +
                '                        <div class="user-box">\n' +
                '                            <div class="user-info">\n' +
                '                                <h3 class="my-name">加入群聊</h3>\n' +
                '                                <p class="my-message">通过群号加入一个群聊</p>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </button>';
            var friends = result.data;
            for (var i = 0; i < friends.length; i++) {
                loadFriendOnMenu(friends[i]);
            }
        });
    }

    //加载未读消息
    function loadUnReadMessage(page) {
        var url = "http://${host}/wechat/message";
        var request = {
            method: "unread.do",
            user_id: "${sessionScope.login.id}",
            page: page
        };
        postRequest(url, request, function (result) {
            var messages = result.data;
            console.log("查询到未读消息 ： " + messages.length)

            for (var i = messages.length - 1; i >= 0; i--) {
                showMessage(messages[i]);
            }
        });
    }


    //加载一个聊天的未读消息
    function loadUnReadMessageInAChat(chat_id, page) {
        var url = "http://${host}/wechat/message";
        var request = {
            method: "unread.do",
            user_id: "${sessionScope.login.id}",
            chat_id: chat_id,
            page: page
        };
        postRequest(url, request, function (result) {
            var messages = result.data;
            console.log("查询到未读消息 ： " + messages.length)
            for (var i = messages.length - 1; i >= 0; i--) {
                showMessage(messages[i]);
            }
        });
    }

    //加载一个聊天中的所有消息
    function loadAllMessage(page, chat_id) {
        var url = "http://${host}/wechat/message";
        var request = {
            method: "list.do",
            user_id: "${sessionScope.login.id}",
            chat_id: chat_id,
            page: page,
        };
        postRequest(url, request, function (result) {
            document.getElementById(chat_id + "accept-message").innerHTML = '';
            var messages = result.data;
            for (var i = messages.length - 1; i >= 0; i--) {
                showMessage(messages[i]);
            }
        });
    }

    //加载朋友圈动态
    function loadNews(page) {
        var url = "http://${host}/wechat/moment";
        var request = {
            method: "news.do",
            user_id: "${sessionScope.login.id}",
            page: page
        };
        alert("正在加载朋友圈动态，请稍后...");
        postRequest(url, request, function (result) {
            var news = result.data;
            //加载之前先将之前的清空
            document.getElementById('news-box-content').innerHTML = '';
            for (var i = 0; i <= news.length - 1; i++) {
                addNewsBlockHtml(news[i]);
            }
        });
        showWindowOnRight('news-box');
    }

    //加载我的朋友圈
    function loadMyMoment(page) {
        var url = "http://${host}/wechat/moment";
        var request = {
            method: "moment.do",
            user_id: "${sessionScope.login.id}",
            page: page
        };
        alert("正在加载您的朋友圈，请稍后...");
        postRequest(url, request, function (result) {
            var moments = result.data;
            //加载之前先将之前的清空
            document.getElementById('moment-box-content').innerHTML = '';
            for (var i = 0; i < moments.length - 1; i++) {
                addMomentBlockHtml(moments[i]);
            }
        });
        showWindowOnRight('moment-box');
    }

    //查询朋友圈图片
    function loadPhoto(page) {
        var url = 'http://${host}/wechat/moment';
        var request = {
            method: "photo.do",
            user_id: ${sessionScope.login.id},
            page: page
        };
        alert("正在加载朋友圈相册，请稍后...");
        postRequest(url, request, function (result) {
            var photos = result.data;
            //加载之前先将之前的清空
            document.getElementById('photo-box-content').innerHTML = '';
            for (var i = 0; i < photos.length; i++) {
                addPhotoHtml(photos[i]);
            }
        });
        showWindowOnRight('photo-box');
    }

    //下一页
    function nextNewsPage() {
        var page = document.getElementById("news-box").dataset.page;
        loadNews(page);
        document.getElementById("news-box").dataset.page = page + 1;
    }

    //删除朋友圈
    function deleteMoment(moment_id) {
        if (confirm("是否确定要删除这条朋友圈？")) {
            var url = 'http://${host}/wechat/moment';
            var request = {
                method: "delete.do",
                moment_id: moment_id
            };
            postRequest(url, request, function (result) {
            });
        } else {
            return;
        }
    }

    //删除朋友圈评论
    function deleteRemark(remark_id, moment_id) {
        if (confirm("是否确定要删除这条评论？")) {
            var url = 'http://${host}/wechat/remark';
            var request = {
                method: "delete.do",
                remark_id: remark_id
            };
            postRequest(url, request, function (result) {
                addMomentDetailHtml(moment_id);
            });
        } else {
            return;
        }
    }

    //删除好友
    function deleteFriend(friend_id) {
        if (confirm("是否确定要删除这个好友？")) {
            var url = 'http://${host}/wechat/friend';
            var request = {
                method: "delete.do",
                user_id: ${sessionScope.login.id},
                friend_id: friend_id
            };
            alert("正在删除好友，请稍后...");
            postRequest(url, request, function (result) {
                loadFriendList();
            });
        } else {
            return;
        }
    }


    //加好友
    function addFriend(friend_id) {

        var url = "http://${host}/wechat/friend?method=add.do";
        var description = prompt("请输入好友申请", "我是${sessionScope.login.name},快加我为好友吧！");
        var alias = prompt("请输入好友备注", "");
        if (description == null) {
            return;
        }
        var request = JSON.stringify({
            user_id: "${sessionScope.login.id}",
            friend_id: friend_id,
            description: description,
            alias: alias
        });
        if (alias == null) {
            return;
        }
        if (confirm("是否确定要发送好友申请？")) {
            alert("正在发送好友申请，请稍后...");
            ajaxJsonRequest(url, request, function (result) {
            })
        } else {
            return;
        }
    }

    //同意加好友
    function agreeAddFriend(friend_id) {
        if (confirm("是否确定同意好友申请？")) {
            console.log("同意加好友：friend_id " + friend_id);
            var url = "http://${host}/wechat/friend?method=add.do";
            var alias = prompt("请输入好友备注", "");
            if (alias == null) {
                return;
            }
            var request = JSON.stringify({
                user_id: "${sessionScope.login.id}",
                friend_id: friend_id,
                alias: alias
            });
            alert("正在同意好友申请，请稍后...");
            ajaxJsonRequest(url, request, function (result) {
            })
        } else {
            return;
        }
    }


    //退出群聊
    function quitChat(chat_id) {
        if (confirm("是否确定要退出该群聊？")) {
            var url = "http://${host}/wechat/chat?method=quit.do";
            var request = JSON.stringify({
                user_id: "${sessionScope.login.id}",
                chat_id: chat_id,
            });
            alert("正在退出群聊，请稍后...");
            ajaxJsonRequest(url, request, function (result) {
            })
        } else {
            return;
        }
    }

    //更新个人信息
    function updateUserInfo() {
        if (confirm("是否确定更新个人信息？")) {
            var jsonStr = JSON.stringify({
                id: "${sessionScope.login.id}",
                name: document.getElementById("name").innerText,
                signature: document.getElementById("signature").innerText,
                wechat_id: document.getElementById("wechat_id").innerText,
                gender: document.getElementById("gender").innerText,
                location: document.getElementById("location").innerText
            });
            //更新基本信息
            alert("正在更新个人信息，请稍后...");
            var url = "http://${host}/wechat/user?method=update.do";
            ajaxJsonRequest(url, jsonStr, function (result) {
                if ("SUCCESS" === result.status) {
                } else {
                }
            });
            //更新头像
            url = "http://${host}/wechat/upload?method=uploadphoto.do&id=${sessionScope.login.id}&table=user";
            uploadPhoto(url, 'user-photo');
        } else {
            return;
        }
    }


    //更新聊天背景
    function updateBackground() {
        imgPreview(document.getElementById('background-upload'), 'background');
        var url = "http://${host}/wechat/upload?method=background.do&id=${sessionScope.login.id}";
        alert("正在更新聊天背景，请稍后...");
        uploadPhoto(url, 'background-upload');
    }

    //发布朋友圈
    function postMoment() {
        var content = document.getElementById("moment-content").value;
        var jsonStr = JSON.stringify({
            owner_id: "${sessionScope.login.id}",
            content: content
        });
        var url = "http://${host}/wechat/moment?method=add.do";
        if (!('' === content)) {
            alert("正在发布朋友圈，请稍后...");
            ajaxJsonRequest(url, jsonStr, function (result) {
                if ("SUCCESS" === result.status) {
                    //成功之后上传图片
                    url = "http://${host}/wechat/upload?method=uploadphoto.do&id=" + result.data.id + "&table=moment";
                    uploadPhoto(url, 'moment-photo');
                } else {
                }
            });
            document.getElementById("moment-content").value = '';
        } else {
            alert("发送内容不能为空");
            return;
        }
    }

    //点赞朋友圈
    function loveMoment(moment_id, moment_love) {
        var url = 'http://${host}/wechat/moment';
        var request = {
            method: "love.do",
            moment_id: moment_id,
            user_id:${sessionScope.login.id},
        };
        postRequest(url, request, function (result) {
            var islove = result.data;
            var love = parseInt(document.getElementById(moment_id + "love").dataset.love);
            console.log("当前点赞数" + love);
            if (islove) {
                document.getElementById(moment_id + "love").innerText = '点赞(' + (love + 1) + ')';
                document.getElementById(moment_id + "love").dataset.love = love + 1;
            } else {
                document.getElementById(moment_id + "love").innerText = '点赞(' + (love - 1) + ')';
                document.getElementById(moment_id + "love").dataset.love = love - 1;
            }
        });
    }


    //评论朋友圈//TODO
    function remarkMoment(moment_id) {
        var content = prompt("请输入评论", '');
        if (content == null) {
            return;
        }
        var time = new Date().getTime();
        var url = "http://${host}/wechat/remark?method=add.do";
        var request = JSON.stringify({
            user_id: "${sessionScope.login.id}",
            moment_id: moment_id,
            time: time,
            content: content
        });
        if (!('' === content || content == null)) {
            if (confirm("是否确定要发布该评论？")) {
                alert("正在发布评论，请稍后...");
                ajaxJsonRequest(url, request, function (result) {
                    var remark = parseInt(document.getElementById(moment_id + "remark").dataset.remark);
                    console.log("当前评论数" + remark);
                    document.getElementById(moment_id + "remark").dataset.remark = remark + 1;
                    document.getElementById(moment_id + "remark").innerText = '评论(' + (remark + 1) + ')';
                    addMomentDetailHtml(moment_id);
                })
            } else {
                return;
            }
        } else {
            alert("评论内容不能为空");
            return;
        }
    }

    //回复一条评论
    function replyRemark(moment_id, user_name) {
        var content = prompt("请输入回复", "");
        if (content == null) {
            return;
        }
        content = "@" + user_name + " " + content;
        var time = new Date().getTime();
        var url = "http://${host}/wechat/remark?method=add.do";
        var request = JSON.stringify({
            user_id: "${sessionScope.login.id}",
            moment_id: moment_id,
            time: time,
            content: content
        });
        if (!('' === content)) {
            if (confirm("是否确定要发布该回复？")) {
                alert("正在发布回复，请稍后...");
                ajaxJsonRequest(url, request, function (result) {
                    var remark = parseInt(document.getElementById(moment_id + "remark").dataset.remark);
                    document.getElementById(moment_id + "remark").dataset.remark = remark + 1;
                    document.getElementById(moment_id + "remark").innerText = '评论(' + (remark + 1) + ')';
                    addMomentDetailHtml(moment_id);

                })
            } else {
                return;
            }
        } else {
            alert("回复内容不能为空");
            return;
        }
    }


    //上传图片
    function uploadPhoto(url, photo_id) {
        var formData = new FormData();
        formData.append('photo', $(document.getElementById(photo_id))[0].files[0]);  //添加图片信息的参数
        $.ajax({
            url: url,
            type: 'POST',
            cache: false, //上传文件不需要缓存
            data: formData,
            processData: false, // 告诉jQuery不要去处理发送的数据
            contentType: false, // 告诉jQuery不要去设置Content-Type请求头
            success: function (data) {
                if (data.message != null && data.message !== '') {
                    alert("系统提示：" + data.message);
                }
            },
            Error: function (xhr, error, exception) {
                alert(exception.toString());
            }
        })
    }

    //加载聊天列表
    function loadChatListOnMenu(chat) {
        var chat_html = '<button class="user-list-block-href"  onmouseover="this.style.backgroundColor=\'#3A3F45\';" ' +
            'onmouseout="this.style.backgroundColor=\'#2e3238\';"' +
            'onclick="showChatBox(\'' + chat.id + '\')"><div class="user-list-block">\n' +
            '                <div class="user-box" >\n' +
            '                    <div class="user-photo">\n' +
            '                        <img src="${pageContext.request.contextPath}/upload/photo/' + chat.photo + '" alt="用户头像" class="my-photo">\n' +
            '                    </div>\n' +
            '                    <div class="user-info">\n' +
            '                        <h3 class="my-name">' + chat.name + '</h3>\n' +
            '                        <p class="my-message" id="' + chat.id + 'new-message">没有新消息</p>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div></button>';
        document.getElementById("chat-list").innerHTML += chat_html;
    }

    //加载通知列表
    function loadNotify(notify) {
        var html = '        <button class="user-list-block-href" onmouseover="this.style.backgroundColor=#3A3F45;"\n' +
            '                        onmouseout="this.style.backgroundColor=#2e3238;"\n' +
            '                        onclick="">\n' +
            '                    <div class="user-list-block">\n' +
            '                        <div class="user-box">\n' +
            '                            <div class="user-photo">\n' +
            '                                <img src="${pageContext.request.contextPath}/upload/photo/' + friend.photo + '  " alt="用户头像" class="my-photo">\n' +
            '                            </div>\n' +
            '                            <div class="user-info">\n' +
            '                                <h3 class="my-name"></h3>\n' +
            '                                <p class="my-message">' + friend.description + ' </p>\n' +
            '                            </div>\n' +
            '                        </div>\n' +
            '                    </div>\n' +
            '                    <button id="" onclick="postMoment()" style="float: right;\n' +
            '                    background-color:#1AAD19;border: solid 1px;width: 100px;margin-right: 50px"\n' +
            '                            contenteditable="false">发布\n' +
            '                    </button>\n' +
            '                </button>';
        document.getElementById("notify-list").innerHTML += chat_html;
    }

    //加载好友列表
    function loadFriendOnMenu(friend) {
        var chat_html = '<button class="user-list-block-href"  onmouseover="this.style.backgroundColor=\'#3A3F45\';" ' +
            'onmouseout="this.style.backgroundColor=\'#2e3238\';"' +
            '><div class="user-list-block">\n' +
            '                <div class="user-box" onclick="updateFriend(\'' + friend.id + '\')">\n' +
            '                    <div class="user-photo">\n' +
            '                        <img src="${pageContext.request.contextPath}/upload/photo/' + friend.photo + '" alt="用户头像" class="my-photo">\n' +
            '                    </div>\n' +
            '                    <div class="user-info">\n' +
            '                        <h3 class="my-name">' + friend.alias + '</h3>\n' +
            '                        <p class="my-message">' + friend.description + '</p>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>  ' +
            '<div class="menu-option-item">\n' +
            '                <div id="chat" onclick="showChatBox(\'' + friend.chat_id + '\')" class="menu-option-button">发消息</div>\n' +
            '            </div>          ' +
            '<div class="menu-option-item">\n' +
            '                <div id="chat"  onclick="deleteFriend(\'' + friend.friend_id + '\')" class="menu-option-button" style="float: right">删除好友</div>\n' +
            '            </div></button>';
        document.getElementById("friend-list").innerHTML += chat_html;
    }

    //加载好友通知
    function loadAddFriendOnMenu(message) {
        var chat_html = '<button class="user-list-block-href"  onmouseover="this.style.backgroundColor=\'#3A3F45\';" ' +
            'onmouseout="this.style.backgroundColor=\'#2e3238\';"' +
            '><div class="user-list-block">\n' +
            '                <div class="user-box" >\n' +
            '                    <div class="user-photo">\n' +
            '                        <img src="${pageContext.request.contextPath}/upload/photo/' + message.sender_photo + '" alt="用户头像" class="my-photo">\n' +
            '                    </div>\n' +
            '                    <div class="user-info">\n' +
            '                        <h3 class="my-name">' + message.sender_name + '</h3>\n' +
            '                        <p class="my-message">' + message.content + '</p>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>  ' +
            '<div class="menu-option-item">\n' +
            '                <div id="chat" onclick="agreeAddFriend(\'' + message.sender_id + '\')" class="menu-option-button">同意</div>\n' +
            '            </div>          ';
        document.getElementById("friend-list").innerHTML += chat_html;
    }

    //加载搜索结果页面，并显示
    function loadSearchResult() {
        document.getElementById("search-result-box").innerHTML =
            '            <div class="info-box-head">          \n' +
            '                <div class="info-box-title">                  \n' +
            '                    <div class="info-box-title-box"><a class="info-box-title-text">用户列表</a></div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div class="info-detail-box">                  \n' +
            '                <div id="content" class="info-detail">           \n' +
            '                    <div></div>\n' +
            '                </div>\n' +
            '            </div>\n';

        showWindowOnRight("search-result-box");
    }

    //加载群聊信息
    function loadChatInfoHead(chat_id) {
        document.getElementById("search-result-box").innerHTML =
            '                <div class="chat-box-title">       \n' +
            '                        <a class="chat-box-title-text">聊天成员列表</a>       \n' +
            '                </div>\n' +
            '            <div class="info-detail-box">                  \n' +
            '                <div id="content" class="info-detail">           \n' +
            '                    <div></div>\n' +
            '                </div>\n' +
            '            </div>\n';

        showWindowOnRight("search-result-box");
    }

    //让该id对应的窗口显示出来，并把之前的隐藏起来
    function showWindowOnRight(window_id) {
        var current_window = document.getElementById("right-page").dataset.window;
        console.log("隐藏窗口id : " + current_window);
        document.getElementById(current_window).style.display = "none";
        document.getElementById(window_id).style.display = "";
        document.getElementById("right-page").dataset.window = window_id;
        console.log("当前窗口id : " + document.getElementById("right-page").dataset.window);
    }

    //让该id对应的窗口显示出来，并把之前的隐藏起来
    function showWindowOnLeft(window_id) {
        var current_window = document.getElementById("menu-body").dataset.window;
        console.log("隐藏窗口id : " + current_window);
        document.getElementById(current_window).style.display = "none";
        document.getElementById(window_id).style.display = "";
        document.getElementById("menu-body").dataset.window = window_id;
        console.log("当前窗口id : " + document.getElementById("menu-body").dataset.window);
    }


    //加载发朋友圈窗口
    function loadPostMomentBox() {
        var html = '<div class="info-box" id="info-box">\n' +
            '            <div class="info-box-head">   \n' +
            '                <div class="info-box-title">       \n' +
            '                    <div class="info-box-title-box"><a class="info-box-title-text">写朋友圈</a></div>\n' +
            '                    <button id="post-moment" onclick="postMoment()"\n' +
            '                            style="float: right" contenteditable="false">发布\n' +
            '                    </button>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '            <div id="${sessionScope.login.id}info" class="info-detail-box">\n' +
            '                <div class="info-outline">\n' +
            '                    <div class="info-head-photo">\n' +
            '                        <img id="preview" src="${pageContext.request.contextPath}/upload/photo/upload.jpg" class="info-head-img"\n' +
            '                             onclick="document.getElementById(\'input_file\').click()">\n' +
            '                        <input type="file" name="file" id="input_file"\n' +
            '                               accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"\n' +
            '                               oninput="imgPreview(document.getElementById(\'input_file\'))" style="display: none">\n' +
            '                    </div>\n' +
            '                    <div class="info-head-info">\n' +
            '                        <h3 class="info-head-nickname" style="    font-size: 30px;">单击左侧上传图片</h3>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '                <div class="info-detail">\n' +
            '                    <div class="info-detail-block" style="margin-left: 20px">\n' +
            '                        <label for="moment-content"></label>\n' +
            '                        <textarea class="input-text-content" style="    width: 70%;" id="moment-content" autofocus="autofocus" cols="100"\n' +
            '                                  contenteditable="true" onchange="enterClick(\'post-moment\')" placeholder="分享自己的动态..."\n' +
            '                                  required="required" maxlength="300" oninput="enterClick(\'post-moment\')"></textarea>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '        </div>\n';
        document.getElementById("info-box").innerHTML = html;
    }

    //加载图片
    function imgPreview(fileDom, preview) {
        //判断是否支持FileReader
        if (window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持图片预览功能，如需该功能请升级您的设备！");
        }
        //获取文件
        var file = fileDom.files[0];
        var imageType = /^image\//;
        //是否是图片
        if (!imageType.test(file.type)) {
            alert("该文件不是图片或者已经损坏，请重新选择！");
            return;
        }
        //图片大小
        var size = (file.size / 1024) / 1024;
        console.log("size" + size);
        if (size > 5) {
            alert("图片大小不能大于5m！");
            file.value = "";
            return;
        } else if (size <= 0) {
            alert("文件大小不能为0M！");
            file.value = "";
            return;
        }

        //读取完成
        reader.onload = function (e) {
            //获取图片dom
            var img = document.getElementById(preview);
            //图片路径设置为读取的图片
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);

    }


    //动态加载聊天窗口，不显示loadAllMessage(page, chat_id)
    function loadChatBox(chat) {
        var html =
            '<div id="' + chat.id + '" class="chat-box" style="display: none;background: transparent;">\n' +
            '            <div class="chat-box-title">\n' +
            '                    <button onclick="quitChat(\'' + chat.id + '\')"\n' +
            '                            class="button" contenteditable="false">退出聊天\n' +
            '                    </button>\n' +
            '         <button \n' +
            '                            onclick="deleteChatMessage(\'' + chat.id + '\')"\n' +
            '                            class="button" contenteditable="false">清除聊天记录\n' +
            '                    </button>' +
            '         <button \n' +
            '                            onclick="showChatMember(\'' + chat.id + '\')"\n' +
            '                            class="button" contenteditable="false">聊天信息\n' +
            '                    </button>' +
            '         <button \n' +
            '                            onclick="loadAllMessage(\'1\',\'' + chat.id + '\')"\n' +
            '                            class="button" contenteditable="false">加载已读消息\n' +
            '                    </button>' +
            '                    <p class="chat-box-title-text">\n' +
            '                        ' + chat.name + '\n' +
            '                    </p>\n' +

            '            </div>\n' +
            '<div class="chat-box-head">\n' +
            '        </div>\n' +
            '        <div id="' + chat.id + 'accept-message" class="chat-output-box" style="background: transparent;">\n' +
            '        </div>\n' +
            '        <div class="chat-input-box" style="background-color:#eee;" >\n' +
            '            <button id="' + chat.id + 'send-button" onclick="sendMessage(\'' + chat.id + '\',\'user\')"  style="float: left" class="button">发送</button>\n' +


            '      <input type="file" name="file" id="' + chat.id + 'send-file"\n' +
            '                               oninput="send_file(document.getElementById(\'' + chat.id + 'send-file\'),\'' + chat.id + 'send-file\',\'' + chat.id + 'send-message\',\'' + chat.id + '\')"\n' +
            '                               style="display: none">' +
            '            <button onclick="document.getElementById(\'' + chat.id + 'send-file\').click()" style="float: left" class="' +
            'button">文件</button>\n' +

            '      <input type="file" name="file" id="' + chat.id + 'send-img"\n' +
            '                               oninput="send_img(document.getElementById(\'' + chat.id + 'send-img\'),\'' + chat.id + 'send-img\',\'' + chat.id + 'send-message\',\'' + chat.id + '\')"\n' +
            '                               style="display: none">' +
            '            <button  onclick="document.getElementById(\'' + chat.id + 'send-img\').click()" style="float: left" class="button">图片</button>\n' +

            '            <textarea id="' + chat.id + 'send-message" class="text-area" autofocus="autofocus" cols="100"\n' +
            '                      required="required" maxlength="300"  oninput="enterClick(\'' + chat.id + 'send-button\')"></textarea>\n' +
            '        </div></div>';
        document.getElementById("right-page").innerHTML += html;
    }

    //发送消息
    function sendMessage(chat_id, type) {
        if (websocket === null) {
            alert("正在初始化websocket连接，第一次连接需要加载数据，请稍后...");
            return;
        }
        if (websocket === '') {
            alert("您已断开与服务器的连接，可能您的账号已在别处登陆，请刷新浏览器重新连接服务器");
            return;
        }
        var content = document.getElementById(chat_id + 'send-message').value;
        if (!('' === content)) {
            var user_id = "${sessionScope.login.id}";
            var time = new Date().getTime();
            websocket.send(JSON.stringify({
                sender_id: user_id,
                chat_id: chat_id,
                content: content,
                type: type,
                time: time
            }));
            //发送完之后将消息清空
            document.getElementById(chat_id + 'send-message').value = '';
        } else {
            alert("发送内容不能为空");
            return;
        }
    }

    //发送文件
    function send_file(fileDom, file_id, preview, chat_id) {
        //判断是否支持FileReader
        if (window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持文件预览功能，如需该功能请升级您的设备！");
        }
        //获取文件
        var file = fileDom.files[0];
        //文件大小
        var size = (file.size / 1024) / 1024;
        console.log("size" + size);
        if (size > 20) {
            alert("文件大小不能大于20m！");
            file.value = "";
            return;
        } else if (size <= 0) {
            alert("文件大小不能为0M！");
            file.value = "";
            return;
        }
        if (confirm("是否确定要立即发送文件：" + file.name)) {
            //upload-file
            var formData = new FormData();
            var url = "http://${host}/wechat/upload?method=uploadfile.do";
            formData.append('file', $(document.getElementById(file_id))[0].files[0]);
            $.ajax({
                url: url,
                type: 'POST',
                cache: false,
                data: formData,
                dataType: 'json',
                processData: false,
                contentType: false,
                success: function (result) {
                    if (result.message != null && result.message !== '') {
                        alert("系统提示：" + result.message);
                    }
                    if ("SUCCESS" === result.status) {
                        var html = '<a href="http://${host}/upload/file/' + result.data + '" download="' + file.name + '">下载</a>';
                        document.getElementById(preview).value += '[文件：' + file.name + ']' + html;
                        sendMessage(chat_id, "file");
                    }
                },
                Error: function (xhr, error, exception) {
                    alert(exception.toString());
                }
            })
        } else {
            return;
        }
    }

    //发送图片
    function send_img(fileDom, file_id, preview, chat_id) {
        //判断是否支持FileReader
        if (window.FileReader) {
            var reader = new FileReader();
        } else {
            alert("您的设备不支持文件预览功能，如需该功能请升级您的设备！");
        }
        //获取文件
        var file = fileDom.files[0];
        //文件大小
        var size = (file.size / 1024) / 1024;
        console.log("size" + size);
        var imageType = /^image\//;
        //是否是图片
        if (!imageType.test(file.type)) {
            alert("该文件不是图片或者已经损坏，请重新选择！");
            return;
        }
        if (size > 5) {
            alert("图片大小不能大于5m！");
            file.value = "";
            return;
        } else if (size <= 0) {
            alert("文件大小不能为0M！");
            file.value = "";
            return;
        }
        //读取完成
        reader.onload = function () {
        };
        reader.readAsDataURL(file);
        if (confirm("是否确定要立即发送图片：" + file.name)) {
            //upload-file
            var formData = new FormData();
            var url = "http://${host}/wechat/upload?method=uploadfile.do";
            formData.append('file', $(document.getElementById(file_id))[0].files[0]);
            $.ajax({
                url: url,
                type: 'POST',
                cache: false,
                data: formData,
                dataType: 'json',
                processData: false,
                contentType: false,
                success: function (result) {
                    if (result.message != null && result.message !== '') {
                        alert("系统提示：" + result.message);
                    }
                    if ("SUCCESS" === result.status) {
                        var html = '<img src="${pageContext.request.contextPath}/upload/file/' + result.data + '"\n' +
                            '         style="height: 100%;width: 100%;max-height:200px;max-width:200px;">\n';
                        document.getElementById(preview).value += html;
                        sendMessage(chat_id, "img");
                    }
                },
                Error: function (xhr, error, exception) {
                    alert(exception.toString());
                }
            })
        } else {
            return;
        }
    }


    //移除一个成员
    function removeMember(member_id, chat_id) {
        if (confirm("是否确定要移除该成员？")) {
            var url = 'http://${host}/wechat/chat';
            var request = {
                method: "remove.do",
                member_id: member_id,
            };
            alert("正在移除该成员，请稍后...");
            postRequest(url, request, function (result) {
                if ('SUCCESS' === result.status) {
                    showChatMember(chat_id);
                }
            });
        } else {
            return;
        }
    }

    //插入一个搜索用户的结果
    function addSearchUserResultHtml(user) {
        <%--var html = '                   <div class="info-detail-block">               \n' +--%>
        <%--    // '                        <div class="user-box" style="border-top: 1px solid;margin: 20px;">\n' +--%>
        <%--    '                            <div class="user-photo" style="margin: 20px">\n' +--%>
        <%--    '                                <img src="${pageContext.request.contextPath}/upload/photo/' + user.photo + '" alt="用户头像" class="my-photo">\n' +--%>
        <%--    '                            </div>\n' +--%>
        <%--    '                            <div class="user-info">\n' +--%>
        <%--    '                                <h3 class="my-name" style="color: #333；width: fit-content;">' + user.name + '</h3>\n' +--%>
        <%--    '                            <button onclick="addFriend(\'' + user.id + '\')" style="float: right"\n' +--%>
        <%--    '                                    contenteditable="false">加好友\n' +--%>
        <%--    '                            </button>\n' +--%>
        <%--    '                            </div>\n' +--%>
        <%--    '                                <p class="my-message" style="margin-top:-25px;">' + user.signature + '</p>\n' +--%>
        <%--    // '                        </div>\n' +--%>
        <%--    '                    </div>';--%>
        var html = '                   <div class="info-detail-block" style="  width: 95%;min-width:300px;">               \n' +
            // '                        <div class="user-box" style="border-top: 1px solid;margin: 20px;">\n' +
            '                            <div class="user-photo" style="margin: 20px">\n' +
            '                                <img src="${pageContext.request.contextPath}/upload/photo/' + user.photo + '" alt="用户头像" class="my-photo">\n' +
            '                            </div>\n' +
            '                            <div class="user-info">\n' +
            '                                <h3 class="my-name" style="color: #333;width: fit-content;">' + user.name + '</h3>\n' +
            '                            <button onclick="addFriend(\'' + user.id + '\')" class="button"\n' +
            '                                    contenteditable="false">加好友\n' +
            '                            </button>\n' +
            '                            </div>\n' +
            '                                <p class="my-message" style="margin-top:-25px;width: 70%;">' + user.signature + '</p>\n' +
            // '                        </div>\n' +
            '                    </div>';
        document.getElementById("content").innerHTML += html;
    }

    //插入一个群成员的信息
    function addMemberHtml(member) {
        var html = '                   <div class="info-detail-block" style="  width: 95%;min-width:300px;">               \n' +
            // '                        <div class="user-box" style="border-top: 1px solid;margin: 20px;">\n' +
            '                            <div class="user-photo" style="margin: 20px">\n' +
            '                                <img src="${pageContext.request.contextPath}/upload/photo/' + member.photo + '" alt="用户头像" class="my-photo">\n' +
            '                            </div>\n' +
            '                            <div class="user-info">\n' +
            '                                <h3 class="my-name" style="color: #333;width: fit-content;">' + member.name + '</h3>\n' +
            '                            <button onclick="removeMember(\'' + member.id + '\',\'' + member.chat_id + '\')" class="button"\n' +
            '                                    contenteditable="false">移出该群\n' +
            '                            </button>\n' +
            '                            <button onclick="addFriend(\'' + member.user_id + '\')" class="button"\n' +
            '                                    contenteditable="false">加好友\n' +
            '                            </button>\n' +
            '                            </div>\n' +
            '                                <p class="my-message" style="margin-top:-25px;width: 60%;">' + member.signature + '</p>\n' +
            // '                        </div>\n' +
            '                    </div>';
        document.getElementById("content").innerHTML += html;
    }


    //显示朋友圈详情
    function addMomentDetailHtml(moment_id) {
        var html = '           <div id="' + moment.id + '" class="info-detail-block" style="margin-left: 20px">\n' +
            document.getElementById(moment_id).innerHTML +
            '                    </div>';
        document.getElementById("news-detail-box-content").innerHTML = html;
        loadRemark(moment_id, 1);
        showWindowOnRight('news-detail-box');
    }

    //加载评论
    function loadRemark(moment_id, page) {
        var url = "http://${host}/wechat/remark";
        var request = {
            method: "list.do",
            moment_id: moment_id,
            page: page
        };
        alert("正在加载评论，请稍侯...");
        postRequest(url, request, function (result) {
            var remarks = result.data;
            for (var i = 0; i < remarks.length; i++) {
                addRemarkBlockHtml(remarks[i]);
            }
        });
    }

    //插入一条用户的朋友圈评论
    function addRemarkBlockHtml(remark) {
        var time = new Date(remark.time).toLocaleString();
        var html = '           <div id="' + remark.id + '" class="info-detail-block" style="margin-left: 20px;margin-bottom: -26px">\n' +
            '                        <label for="moment-content">\n' +
            '                            <div class="info-detail-block" style="margin-bottom: -5px;">               \n' +
            '                                <div class="user-box" style="width: 95%;border-bottom: 1px solid #ccc;    margin-left: 70px;">\n' +
            '                                    <div class="user-photo">\n' +
            '                                        <img src="${pageContext.request.contextPath}/upload/photo/' + remark.user_photo + '" alt="用户头像" class="my-photo">\n' +
            '                                    </div>\n' +
            '                                    <div onclick="addMomentDetailHtml(\'' + remark.id + '\')" class="user-info" style="height: fit-content;margin-bottom: 11px;">\n' +
            '                                        <h3 class="my-name" style="color: #333">' + remark.user_name + ' 发布于 ' + time + '</h3>\n' +
            '                                        <div style="word-break: break-all;white-space: normal;max-width: 600px;">' + remark.content + '</div>\n' +
            '                                    </div>\n' +
            '                                    <button id="' + remark.id + 'love" data-love="' + remark.love + '" onclick="dev()" style="float: left"\n' +
            '                                            contenteditable="false" class="button">点赞\(' + remark.love + '\)\n' +
            '                                    </button>\n' +
            '                                    <button id="' + remark.id + 'remark" data-reply="' + remark.reply + '" onclick="replyRemark(\'' + remark.moment_id + '\',\'' + remark.user_name + '\')" style="float: left"\n' +
            '                                            contenteditable="false" class="button">回复' +
            '                                    </button>\n';
        var visitorArea =
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </label>\n' +
            '                    </div>';
        var ownerArea =
            '                                    <button onclick="deleteRemark(\'' + remark.id + '\',\'' + remark.moment_id + '\')" style="float: right" \n' +
            '                                            contenteditable="false" class="button">删除\n' +
            '                                    </button>\n' +
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </label>\n' +
            '                    </div>';
        if (remark.user_id ===${sessionScope.login.id}) {
            document.getElementById("news-detail-box-content").innerHTML += html + ownerArea;
        } else {
            document.getElementById("news-detail-box-content").innerHTML += html + visitorArea;
        }
    }

    //插入一条朋友圈动态
    function addNewsBlockHtml(moment) {
        var time = new Date(moment.time).toLocaleString();
        var html = '           <div id="' + moment.id + '" class="info-detail-block" style="margin-left: 20px;margin-bottom:0px;">\n' +
            '                        <label for="moment-content" style="    margin-bottom: -47px;">\n' +
            '                            <div class="info-detail-block" >               \n' +
            '                                <div class="user-box" style="border-bottom: 1px solid #ccc;width:100%;">\n' +
            '                                    <div class="user-photo">\n' +
            '                                        <img src="${pageContext.request.contextPath}/upload/photo/' + moment.user_photo + '" alt=w"用户头像" class="my-photo">\n' +
            '                                    </div>\n' +
            '                                    <div onclick="addMomentDetailHtml(\'' + moment.id + '\')" class="user-info" style="height: fit-content;margin-bottom: 11px;">\n' +
            '                                        <h3 class="my-name" style="color: #333">' + moment.user_name + ' 发布于 ' + time + '</h3>\n' +
            '                                        <div style="word-break: break-all;white-space: normal;    max-width: 70%">' + moment.content + '</div>\n' +
            '                                        <img src="${pageContext.request.contextPath}/upload/photo/' + moment.photo + '" style="position:relative;height: 100%;' +
            '                                       max-width:500px;max-height:300px;width: 100%">\n' +
            '                                    </div>\n' +
            '                                    <button id="' + moment.id + 'love" data-love="' + moment.love + '" ' +
            '                                       onclick="loveMoment(\'' + moment.id + '\',' + moment.love + ')" style="float: left;height: 30px;"  class="button" \n' +
            '                                            contenteditable="false">点赞\(' + moment.love + '\)\n' +
            '                                    </button>\n' +
            '                                    <button id="' + moment.id + 'remark" data-remark="' + moment.remark + '" ' +
            '                                       onclick="remarkMoment(\'' + moment.id + '\',' + moment.remark + ')" style="float: left;height: 30px;"  class="button" \n' +
            '                                            contenteditable="false">评论\(' + moment.remark + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="dev()" style="float: left;height: 30px;"  class="button" \n' +
            '                                            contenteditable="false">收藏\(' + moment.collect + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="dev()" style="float: left;height: 30px;"  class="button" \n' +
            '                                            contenteditable="false">转发\(' + moment.share + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="" style="float: left;height: 30px;"  class="button" \n' +
            '                                            contenteditable="false">浏览量\(' + moment.view + '\)\n' +
            '                                    </button>\n';

        var visitorArea =
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </label>\n' +
            '                    </div>';
        var ownerArea =
            '                                    <button onclick="deleteMoment(\'' + moment.id + '\')" style="float: left;margin-left: 210px;height: 30px;"  \n' +
            '                                            class="button" contenteditable="false">删除\n' +
            '                                    </button>\n' +
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </label>\n' +
            '                    </div>';
        if (moment.owner_id ===${sessionScope.login.id}) {
            document.getElementById("news-box-content").innerHTML += html + ownerArea;
        } else {
            document.getElementById("news-box-content").innerHTML += html + visitorArea;
        }
    }

    //插入一条用户的朋友圈
    function addMomentBlockHtml(moment) {
        var time = new Date(moment.time).toLocaleString();
        var html = '           <div id="' + moment.id + '" class="info-detail-block" style="margin-left: 20px;margin-bottom:0px;">\n' +
            '                        <label for="moment-content" style="    margin-bottom: -47px;">\n' +
            '                            <div class="info-detail-block" >               \n' +
            '                                <div class="user-box" style="border-bottom: 1px solid #ccc;width:100%;">\n' +
            '                                    <div class="user-photo">\n' +
            '                                        <img src="${pageContext.request.contextPath}/upload/photo/' + moment.user_photo + '" alt=w"用户头像" class="my-photo">\n' +
            '                                    </div>\n' +
            '                                    <div onclick="addMomentDetailHtml(\'' + moment.id + '\')" class="user-info" style="height: fit-content;margin-bottom: 11px;">\n' +
            '                                        <h3 class="my-name" style="color: #333">' + moment.user_name + ' 发布于 ' + time + '</h3>\n' +
            '                                        <div style="word-break: break-all;white-space: normal;    max-width: 70%">' + moment.content + '</div>\n' +
            '                                        <img src="${pageContext.request.contextPath}/upload/photo/' + moment.photo + '" style="position:relative;height: 100%;' +
            '                                       max-width:500px;max-height:300px;width: 100%">\n' +
            '                                    </div>\n' +
            '                                    <button id="' + moment.id + 'love" data-love="' + moment.love + '" ' +
            '                                       onclick="loveMoment(\'' + moment.id + '\',' + moment.love + ')" style="float: left;height: 30px;"  class="button"\n' +
            '                                            contenteditable="false">点赞\(' + moment.love + '\)\n' +
            '                                    </button>\n' +
            '                                    <button id="' + moment.id + 'remark" data-remark="' + moment.remark + '" ' +
            '                                       onclick="remarkMoment(\'' + moment.id + '\',' + moment.remark + ')" style="float: left;height: 30px;"  class="button"\n' +
            '                                            contenteditable="false">评论\(' + moment.remark + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="dev()" style="float: left;height: 30px;"  class="button"\n' +
            '                                            contenteditable="false">收藏\(' + moment.collect + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="dev()" style="float: left;height: 30px;"  class="button"\n' +
            '                                            contenteditable="false">转发\(' + moment.share + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="" style="float: left;height: 30px;"  class="button"\n' +
            '                                            contenteditable="false">浏览量\(' + moment.view + '\)\n' +
            '                                    </button>\n';

        var visitorArea =
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </label>\n' +
            '                    </div>';
        var ownerArea =
            '                                    <button onclick="deleteMoment(\'' + moment.id + '\')" style="float: left;margin-left: 210px;height: 30px;"\n' +
            '                                            class="button" contenteditable="false">删除\n' +
            '                                    </button>\n' +
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </label>\n' +
            '                    </div>';
        document.getElementById("moment-box-content").innerHTML += html + ownerArea;
    }

    //插入朋友圈照片
    function addPhotoHtml(photo) {
        var html = '           <div class="info-detail-block" style="margin-left: 20px">\n' +
            '                            <div class="info-detail-block">               \n' +
            '                                <div class="user-box" style="">\n' +
            '                                    <div class="user-info" style="    border-bottom: 1px solid #ccc;height: fit-content;margin-bottom: 11px;">\n' +
            '                                        <img src="${pageContext.request.contextPath}/upload/photo/' + photo + '" style="position:relative;height: 100%;' +
            'max-width:500px;max-height:300px;width: 100%">\n' +
            '                                    </div>\n' +
            '                                </div>\n' +
            '                            </div>\n' +
            '                    </div>';

        document.getElementById("photo-box-content").innerHTML += html;
    }

    //将消息显示在消息对应的聊天窗口上,并在聊天列表对应位置显示
    function addMessageToChat(message) {
        var right_bubble_html = '<div class="chat-output-content-right">\n' +
            '    <img src="${pageContext.request.contextPath}/upload/photo/' + message.sender_photo + '" alt="头像" class="chat-output-head-photo-right">\n' +
            '    <div class="chat-output-bubble-right">\n' +
            '        <div class="chat-output-bubble-inner">\n' +
            '            <pre class="chat-output-bubble-pre-right">' + message.content + '</pre></div></div></div>';
        var left_bubble_html = '<div class="chat-output-content-left">\n' +
            '    <img src="${pageContext.request.contextPath}/upload/photo/' + message.sender_photo + '" alt="头像" class="chat-output-head-photo-left">\n' +
            '    <h4 class="chat-output-meta-left">' + message.sender_name + '</h4>\n' +
            '    <div class="chat-output-bubble-left">\n' +
            '        <div class="chat-output-bubble-inner">\n' +
            '            <pre class="chat-output-bubble-pre-left">' + message.content + '</pre></div></div></div>';
        if (message.sender_id ===${sessionScope.login.id}) {
            document.getElementById(message.chat_id + "accept-message").innerHTML += '<br/>' + right_bubble_html;
        } else {
            document.getElementById(message.chat_id + "accept-message").innerHTML += '<br/>' + left_bubble_html;
        }
        document.getElementById(message.chat_id + "accept-message").scrollTop = document.getElementById(message.chat_id + "accept-message").scrollHeight;
        //显示在列表上
        if ("file" === message.type) {
            document.getElementById(message.chat_id + "new-message").innerText = "你收到一个文件";
        } else if ("img" === message.type) {
            document.getElementById(message.chat_id + "new-message").innerText = "你收到一个图片";
        } else {
            document.getElementById(message.chat_id + "new-message").innerText = message.content;
        }
    }

    //显示消息
    function showMessage(message) {
        if (message.type === "system") {
            alert(message.content);
            return;
        }
        if (message.type === "user" || message.type === "file" || message.type === "img") {
            console.log("显示用户消息");
            addMessageToChat(message);
        }
        if (message.type === "friend") {
            alert("收到好友申请");
            console.log("显示加好友通知");
            loadAddFriendOnMenu(message);
            addMessageToChat(message);
        }
    }

    //功能不可用
    function dev() {
        alert("该功能正在开发中，暂时不可用");
    }

</script>
<!--END——程序执行脚本-->
<!--BEGIN——websocket脚本-->
<script type="text/javascript">
    var websocket = null;
    var url = "ws://${host}/server/chat/${sessionScope.login.id}";

    function connectWebsocket() {

        //判断当前浏览器是否支持WebSocket
        if ('WebSocket' in window) {
            websocket = new WebSocket(url);
        } else {
            alert('当前浏览器不支持 websocket,无法进行实时聊天')
        }

        //连接发生错误的回调方法
        websocket.onerror = function () {
            alert("WebSocket连接发生错误,请刷新浏览器重新连接");
            websocket = '';
        };

        //连接成功建立的回调方法
        websocket.onopen = function () {
        }

        //接收到消息的回调方法
        websocket.onmessage = function (event) {
            // alert("收到服务器的新消息" + event.data);
            var message = eval("(" + event.data + ")");
            showMessage(message);
        }
        //连接关闭的回调方法
        websocket.onclose = function () {
            alert("WebSocket连接已关闭，请刷新浏览器重新连接");
            websocket = '';
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            closeWebSocket();
        }

    }


    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();

    }


</script>
<!--END——websocket脚本-->
<!--BEGIN——预加载脚本-->
<script>
    //请求聊天列表
    loadChatListAndBox();
    loadFriendList();
    connectWebsocket();
</script>
<!--END——预加载脚本-->
</body>
<style>
    .info-box {
        position: relative;
        background-color: #eee;
        overflow: hidden
    }

    .info-box-head {
        text-align: center;
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        line-height: 40px
    }

    .info-head-img {
        width: 220px;
        height: 220px;
        margin: 62px;
        border-radius: 14px;
        float: left;
    }

    .info-head-info {
        float: left;
        margin-top: 89px;
        max-width: 360px;
        overflow: hidden
    }

    .info-head-nickname {
        font-size: 53px;
        max-height: 200px;
        overflow: hidden;
        word-wrap: break-word;
        word-break: break-all;
    }

    .info-box-title {
        position: relative;
        padding: 10px 0;
        margin: 0 19px;
        border-bottom: 1px solid #d6d6d6;
        background-color: #eee;
        z-index: 1024
    }

    .info-box-title-box {
        font-weight: 400;
        height: 25px;
        display: inline-block;
        font-size: 23px;
        float: left
    }

    .info-box-title-text {
        display: inline-block;
        vertical-align: middle;
        max-width: 300px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        word-wrap: normal;
        text-decoration: none;
        color: #000;
        font-weight: 400;
    }

    .info-outline {
        float: left;
        height: fit-content;
        width: 100%;
    }

    .info-detail {
        float: left;
        height: fit-content;
        width: 100%;
    }

    .info-detail-block {
        float: left;
        height: fit-content;
        width: 100%;
        margin-bottom: 20px;
        min-width: 850px;
    }

    .info-detail-item {
        height: 50px;
        font-size: 34px;
        padding-left: 62px;
        text-align: left;
        position: absolute;
        width: 255px;
    }

    .info-detail-value {
        text-align: left;
        width: 800px;
        font-size: 34px;
        height: 50px;
        position: relative;
        margin-left: 300px;
        border-bottom: solid 2px #ccc;
        outline: none;
        white-space: nowrap;
    }

    .input-text-content {
        border-top: 1px solid #d6d6d6;
        height: 200px;
        width: 90%;
        margin-left: 30px;
        margin-right: 30px;
        margin-bottom: 15px;
        resize: none;
        overflow-y: auto;
        overflow-x: hidden;
        padding-left: 20px;
        outline: solid;
        border: 0;
        font-size: 25px;
        background-color: #eee
    }

    .info-submit-box {
        position: fixed;
        height: 250px;
        bottom: 0;
        min-height: 250px;
        border-top: 1px solid #d6d6d6;
    }

    .info-detail-box {
        overflow: scroll;
        position: relative;
        margin-bottom: 0px;
        margin-right: 0px;
        margin-top: 80px;
        min-height: 682px;
        height: -webkit-fill-available;
    }

    .page-body {
        min-width: 800px;
        margin: 0 auto;
        border-radius: 3px;
        -moz-border-radius: 3px;
        -webkit-border-radius: 3px;
        overflow: hidden;
    }

    .menu {
        width: 30%;
        position: relative;
        /*height: 750px;*/
        height: -webkit-fill-available;
        min-height: 750px;
        float: left;
        overflow: scroll;
        background: #2e3238;
        display: block;
    }

    .menu-head {
        padding: 18px;
        position: relative;
    }

    .menu-head-photo {
        display: table-cell;
        vertical-align: middle;
        word-wrap: break-word;
        word-break: break-all;
        white-space: nowrap;
        padding-right: 10.625px;
    }

    .menu-head-img {
        width: 60px;
        height: 60px;
        border-radius: 2px;
        -moz-border-radius: 2px;
        -webkit-border-radius: 2px;
        display: block;
        cursor: pointer;
    }

    .menu-head-info {
        display: table-cell;
        vertical-align: middle;
        word-wrap: break-word;
        word-break: break-all;
        width: 2000px;
    }

    .menu-head-nickname {
        font-weight: 400;
        font-size: 30px;
        color: #fff;
        line-height: 20px;
        margin-top: 5px;
    }

    .menu-search {
        position: relative;
        width: -webkit-fill-available;
        margin: 30px;
    }

    .menu-search-icon {
        position: absolute;
        z-index: 101;
        top: 1px;
    }

    .search-button {
        padding: 13px;
        float: right;
        height: 50px;
        width: 55px;
        background-color: #3A3F45;
        color: white;
    }


    .menu-search-bar {
        height: 50px;
        line-height: 32px;
        border: 0;
        border-radius: 2px;
        -moz-border-radius: 2px;
        -webkit-border-radius: 2px;
        background-color: #26292e;
        color: #fff;
        padding-left: 10px;
        font-size: 20px;
        width: 70%;
    }

    .menu-option {
        overflow: hidden;
        position: relative;
        padding-bottom: 4px;
    }

    .menu-option-item {
        float: left;
        width: 25%;
        position: relative;
    }

    .menu-option-button {
        padding: 13px;
        margin: auto;
        height: 39px;
        width: 90px;
        background-color: #3A3F45;
        color: white;
    }


    .menu-option-chat {
        display: block;
        text-align: center;
    }

    .user-photo {
        float: left;
        margin-right: 10px;
        position: relative
    }

    .my-photo {
        display: block;
        width: 60px;
        height: 60px;
        border-radius: 2px;
        -moz-border-radius: 2px;
        -webkit-border-radius: 2px
    }

    .user-list-block-href {
        background: #2e3238;
        border: 0px;
        outline: none;
    }

    .user-list-block {
        display: block;
    }

    .user-info {
        overflow: hidden;
        height: 60px;
    }

    .user-box {
        overflow: hidden;
        padding: 12px 18px 11px;
        border-bottom: 1px solid #292c33;
        cursor: pointer;
        position: relative;
    }

    .my-name {
        font-weight: 400;
        font-size: 20px;
        color: #fff;
        line-height: 20px;
        margin-top: 5px;
        float: left;
        width: 100%;
        text-align: left;

    }

    .my-message {
        color: #989898;
        font-size: 17px;
        width: 100%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        word-wrap: normal;
        height: 1.5em;
        float: left;
        text-align: left;
        margin-right: 20px;
        width: 300px;

    }

    .chat-box {
        position: relative;
        background-color: #eee;
        height: -webkit-fill-available;
        overflow: hidden
    }

    .chat-box-head {
        text-align: center;
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        line-height: 40px;
        background-color: #eee;

    }

    .chat-box-title {
        position: fixed;
        /* padding: 10px 0; */
        padding-left: 20px;
        padding-right: 20px;
        /* align-items: center; */
        /* margin: 0 19px; */
        /* width: auto; */
        width: -webkit-fill-available;
        max-width: 70%;
        border-bottom: 1px solid #d6d6d6;
        background-color: #eee;
        z-index: 999;
        right: 0px;
        height: 60px;
    }

    .chat-box-title-box {
        font-weight: 400;
        height: 25px;
        display: inline-block;
        font-size: 23px;
    }

    .chat-box-title-text {
        vertical-align: middle;
        max-width: 70%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        word-wrap: normal;
        text-decoration: none;
        color: #000;
        font-weight: 400;
        width: fit-content;
        position: fixed;
        height: fit-content;
        display: inline-block;
        font-size: 23px;
        margin-top: 10px
    }

    .chat-input-box {
        position: fixed;
        height: 200px;
        bottom: 0;
        min-height: 200px;
        border-top: 1px solid #d6d6d6;
    }

    .text-area {
        border-top: 1px solid #d6d6d6;
        height: 200px;
        width: 100%;
        margin-bottom: 15px;
        resize: none;
        overflow-y: auto;
        overflow-x: hidden;
        padding-left: 20px;
        outline: none;
        border: 0;
        font-size: 25px;
        background-color: #eee;
    }

    .chat-output-box {
        background: transparent;
        position: relative;
        /* margin-bottom: 200px; */
        padding-bottom: 200px;
        padding-top: 80px;
        margin-right: 0px;
        /* margin-top: 80px; */
        min-height: 443px;
        /* max-height: 473px; */
        height: -webkit-fill-available;
        overflow: scroll;
    }

    .chat-output-head-photo-right {
        float: right;
        width: 60px;
        height: 60px;
        margin-right: 15px;
    }

    .chat-output-head-photo-left {
        float: left;
        width: 60px;
        height: 60px;
        margin-left: 15px;
        margin-top: 15px
    }

    .chat-output-content-right {
        overflow: hidden;
        text-align: right;
    }

    .chat-output-content-left {
        overflow: hidden;
        text-align: left;
    }

    .chat-output-meta-left {
        font-weight: 400;
        padding-left: 10px;
        height: 20px;
        line-height: 18px;
        color: #4f4f4f;
        width: 500px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        word-wrap: normal;
        margin-top: 22px
    }

    .chat-output-bubble-right {
        max-width: 500px;
        /*min-height: 55px;*/
        display: inline-block;
        vertical-align: top;
        position: relative;
        text-align: left;
        font-size: 20px;
        -webkit-border-radius: 3px;
        margin-right: 10px;

    }

    .chat-output-bubble-left {
        background-color: #eeeeee;
        max-width: 500px;
        /*min-height: 55px;*/
        display: inline-block;
        vertical-align: top;
        position: relative;
        text-align: left;
        font-size: 20px;
        -webkit-border-radius: 3px;
        margin-left: 10px;

    }

    .chat-output-bubble-inner {
        word-wrap: break-word;
        word-break: break-all;
        min-height: 25px;
    }

    .chat-output-bubble-pre-right {
        background-color: #b2e281;
        margin: 0;
        font-family: inherit;
        font-size: inherit;
        white-space: pre-wrap;
        word-break: normal;
    }

    .chat-output-bubble-pre-left {
        margin: 0;
        font-family: inherit;
        font-size: inherit;
        white-space: pre-wrap;
        word-break: normal;
    }

    .button {
        float: right;
        outline: none;
        border: none;
        height: 40px;
        margin-top: 10px;
        margin-right: 5px;
        z-index: 99;
    }
</style>
</html>


