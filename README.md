# wechat

---------

[![release](https://img.shields.io/badge/release-1.0.0-green)](https://github.com/misterchaos/wechat/releases)
[![release](https://img.shields.io/badge/version-beta-orange)](https://github.com/misterchaos/wechat/releases)
[![release](https://img.shields.io/badge/build-passing-green)](https://github.com/misterchaos/wechat/releases)

## :smile:Introduction

QG工作室终期考核项目：QG版微信（黄钰朝）

wechat是一个在线聊天系统，提供实时聊天，账户管理，好友管理，聊天记录管理，聊天群组，朋友圈，相册等功能</br>
后台技术：Java,tomcat,mysql,servlet,jsp</br>
前端技术：html,js,css,ajax</br>
通信技术：websocket,json</br>

## :heavy_check_mark:Quick Start

### :point_right:[点击这里](http://47.102.139.183:9090/wechat/)立即体验
### （如果使用过程中出现问题，欢迎发送邮件到hyc@mail2.gdut.edu.cn进行反馈，我会及时处理）


## :bulb:Information

开发者：黄钰朝</br>
联系邮箱：<a href="mailto:kobe524348@gmail.com">kobe524348@gmail.com</a></br>
项目开发时间：2019-05-01至2019-05-10</br>
版本号：1.0.0</br>
开源许可：Apache License 2.0</br>

## :sunny:Features

#### 1.登陆页面

登陆页面可以选择输入邮箱号和密码进行登陆，登陆之后将进入程序的主页面，也可以选择跳转到注册页面进行账号注册，还可以选择游客模式快速登陆，这种方式无须用户操作，系统将自动注册一个游客账号，并自动通过登陆验证，同样会进入程序的主页面，但是进入的是功能受限模式，无法使用好友和朋友圈的功能。输入框的左下角还有一个自动登陆选项，如果用户选择该选项，则在30天内在此浏览器上会执行自动登陆功能
![img](https://github.com/misterchaos/wechat/blob/dev/wechat项目截图/登陆功能.jpg)
 

#### 2.聊天功能

聊天功能包括一对一单聊，多人群聊，聊天中可以发送文字，图片，文件等不同类型的消息内容，同时提供了保存聊天记录的功能，可以加载漫游的聊天记录，还支持自由更换聊天背景等个性化设置
![img](https://github.com/misterchaos/wechat/blob/dev/wechat项目截图/聊天功能.jpg)

#### 3.朋友圈功能

用户可以查看好友的朋友圈，发布自己的朋友圈，朋友圈支持点赞和评论功能
![img](https://github.com/misterchaos/wechat/blob/dev/wechat项目截图/朋友圈功能.jpg)

#### 4.项目亮点

![img](https://github.com/misterchaos/wechat/blob/dev/wechat项目截图/项目亮点.jpg)

## :triangular_flag_on_post:Installation

#### 安装环境

> Tomcat版本：9.0.17</br>
> Jdk 版本：1.8</br>
> MySQL版本：5.7</br>

#### 配置说明

- 数据库配置文件路径：wechat/src/data_source.properties
- sql文件路径: wechat/wechat.sql
- 数据库配置：

配置文件中已配置阿里云服务器中的数据库，在联网情况下可以不用配置数据库，如果要更换数据库服务器，在运行sql文件时要将数据一并获取，否则需要在数据库chat表添加一个id为0的记录，作为聊天总群，并且在group表添加一个id为0的记录，作为默认好友分组，否则程序无法正常运行

- web.xml配置说明：

<multipart-config>中\<location>的值为上传文件路径，需要改为项目文件中upload文件夹在系统中的绝对路径，并且idea的tomcat的deployment配置中配置web目录的application context 为空

- 服务器主机名配置

如果运行环境的主机名不是localhost:8080，需要修改/web/views/index.jsp文件的第二行配置，将host的值改为对应的主机名

## :question:Problems

#### 一直提示访问参数不足？

可能是数据库连接有问题，如果使用阿里云的数据库，先检查网络，其次，数据库连接池可能在并发访问的过程中出现问题，我测试时发现出现数据库连接问题，尝试使用线程锁进行改进了，但是我多线程的东西我还没学，应该没有处理好...

#### 图片加载不出？

检查一下upload文件夹有没有配置路径映射...

## :star:License

本软件仅供交流学习，不得用于商业用途

Copyright 黄钰朝 

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
