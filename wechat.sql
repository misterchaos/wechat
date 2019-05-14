/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云数据库
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : 47.102.139.183:3306
 Source Schema         : wechat

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 10/05/2019 14:29:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '作者id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '封面',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `love` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `comment` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数',
  `share` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '转发数',
  `view` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量',
  `collect` int(10) UNSIGNED NOT NULL COMMENT '收藏量',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `author_id`(`user_id`) USING BTREE,
  CONSTRAINT `fk_user_id_5` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(70) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '聊天唯一编号',
  `owner_id` bigint(10) UNSIGNED NOT NULL COMMENT '群主id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '群聊' COMMENT '聊天名称',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'chat.jpg' COMMENT '聊天头像',
  `member` smallint(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '成员人数',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat
-- ----------------------------
INSERT INTO `chat` VALUES (0, '0', 0, '聊天总群', 'chat.jpg', 32, 0, '2019-05-10 11:04:21', '2019-05-10 13:35:45');
INSERT INTO `chat` VALUES (59, '35a984588ae14742aceb0312dcb65a6a', 210, '群聊', 'chat.jpg', 2, 0, '2019-05-10 05:16:32', '2019-05-10 13:35:52');

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '用户id',
  `friend_id` bigint(10) UNSIGNED NOT NULL COMMENT '好友id',
  `chat_id` bigint(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '聊天id',
  `photo` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'default_head' COMMENT '好友头像',
  `group_id` bigint(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所处分组id',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '好友备注',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未添加好友描述' COMMENT '好友描述',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_2`(`user_id`) USING BTREE,
  INDEX `fk_friend_id_1`(`friend_id`) USING BTREE,
  INDEX `fk_group_id_1`(`group_id`) USING BTREE,
  CONSTRAINT `fk_friend_id_1` FOREIGN KEY (`friend_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_group_id_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_id_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES (88, 210, 0, 59, 'default_head', 0, 'hhh', '未添加好友描述', 0, '2019-05-10 05:16:01', '2019-05-10 05:16:01');
INSERT INTO `friend` VALUES (89, 0, 210, 59, 'default_head', 0, 'faf', '未添加好友描述', 0, '2019-05-10 05:16:32', '2019-05-10 05:16:32');

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT ' ',
  `user_id` bigint(10) NOT NULL COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组名称',
  `priority` smallint(10) UNSIGNED NOT NULL COMMENT '优先级',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group
-- ----------------------------
INSERT INTO `group` VALUES (0, 0, '默认分组', 0, 0, '2019-05-09 16:30:16', '2019-05-09 16:30:23');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '用户id',
  `chat_id` bigint(10) UNSIGNED NOT NULL COMMENT '角色id',
  `group_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '群聊昵称',
  `level` smallint(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '群等级',
  `background` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '聊天背景',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id`(`user_id`) USING BTREE,
  INDEX `fk_role_id`(`chat_id`) USING BTREE,
  CONSTRAINT `fk_chat_id_2` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_6` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 271 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (234, 0, 59, '', 0, '', 0, '2019-05-10 05:16:33', '2019-05-10 05:16:33');
INSERT INTO `member` VALUES (235, 210, 59, '', 0, '', 0, '2019-05-10 05:16:33', '2019-05-10 05:16:33');
INSERT INTO `member` VALUES (251, 0, 0, '', 0, '', 0, '2019-05-10 11:38:50', '2019-05-10 11:38:50');
INSERT INTO `member` VALUES (252, 210, 0, '', 0, '', 0, '2019-05-10 11:39:03', '2019-05-10 11:39:03');
INSERT INTO `member` VALUES (263, 271, 0, '游客', 0, '', 0, '2019-05-10 13:08:59', '2019-05-10 13:08:59');
INSERT INTO `member` VALUES (264, 272, 0, '游客', 0, '', 0, '2019-05-10 13:09:11', '2019-05-10 13:09:11');
INSERT INTO `member` VALUES (265, 273, 0, '游客', 0, '', 0, '2019-05-10 13:22:04', '2019-05-10 13:22:04');
INSERT INTO `member` VALUES (266, 274, 0, '游客', 0, '', 0, '2019-05-10 13:26:06', '2019-05-10 13:26:06');
INSERT INTO `member` VALUES (267, 275, 0, '游客', 0, '', 0, '2019-05-10 14:05:16', '2019-05-10 14:05:16');
INSERT INTO `member` VALUES (268, 276, 0, '游客', 0, '', 0, '2019-05-10 14:16:43', '2019-05-10 14:16:43');
INSERT INTO `member` VALUES (269, 277, 0, '游客', 0, '', 0, '2019-05-10 14:17:30', '2019-05-10 14:17:30');
INSERT INTO `member` VALUES (270, 278, 0, '游客', 0, '', 0, '2019-05-10 14:19:06', '2019-05-10 14:19:06');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sender_id` bigint(10) UNSIGNED NOT NULL COMMENT '发送者id',
  `chat_id` bigint(10) UNSIGNED NOT NULL COMMENT '聊天id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '消息内容',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '消息类型',
  `time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) COMMENT '发送时间',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_3`(`sender_id`) USING BTREE,
  INDEX `fk_chat_id_4`(`chat_id`) USING BTREE,
  CONSTRAINT `fk_chat_id_4` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_3` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 319 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (238, 0, 59, '我是徐坤', 'user', '2019-05-10 06:31:28.069000', 0, '2019-05-10 06:31:26', '2019-05-10 06:31:26');
INSERT INTO `message` VALUES (239, 210, 59, '我上线了', 'user', '2019-05-10 06:32:28.051000', 0, '2019-05-10 06:32:28', '2019-05-10 06:32:28');
INSERT INTO `message` VALUES (240, 210, 59, '你好', 'user', '2019-05-10 06:32:37.564000', 0, '2019-05-10 06:32:37', '2019-05-10 06:32:37');
INSERT INTO `message` VALUES (241, 0, 59, '好吧', 'user', '2019-05-10 06:32:49.822000', 0, '2019-05-10 06:32:47', '2019-05-10 06:32:47');
INSERT INTO `message` VALUES (242, 210, 59, '我也上线了', 'user', '2019-05-10 06:33:05.049000', 0, '2019-05-10 06:33:04', '2019-05-10 06:33:04');
INSERT INTO `message` VALUES (244, 210, 59, '大师傅', 'user', '2019-05-10 06:35:53.079000', 0, '2019-05-10 06:35:52', '2019-05-10 06:35:52');
INSERT INTO `message` VALUES (245, 210, 59, 'aa', 'user', '2019-05-10 06:35:54.913000', 0, '2019-05-10 06:35:55', '2019-05-10 06:35:55');
INSERT INTO `message` VALUES (246, 210, 59, 'df', 'user', '2019-05-10 06:35:56.068000', 0, '2019-05-10 06:35:55', '2019-05-10 06:35:55');
INSERT INTO `message` VALUES (247, 210, 59, 'adf', 'user', '2019-05-10 06:35:57.144000', 0, '2019-05-10 06:35:56', '2019-05-10 06:35:56');
INSERT INTO `message` VALUES (248, 0, 59, 'fas', 'user', '2019-05-10 06:40:59.782000', 0, '2019-05-10 06:40:59', '2019-05-10 06:40:59');
INSERT INTO `message` VALUES (249, 210, 59, 'hafdsaf', 'user', '2019-05-10 06:48:35.020000', 0, '2019-05-10 06:48:33', '2019-05-10 06:48:33');
INSERT INTO `message` VALUES (250, 210, 59, '在吗', 'user', '2019-05-10 11:34:07.289000', 0, '2019-05-10 11:34:07', '2019-05-10 11:34:07');
INSERT INTO `message` VALUES (251, 0, 59, '不在', 'user', '2019-05-10 11:34:20.172000', 0, '2019-05-10 11:34:23', '2019-05-10 11:34:23');
INSERT INTO `message` VALUES (252, 0, 59, '啊手动阀', 'user', '2019-05-10 11:43:31.791000', 0, '2019-05-10 11:43:33', '2019-05-10 11:43:33');
INSERT INTO `message` VALUES (253, 0, 0, '啊手动阀', 'user', '2019-05-10 11:47:30.390000', 0, '2019-05-10 11:47:31', '2019-05-10 11:47:31');
INSERT INTO `message` VALUES (254, 0, 0, '士大夫', 'user', '2019-05-10 11:47:32.151000', 0, '2019-05-10 11:47:35', '2019-05-10 11:47:35');
INSERT INTO `message` VALUES (255, 0, 0, '撒地方', 'user', '2019-05-10 11:47:33.313000', 0, '2019-05-10 11:47:40', '2019-05-10 11:47:40');
INSERT INTO `message` VALUES (256, 0, 0, '反对撒', 'user', '2019-05-10 11:48:25.146000', 0, '2019-05-10 11:48:30', '2019-05-10 11:48:30');
INSERT INTO `message` VALUES (257, 0, 0, '阿斯蒂', 'user', '2019-05-10 11:48:26.619000', 0, '2019-05-10 11:48:38', '2019-05-10 11:48:38');
INSERT INTO `message` VALUES (260, 210, 0, '巧了', 'user', '2019-05-10 11:50:21.225000', 0, '2019-05-10 11:50:22', '2019-05-10 11:50:22');
INSERT INTO `message` VALUES (261, 210, 0, '我也是游客', 'user', '2019-05-10 11:50:25.860000', 0, '2019-05-10 11:50:28', '2019-05-10 11:50:28');
INSERT INTO `message` VALUES (262, 0, 0, '？？', 'user', '2019-05-10 11:51:00.945000', 0, '2019-05-10 11:51:03', '2019-05-10 11:51:03');
INSERT INTO `message` VALUES (295, 273, 0, '我是游客1', 'user', '2019-05-10 13:25:56.232000', 0, '2019-05-10 13:25:58', '2019-05-10 13:25:58');
INSERT INTO `message` VALUES (296, 274, 0, '我是游客2', 'user', '2019-05-10 13:29:14.511000', 0, '2019-05-10 13:29:15', '2019-05-10 13:29:15');
INSERT INTO `message` VALUES (297, 273, 0, '我是游客1', 'user', '2019-05-10 13:29:27.288000', 0, '2019-05-10 13:29:27', '2019-05-10 13:29:27');
INSERT INTO `message` VALUES (298, 274, 0, 'ok', 'user', '2019-05-10 13:29:36.182000', 0, '2019-05-10 13:29:36', '2019-05-10 13:29:36');
INSERT INTO `message` VALUES (299, 273, 0, '我是游客11111', 'user', '2019-05-10 13:29:46.126000', 0, '2019-05-10 13:29:48', '2019-05-10 13:29:48');
INSERT INTO `message` VALUES (300, 274, 0, 'woshiyouke22222222222', 'user', '2019-05-10 13:29:54.191000', 0, '2019-05-10 13:29:54', '2019-05-10 13:29:54');
INSERT INTO `message` VALUES (301, 0, 0, '案说法', 'user', '2019-05-10 14:03:11.757000', 0, '2019-05-10 14:03:14', '2019-05-10 14:03:14');
INSERT INTO `message` VALUES (302, 0, 0, '撒', 'user', '2019-05-10 14:03:14.471000', 0, '2019-05-10 14:03:16', '2019-05-10 14:03:16');
INSERT INTO `message` VALUES (303, 0, 0, '阿斯蒂', 'user', '2019-05-10 14:03:16.843000', 0, '2019-05-10 14:03:17', '2019-05-10 14:03:17');
INSERT INTO `message` VALUES (304, 0, 0, '案说法', 'user', '2019-05-10 14:03:33.954000', 0, '2019-05-10 14:03:36', '2019-05-10 14:03:36');
INSERT INTO `message` VALUES (305, 0, 0, '撒地方', 'user', '2019-05-10 14:03:36.189000', 0, '2019-05-10 14:03:37', '2019-05-10 14:03:37');
INSERT INTO `message` VALUES (306, 0, 0, '撒旦', 'user', '2019-05-10 14:03:55.101000', 0, '2019-05-10 14:03:55', '2019-05-10 14:03:55');
INSERT INTO `message` VALUES (307, 0, 0, '萨芬', 'user', '2019-05-10 14:04:00.063000', 0, '2019-05-10 14:04:01', '2019-05-10 14:04:01');
INSERT INTO `message` VALUES (308, 0, 0, '萨芬', 'user', '2019-05-10 14:04:02.773000', 0, '2019-05-10 14:04:03', '2019-05-10 14:04:03');
INSERT INTO `message` VALUES (309, 0, 0, '啊手动阀', 'user', '2019-05-10 14:04:04.092000', 0, '2019-05-10 14:04:05', '2019-05-10 14:04:05');
INSERT INTO `message` VALUES (310, 0, 0, '啊手动阀', 'user', '2019-05-10 14:04:05.505000', 0, '2019-05-10 14:04:07', '2019-05-10 14:04:07');
INSERT INTO `message` VALUES (311, 0, 0, '撒地方', 'user', '2019-05-10 14:04:06.675000', 0, '2019-05-10 14:04:08', '2019-05-10 14:04:08');
INSERT INTO `message` VALUES (312, 275, 0, 'saf', 'user', '2019-05-10 14:05:24.246000', 0, '2019-05-10 14:05:25', '2019-05-10 14:05:25');
INSERT INTO `message` VALUES (313, 0, 0, '案说法', 'user', '2019-05-10 14:05:33.878000', 0, '2019-05-10 14:05:35', '2019-05-10 14:05:35');
INSERT INTO `message` VALUES (314, 275, 0, 'asdf', 'user', '2019-05-10 14:05:43.288000', 0, '2019-05-10 14:05:43', '2019-05-10 14:05:43');
INSERT INTO `message` VALUES (315, 0, 0, '萨芬', 'user', '2019-05-10 14:06:01.357000', 0, '2019-05-10 14:06:01', '2019-05-10 14:06:01');
INSERT INTO `message` VALUES (316, 0, 0, '撒旦', 'user', '2019-05-10 14:06:08.534000', 0, '2019-05-10 14:06:10', '2019-05-10 14:06:10');
INSERT INTO `message` VALUES (317, 0, 0, '艾苏', 'user', '2019-05-10 14:06:26.008000', 0, '2019-05-10 14:06:28', '2019-05-10 14:06:28');
INSERT INTO `message` VALUES (318, 0, 0, '阿斯蒂', 'user', '2019-05-10 14:06:27.619000', 0, '2019-05-10 14:06:30', '2019-05-10 14:06:30');

-- ----------------------------
-- Table structure for moment
-- ----------------------------
DROP TABLE IF EXISTS `moment`;
CREATE TABLE `moment`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `owner_id` bigint(10) UNSIGNED NOT NULL COMMENT '发布者id',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间',
  `love` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `remark` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数',
  `share` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '转发数',
  `view` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量',
  `collect` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏量',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_4`(`owner_id`) USING BTREE,
  CONSTRAINT `fk_user_id_4` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of moment
-- ----------------------------
INSERT INTO `moment` VALUES (88, 0, 'com.hyc.wechat.dao.impl.DataSourceImpl.getConnection(DataSourceImpl.java:155)]连接池已创建连接数3空闲连接数2[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/upload.jpg[请求参数]：null[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/user.photo[请求参数]：null[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/[请求参数]：nullcom.mysql.cj.jdbc.ClientPreparedStatement:selectm.id,m.sender_id,m.chat_id,m.content,m.type,m.time,m.status,m.gmt_create,m.gmt_modifiedfrommessageasm,recordasrwherem.id=r.message_idandr.user_id=\'209\'andr.status=0orderbym.timed', '03530a39ca574e8882bf77a72b2d0bb4.png', '2019-05-09 15:56:55', 1, 0, 0, 0, 0, 0, '2019-05-09 15:56:55', '2019-05-09 15:56:59');
INSERT INTO `moment` VALUES (92, 0, 'com.hyc.wechat.dao.impl.DataSourceImpl.getConnection(DataSourceImpl.java:155)]连接池已创建连接数3空闲连接数2[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/upload.jpg[请求参数]：null[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/user.photo[请求参数]：null[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/[请求参数]：nullcom.mysql.cj.jdbc.ClientPreparedStatement:selectm.id,m.sender_id,m.chat_id,m.content,m.type,m.time,m.status,m.gmt_create,m.gmt_modifiedfrommessageasm,recordasrwherem.id=r.message_idandr.user_id=\'209\'andr.status=0orderbym.timed', '6d200fc9151943f6a04f7f3406c7fd57.jpg', '2019-05-09 23:52:24', 0, 0, 0, 0, 0, 0, '2019-05-09 23:52:24', '2019-05-09 23:52:26');
INSERT INTO `moment` VALUES (94, 0, '哈哈哈', 'moment.jpg', '2019-05-10 01:15:54', 0, 0, 0, 0, 0, 0, '2019-05-10 01:15:54', '2019-05-10 01:15:55');
INSERT INTO `moment` VALUES (95, 0, '哈哈', 'moment.jpg', '2019-05-10 01:16:24', 0, 0, 0, 0, 0, 0, '2019-05-10 01:16:24', '2019-05-10 01:16:25');
INSERT INTO `moment` VALUES (96, 0, '我要发朋友圈了', '1edbd7cf72a84790b6b9a9a28db33f13.jpg', '2019-05-10 07:15:44', 0, 0, 0, 0, 0, 0, '2019-05-10 07:15:44', '2019-05-10 07:15:46');
INSERT INTO `moment` VALUES (97, 0, 'sfads', '', '2019-05-10 13:40:09', 0, 0, 0, 0, 0, 0, '2019-05-10 13:40:09', '2019-05-10 13:40:10');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '发布者id',
  `moment_id` bigint(10) UNSIGNED NOT NULL COMMENT '朋友圈id',
  `loved` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否点赞',
  `shared` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否转发',
  `viewed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否浏览',
  `collected` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否收藏',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_4`(`user_id`) USING BTREE,
  INDEX `fk_moment_id_3`(`moment_id`) USING BTREE,
  CONSTRAINT `fk_moment_id_3` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_12` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 99 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (87, 0, 88, 1, 0, 0, 0, 0, '2019-05-09 15:56:57', '2019-05-09 15:56:57');
INSERT INTO `news` VALUES (88, 210, 92, 0, 0, 0, 0, 0, '2019-05-09 23:52:24', '2019-05-09 23:52:24');
INSERT INTO `news` VALUES (89, 0, 92, 0, 0, 0, 0, 0, '2019-05-09 23:52:25', '2019-05-09 23:52:25');
INSERT INTO `news` VALUES (91, 210, 94, 0, 0, 0, 0, 0, '2019-05-10 01:15:55', '2019-05-10 01:15:55');
INSERT INTO `news` VALUES (92, 0, 94, 0, 0, 0, 0, 0, '2019-05-10 01:15:55', '2019-05-10 01:15:55');
INSERT INTO `news` VALUES (93, 210, 95, 0, 0, 0, 0, 0, '2019-05-10 01:16:25', '2019-05-10 01:16:25');
INSERT INTO `news` VALUES (94, 0, 95, 0, 0, 0, 0, 0, '2019-05-10 01:16:25', '2019-05-10 01:16:25');
INSERT INTO `news` VALUES (95, 210, 96, 0, 0, 0, 0, 0, '2019-05-10 07:15:45', '2019-05-10 07:15:45');
INSERT INTO `news` VALUES (96, 0, 96, 0, 0, 0, 0, 0, '2019-05-10 07:15:45', '2019-05-10 07:15:45');
INSERT INTO `news` VALUES (97, 210, 97, 0, 0, 0, 0, 0, '2019-05-10 13:40:10', '2019-05-10 13:40:10');
INSERT INTO `news` VALUES (98, 0, 97, 0, 0, 0, 0, 0, '2019-05-10 13:40:10', '2019-05-10 13:40:10');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '权限名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '权限描述',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '用户id',
  `message_id` bigint(10) UNSIGNED NOT NULL COMMENT '消息id',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态（0未读，1已读）',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_3`(`user_id`) USING BTREE,
  INDEX `fk_message_id_2`(`message_id`) USING BTREE,
  CONSTRAINT `fk_message_id_2` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `record_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1275 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (98, 0, 238, 1, '2019-05-10 06:31:26', '2019-05-10 06:31:33');
INSERT INTO `record` VALUES (99, 210, 238, 1, '2019-05-10 06:31:27', '2019-05-10 06:32:17');
INSERT INTO `record` VALUES (100, 0, 239, 1, '2019-05-10 06:32:28', '2019-05-10 06:32:30');
INSERT INTO `record` VALUES (101, 210, 239, 1, '2019-05-10 06:32:28', '2019-05-10 06:35:47');
INSERT INTO `record` VALUES (102, 0, 240, 1, '2019-05-10 06:32:37', '2019-05-10 06:35:57');
INSERT INTO `record` VALUES (103, 210, 240, 1, '2019-05-10 06:32:37', '2019-05-10 06:35:47');
INSERT INTO `record` VALUES (104, 0, 241, 1, '2019-05-10 06:32:48', '2019-05-10 06:35:57');
INSERT INTO `record` VALUES (105, 210, 241, 1, '2019-05-10 06:32:48', '2019-05-10 06:35:47');
INSERT INTO `record` VALUES (106, 0, 242, 1, '2019-05-10 06:33:04', '2019-05-10 06:35:57');
INSERT INTO `record` VALUES (107, 210, 242, 1, '2019-05-10 06:33:04', '2019-05-10 06:35:47');
INSERT INTO `record` VALUES (109, 0, 244, 1, '2019-05-10 06:35:52', '2019-05-10 06:35:57');
INSERT INTO `record` VALUES (110, 210, 244, 1, '2019-05-10 06:35:52', '2019-05-10 06:41:39');
INSERT INTO `record` VALUES (111, 0, 245, 1, '2019-05-10 06:35:55', '2019-05-10 06:35:57');
INSERT INTO `record` VALUES (112, 210, 245, 1, '2019-05-10 06:35:55', '2019-05-10 06:41:39');
INSERT INTO `record` VALUES (113, 0, 246, 1, '2019-05-10 06:35:56', '2019-05-10 06:35:57');
INSERT INTO `record` VALUES (114, 210, 246, 1, '2019-05-10 06:35:56', '2019-05-10 06:41:39');
INSERT INTO `record` VALUES (115, 0, 247, 1, '2019-05-10 06:35:56', '2019-05-10 06:35:57');
INSERT INTO `record` VALUES (116, 210, 247, 1, '2019-05-10 06:35:56', '2019-05-10 06:41:39');
INSERT INTO `record` VALUES (117, 0, 248, 1, '2019-05-10 06:41:00', '2019-05-10 06:41:43');
INSERT INTO `record` VALUES (118, 210, 248, 1, '2019-05-10 06:41:00', '2019-05-10 06:41:39');
INSERT INTO `record` VALUES (119, 0, 249, 1, '2019-05-10 06:48:33', '2019-05-10 06:48:39');
INSERT INTO `record` VALUES (120, 210, 249, 1, '2019-05-10 06:48:34', '2019-05-10 06:49:06');
INSERT INTO `record` VALUES (121, 0, 250, 1, '2019-05-10 11:34:08', '2019-05-10 11:34:12');
INSERT INTO `record` VALUES (122, 210, 250, 1, '2019-05-10 11:34:08', '2019-05-10 11:52:36');
INSERT INTO `record` VALUES (123, 0, 251, 1, '2019-05-10 11:34:23', '2019-05-10 11:43:29');
INSERT INTO `record` VALUES (124, 210, 251, 1, '2019-05-10 11:34:24', '2019-05-10 11:52:36');
INSERT INTO `record` VALUES (125, 0, 252, 1, '2019-05-10 11:43:33', '2019-05-10 11:52:47');
INSERT INTO `record` VALUES (126, 210, 252, 1, '2019-05-10 11:43:33', '2019-05-10 11:52:36');
INSERT INTO `record` VALUES (141, 0, 253, 1, '2019-05-10 11:47:34', '2019-05-10 11:48:55');
INSERT INTO `record` VALUES (142, 210, 253, 1, '2019-05-10 11:47:34', '2019-05-10 11:48:41');
INSERT INTO `record` VALUES (158, 0, 254, 1, '2019-05-10 11:47:39', '2019-05-10 11:48:55');
INSERT INTO `record` VALUES (159, 210, 254, 1, '2019-05-10 11:47:39', '2019-05-10 11:48:41');
INSERT INTO `record` VALUES (175, 0, 255, 1, '2019-05-10 11:47:44', '2019-05-10 11:48:55');
INSERT INTO `record` VALUES (176, 210, 255, 1, '2019-05-10 11:47:44', '2019-05-10 11:48:41');
INSERT INTO `record` VALUES (192, 0, 256, 1, '2019-05-10 11:48:36', '2019-05-10 11:48:55');
INSERT INTO `record` VALUES (193, 210, 256, 1, '2019-05-10 11:48:37', '2019-05-10 11:48:41');
INSERT INTO `record` VALUES (210, 0, 257, 1, '2019-05-10 11:48:42', '2019-05-10 11:48:55');
INSERT INTO `record` VALUES (211, 210, 257, 1, '2019-05-10 11:48:43', '2019-05-10 11:49:21');
INSERT INTO `record` VALUES (264, 0, 260, 1, '2019-05-10 11:50:25', '2019-05-10 11:52:42');
INSERT INTO `record` VALUES (265, 210, 260, 1, '2019-05-10 11:50:25', '2019-05-10 11:52:38');
INSERT INTO `record` VALUES (282, 0, 261, 1, '2019-05-10 11:50:31', '2019-05-10 11:52:42');
INSERT INTO `record` VALUES (283, 210, 261, 1, '2019-05-10 11:50:31', '2019-05-10 11:52:38');
INSERT INTO `record` VALUES (300, 0, 262, 1, '2019-05-10 11:51:06', '2019-05-10 11:52:42');
INSERT INTO `record` VALUES (301, 210, 262, 1, '2019-05-10 11:51:06', '2019-05-10 11:52:38');
INSERT INTO `record` VALUES (1125, 0, 295, 1, '2019-05-10 13:25:59', '2019-05-10 13:42:33');
INSERT INTO `record` VALUES (1126, 210, 295, 1, '2019-05-10 13:25:59', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1127, 271, 295, 0, '2019-05-10 13:25:59', '2019-05-10 13:25:59');
INSERT INTO `record` VALUES (1128, 272, 295, 0, '2019-05-10 13:25:59', '2019-05-10 13:25:59');
INSERT INTO `record` VALUES (1129, 273, 295, 1, '2019-05-10 13:25:59', '2019-05-10 13:27:12');
INSERT INTO `record` VALUES (1130, 0, 296, 1, '2019-05-10 13:29:15', '2019-05-10 13:42:33');
INSERT INTO `record` VALUES (1131, 210, 296, 1, '2019-05-10 13:29:16', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1132, 271, 296, 0, '2019-05-10 13:29:16', '2019-05-10 13:29:16');
INSERT INTO `record` VALUES (1133, 272, 296, 0, '2019-05-10 13:29:16', '2019-05-10 13:29:16');
INSERT INTO `record` VALUES (1134, 273, 296, 1, '2019-05-10 13:29:16', '2019-05-10 13:29:20');
INSERT INTO `record` VALUES (1135, 274, 296, 1, '2019-05-10 13:29:16', '2019-05-10 13:45:55');
INSERT INTO `record` VALUES (1136, 0, 297, 1, '2019-05-10 13:29:28', '2019-05-10 13:42:33');
INSERT INTO `record` VALUES (1137, 210, 297, 1, '2019-05-10 13:29:28', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1138, 271, 297, 0, '2019-05-10 13:29:28', '2019-05-10 13:29:28');
INSERT INTO `record` VALUES (1139, 272, 297, 0, '2019-05-10 13:29:28', '2019-05-10 13:29:28');
INSERT INTO `record` VALUES (1140, 273, 297, 0, '2019-05-10 13:29:28', '2019-05-10 13:29:28');
INSERT INTO `record` VALUES (1141, 274, 297, 1, '2019-05-10 13:29:29', '2019-05-10 13:45:55');
INSERT INTO `record` VALUES (1142, 0, 298, 1, '2019-05-10 13:29:36', '2019-05-10 13:42:33');
INSERT INTO `record` VALUES (1143, 210, 298, 1, '2019-05-10 13:29:37', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1144, 271, 298, 0, '2019-05-10 13:29:37', '2019-05-10 13:29:37');
INSERT INTO `record` VALUES (1145, 272, 298, 0, '2019-05-10 13:29:37', '2019-05-10 13:29:37');
INSERT INTO `record` VALUES (1146, 273, 298, 0, '2019-05-10 13:29:37', '2019-05-10 13:29:37');
INSERT INTO `record` VALUES (1147, 274, 298, 1, '2019-05-10 13:29:37', '2019-05-10 13:45:55');
INSERT INTO `record` VALUES (1148, 0, 299, 1, '2019-05-10 13:29:49', '2019-05-10 13:42:33');
INSERT INTO `record` VALUES (1149, 210, 299, 1, '2019-05-10 13:29:49', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1150, 271, 299, 0, '2019-05-10 13:29:49', '2019-05-10 13:29:49');
INSERT INTO `record` VALUES (1151, 272, 299, 0, '2019-05-10 13:29:49', '2019-05-10 13:29:49');
INSERT INTO `record` VALUES (1152, 273, 299, 0, '2019-05-10 13:29:49', '2019-05-10 13:29:49');
INSERT INTO `record` VALUES (1153, 274, 299, 1, '2019-05-10 13:29:49', '2019-05-10 13:45:55');
INSERT INTO `record` VALUES (1154, 0, 300, 1, '2019-05-10 13:29:54', '2019-05-10 13:42:33');
INSERT INTO `record` VALUES (1155, 210, 300, 1, '2019-05-10 13:29:55', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1156, 271, 300, 0, '2019-05-10 13:29:55', '2019-05-10 13:29:55');
INSERT INTO `record` VALUES (1157, 272, 300, 0, '2019-05-10 13:29:55', '2019-05-10 13:29:55');
INSERT INTO `record` VALUES (1158, 273, 300, 0, '2019-05-10 13:29:55', '2019-05-10 13:29:55');
INSERT INTO `record` VALUES (1159, 274, 300, 1, '2019-05-10 13:29:55', '2019-05-10 13:45:55');
INSERT INTO `record` VALUES (1160, 0, 301, 1, '2019-05-10 14:03:14', '2019-05-10 14:03:30');
INSERT INTO `record` VALUES (1161, 210, 301, 1, '2019-05-10 14:03:15', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1162, 271, 301, 0, '2019-05-10 14:03:15', '2019-05-10 14:03:15');
INSERT INTO `record` VALUES (1163, 272, 301, 0, '2019-05-10 14:03:15', '2019-05-10 14:03:15');
INSERT INTO `record` VALUES (1164, 273, 301, 0, '2019-05-10 14:03:15', '2019-05-10 14:03:15');
INSERT INTO `record` VALUES (1165, 274, 301, 0, '2019-05-10 14:03:15', '2019-05-10 14:03:15');
INSERT INTO `record` VALUES (1166, 0, 302, 1, '2019-05-10 14:03:16', '2019-05-10 14:03:30');
INSERT INTO `record` VALUES (1167, 210, 302, 1, '2019-05-10 14:03:16', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1168, 271, 302, 0, '2019-05-10 14:03:16', '2019-05-10 14:03:16');
INSERT INTO `record` VALUES (1169, 272, 302, 0, '2019-05-10 14:03:16', '2019-05-10 14:03:16');
INSERT INTO `record` VALUES (1170, 273, 302, 0, '2019-05-10 14:03:17', '2019-05-10 14:03:17');
INSERT INTO `record` VALUES (1171, 274, 302, 0, '2019-05-10 14:03:17', '2019-05-10 14:03:17');
INSERT INTO `record` VALUES (1172, 0, 303, 1, '2019-05-10 14:03:18', '2019-05-10 14:03:30');
INSERT INTO `record` VALUES (1173, 210, 303, 1, '2019-05-10 14:03:18', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1174, 271, 303, 0, '2019-05-10 14:03:18', '2019-05-10 14:03:18');
INSERT INTO `record` VALUES (1175, 272, 303, 0, '2019-05-10 14:03:18', '2019-05-10 14:03:18');
INSERT INTO `record` VALUES (1176, 273, 303, 0, '2019-05-10 14:03:18', '2019-05-10 14:03:18');
INSERT INTO `record` VALUES (1177, 274, 303, 0, '2019-05-10 14:03:18', '2019-05-10 14:03:18');
INSERT INTO `record` VALUES (1178, 0, 304, 1, '2019-05-10 14:03:36', '2019-05-10 14:03:45');
INSERT INTO `record` VALUES (1179, 210, 304, 1, '2019-05-10 14:03:36', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1180, 271, 304, 0, '2019-05-10 14:03:36', '2019-05-10 14:03:36');
INSERT INTO `record` VALUES (1181, 272, 304, 0, '2019-05-10 14:03:37', '2019-05-10 14:03:37');
INSERT INTO `record` VALUES (1182, 273, 304, 0, '2019-05-10 14:03:37', '2019-05-10 14:03:37');
INSERT INTO `record` VALUES (1183, 274, 304, 0, '2019-05-10 14:03:37', '2019-05-10 14:03:37');
INSERT INTO `record` VALUES (1184, 0, 305, 1, '2019-05-10 14:03:38', '2019-05-10 14:03:45');
INSERT INTO `record` VALUES (1185, 210, 305, 1, '2019-05-10 14:03:38', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1186, 271, 305, 0, '2019-05-10 14:03:38', '2019-05-10 14:03:38');
INSERT INTO `record` VALUES (1187, 272, 305, 0, '2019-05-10 14:03:38', '2019-05-10 14:03:38');
INSERT INTO `record` VALUES (1188, 273, 305, 0, '2019-05-10 14:03:38', '2019-05-10 14:03:38');
INSERT INTO `record` VALUES (1189, 274, 305, 0, '2019-05-10 14:03:38', '2019-05-10 14:03:38');
INSERT INTO `record` VALUES (1190, 0, 306, 1, '2019-05-10 14:03:55', '2019-05-10 14:04:15');
INSERT INTO `record` VALUES (1191, 210, 306, 1, '2019-05-10 14:03:55', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1192, 271, 306, 0, '2019-05-10 14:03:55', '2019-05-10 14:03:55');
INSERT INTO `record` VALUES (1193, 272, 306, 0, '2019-05-10 14:03:55', '2019-05-10 14:03:55');
INSERT INTO `record` VALUES (1194, 273, 306, 0, '2019-05-10 14:03:56', '2019-05-10 14:03:56');
INSERT INTO `record` VALUES (1195, 274, 306, 0, '2019-05-10 14:03:56', '2019-05-10 14:03:56');
INSERT INTO `record` VALUES (1196, 0, 307, 1, '2019-05-10 14:04:01', '2019-05-10 14:04:15');
INSERT INTO `record` VALUES (1197, 210, 307, 1, '2019-05-10 14:04:01', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1198, 271, 307, 0, '2019-05-10 14:04:01', '2019-05-10 14:04:01');
INSERT INTO `record` VALUES (1199, 272, 307, 0, '2019-05-10 14:04:01', '2019-05-10 14:04:01');
INSERT INTO `record` VALUES (1200, 273, 307, 0, '2019-05-10 14:04:02', '2019-05-10 14:04:02');
INSERT INTO `record` VALUES (1201, 274, 307, 0, '2019-05-10 14:04:02', '2019-05-10 14:04:02');
INSERT INTO `record` VALUES (1202, 0, 308, 1, '2019-05-10 14:04:04', '2019-05-10 14:04:15');
INSERT INTO `record` VALUES (1203, 210, 308, 1, '2019-05-10 14:04:04', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1204, 271, 308, 0, '2019-05-10 14:04:05', '2019-05-10 14:04:05');
INSERT INTO `record` VALUES (1205, 272, 308, 0, '2019-05-10 14:04:05', '2019-05-10 14:04:05');
INSERT INTO `record` VALUES (1206, 273, 308, 0, '2019-05-10 14:04:05', '2019-05-10 14:04:05');
INSERT INTO `record` VALUES (1207, 274, 308, 0, '2019-05-10 14:04:05', '2019-05-10 14:04:05');
INSERT INTO `record` VALUES (1208, 0, 309, 1, '2019-05-10 14:04:06', '2019-05-10 14:04:15');
INSERT INTO `record` VALUES (1209, 210, 309, 1, '2019-05-10 14:04:06', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1210, 271, 309, 0, '2019-05-10 14:04:06', '2019-05-10 14:04:06');
INSERT INTO `record` VALUES (1211, 272, 309, 0, '2019-05-10 14:04:06', '2019-05-10 14:04:06');
INSERT INTO `record` VALUES (1212, 273, 309, 0, '2019-05-10 14:04:06', '2019-05-10 14:04:06');
INSERT INTO `record` VALUES (1213, 274, 309, 0, '2019-05-10 14:04:07', '2019-05-10 14:04:07');
INSERT INTO `record` VALUES (1214, 0, 310, 1, '2019-05-10 14:04:07', '2019-05-10 14:04:15');
INSERT INTO `record` VALUES (1215, 210, 310, 1, '2019-05-10 14:04:07', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1216, 271, 310, 0, '2019-05-10 14:04:08', '2019-05-10 14:04:08');
INSERT INTO `record` VALUES (1217, 272, 310, 0, '2019-05-10 14:04:08', '2019-05-10 14:04:08');
INSERT INTO `record` VALUES (1218, 273, 310, 0, '2019-05-10 14:04:08', '2019-05-10 14:04:08');
INSERT INTO `record` VALUES (1219, 274, 310, 0, '2019-05-10 14:04:08', '2019-05-10 14:04:08');
INSERT INTO `record` VALUES (1220, 0, 311, 1, '2019-05-10 14:04:09', '2019-05-10 14:04:15');
INSERT INTO `record` VALUES (1221, 210, 311, 1, '2019-05-10 14:04:09', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1222, 271, 311, 0, '2019-05-10 14:04:09', '2019-05-10 14:04:09');
INSERT INTO `record` VALUES (1223, 272, 311, 0, '2019-05-10 14:04:09', '2019-05-10 14:04:09');
INSERT INTO `record` VALUES (1224, 273, 311, 0, '2019-05-10 14:04:09', '2019-05-10 14:04:09');
INSERT INTO `record` VALUES (1225, 274, 311, 0, '2019-05-10 14:04:10', '2019-05-10 14:04:10');
INSERT INTO `record` VALUES (1226, 0, 312, 1, '2019-05-10 14:05:26', '2019-05-10 14:05:58');
INSERT INTO `record` VALUES (1227, 210, 312, 1, '2019-05-10 14:05:26', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1228, 271, 312, 0, '2019-05-10 14:05:26', '2019-05-10 14:05:26');
INSERT INTO `record` VALUES (1229, 272, 312, 0, '2019-05-10 14:05:27', '2019-05-10 14:05:27');
INSERT INTO `record` VALUES (1230, 273, 312, 0, '2019-05-10 14:05:27', '2019-05-10 14:05:27');
INSERT INTO `record` VALUES (1231, 274, 312, 0, '2019-05-10 14:05:27', '2019-05-10 14:05:27');
INSERT INTO `record` VALUES (1232, 275, 312, 1, '2019-05-10 14:05:27', '2019-05-10 14:05:38');
INSERT INTO `record` VALUES (1233, 0, 313, 1, '2019-05-10 14:05:35', '2019-05-10 14:05:58');
INSERT INTO `record` VALUES (1234, 210, 313, 1, '2019-05-10 14:05:36', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1235, 271, 313, 0, '2019-05-10 14:05:36', '2019-05-10 14:05:36');
INSERT INTO `record` VALUES (1236, 272, 313, 0, '2019-05-10 14:05:36', '2019-05-10 14:05:36');
INSERT INTO `record` VALUES (1237, 273, 313, 0, '2019-05-10 14:05:36', '2019-05-10 14:05:36');
INSERT INTO `record` VALUES (1238, 274, 313, 0, '2019-05-10 14:05:36', '2019-05-10 14:05:36');
INSERT INTO `record` VALUES (1239, 275, 313, 1, '2019-05-10 14:05:37', '2019-05-10 14:05:38');
INSERT INTO `record` VALUES (1240, 0, 314, 1, '2019-05-10 14:05:44', '2019-05-10 14:05:58');
INSERT INTO `record` VALUES (1241, 210, 314, 1, '2019-05-10 14:05:44', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1242, 271, 314, 0, '2019-05-10 14:05:44', '2019-05-10 14:05:44');
INSERT INTO `record` VALUES (1243, 272, 314, 0, '2019-05-10 14:05:44', '2019-05-10 14:05:44');
INSERT INTO `record` VALUES (1244, 273, 314, 0, '2019-05-10 14:05:45', '2019-05-10 14:05:45');
INSERT INTO `record` VALUES (1245, 274, 314, 0, '2019-05-10 14:05:45', '2019-05-10 14:05:45');
INSERT INTO `record` VALUES (1246, 275, 314, 0, '2019-05-10 14:05:45', '2019-05-10 14:05:45');
INSERT INTO `record` VALUES (1247, 0, 315, 1, '2019-05-10 14:06:02', '2019-05-10 14:06:19');
INSERT INTO `record` VALUES (1248, 210, 315, 1, '2019-05-10 14:06:02', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1249, 271, 315, 0, '2019-05-10 14:06:02', '2019-05-10 14:06:02');
INSERT INTO `record` VALUES (1250, 272, 315, 0, '2019-05-10 14:06:02', '2019-05-10 14:06:02');
INSERT INTO `record` VALUES (1251, 273, 315, 0, '2019-05-10 14:06:02', '2019-05-10 14:06:02');
INSERT INTO `record` VALUES (1252, 274, 315, 0, '2019-05-10 14:06:03', '2019-05-10 14:06:03');
INSERT INTO `record` VALUES (1253, 275, 315, 0, '2019-05-10 14:06:03', '2019-05-10 14:06:03');
INSERT INTO `record` VALUES (1254, 0, 316, 1, '2019-05-10 14:06:11', '2019-05-10 14:06:19');
INSERT INTO `record` VALUES (1255, 210, 316, 1, '2019-05-10 14:06:11', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1256, 271, 316, 0, '2019-05-10 14:06:11', '2019-05-10 14:06:11');
INSERT INTO `record` VALUES (1257, 272, 316, 0, '2019-05-10 14:06:11', '2019-05-10 14:06:11');
INSERT INTO `record` VALUES (1258, 273, 316, 0, '2019-05-10 14:06:11', '2019-05-10 14:06:11');
INSERT INTO `record` VALUES (1259, 274, 316, 0, '2019-05-10 14:06:11', '2019-05-10 14:06:11');
INSERT INTO `record` VALUES (1260, 275, 316, 0, '2019-05-10 14:06:11', '2019-05-10 14:06:11');
INSERT INTO `record` VALUES (1261, 0, 317, 0, '2019-05-10 14:06:29', '2019-05-10 14:06:29');
INSERT INTO `record` VALUES (1262, 210, 317, 1, '2019-05-10 14:06:29', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1263, 271, 317, 0, '2019-05-10 14:06:29', '2019-05-10 14:06:29');
INSERT INTO `record` VALUES (1264, 272, 317, 0, '2019-05-10 14:06:29', '2019-05-10 14:06:29');
INSERT INTO `record` VALUES (1265, 273, 317, 0, '2019-05-10 14:06:29', '2019-05-10 14:06:29');
INSERT INTO `record` VALUES (1266, 274, 317, 0, '2019-05-10 14:06:29', '2019-05-10 14:06:29');
INSERT INTO `record` VALUES (1267, 275, 317, 0, '2019-05-10 14:06:30', '2019-05-10 14:06:30');
INSERT INTO `record` VALUES (1268, 0, 318, 0, '2019-05-10 14:06:30', '2019-05-10 14:06:30');
INSERT INTO `record` VALUES (1269, 210, 318, 1, '2019-05-10 14:06:30', '2019-05-10 14:07:21');
INSERT INTO `record` VALUES (1270, 271, 318, 0, '2019-05-10 14:06:31', '2019-05-10 14:06:31');
INSERT INTO `record` VALUES (1271, 272, 318, 0, '2019-05-10 14:06:31', '2019-05-10 14:06:31');
INSERT INTO `record` VALUES (1272, 273, 318, 0, '2019-05-10 14:06:31', '2019-05-10 14:06:31');
INSERT INTO `record` VALUES (1273, 274, 318, 0, '2019-05-10 14:06:31', '2019-05-10 14:06:31');
INSERT INTO `record` VALUES (1274, 275, 318, 0, '2019-05-10 14:06:31', '2019-05-10 14:06:31');

-- ----------------------------
-- Table structure for remark
-- ----------------------------
DROP TABLE IF EXISTS `remark`;
CREATE TABLE `remark`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '评论者id',
  `moment_id` bigint(10) UNSIGNED NOT NULL COMMENT '评论对象id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `love` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `collect` int(10) UNSIGNED NOT NULL COMMENT '收藏量',
  `reply` bigint(10) UNSIGNED NOT NULL COMMENT '回复数',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_7`(`user_id`) USING BTREE,
  INDEX `fk_target_id_2`(`moment_id`) USING BTREE,
  CONSTRAINT `fk_target_id_1` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_target_id_2` FOREIGN KEY (`moment_id`) REFERENCES `article` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_7` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '回复者id',
  `to_uid` bigint(10) UNSIGNED NOT NULL COMMENT '被回复用户id',
  `remark_id` bigint(10) UNSIGNED NOT NULL COMMENT '所处评论id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `love` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `collect` int(10) UNSIGNED NOT NULL COMMENT '收藏量',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_8`(`user_id`) USING BTREE,
  INDEX `fk_remark_id_1`(`remark_id`) USING BTREE,
  CONSTRAINT `fk_remark_id_1` FOREIGN KEY (`remark_id`) REFERENCES `remark` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_8` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '角色描述',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(10) UNSIGNED NOT NULL COMMENT '角色id',
  `permission_id` bigint(10) UNSIGNED NOT NULL COMMENT '权限id',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_permission_id`(`permission_id`) USING BTREE,
  INDEX `fk_permission_role`(`role_id`) USING BTREE,
  CONSTRAINT `fk_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_permission_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for table
-- ----------------------------
DROP TABLE IF EXISTS `table`;
CREATE TABLE `table`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱号',
  `wechat_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未设置' COMMENT '微信号',
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1234' COMMENT '账号密码',
  `gender` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '未设置' COMMENT '性别（未设置/男/女）',
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球' COMMENT '个性签名',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '默认昵称' COMMENT '用户昵称',
  `photo` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'user_photo.jpg' COMMENT '用户头像',
  `chat_background` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '聊天背景',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户所在地区',
  `online_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '离线' COMMENT '在线状态（离线/在线/隐身/忙碌）',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 279 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (0, '1234@qq.com', '未设置', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', '我是蔡徐坤', '1234@qq.com的昵称', 'bc3ea5a024464cae9f59901d3d9799e2.jpg', 'd4d63b2a383c47fbb8a6a2a744ad3282.jpg', '', '离线', 0, '2019-05-09 15:52:49', '2019-05-10 07:15:10');
INSERT INTO `user` VALUES (210, 'test5@qq.com', '未设置', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', '', 'test5@qq.com的昵称', 'd05ac5608773423abdebf899cde10d94.png', 'cb78151bba9142c5a67f87badaeef9d6.jpg', '', '离线', 0, '2019-05-09 16:09:50', '2019-05-10 04:50:53');
INSERT INTO `user` VALUES (219, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-09 18:51:00', '2019-05-09 18:51:00');
INSERT INTO `user` VALUES (220, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-09 19:01:01', '2019-05-09 19:01:01');
INSERT INTO `user` VALUES (221, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-09 19:01:39', '2019-05-09 19:01:39');
INSERT INTO `user` VALUES (222, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-09 19:02:44', '2019-05-09 19:02:44');
INSERT INTO `user` VALUES (224, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-09 19:05:44', '2019-05-09 19:05:44');
INSERT INTO `user` VALUES (271, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客1', 'c6b34b21abe749cf9c338c84a59fa1c7.jpg', '', '', '离线', 0, '2019-05-10 13:08:58', '2019-05-10 13:10:04');
INSERT INTO `user` VALUES (272, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-10 13:09:10', '2019-05-10 13:09:10');
INSERT INTO `user` VALUES (273, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客1', 'baea71e46d864b69b927784956d46236.jpg', '', '', '离线', 0, '2019-05-10 13:22:03', '2019-05-10 13:25:20');
INSERT INTO `user` VALUES (274, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客2', 'user_photo.jpg', '', '', '离线', 0, '2019-05-10 13:26:05', '2019-05-10 13:26:25');
INSERT INTO `user` VALUES (275, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-10 14:05:15', '2019-05-10 14:05:15');
INSERT INTO `user` VALUES (276, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-10 14:16:42', '2019-05-10 14:16:42');
INSERT INTO `user` VALUES (277, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-10 14:17:29', '2019-05-10 14:17:29');
INSERT INTO `user` VALUES (278, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-10 14:19:06', '2019-05-10 14:19:06');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '用户id',
  `role_id` bigint(10) UNSIGNED NOT NULL COMMENT '角色id',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_role_id`(`role_id`) USING BTREE,
  INDEX `fk_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
