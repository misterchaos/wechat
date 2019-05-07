/*
 Navicat Premium Data Transfer

 Source Server         : 本地测试库
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : wechat

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 07/05/2019 16:49:36
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
  `like` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
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
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'default_head.jpg' COMMENT '聊天头像',
  `member` smallint(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '成员人数',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat
-- ----------------------------
INSERT INTO `chat` VALUES (0, '', 0, '聊天总群', 'images.png', 3, 0, '2019-05-06 19:58:06', '2019-05-06 20:41:35');
INSERT INTO `chat` VALUES (40, '3dc388d088874222b14db4af14dd1ab6', 184, '群聊', 'default_head.jpg', 3, 0, '2019-05-06 23:51:17', '2019-05-07 11:10:28');
INSERT INTO `chat` VALUES (41, '4cfedd2d689a49668e83db93024f1af3', 0, '群聊', 'default_head.jpg', 0, 0, '2019-05-07 00:28:57', '2019-05-07 00:28:57');
INSERT INTO `chat` VALUES (42, '6c4d450b123c4428bfeebcc28ca05d65', 0, '群聊', 'default_head.jpg', 0, 0, '2019-05-07 00:30:18', '2019-05-07 00:30:18');
INSERT INTO `chat` VALUES (43, '5cc538ee9cda4703b248abace616f008', 0, '广工夸夸', 'default_head.jpg', 0, 0, '2019-05-07 00:31:04', '2019-05-07 00:31:04');

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
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '好友描述',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_2`(`user_id`) USING BTREE,
  INDEX `fk_friend_id_1`(`friend_id`) USING BTREE,
  INDEX `fk_group_id_1`(`group_id`) USING BTREE,
  CONSTRAINT `fk_user_id_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_friend_id_1` FOREIGN KEY (`friend_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_group_id_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES (52, 184, 0, 0, 'default_head', 0, '', '', 0, '2019-05-06 20:24:22', '2019-05-06 20:24:22');
INSERT INTO `friend` VALUES (53, 0, 184, 0, 'default_head', 0, '', '', 0, '2019-05-06 23:51:17', '2019-05-06 23:51:17');
INSERT INTO `friend` VALUES (54, 0, 179, 0, 'default_head', 0, '', '', 0, '2019-05-07 10:32:05', '2019-05-07 10:32:05');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group
-- ----------------------------
INSERT INTO `group` VALUES (0, 0, '', 0, 0, '2019-05-02 02:08:33', '2019-05-02 02:10:42');

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
  CONSTRAINT `fk_user_id_6` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chat_id_2` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 202 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (193, 184, 0, '', 0, '', 0, '2019-05-06 19:59:24', '2019-05-06 19:59:24');
INSERT INTO `member` VALUES (194, 0, 0, '', 0, '', 0, '2019-05-06 20:00:00', '2019-05-06 20:00:00');
INSERT INTO `member` VALUES (199, 0, 40, '', 0, '', 0, '2019-05-06 23:51:17', '2019-05-06 23:51:17');
INSERT INTO `member` VALUES (200, 184, 40, '', 0, '', 0, '2019-05-06 23:51:17', '2019-05-06 23:51:17');
INSERT INTO `member` VALUES (201, 182, 40, '', 0, '', 0, '2019-05-07 11:10:17', '2019-05-07 11:10:17');

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
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发送时间',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_3`(`sender_id`) USING BTREE,
  INDEX `fk_chat_id_4`(`chat_id`) USING BTREE,
  CONSTRAINT `fk_user_id_3` FOREIGN KEY (`sender_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chat_id_4` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (73, 0, 40, 'JILUL', 'user', '2019-05-07 16:15:03', 0, '2019-05-07 16:15:18', '2019-05-07 16:15:18');
INSERT INTO `message` VALUES (74, 0, 40, '阿斯蒂', 'user', '2019-05-07 16:23:12', 0, '2019-05-07 16:25:56', '2019-05-07 16:25:56');
INSERT INTO `message` VALUES (75, 0, 40, '很快就', 'user', '2019-05-07 16:25:45', 0, '2019-05-07 16:25:56', '2019-05-07 16:25:56');
INSERT INTO `message` VALUES (76, 0, 40, '你好', 'user', '2019-05-07 16:28:18', 0, '2019-05-07 16:44:09', '2019-05-07 16:44:09');

-- ----------------------------
-- Table structure for moment
-- ----------------------------
DROP TABLE IF EXISTS `moment`;
CREATE TABLE `moment`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '发布者id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间',
  `love` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `comment` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数',
  `share` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '转发数',
  `view` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量',
  `collect` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏量',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_4`(`user_id`) USING BTREE,
  CONSTRAINT `fk_user_id_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of moment
-- ----------------------------
INSERT INTO `moment` VALUES (7, 184, '一条朋友圈', '2019-05-07 14:07:52', 0, 0, 0, 0, 0, 0, '2019-05-07 13:04:34', '2019-05-07 13:04:34');
INSERT INTO `moment` VALUES (8, 184, '一条朋友圈', '2019-05-07 14:07:52', 0, 0, 0, 0, 0, 0, '2019-05-07 13:04:40', '2019-05-07 13:04:40');
INSERT INTO `moment` VALUES (9, 0, '一条朋友圈', '2019-05-07 14:07:52', 10, 0, 0, 0, 0, 0, '2019-05-07 13:08:23', '2019-05-07 13:08:23');
INSERT INTO `moment` VALUES (10, 0, '一条朋友圈', '2019-05-07 16:49:08', 10, 0, 0, 0, 0, 0, '2019-05-07 16:49:08', '2019-05-07 16:49:08');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '用户id',
  `moment_id` bigint(10) UNSIGNED NOT NULL COMMENT '朋友圈id',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态（0未读，1已读）',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_3`(`user_id`) USING BTREE,
  INDEX `fk_message_id_2`(`moment_id`) USING BTREE,
  CONSTRAINT `news_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_moment_1` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用来记录一条朋友圈和可见用户的映射关系' ROW_FORMAT = Dynamic;

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
  CONSTRAINT `record_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_message_id_2` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (77, 0, 73, 0, '2019-05-07 16:15:18', '2019-05-07 16:15:18');
INSERT INTO `record` VALUES (78, 0, 73, 0, '2019-05-07 16:15:18', '2019-05-07 16:15:18');
INSERT INTO `record` VALUES (79, 184, 73, 0, '2019-05-07 16:15:18', '2019-05-07 16:15:18');
INSERT INTO `record` VALUES (80, 182, 73, 0, '2019-05-07 16:15:18', '2019-05-07 16:15:18');
INSERT INTO `record` VALUES (81, 0, 73, 0, '2019-05-07 16:25:56', '2019-05-07 16:25:56');
INSERT INTO `record` VALUES (82, 184, 73, 0, '2019-05-07 16:25:56', '2019-05-07 16:25:56');
INSERT INTO `record` VALUES (83, 182, 73, 0, '2019-05-07 16:25:56', '2019-05-07 16:25:56');
INSERT INTO `record` VALUES (84, 0, 73, 0, '2019-05-07 16:25:56', '2019-05-07 16:25:56');
INSERT INTO `record` VALUES (85, 184, 73, 0, '2019-05-07 16:25:56', '2019-05-07 16:25:56');
INSERT INTO `record` VALUES (86, 182, 73, 0, '2019-05-07 16:25:56', '2019-05-07 16:25:56');
INSERT INTO `record` VALUES (87, 0, 73, 0, '2019-05-07 16:44:09', '2019-05-07 16:44:09');
INSERT INTO `record` VALUES (88, 184, 73, 0, '2019-05-07 16:44:09', '2019-05-07 16:44:09');
INSERT INTO `record` VALUES (89, 182, 73, 0, '2019-05-07 16:44:09', '2019-05-07 16:44:09');

-- ----------------------------
-- Table structure for remark
-- ----------------------------
DROP TABLE IF EXISTS `remark`;
CREATE TABLE `remark`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '评论者id',
  `target_id` bigint(10) UNSIGNED NOT NULL COMMENT '评论对象id',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论类型',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `like` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `collect` int(10) UNSIGNED NOT NULL COMMENT '收藏量',
  `reply` bigint(10) UNSIGNED NOT NULL COMMENT '回复数',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_7`(`user_id`) USING BTREE,
  INDEX `fk_target_id_2`(`target_id`) USING BTREE,
  CONSTRAINT `fk_user_id_7` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_target_id_1` FOREIGN KEY (`target_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_target_id_2` FOREIGN KEY (`target_id`) REFERENCES `article` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `like` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `collect` int(10) UNSIGNED NOT NULL COMMENT '收藏量',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_8`(`user_id`) USING BTREE,
  INDEX `fk_remark_id_1`(`remark_id`) USING BTREE,
  CONSTRAINT `fk_user_id_8` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_remark_id_1` FOREIGN KEY (`remark_id`) REFERENCES `remark` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '个性签名',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '默认昵称' COMMENT '用户昵称',
  `photo` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `chat_background` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '聊天背景',
  `location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户所在地区',
  `online_status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '离线' COMMENT '在线状态（离线/在线/隐身/忙碌）',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 190 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (0, '1234@qq.com', 'misterchaos3', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', '我是蔡徐坤', '蔡徐坤', 'da65e244e14649dea1a4b3c08599f983.jpg', '', '中国', '离线', 0, '2019-05-05 04:33:05', '2019-05-06 20:04:47');
INSERT INTO `user` VALUES (168, 'test3@qq.com', '未设置', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', '', 'test3@qq.com的昵称', '', '', '', '离线', 0, '2019-05-05 16:12:34', '2019-05-05 16:12:34');
INSERT INTO `user` VALUES (178, 'test4@qq.com', '未设置', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', '', 'test4', '', '', '', '离线', 0, '2019-05-06 05:49:52', '2019-05-06 05:53:36');
INSERT INTO `user` VALUES (179, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-06 06:22:47', '2019-05-06 06:22:47');
INSERT INTO `user` VALUES (180, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-06 06:23:40', '2019-05-06 06:23:40');
INSERT INTO `user` VALUES (181, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-06 06:25:37', '2019-05-06 06:25:37');
INSERT INTO `user` VALUES (182, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-06 06:25:51', '2019-05-06 06:25:51');
INSERT INTO `user` VALUES (184, 'test5@qq.com', '未设置', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', '', 'test5@qq.com的昵称', 'a547ca40b9004db4a376d0c0fb3f99a5.png', '', '', '离线', 0, '2019-05-06 19:59:24', '2019-05-06 20:06:48');
INSERT INTO `user` VALUES (185, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-07 11:57:44', '2019-05-07 11:57:44');
INSERT INTO `user` VALUES (186, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-07 11:58:25', '2019-05-07 11:58:25');
INSERT INTO `user` VALUES (187, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-07 11:59:10', '2019-05-07 11:59:10');
INSERT INTO `user` VALUES (188, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-07 13:08:23', '2019-05-07 13:08:23');
INSERT INTO `user` VALUES (189, '', '未设置', '', '1234', '未设置', '', 'testasdf中文', '', '', '', '离线', 0, '2019-05-07 16:49:08', '2019-05-07 16:49:08');

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
