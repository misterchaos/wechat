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
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script>
        function register() {
            var email = document.getElementById("email").value;
            var password = document.getElementById("password").value;
            if(email==null||email==''){
                alert("请填写邮箱");
                return;
            }
            if(password==null||password===''){
                alert("请填写密码");
                return;
            }
            if(!document.getElementById("agree").checked){
                alert("请先同意用户使用协议");
                return;
            }
            document.getElementById("submit").click();
        }


    </script>
</head>
<body>
<script>
    <c:if test="${message!=null}">
    alert("系统提示：${message}");
    </c:if>
</script>
<div class="background">
    <%-- 页面头部--%>
    <div class="login-head" style="height: 100px">
        <div class="jumbotron" style="padding-bottom: 20px;padding-top:20px;margin:0px">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/index.jsp"
                   style="color: #999;font-size: 44px;text-decoration: none"><img
                        src="${pageContext.request.contextPath}/static/img/logo.png" alt="logo"
                        style="width: 100px;margin: 10px">微信，是一种生活方式</h2>
                </a>
            </div>
        </div>
    </div>
    <div class="input-box">
        <div class="color-input-field">
            <h2 class="input-box-title">注册账号</h2>
            <form   action="http://${host}/wechat/user?method=register.do" method="post">
                <input id="index" type="submit" style="display: none">
            <input id="email" type="text" required="required" class="form-control" name="email"
                   value="${data.email}" placeholder="请输入邮箱号">
            <br/>
            <input id="password" type="password" required="required" class="form-control" name="password"
                  value="${data.password}" placeholder="请输入密码(6-20位英文字母，数字或下划线)">
            <div class="remember-me">
                <input id="agree" type="checkbox" name="agreement"  value="true"
                       style="margin-bottom: 13px">我已阅读并同意<a href="agreement.html">《微信服务协议》</a>
            </div>
                <input type="submit" id="submit" style="display: none">
            <input onclick="register()" type="button" class="submit-button" value="注册">
            <br>
            <div class="switch-button">
                已有账号？<a href="${pageContext.request.contextPath}/login.jsp">请登陆</a>
                <a href="http://${host}/wechat/user?method=login.do&email=visitor" >| 游客模式</a>
            </div>
            </form>
        </div>
    </div>
</div>

</body>
<style type="text/css">

    .background {
        height: -webkit-fill-available;
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
        background-color: #1AAD19;
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


