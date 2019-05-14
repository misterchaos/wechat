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
  Date: 2019/4/17
  Time: 21:23
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <title>wechat</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div class="background">
    <%-- 页面头部--%>
    <div class="login-head" style="height: 100px">
        <div class="jumbotron" style="padding-bottom: 20px;padding-top:20px;margin:0px">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/index.jsp" style="color: #999;font-size: 44px;text-decoration: none"><img
                        src="${pageContext.request.contextPath}/static/img/logo.png" alt="logo" style="width: 100px;margin: 10px">微信，是一种生活方式</h2>
                </a>
            </div>
        </div>
    </div>
    <script>
        <c:if test="${message!=null}">
        alert("系统提示：${message}");
        </c:if>
    </script>
    <div class="input-box">
        <div class="color-input-field">
            <h2 class="input-box-title">注册账号</h2>
            <form action="${pageContext.request.contextPath}/wechat/user?method=register.do"
                  method="post">
                <input type="text" required="required" class="form-control" name="email"
                       value="${data.email}" placeholder="请输入邮箱号">
                <br/>
                <input type="password" required="required" class="form-control" name="password"
                       placeholder="请输入密码(6-20位英文字母，数字或下划线)">
                <div class="remember-me">
                    <input id="agree" type="checkbox" name="agreement" checked="checked" value="true"
                           style="margin-bottom: 13px">我已阅读并同意《微信用户协议》
                </div>
                <input type="submit" class="submit-button" value="注册">
            </form>
            <br>
            <div class="switch-button">
                已有账号？<a href="${pageContext.request.contextPath}/login.jsp">请登陆</a>
                <a href="${pageContext.request.contextPath}/wechat/user?method=login.do&wechatId=visitor">游客模式</a>
            </div>
        </div>
    </div>
</div>

</body>
<style type="text/css">

    .background {
        height: 100%;
        min-height: 750px;
        text-align: center;
        font-size: 14px;
        background-color: #f1f1f1;
        z-index: -1;
    }

    .logo {
        position: absolute;
        top: 56px;
        margin-left: 50px;
    }

    .form-control {
        padding: 10px;
        min-height: 55px;
        max-height: 70px;
        font-size: 22px;
    }

    .input-box-title {
        text-align: center;
        margin: 0 auto 50px;
        padding: 10px;
        font-weight: 400;
        color: #969696
    }

    .color-input-field {
        padding: 50px;
        font-size: 22px;
        height: 625px;
        width: 500px
    }

    .input-box {
        width: fit-content;
        margin: 104px auto;
        background-color: #fff;
        border-radius: 4px;
        box-shadow: 0 0 8px rgba(0, 0, 0, .1);
        vertical-align: middle;
    }

    .submit-button {
        margin-top: 20px;
        background-color:#1AAD19;
        color: #FFFFFF;
        padding: 9px 18px;
        border-radius: 5px;
        outline: none;
        border: none;
        width: 100%;
    }

    .remember-me {
        float: left;
        font-weight: 400;
        color: #969696;
        margin-top: 20px;
    }

    .switch-button {
        text-align: left;
    }

</style>
</html>


