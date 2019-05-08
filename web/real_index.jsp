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
    <link rel="stylesheet"
          href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="page-body">
    <!--BEGIN——菜单列表-->
    <div class="menu">
        <div class="menu-head">
            <div class="menu-head-photo">
                <img src="/upload/photo/default_head.jpg" class="menu-head-img">
            </div>
            <div class="menu-head-info">
                <h3 class="menu-head-nickname">${login.name}</h3>
            </div>
        </div>
        <div class="menu-search">
            <i class="menu-search-icon"></i>
            <input type="text" placeholder="搜索" class="menu-search-bar">
        </div>
        <div class="menu-option">
            <div class="menu-option-item">
                <a class="menu-option-chat">聊天</a>
            </div>
            <div class="menu-option-item">
                <a class="menu-option-friend">好友</a>
            </div>
            <div class="menu-option-item">
                <a class="menu-option-article">文章</a>
            </div>
            <div class="menu-option-item">
                <a class="menu-option-moment">朋友圈</a>
            </div>
        </div>

        <!--BEGIN——聊天列表-->
        <div id="menu-body" class="menu-body">

        </div>
        <!--END——聊天列表-->

    </div>
    <!--END——菜单列表-->
    <!--BEGIN——聊天窗口-->
    <div id="chat-box" class="chat-box">
        <div class="chat-box-head">   
            <div class="chat-box-title">       
                <div class="chat-box-title-box">           
                    <a class="chat-box-title-text">当前没有选择聊天</a>       
                </div>
            </div>
        </div>
        <div id="${param.chat_id}accept-message" class="chat-output-box">   
            <div class="chat-output-content-left">       
                <img src="/upload/photo/default_head.jpg" alt="头像" class="chat-output-head-photo-left">     
                <h4 class="chat-output-meta-left">系统消息</h4>
                <div class="chat-output-bubble-left">
                    <pre class="chat-output-bubble-pre-left">一条消息</pre>
                </div>
            </div>
        </div>
        <div class="chat-input-box" style="height: 250px">   
            <button id="send-button"
                    onclick="sendMessage('${param.chat_id}','user-message')"onkeypress="EnterPress(event)">
                发送   
            </button>
                <textarea id="${param.chat_id}send-message" class="text-area"
                          autofocus="autofocus" cols="100" required="required" maxlength="200"></textarea>
        </div>
    </div>
    <!--END——聊天窗口-->

    <!--BEGIN——监听键盘-->
    <script>
        document.onkeydown = function (event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) { // enter 键
                document.getElementById("send-button").click();
            }

        };
    </script>
    <!--END——监听键盘-->
    <!--BEGIN——加载网页脚本-->
    <script>
        load_chat_list();

        //加载聊天列表
        function add_chat_html(chat) {
            var chat_html = '<button class="user-list-block-href"  onmouseover="this.style.backgroundColor=\'#3A3F45\';" ' +
                'onmouseout="this.style.backgroundColor=\'#2e3238\';"' +
                'onclick="showWindowOnRight(\'' + chat.name + '\',\'' + chat.id + '\')"><div class="user-list-block">\n' +
                '                <div class="user-box">\n' +
                '                    <div class="user-photo">\n' +
                '                        <img src="/upload/photo/' + chat.photo + '" alt="用户头像" class="my-photo">\n' +
                '                    </div>\n' +
                '                    <div class="user-info">\n' +
                '                        <h3 class="my-name">' + chat.name + '</h3>\n' +
                '                        <p class="my-message">[666条新消息]你半夜还在打码，夸你,你半夜还在打码，夸你,你半夜还在打码，夸你</p>\n' +
                '                    </div>\n' +
                '                </div>\n' +
                '            </div></button>';
            document.getElementById("menu-body").innerHTML += chat_html;
        }

        //请求聊天列表
        function load_chat_list() {
            $.post("http://localhost:8080/wechat/chat",
                {
                    method: "list.do",
                    id: "${login.id}"
                },
                function (data, status) {
                    alert("Data: " + data + "\nStatus: " + status);
                    var result = eval("(" + data + ")");
                    var chats = result.data;
                    for (var i = 0; i < chats.length; i++) {
                        add_chat_html(chats[i]);
                    }
                });
        }

        //加载聊天窗口
        function load_chat_box(chat_name, chat_id) {
            document.getElementById("chat-box").innerHTML = '<div class="chat-box-head">\n' +
                '            <div class="chat-box-title">\n' +
                '                <div class="chat-box-title-box">\n' +
                '                    <a class="chat-box-title-text">\n' +
                '                        ' + chat_name + '\n' +
                '                    </a>\n' +
                '                </div>\n' +
                '            </div>\n' +
                '        </div>\n' +
                '        <div id="' + chat_id + 'accept-message" class="chat-output-box">\n' +
                '            <div class="chat-output-content-left">\n' +
                '                <img src="/upload/photo/default_head.jpg" alt="头像" class="chat-output-head-photo-left">\n' +
                '    <h4 class="chat-output-meta-left">系统消息</h4>\n' +
                '                <div class="chat-output-bubble-left">\n' +
                '                        <pre class="chat-output-bubble-pre-left">一条消息</pre>\n' +
                '                </div>\n' +
                '            </div>\n' +
                '        </div>\n' +
                '        <div class="chat-input-box" style="height: 250px">\n' +
                '            <button id="send-button" onclick="sendMessage(\'' + chat_id + '\',\'user-message\')"\n' +
                '                    onkeypress="EnterPress(event)">发送\n' +
                '            </button>\n' +
                '            <textarea id="' + chat_id + 'send-message" class="text-area" autofocus="autofocus" cols="100"\n' +
                '                      required="required" maxlength="300"></textarea>\n' +
                '        </div>';
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
        };

        //连接成功建立的回调方法
        websocket.onopen = function () {
            alert("WebSocket连接成功");
        }

        //接收到消息的回调方法
        websocket.onmessage = function (event) {
            var message = eval("(" + event.data + ")");
            add_message_to_output_box(message);
        }

        //连接关闭的回调方法
        websocket.onclose = function () {
            alert("WebSocket连接关闭");
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            closeWebSocket();
        }

        //将消息显示在网页上
        function add_message_to_output_box(message) {
            var right_bubble_html = '<div class="chat-output-content-right">\n' +
                '    <img src="/upload/photo/default_head.jpg" alt="头像" class="chat-output-head-photo-right">\n' +
                '    <div class="chat-output-bubble-right">\n' +
                '        <div class="chat-output-bubble-inner">\n' +
                '            <pre class="chat-output-bubble-pre-right">' + message.content + '</pre></div></div></div>';
            var left_bubble_html = '<div class="chat-output-content-left">\n' +
                '    <img src="/upload/photo/default_head.jpg" alt="头像" class="chat-output-head-photo-left">\n' +
                '    <h4 class="chat-output-meta-left">'+message.sender_name+'</h4>\n' +
                '    <div class="chat-output-bubble-left">\n' +
                '        <div class="chat-output-bubble-inner">\n' +
                '            <pre class="chat-output-bubble-pre-left">' + message.content + '</pre></div></div></div>';
            if (message.sender_id ==${login.id}) {
                document.getElementById(message.chat_id + "accept-message").innerHTML += '<br/>' + right_bubble_html;
            } else {
                document.getElementById(message.chat_id + "accept-message").innerHTML += '<br/>' + left_bubble_html;
            }
            document.getElementById(message.chat_id + "accept-message").scrollTop = document.getElementById(message.chat_id + "accept-message").scrollHeight;
        }

        //关闭WebSocket连接
        function closeWebSocket() {
            websocket.close();
        }

        //发送消息
        function sendMessage(chat_id, type) {
            var content = document.getElementById(chat_id + 'send-message').value;
            var user_id = "${login.id}";
            var time = new Date();
            var sender_name="${login.name}";
            websocket.send(JSON.stringify({
                //TODO 将param改成login.id,到时使用后台传过来的login对象的email
                sender_id: user_id,
                sender_name:sender_name,
                chat_id: chat_id,
                content: content,
                type: type,
                time: time
            }));
            //发送完之后将消息清空
            document.getElementById(chat_id + 'send-message').value = '';
        }
    </script>
    <!--END——websocket脚本-->

</div>

<style>
    .page-body {
        min-width: 800px;
        height: 100%;
        margin: 0 auto;
        border-radius: 3px;
        -moz-border-radius: 3px;
        -webkit-border-radius: 3px;
        overflow: hidden;
    }

    .menu {
        width: 30%;
        position: relative;
        height: -webkit-fill-available;
        float: left;
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

    .menu-search-bar {
        width: -webkit-fill-available;
        height: 50px;
        line-height: 32px;
        border: 0;
        border-radius: 2px;
        -moz-border-radius: 2px;
        -webkit-border-radius: 2px;
        background-color: #26292e;
        color: #fff;
        padding-left: 30px;
        font-size: 12px;
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

    .menu-option-chat {
        display: block;
        text-align: center;
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
        line-height: 40px
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
        position: fixed;
        height: 200px;
        bottom: 0;
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
        position: relative;
        margin-bottom: 0px;
        margin-right: 0px;
        margin-top: 80px;
        min-height: 500px;
        max-height: 600px;
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
</style>

</body>
</html>


