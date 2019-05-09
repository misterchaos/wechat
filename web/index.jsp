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

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <title>wechat</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.4.1.js"></script>
    <!--BEGIN——发送请求脚本-->
    <script>
        //post方法
        function postRequest(url, request, callback) {
            $.post(url, request, function (data, status) {
                var result = eval("(" + data + ")");
                alert("系统提示：" + result.message);
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
                    alert("系统提示：" + data.message);
                    callback(data);
                },
                Error: function (xhr, error, exception) {
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
    <img src="/upload/photo/${login.chatBackground}" style="position: absolute;height: 100%;width: 100%">

    <!--BEGIN——菜单列表-->
    <div class="menu">
        <div class="menu-head">
            <div class="menu-head-photo">
                <img src="/upload/photo/${login.photo}" class="menu-head-img"
                     onclick="showWindowOnRight('user-info-box')">
            </div>
            <div class="menu-head-info">
                <h3 class="menu-head-nickname">${login.name}</h3>
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
                <div id="notify" onclick="showWindowOnLeft('notify-list')" class="menu-option-button">通知</div>
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
                        onclick="document.getElementById('search').click()">
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
                        onclick="loadNews(1)">
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
                        onclick="loadMyMoment(1)">
                    <div class="user-list-block">
                        <div class="user-box">
                            <div class="user-info">
                                <h3 class="my-name">我的朋友圈</h3>
                                <p class="my-message">查看自己发布的朋友圈</p>
                            </div>
                        </div>
                    </div>
                </button>
            </div>
            <div id="notify-list" style="display: none">


            </div>
            <div id="setting-list" style="display: none"></div>
        </div>
        <!--END——功能列表-->

    </div>
    <!--END——菜单列表-->

    <!--BEGIN——右边窗口-->
    <div id="right-page" data-window="0">

        <!--BEGIN——聊天窗口-->
        <div id="0" class="chat-box" style="display:block;background: transparent;">
            <div class="chat-box-head">   
                <div class="chat-box-title">       
                    <div class="chat-box-title-box">           
                        <a class="chat-box-title-text">当前没有选择聊天</a>       
                    </div>
                </div>
            </div>
            <div id="${param.chat_id}accept-message" class="chat-output-box">   

                <div class="chat-output-content-left">       
                    <img src="/upload/photo/system.jpg" alt="头像" class="chat-output-head-photo-left">     
                    <h4 class="chat-output-meta-left">系统消息</h4>
                    <div class="chat-output-bubble-left">
                        <pre class="chat-output-bubble-pre-left">这是一条系统消息，提醒你必须选择一个聊天才能进行聊天</pre>
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
                            style="float: right" contenteditable="false">更新
                    </button>
                </div>
            </div>
            <div id="${login.id}info" class="info-detail-box" onclick="enterClick('update-user')">
                   
                <div class="info-outline">
                    <div class="info-head-photo">
                        <img id="user-preview" src="/upload/photo/${login.photo}" class="info-head-img"
                             onclick="document.getElementById('user-photo').click()">
                        <input type="file" name="file" id="user-photo"
                               accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"
                               oninput="imgPreview(document.getElementById('user-photo'),'user-preview')"
                               style="display: none">

                    </div>
                    <div class="info-head-info">
                        <h3 class="info-head-nickname">${login.name}</h3>
                    </div>
                </div>
                <div class="info-detail">
                    <div class="info-detail-block">
                        <div class="info-detail-item" contenteditable="false">昵称:</div>
                        <div class="info-detail-value" id="name" contenteditable="true">${login.name}</div>
                    </div>
                    <div class="info-detail-block">
                        <div class="info-detail-item">个性签名:</div>
                        <div class="info-detail-value" id="signature" contenteditable="true">${login.signature}</div>
                    </div>
                    <div class="info-detail-block">
                        <div class="info-detail-item">微信号:</div>
                        <div class="info-detail-value" id="wechat_id" contenteditable="true">${login.wechatId}</div>
                    </div>
                    <div class="info-detail-block">
                        <div class="info-detail-item">性别:</div>
                        <div class="info-detail-value" id="gender" contenteditable="true">${login.gender}</div>
                    </div>
                    <div class="info-detail-block">
                        <div class="info-detail-item">地区:</div>
                        <div class="info-detail-value" id="location" contenteditable="true">${login.location}</div>
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
                    background-color:#1AAD19;border: solid 1px;width: 72px;"
                            contenteditable="false">发布
                    </button>
                </div>
            </div>
            <div id="${login.id}info" class="info-detail-box">
                <div class="info-outline">
                    <div class="info-head-photo">
                        <img id="moment-preview" src="/upload/photo/upload.jpg" class="info-head-img"
                             onclick="document.getElementById('moment-photo').click()">
                        <input type="file" name="file" id="moment-photo"
                               accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"
                               oninput="imgPreview(document.getElementById('moment-photo'),'moment-preview')"
                               style="display: none">
                    </div>
                    <div class="info-head-info">
                        <h3 class="info-head-nickname">单击左侧上传图片</h3>
                    </div>
                </div>
                <div class="info-detail">
                    <div class="info-detail-block" style="margin-left: 20px">
                        <label for="moment-content"></label>
                        <textarea class="input-text-content" id="moment-content" autofocus="autofocus" cols="100"
                                  contenteditable="true" onchange="enterClick('post-moment')" placeholder="分享自己的动态..."
                                  required="required" maxlength="800" oninput="enterClick('post-moment')"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <!--END——发朋友圈窗口-->
        <!--BEGIN——查看朋友圈窗口-->
        <div id="news-box" class="info-box" style="display: none">
            <div class="info-box-head">   
                <div class="info-box-title">       
                    <div class="info-box-title-box"><a class="info-box-title-text">朋友圈</a></div>
                    <button id="see-moment" onclick="postMoment()"
                            style="float: right" contenteditable="false">
                    </button>
                </div>
            </div>
            <div id="${login.id}info" class="info-detail-box">
                <div id="news-box-content" class="info-detail">
                    <div class="info-detail-block" style="margin-left: 20px">
                        <label for="moment-content">
                            <div class="info-detail-block">               
                                <div class="user-box" style="border-top: 1px solid;">
                                    <div class="user-photo">
                                        <img src="/upload/photo/user.photo" alt="用户头像" class="my-photo">
                                    </div>
                                    <div class="user-info" style="height: fit-content">
                                        <h3 class="my-name" style="color: #333">userName 发布于 2019-10-10</h3>
                                        <div> Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam. Integer
                                            ut neque. Vivamus nisi metus, molestie vel, gravida in, condimentum sit
                                            amet, nunc. Nam a nibh. Donec suscipit eros. Nam mi. Proin viverra leo ut
                                            odio. Curabitur malesuada. Vestibulum a velit eu ante scele
                                        </div>
                                        <img src="/upload/photo/${login.chatBackground}"
                                             style="position: relative;height: 100%;max-width:500px;width: 100%">

                                    </div>
                                    <button onclick="loveMoment('84',function() {
                                    callback();
                                    })" style="float: left"
                                            contenteditable="false">点赞()
                                    </button>
                                    <button onclick="addFriend(  user.id  )" style="float: left"
                                            contenteditable="false">评论()
                                    </button>
                                    <button onclick="addFriend(  user.id  )" style="float: left"
                                            contenteditable="false">收藏()
                                    </button>
                                    <button onclick="addFriend(  user.id  )" style="float: left"
                                            contenteditable="false">转发()
                                    </button>
                                </div>
                            </div>
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <!--END——查看朋友圈窗口-->
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
    //请求聊天列表
    loadChatListAndBox();
    loadFriendList();
    loadUnReadMessage(1);

    //创建群聊

    function createChat() {
        var name = prompt("请输入群聊名称", "广工夸夸群");
        if (name === '') {
            alert("您没有设置群聊名称，将使用默认名称");
        }
        var number;
        for (; ;) {
            number = prompt("请输入群号", "");
            if (number === '') {
                alert("群号不可为空，必须由6-20位数字组成");
            }else {
                break;
            }
        }
        var url = "http://localhost:8080/wechat/chat?method=add.do";
        var request = JSON.stringify({
            owner_id: "${login.id}",
            name :name,
            number:number
        });
        ajaxJsonRequest(url, request, function (result) {
            if(result.status==="SUCCESS"){
                loadChatListAndBox();
            }
        })


    }

    //发送消息
    function sendMessage(chat_id, type) {
        if (websocket === '') {
            alert("当前没有连接服务器，请刷新界面重试");
            return;
        }
        var content = document.getElementById(chat_id + 'send-message').value;
        if (!('' === content)) {
            var user_id = "${login.id}";
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

    //请求搜索用户结果
    function searchUser() {
        var name = document.getElementById("keyword").value;
        if (name === '') {
            alert("请输入好友昵称");
            document.getElementById('keyword').focus();
            return;
        }
        var url = "http://localhost:8080/wechat/user";
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

    //显示聊天窗口
    function showChatBox(chat_id) {
        showWindowOnRight(chat_id);
        var url = "http://localhost:8080/wechat/message";
        var request = {
            method: "read.do",
            user_id: ${login.id},
            chat_id: chat_id
        };
        postRequest(url, request, function (result) {
        })
    }

    //加载聊天列表，并且每个聊天加载隐藏的聊天窗口
    function loadChatListAndBox() {
        var url = "http://localhost:8080/wechat/chat";
        var request = {
            method: "list.do",
            id: "${login.id}"
        };
        postRequest(url, request, function (result) {
            var chats = result.data;
            for (var i = 0; i < chats.length; i++) {
                loadChatListOnMenu(chats[i]);
                loadChatBox(chats[i]);
            }
        });
    }

    //加载加载好友列表
    function loadFriendList() {
        var url = "http://localhost:8080/wechat/friend";
        var request = {
            method: "list.do",
            user_id: "${login.id}"
        };
        postRequest(url, request, function (result) {
            var friends = result.data;
            for (var i = 0; i < friends.length; i++) {
                loadFriendOnMenu(friends[i]);
            }
        });
    }

    //加载未读消息
    function loadUnReadMessage(page) {
        var url = "http://localhost:8080/wechat/message";
        var request = {
            method: "unread.do",
            user_id: "${login.id}",
            page: page
        };
        postRequest(url, request, function (result) {
            var messages = result.data;
            for (var i = messages.length - 1; i >= 0; i--) {
                addMessageToChat(messages[i]);
            }
        });
    }

    //加载朋友圈动态
    function loadNews(page) {
        var url = "http://localhost:8080/wechat/moment";
        var request = {
            method: "news.do",
            user_id: "${login.id}",
            page: page
        };
        postRequest(url, request, function (result) {
            var news = result.data;
            //加载之前先将之前的清空
            document.getElementById('news-box-content').innerHTML = '';
            for (var i = news.length - 1; i >= 0; i--) {
                addMomentBlockHtml(news[i], function () {
                    alert("回调");
                    loadNews(page);
                });
            }
        });
        showWindowOnRight('news-box');
    }

    //加载我的朋友圈
    function loadMyMoment(page) {
        var url = "http://localhost:8080/wechat/moment";
        var request = {
            method: "moment.do",
            user_id: "${login.id}",
            page: page
        };
        postRequest(url, request, function (result) {
            var news = result.data;
            //加载之前先将之前的清空
            document.getElementById('news-box-content').innerHTML = '';
            for (var i = 0; i < news.length; i++) {
                addMomentBlockHtml(news[i], function () {
                    loadMyMoment(page);
                });
            }
        });
        showWindowOnRight('news-box');
    }

    //删除朋友圈
    function deleteMoment(moment_id) {
        if (confirm("是否确定要删除这条朋友圈？")) {
            var url = 'http://localhost:8080/wechat/moment';
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

    //加好友
    function addFriend(friend_id) {
        var url = "http://localhost:8080/wechat/friend?method=add.do";
        var request = JSON.stringify({
            user_id: "${login.id}",
            friend_id: friend_id,
        });
        ajaxJsonRequest(url, request, function (result) {

        })
    }

    //更新个人信息
    function updateUserInfo() {
        var jsonStr = JSON.stringify({
            id: "${login.id}",
            name: document.getElementById("name").innerText,
            signature: document.getElementById("signature").innerText,
            wechat_id: document.getElementById("wechat_id").innerText,
            gender: document.getElementById("gender").innerText,
            location: document.getElementById("location").innerText
        });
        //更新基本信息
        var url = "http://localhost:8080/wechat/user?method=update.do";
        ajaxJsonRequest(url, jsonStr, function (result) {
            if ("SUCCESS" === result.status) {
            } else {
            }
        });
        //更新头像
        url = "http://localhost:8080/wechat/upload?method=uploadphoto.do&id=${login.id}&table=user";
        uploadPhoto(url, 'user-photo');
    }

    //发布朋友圈
    function postMoment() {
        var content = document.getElementById("moment-content").value;
        var jsonStr = JSON.stringify({
            owner_id: "${login.id}",
            content: content
        });
        var url = "http://localhost:8080/wechat/moment?method=add.do";
        if (!('' === content)) {
            ajaxJsonRequest(url, jsonStr, function (result) {
                if ("SUCCESS" === result.status) {
                    //成功之后上传图片
                    url = "http://localhost:8080/wechat/upload?method=uploadphoto.do&id=" + result.data.id + "&table=moment";
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
    function loveMoment(moment_id, callback) {
        var url = 'http://localhost:8080/wechat/moment';
        var request = {
            method: "love.do",
            moment_id: moment_id,
            user_id:${login.id},
        };
        postRequest(url, request, function (result) {
            var love = result.data;
            if (love) {
                alert("点赞成功！");
            } else {
                alert("取消点赞成功");
            }
            //闭包回调刷新页面
            callback();
        });
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
                var rs = eval("(" + data + ")");
                alert(rs);
            },
            error: function (data) {
            }
        })
    }
</script>
<!--END——程序执行脚本-->
<!--BEGIN——预加载脚本-->
<script>
    //动态加载聊天窗口，不显示
    function loadChatBox(chat) {
        var html = '<div id="' + chat.id + '" class="chat-box" style="display: none;background: transparent;">\n' +
            '<div class="chat-box-head">\n' +
            '            <div class="chat-box-title">\n' +
            '                <div class="chat-box-title-box">\n' +
            '                    <a class="chat-box-title-text">\n' +
            '                        ' + chat.name + '\n' +
            '                    </a>\n' +
            '                </div>\n' +
            '            </div>\n' +
            '        </div>\n' +
            '        <div id="' + chat.id + 'accept-message" class="chat-output-box" style="background: transparent;">\n' +
            '        </div>\n' +
            '        <div class="chat-input-box" style="background-color:#eee;" >\n' +
            '            <button id="' + chat.id + 'send-button" onclick="sendMessage(\'' + chat.id + '\',\'user\')">发送</button>\n' +
            '            <textarea id="' + chat.id + 'send-message" class="text-area" autofocus="autofocus" cols="100"\n' +
            '                      required="required" maxlength="300" oninput="enterClick(\'' + chat.id + 'send-button\')"></textarea>\n' +
            '        </div></div>';
        document.getElementById("right-page").innerHTML += html;
    }

    //加载聊天列表
    function loadChatListOnMenu(chat) {
        var chat_html = '<button class="user-list-block-href"  onmouseover="this.style.backgroundColor=\'#3A3F45\';" ' +
            'onmouseout="this.style.backgroundColor=\'#2e3238\';"' +
            'onclick="showChatBox(\'' + chat.id + '\')"><div class="user-list-block">\n' +
            '                <div class="user-box">\n' +
            '                    <div class="user-photo">\n' +
            '                        <img src="/upload/photo/' + chat.photo + '" alt="用户头像" class="my-photo">\n' +
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
            '                                <img src="/upload/photo/friend.photo  " alt="用户头像" class="my-photo">\n' +
            '                            </div>\n' +
            '                            <div class="user-info">\n' +
            '                                <h3 class="my-name"></h3>\n' +
            '                                <p class="my-message"> friend.description </p>\n' +
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
            'onclick="showWindowOnRight()"><div class="user-list-block">\n' +
            '                <div class="user-box">\n' +
            '                    <div class="user-photo">\n' +
            '                        <img src="/upload/photo/' + friend.photo + '" alt="用户头像" class="my-photo">\n' +
            '                    </div>\n' +
            '                    <div class="user-info">\n' +
            '                        <h3 class="my-name">' + friend.alias + '</h3>\n' +
            '                        <p class="my-message">' + friend.description + '</p>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div></button>';
        document.getElementById("friend-list").innerHTML += chat_html;
    }


</script>
<!--END——预加载脚本-->

<!--BEGIN——加载网页脚本-->
<script>


    //加载搜索结果页面，并显示
    function loadSearchResult() {
        document.getElementById("search-result-box").innerHTML =
            '            <div class="info-box-head">          \n' +
            '                <div class="info-box-title">                  \n' +
            '                    <div class="info-box-title-box"><a class="info-box-title-text">搜索结果</a></div>\n' +
            '                </div>\n' +
            '            </div>\n' +
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
            '            <div id="${login.id}info" class="info-detail-box">\n' +
            '                <div class="info-outline">\n' +
            '                    <div class="info-head-photo">\n' +
            '                        <img id="preview" src="/upload/photo/upload.jpg" class="info-head-img"\n' +
            '                             onclick="document.getElementById(\'input_file\').click()">\n' +
            '                        <input type="file" name="file" id="input_file"\n' +
            '                               accept="image/gif,image/jpeg,image/jpg,image/png,image/svg"\n' +
            '                               oninput="imgPreview(document.getElementById(\'input_file\'))" style="display: none">\n' +
            '                    </div>\n' +
            '                    <div class="info-head-info">\n' +
            '                        <h3 class="info-head-nickname">单击左侧上传图片</h3>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '                <div class="info-detail">\n' +
            '                    <div class="info-detail-block" style="margin-left: 20px">\n' +
            '                        <label for="moment-content"></label>\n' +
            '                        <textarea class="input-text-content" id="moment-content" autofocus="autofocus" cols="100"\n' +
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
            alert("请选择图片！");
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

    //插入一个搜索用户的结果
    function addSearchUserResultHtml(user) {
        var html = '                   <div class="info-detail-block">               \n' +
            '                        <div class="user-box" style="border-top: 1px solid;">\n' +
            '                            <div class="user-photo">\n' +
            '                                <img src="/upload/photo/' + user.photo + '" alt="用户头像" class="my-photo">\n' +
            '                            </div>\n' +
            '                            <div class="user-info">\n' +
            '                                <h3 class="my-name" style="color: #333">' + user.name + '</h3>\n' +
            '                                <p class="my-message">' + user.signature + '</p>\n' +
            '                            </div>\n' +
            '                            <button onclick="addFriend(\'' + user.id + '\')" style="float: right"\n' +
            '                                    contenteditable="false">加好友\n' +
            '                            </button>\n' +
            '                        </div>\n' +
            '                    </div>';
        document.getElementById("content").innerHTML += html;
    }

    //插入一条用户的朋友圈
    function addMomentBlockHtml(moment, callback) {
        var time = new Date(moment.time).toLocaleString();
        var html = '           <div class="info-detail-block" style="margin-left: 20px">\n' +
            '                        <label for="moment-content">\n' +
            '                            <div class="info-detail-block">               \n' +
            '                                <div class="user-box" style="border-top: 1px solid;width: 95%;">\n' +
            '                                    <div class="user-photo">\n' +
            '                                        <img src="/upload/photo/' + moment.user_photo + '" alt="用户头像" class="my-photo">\n' +
            '                                    </div>\n' +
            '                                    <div class="user-info" style="height: fit-content;margin-bottom: 11px;">\n' +
            '                                        <h3 class="my-name" style="color: #333">' + moment.user_name + ' 发布于 ' + time + '</h3>\n' +
            '                                        <div style="word-break: break-all;white-space: normal;">' + moment.content + '</div>\n' +
            '                                        <img src="/upload/photo/' + moment.photo + '" style="position:relative;height: 100%;' +
            'max-width:500px;max-height:300px;width: 100%">\n' +
            '                                    </div>\n' +
            '                                    <button onclick="loveMoment(\'' + moment.id + '\',' + function () {
                callback();
            } + ')" style="float: left"\n' +
            '                                            contenteditable="false">点赞\(' + moment.love + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="" style="float: left"\n' +
            '                                            contenteditable="false">评论\(' + moment.remark + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="" style="float: left"\n' +
            '                                            contenteditable="false">收藏\(' + moment.collect + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="" style="float: left"\n' +
            '                                            contenteditable="false">转发\(' + moment.share + '\)\n' +
            '                                    </button>\n' +
            '                                    <button onclick="" style="float: left"\n' +
            '                                            contenteditable="false">浏览量\(' + moment.view + '\)\n' +
            '                                    </button>\n';

        var visitorArea =
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </label>\n' +
            '                    </div>';
        var ownerArea =
            '                                    <button onclick="deleteMoment(\'' + moment.id + '\')" style="float: right" \n' +
            '                                            contenteditable="false">删除\n' +
            '                                    </button>\n' +
            '                                </div>\n' +
            '                            </div>\n' +
            '                        </label>\n' +
            '                    </div>';
        if (moment.owner_id ===${login.id}) {
            document.getElementById("news-box-content").innerHTML += html + ownerArea;
        } else {
            document.getElementById("news-box-content").innerHTML += html + visitorArea;
        }
    }

    //将消息显示在消息对应的聊天窗口上,并在聊天列表对应位置显示
    //TODO 发送者头像，发送者昵称
    function addMessageToChat(message) {
        var right_bubble_html = '<div class="chat-output-content-right">\n' +
            '    <img src="/upload/photo/${login.photo}" alt="头像" class="chat-output-head-photo-right">\n' +
            '    <div class="chat-output-bubble-right">\n' +
            '        <div class="chat-output-bubble-inner">\n' +
            '            <pre class="chat-output-bubble-pre-right">' + message.content + '</pre></div></div></div>';
        var left_bubble_html = '<div class="chat-output-content-left">\n' +
            '    <img src="/upload/photo/' + message.sender_photo + '" alt="头像" class="chat-output-head-photo-left">\n' +
            '    <h4 class="chat-output-meta-left">' + message.sender_name + '</h4>\n' +
            '    <div class="chat-output-bubble-left">\n' +
            '        <div class="chat-output-bubble-inner">\n' +
            '            <pre class="chat-output-bubble-pre-left">' + message.content + '</pre></div></div></div>';
        if (message.sender_id ==${login.id}) {
            document.getElementById(message.chat_id + "accept-message").innerHTML += '<br/>' + right_bubble_html;
        } else {
            document.getElementById(message.chat_id + "accept-message").innerHTML += '<br/>' + left_bubble_html;
        }
        document.getElementById(message.chat_id + "accept-message").scrollTop = document.getElementById(message.chat_id + "accept-message").scrollHeight;
        //显示在列表上
        document.getElementById(message.chat_id + "new-message").innerText = message.content;
    }

</script>
<!--END——加载网页脚本-->
<!--BEGIN——websocket脚本-->
<script type="text/javascript">
    var websocket = null;
    //TODO 将param改成login.id,到时使用后台传过来的login对象的email
    var url = "ws://localhost:8080/server/chat/${login.id}";
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket(url);
    } else {
        alert('当前浏览器不支持 websocket,无法进行实时聊天')
    }

    //连接发生错误的回调方法
    websocket.onerror = function () {
        alert("WebSocket连接发生错误");
        websocket = '';
    };

    //连接成功建立的回调方法
    websocket.onopen = function () {
    }

    //接收到消息的回调方法
    websocket.onmessage = function (event) {
        alert("收到服务器的新消息" + event.data);
        var message = eval("(" + event.data + ")");
        addMessageToChat(message);
    }

    //连接关闭的回调方法
    websocket.onclose = function () {
        alert("WebSocket连接关闭");
        websocket = '';
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        closeWebSocket();
    }


    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();

    }


</script>
<!--END——websocket脚本-->
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
        max-height: 682px;
    }
</style>

<style>
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
        height: 750px;
        float: left;
        overflow: hidden;
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
        height: 750px;
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
        position: relative;
        padding: 10px 0;
        margin: 0 19px;
        border-bottom: 1px solid #d6d6d6;
        background-color: #eee;
        z-index: 1024

    }

    .chat-box-title-box {
        font-weight: 400;
        height: 25px;
        display: inline-block;
        font-size: 23px;
    }

    .chat-box-title-text {
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

    .chat-input-box {
        position: relative;
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
        margin-bottom: 0px;
        margin-right: 0px;
        margin-top: 80px;
        min-height: 443px;
        max-height: 473px;
        height: 473px;
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
        min-height: 55px;
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
        min-height: 55px;
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
</style>

</body>
</html>


