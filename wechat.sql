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

 Date: 15/05/2019 01:09:17
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
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'friend' COMMENT '聊天类型',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '群聊' COMMENT '聊天名称',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'chat.jpg' COMMENT '聊天头像',
  `member` smallint(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '成员人数',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_owner_id`(`owner_id`) USING BTREE,
  CONSTRAINT `fk_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 120 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat
-- ----------------------------
INSERT INTO `chat` VALUES (0, '0', 0, 'user', '聊天总群', 'chat.jpg', 25, 0, '2019-05-10 11:04:21', '2019-05-13 17:15:27');
INSERT INTO `chat` VALUES (98, '1', 0, 'user', '群聊', 'chat.jpg', 2, 0, '2019-05-13 22:57:37', '2019-05-13 22:58:45');
INSERT INTO `chat` VALUES (99, '8ae767a9dbcd401f9c15cf537435deb4', 0, 'user', '群聊', 'chat.jpg', 2, 0, '2019-05-13 23:18:12', '2019-05-13 23:18:12');
INSERT INTO `chat` VALUES (100, '4435f513f66144eeb000e14395ed7fb1', 0, 'user', '群聊', 'chat.jpg', 2, 0, '2019-05-14 15:41:16', '2019-05-14 15:41:16');
INSERT INTO `chat` VALUES (101, 'ad63a47ae1b94971a4367b2b05846c45', 0, 'user', '群聊', 'chat.jpg', 2, 0, '2019-05-14 16:36:30', '2019-05-14 16:36:30');
INSERT INTO `chat` VALUES (102, '226b8301d8494fd98dae41582877164c', 0, 'user', '群聊', 'chat.jpg', 2, 0, '2019-05-14 16:39:58', '2019-05-14 16:39:58');
INSERT INTO `chat` VALUES (103, 'fea00c48a7934c66bada67963f7b158f', 0, 'user', '群聊', 'chat.jpg', 2, 0, '2019-05-14 17:10:42', '2019-05-14 17:10:42');
INSERT INTO `chat` VALUES (104, '123456', 210, 'user', '广工夸夸群', 'chat.jpg', 13, 0, '2019-05-14 17:13:57', '2019-05-14 17:13:57');
INSERT INTO `chat` VALUES (105, 'e4358272fc1748a2a2d09e898e51986b', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 17:26:49', '2019-05-14 17:26:49');
INSERT INTO `chat` VALUES (106, '8b1fc050fe8f4892a0de54ec7dff49f3', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 17:58:48', '2019-05-14 17:58:48');
INSERT INTO `chat` VALUES (107, 'd126e516e9924d50bb861a75c8b5faeb', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 20:35:38', '2019-05-14 20:35:38');
INSERT INTO `chat` VALUES (108, 'b36ed79c287246c6802623a987832a71', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 21:05:33', '2019-05-14 21:05:33');
INSERT INTO `chat` VALUES (109, '8a48ee888ff2415d93a6ba3e8012f12a', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 21:15:47', '2019-05-14 21:15:47');
INSERT INTO `chat` VALUES (110, '669c968804e64bea9a5287c146a00d5e', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 21:33:58', '2019-05-14 21:33:58');
INSERT INTO `chat` VALUES (111, 'e591cbcabc3c4c30b875299321f8f721', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 21:50:04', '2019-05-14 21:50:04');
INSERT INTO `chat` VALUES (112, '419493a4c2c648bdafb017c0cc77a572', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 22:02:12', '2019-05-14 22:02:12');
INSERT INTO `chat` VALUES (113, '81199d1f5ce848f0a6cb55a8f6ca1943', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 22:02:15', '2019-05-14 22:02:15');
INSERT INTO `chat` VALUES (114, '7e6b41eed8d4471eb9ffcbf748020db7', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 22:11:33', '2019-05-14 22:11:33');
INSERT INTO `chat` VALUES (115, '60a81b9afb1441b98520badff3e3eb18', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 22:20:55', '2019-05-14 22:20:55');
INSERT INTO `chat` VALUES (116, '22ede7f1563d4455886acd32144d5f14', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 22:29:33', '2019-05-14 22:29:33');
INSERT INTO `chat` VALUES (117, '5e905ec2d29848ef93ca12628f0760a2', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 23:14:32', '2019-05-14 23:14:32');
INSERT INTO `chat` VALUES (118, '8b87d70931414018bcf5a0ed6dc20b61', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 23:28:11', '2019-05-14 23:28:11');
INSERT INTO `chat` VALUES (119, '12fc1c3d761145efbfd0c843018cbc75', 0, 'friend', '群聊', 'chat.jpg', 2, 0, '2019-05-14 23:34:35', '2019-05-14 23:34:35');

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
) ENGINE = InnoDB AUTO_INCREMENT = 217 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friend
-- ----------------------------
INSERT INTO `friend` VALUES (122, 425, 0, 87, 'default_head', 0, '蔡徐坤', '灵魂篮球练习生', 0, '2019-05-13 17:23:47', '2019-05-13 22:41:08');
INSERT INTO `friend` VALUES (124, 0, 425, 87, 'default_head', 0, 'test2@qq.com', '未添加好友描述', 0, '2019-05-13 17:30:21', '2019-05-13 17:30:21');
INSERT INTO `friend` VALUES (146, 210, 422, 0, 'default_head', 0, 'kk', '我是test5@qq.com的昵称,快加我为好友吧！', 0, '2019-05-13 19:27:01', '2019-05-13 19:27:01');
INSERT INTO `friend` VALUES (173, 425, 210, 97, 'default_head', 0, '定时', '我是test2@qq.com,快加我为好友吧！', 0, '2019-05-13 22:26:49', '2019-05-13 22:26:49');
INSERT INTO `friend` VALUES (174, 210, 425, 97, 'default_head', 0, 'd ', '未添加好友描述', 0, '2019-05-13 22:27:53', '2019-05-13 22:27:53');
INSERT INTO `friend` VALUES (175, 210, 0, 98, 'default_head', 0, 'a', '我是test5@qq.com的昵称,快加我为好友吧！', 0, '2019-05-13 22:56:06', '2019-05-13 22:59:31');
INSERT INTO `friend` VALUES (176, 0, 210, 98, 'default_head', 0, '', '未添加好友描述', 0, '2019-05-13 22:59:27', '2019-05-13 22:59:38');
INSERT INTO `friend` VALUES (177, 0, 430, 99, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-13 23:18:09', '2019-05-13 23:18:09');
INSERT INTO `friend` VALUES (178, 430, 0, 99, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-13 23:18:11', '2019-05-13 23:18:11');
INSERT INTO `friend` VALUES (179, 0, 433, 100, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 15:41:12', '2019-05-14 15:41:12');
INSERT INTO `friend` VALUES (180, 433, 0, 100, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 15:41:14', '2019-05-14 15:41:14');
INSERT INTO `friend` VALUES (181, 0, 440, 101, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 16:36:27', '2019-05-14 16:36:27');
INSERT INTO `friend` VALUES (182, 440, 0, 101, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 16:36:29', '2019-05-14 16:36:29');
INSERT INTO `friend` VALUES (183, 0, 443, 102, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 16:39:55', '2019-05-14 16:39:55');
INSERT INTO `friend` VALUES (184, 443, 0, 102, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 16:39:57', '2019-05-14 16:39:57');
INSERT INTO `friend` VALUES (185, 0, 445, 103, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 17:10:37', '2019-05-14 17:10:37');
INSERT INTO `friend` VALUES (186, 445, 0, 103, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 17:10:40', '2019-05-14 17:10:40');
INSERT INTO `friend` VALUES (187, 0, 446, 105, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 17:26:46', '2019-05-14 17:26:46');
INSERT INTO `friend` VALUES (188, 446, 0, 105, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 17:26:48', '2019-05-14 17:26:48');
INSERT INTO `friend` VALUES (189, 0, 447, 106, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 17:58:46', '2019-05-14 17:58:46');
INSERT INTO `friend` VALUES (190, 447, 0, 106, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 17:58:47', '2019-05-14 17:58:47');
INSERT INTO `friend` VALUES (191, 0, 448, 107, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 20:35:36', '2019-05-14 20:35:36');
INSERT INTO `friend` VALUES (192, 448, 0, 107, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 20:35:37', '2019-05-14 20:35:37');
INSERT INTO `friend` VALUES (193, 0, 449, 108, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 21:05:28', '2019-05-14 21:05:28');
INSERT INTO `friend` VALUES (194, 449, 0, 108, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 21:05:31', '2019-05-14 21:05:31');
INSERT INTO `friend` VALUES (195, 0, 450, 109, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 21:15:45', '2019-05-14 21:15:45');
INSERT INTO `friend` VALUES (196, 450, 0, 109, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 21:15:47', '2019-05-14 21:15:47');
INSERT INTO `friend` VALUES (197, 0, 451, 110, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 21:33:56', '2019-05-14 21:33:56');
INSERT INTO `friend` VALUES (198, 451, 0, 110, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 21:33:57', '2019-05-14 21:33:57');
INSERT INTO `friend` VALUES (199, 0, 452, 111, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 21:50:02', '2019-05-14 21:50:02');
INSERT INTO `friend` VALUES (200, 452, 0, 111, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 21:50:03', '2019-05-14 21:50:03');
INSERT INTO `friend` VALUES (201, 0, 453, 112, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:02:10', '2019-05-14 22:02:10');
INSERT INTO `friend` VALUES (202, 453, 0, 112, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:02:11', '2019-05-14 22:02:11');
INSERT INTO `friend` VALUES (203, 0, 454, 113, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:02:13', '2019-05-14 22:02:13');
INSERT INTO `friend` VALUES (204, 454, 0, 113, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:02:15', '2019-05-14 22:02:15');
INSERT INTO `friend` VALUES (205, 0, 455, 114, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:11:30', '2019-05-14 22:11:30');
INSERT INTO `friend` VALUES (206, 455, 0, 114, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:11:32', '2019-05-14 22:11:32');
INSERT INTO `friend` VALUES (207, 0, 456, 115, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:20:53', '2019-05-14 22:20:53');
INSERT INTO `friend` VALUES (208, 456, 0, 115, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:20:54', '2019-05-14 22:20:54');
INSERT INTO `friend` VALUES (209, 0, 457, 116, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:29:29', '2019-05-14 22:29:29');
INSERT INTO `friend` VALUES (210, 457, 0, 116, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 22:29:31', '2019-05-14 22:29:31');
INSERT INTO `friend` VALUES (211, 0, 458, 117, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 23:14:30', '2019-05-14 23:14:30');
INSERT INTO `friend` VALUES (212, 458, 0, 117, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 23:14:31', '2019-05-14 23:14:31');
INSERT INTO `friend` VALUES (213, 0, 459, 118, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 23:28:10', '2019-05-14 23:28:10');
INSERT INTO `friend` VALUES (214, 459, 0, 118, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 23:28:11', '2019-05-14 23:28:11');
INSERT INTO `friend` VALUES (215, 0, 460, 119, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 23:34:33', '2019-05-14 23:34:33');
INSERT INTO `friend` VALUES (216, 460, 0, 119, 'default_head', 0, '游客', '未添加好友描述', 0, '2019-05-14 23:34:34', '2019-05-14 23:34:34');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
  `apply` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '大家好，我是本群的新成员' COMMENT '加群申请',
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
) ENGINE = InnoDB AUTO_INCREMENT = 513 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (251, 0, 0, '', '', 0, '', 0, '2019-05-10 11:38:50', '2019-05-10 11:38:50');
INSERT INTO `member` VALUES (252, 210, 0, '', '', 0, '', 0, '2019-05-10 11:39:03', '2019-05-10 11:39:03');
INSERT INTO `member` VALUES (409, 422, 0, '游客', '', 0, '', 0, '2019-05-13 17:23:46', '2019-05-13 17:23:46');
INSERT INTO `member` VALUES (412, 425, 0, 'test2@qq.com', '', 0, '', 0, '2019-05-13 17:30:19', '2019-05-13 17:30:19');
INSERT INTO `member` VALUES (435, 0, 98, '', '', 0, '', 0, '2019-05-13 22:57:57', '2019-05-13 22:57:57');
INSERT INTO `member` VALUES (436, 210, 98, '', '', 0, '', 0, '2019-05-13 22:58:10', '2019-05-13 22:58:10');
INSERT INTO `member` VALUES (437, 430, 0, '游客', '', 0, '', 0, '2019-05-13 23:18:06', '2019-05-13 23:18:06');
INSERT INTO `member` VALUES (438, 430, 99, '游客', '', 0, '', 0, '2019-05-13 23:18:14', '2019-05-13 23:18:14');
INSERT INTO `member` VALUES (439, 0, 99, '系统账号', '', 0, '', 0, '2019-05-13 23:18:15', '2019-05-13 23:18:15');
INSERT INTO `member` VALUES (440, 433, 0, '游客', '', 0, '', 0, '2019-05-14 15:41:11', '2019-05-14 15:41:11');
INSERT INTO `member` VALUES (441, 433, 100, '游客', '', 0, '', 0, '2019-05-14 15:41:17', '2019-05-14 15:41:17');
INSERT INTO `member` VALUES (442, 0, 100, '系统账号', '', 0, '', 0, '2019-05-14 15:41:18', '2019-05-14 15:41:18');
INSERT INTO `member` VALUES (443, 440, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 16:36:23', '2019-05-14 16:36:23');
INSERT INTO `member` VALUES (444, 440, 101, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 16:36:31', '2019-05-14 16:36:31');
INSERT INTO `member` VALUES (445, 0, 101, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 16:36:32', '2019-05-14 16:36:32');
INSERT INTO `member` VALUES (446, 443, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 16:39:53', '2019-05-14 16:39:53');
INSERT INTO `member` VALUES (447, 443, 102, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 16:39:59', '2019-05-14 16:39:59');
INSERT INTO `member` VALUES (448, 0, 102, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 16:40:00', '2019-05-14 16:40:00');
INSERT INTO `member` VALUES (449, 445, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:10:34', '2019-05-14 17:10:34');
INSERT INTO `member` VALUES (450, 445, 103, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:10:43', '2019-05-14 17:10:43');
INSERT INTO `member` VALUES (451, 0, 103, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:10:44', '2019-05-14 17:10:44');
INSERT INTO `member` VALUES (452, 210, 104, 'test5', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:13:58', '2019-05-14 17:13:58');
INSERT INTO `member` VALUES (454, 446, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:26:45', '2019-05-14 17:26:45');
INSERT INTO `member` VALUES (455, 446, 105, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:26:50', '2019-05-14 17:26:50');
INSERT INTO `member` VALUES (456, 0, 105, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:26:51', '2019-05-14 17:26:51');
INSERT INTO `member` VALUES (458, 447, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:58:44', '2019-05-14 17:58:44');
INSERT INTO `member` VALUES (459, 447, 106, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:58:49', '2019-05-14 17:58:49');
INSERT INTO `member` VALUES (460, 0, 106, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 17:58:50', '2019-05-14 17:58:50');
INSERT INTO `member` VALUES (462, 448, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 20:35:34', '2019-05-14 20:35:34');
INSERT INTO `member` VALUES (463, 448, 107, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 20:35:39', '2019-05-14 20:35:39');
INSERT INTO `member` VALUES (464, 0, 107, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 20:35:40', '2019-05-14 20:35:40');
INSERT INTO `member` VALUES (466, 449, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:05:26', '2019-05-14 21:05:26');
INSERT INTO `member` VALUES (467, 449, 108, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:05:33', '2019-05-14 21:05:33');
INSERT INTO `member` VALUES (468, 0, 108, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:05:34', '2019-05-14 21:05:34');
INSERT INTO `member` VALUES (471, 450, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:15:44', '2019-05-14 21:15:44');
INSERT INTO `member` VALUES (472, 450, 109, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:15:48', '2019-05-14 21:15:48');
INSERT INTO `member` VALUES (473, 0, 109, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:15:49', '2019-05-14 21:15:49');
INSERT INTO `member` VALUES (475, 451, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:33:54', '2019-05-14 21:33:54');
INSERT INTO `member` VALUES (476, 451, 110, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:33:59', '2019-05-14 21:33:59');
INSERT INTO `member` VALUES (477, 0, 110, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:34:00', '2019-05-14 21:34:00');
INSERT INTO `member` VALUES (478, 452, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:50:01', '2019-05-14 21:50:01');
INSERT INTO `member` VALUES (479, 452, 111, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:50:05', '2019-05-14 21:50:05');
INSERT INTO `member` VALUES (480, 0, 111, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 21:50:06', '2019-05-14 21:50:06');
INSERT INTO `member` VALUES (482, 453, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:02:08', '2019-05-14 22:02:08');
INSERT INTO `member` VALUES (483, 454, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:02:10', '2019-05-14 22:02:10');
INSERT INTO `member` VALUES (484, 453, 112, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:02:13', '2019-05-14 22:02:13');
INSERT INTO `member` VALUES (485, 0, 112, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:02:14', '2019-05-14 22:02:14');
INSERT INTO `member` VALUES (486, 454, 113, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:02:16', '2019-05-14 22:02:16');
INSERT INTO `member` VALUES (487, 0, 113, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:02:17', '2019-05-14 22:02:17');
INSERT INTO `member` VALUES (489, 455, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:11:28', '2019-05-14 22:11:28');
INSERT INTO `member` VALUES (490, 455, 114, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:11:34', '2019-05-14 22:11:34');
INSERT INTO `member` VALUES (491, 0, 114, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:11:35', '2019-05-14 22:11:35');
INSERT INTO `member` VALUES (493, 456, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:20:52', '2019-05-14 22:20:52');
INSERT INTO `member` VALUES (494, 456, 115, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:20:56', '2019-05-14 22:20:56');
INSERT INTO `member` VALUES (495, 0, 115, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:20:57', '2019-05-14 22:20:57');
INSERT INTO `member` VALUES (496, 456, 104, '游客', 'bbbbb', 0, '', 0, '2019-05-14 22:21:28', '2019-05-14 22:21:28');
INSERT INTO `member` VALUES (497, 457, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:29:26', '2019-05-14 22:29:26');
INSERT INTO `member` VALUES (498, 457, 116, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:29:33', '2019-05-14 22:29:33');
INSERT INTO `member` VALUES (499, 0, 116, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 22:29:34', '2019-05-14 22:29:34');
INSERT INTO `member` VALUES (500, 457, 104, '游客', 'ssss', 0, '', 0, '2019-05-14 22:30:14', '2019-05-14 22:30:14');
INSERT INTO `member` VALUES (501, 458, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:14:29', '2019-05-14 23:14:29');
INSERT INTO `member` VALUES (502, 458, 117, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:14:33', '2019-05-14 23:14:33');
INSERT INTO `member` VALUES (503, 0, 117, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:14:34', '2019-05-14 23:14:34');
INSERT INTO `member` VALUES (504, 458, 104, '游客', 'qqq', 0, '', 0, '2019-05-14 23:15:57', '2019-05-14 23:15:57');
INSERT INTO `member` VALUES (505, 459, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:28:09', '2019-05-14 23:28:09');
INSERT INTO `member` VALUES (506, 459, 118, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:28:12', '2019-05-14 23:28:12');
INSERT INTO `member` VALUES (507, 0, 118, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:28:13', '2019-05-14 23:28:13');
INSERT INTO `member` VALUES (508, 459, 104, '游客', 'wwww', 0, '', 0, '2019-05-14 23:29:24', '2019-05-14 23:29:24');
INSERT INTO `member` VALUES (509, 460, 0, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:34:32', '2019-05-14 23:34:32');
INSERT INTO `member` VALUES (510, 460, 119, '游客', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:34:36', '2019-05-14 23:34:36');
INSERT INTO `member` VALUES (511, 0, 119, '系统账号', '大家好，我是本群的新成员', 0, '', 0, '2019-05-14 23:34:36', '2019-05-14 23:34:36');
INSERT INTO `member` VALUES (512, 460, 104, '游客', 'hhh', 0, '', 0, '2019-05-14 23:36:39', '2019-05-14 23:36:39');

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
) ENGINE = InnoDB AUTO_INCREMENT = 661 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (260, 210, 0, '巧了', 'user', '2019-05-10 11:50:21.225000', 0, '2019-05-10 11:50:22', '2019-05-10 11:50:22');
INSERT INTO `message` VALUES (261, 210, 0, '我也是游客', 'user', '2019-05-10 11:50:25.860000', 0, '2019-05-10 11:50:28', '2019-05-10 11:50:28');
INSERT INTO `message` VALUES (560, 430, 0, '群里有人吗', 'user', '2019-05-13 23:20:37.185000', 0, '2019-05-13 23:20:37', '2019-05-13 23:20:37');
INSERT INTO `message` VALUES (561, 430, 0, '在吗', 'user', '2019-05-13 23:20:43.677000', 0, '2019-05-13 23:20:44', '2019-05-13 23:20:44');
INSERT INTO `message` VALUES (566, 430, 0, '有吗', 'user', '2019-05-13 23:22:49.037000', 0, '2019-05-13 23:22:49', '2019-05-13 23:22:49');
INSERT INTO `message` VALUES (567, 0, 99, '在吗', 'user', '2019-05-13 23:23:28.133000', 0, '2019-05-13 23:23:27', '2019-05-13 23:23:27');
INSERT INTO `message` VALUES (576, 0, 99, '在吗', 'user', '2019-05-13 23:40:11.046000', 0, '2019-05-13 23:40:11', '2019-05-13 23:40:11');
INSERT INTO `message` VALUES (577, 210, 0, '[文件：打开CMD命令行.bat]', 'user', '2019-05-14 11:54:12.343000', 0, '2019-05-14 11:54:12', '2019-05-14 11:54:12');
INSERT INTO `message` VALUES (578, 210, 0, '[文件：打开CMD命令行.bat]', 'user', '2019-05-14 11:55:10.955000', 0, '2019-05-14 11:55:11', '2019-05-14 11:55:11');
INSERT INTO `message` VALUES (579, 210, 0, '文件', 'user', '2019-05-14 11:55:42.719000', 0, '2019-05-14 11:55:43', '2019-05-14 11:55:43');
INSERT INTO `message` VALUES (580, 210, 0, '文件', 'user', '2019-05-14 11:55:46.119000', 0, '2019-05-14 11:55:46', '2019-05-14 11:55:46');
INSERT INTO `message` VALUES (581, 210, 0, '文件', 'user', '2019-05-14 11:56:11.049000', 0, '2019-05-14 11:56:10', '2019-05-14 11:56:10');
INSERT INTO `message` VALUES (582, 210, 0, 'll', 'user', '2019-05-14 11:57:39.855000', 0, '2019-05-14 11:57:39', '2019-05-14 11:57:39');
INSERT INTO `message` VALUES (583, 210, 0, '下载vue的LOGO', 'user', '2019-05-14 11:58:29.665000', 0, '2019-05-14 11:58:29', '2019-05-14 11:58:29');
INSERT INTO `message` VALUES (584, 210, 0, '<a href=\"https://vuejs.org/images/logo.png\" download=\"2017.png\">下载 vue 的 LOGO</a>', 'user', '2019-05-14 12:38:45.272000', 0, '2019-05-14 12:38:44', '2019-05-14 12:38:44');
INSERT INTO `message` VALUES (585, 210, 0, '    <img id=\"background\" src=\"${pageContext.request.contextPath}/upload/photo/${login.chatBackground}\"\n         style=\"position: absolute;height: 100%;width: 100%\">', 'user', '2019-05-14 12:39:26.054000', 0, '2019-05-14 12:39:25', '2019-05-14 12:39:25');
INSERT INTO `message` VALUES (586, 210, 0, '<img src=\"/wechat/upload/photo/16c80bc4e99040d88f2ff9c5efe83da5.png\" class=\"menu-head-img\" onclick=\"showWindowOnRight(\'user-info-box\')\">', 'user', '2019-05-14 12:40:07.484000', 0, '2019-05-14 12:40:06', '2019-05-14 12:40:06');
INSERT INTO `message` VALUES (587, 210, 0, '<img src=\"/wechat/upload/photo/16c80bc4e99040d88f2ff9c5efe83da5.png\" class=\"menu-head-img\" onclick=\"showWindowOnRight(\'user-info-box\')\">', 'user', '2019-05-14 12:40:23.911000', 0, '2019-05-14 12:40:23', '2019-05-14 12:40:23');
INSERT INTO `message` VALUES (588, 210, 0, '<img style=\"height=1000px;\" src=\"/wechat/upload/photo/16c80bc4e99040d88f2ff9c5efe83da5.png\" class=\"menu-head-img\" onclick=\"showWindowOnRight(\'user-info-box\')\">', 'user', '2019-05-14 12:40:49.630000', 0, '2019-05-14 12:40:48', '2019-05-14 12:40:48');
INSERT INTO `message` VALUES (589, 210, 0, '<img style=\"height:1000px;\" src=\"/wechat/upload/photo/16c80bc4e99040d88f2ff9c5efe83da5.png\" class=\"menu-head-img\" onclick=\"showWindowOnRight(\'user-info-box\')\">', 'user', '2019-05-14 12:44:08.613000', 0, '2019-05-14 12:44:07', '2019-05-14 12:44:07');
INSERT INTO `message` VALUES (590, 210, 0, '<img style=\"height:1000px;width:1000px;\" src=\"/wechat/upload/photo/16c80bc4e99040d88f2ff9c5efe83da5.png\" class=\"menu-head-img\" onclick=\"showWindowOnRight(\'user-info-box\')\">', 'user', '2019-05-14 12:44:31.080000', 0, '2019-05-14 12:44:30', '2019-05-14 12:44:30');
INSERT INTO `message` VALUES (591, 210, 0, '[文件：打开CMD命令行.bat]', 'user', '2019-05-14 13:05:04.753000', 0, '2019-05-14 13:05:04', '2019-05-14 13:05:04');
INSERT INTO `message` VALUES (592, 210, 0, '[文件：打开CMD命令行.bat]', 'user', '2019-05-14 13:21:54.413000', 0, '2019-05-14 13:21:53', '2019-05-14 13:21:53');
INSERT INTO `message` VALUES (593, 210, 0, 'fd', 'user', '2019-05-14 13:23:22.598000', 0, '2019-05-14 13:23:21', '2019-05-14 13:23:21');
INSERT INTO `message` VALUES (594, 210, 0, '[文件：打开CMD命令行.bat]\n', 'user', '2019-05-14 13:25:44.140000', 0, '2019-05-14 13:25:43', '2019-05-14 13:25:43');
INSERT INTO `message` VALUES (595, 210, 0, '[文件：打开CMD命令行.bat]\n', 'user', '2019-05-14 13:36:09.381000', 0, '2019-05-14 13:36:08', '2019-05-14 13:36:08');
INSERT INTO `message` VALUES (596, 210, 0, '<a href=\"https://localhost:8080/wechat/upload/file/undefined\" download=\"recovery-twrp一键刷入工具.bat\">下载</a>', 'file', '2019-05-14 13:39:12.616000', 0, '2019-05-14 13:39:11', '2019-05-14 13:39:11');
INSERT INTO `message` VALUES (597, 210, 0, '<a href=\"https://localhost:8080/wechat/upload/file/undefined\" download=\"打开CMD命令行.bat\">下载</a>', 'file', '2019-05-14 13:41:34.464000', 0, '2019-05-14 13:41:33', '2019-05-14 13:41:33');
INSERT INTO `message` VALUES (598, 210, 0, '<a href=\"https://localhost:8080/wechat/upload/file/undefined\" download=\"recovery-twrp一键刷入工具.bat\">下载</a>', 'file', '2019-05-14 13:42:43.874000', 0, '2019-05-14 13:42:42', '2019-05-14 13:42:42');
INSERT INTO `message` VALUES (599, 210, 0, '[文件：recovery-twrp一键刷入工具.bat]', 'user', '2019-05-14 13:47:07.665000', 0, '2019-05-14 13:47:07', '2019-05-14 13:47:07');
INSERT INTO `message` VALUES (600, 210, 0, '<a href=\"https://localhost:8080/wechat/upload/file/8c5461e4073248b4b21f1601df89675d.bat\" download=\"recovery-twrp一键刷入工具.bat\">下载</a>', 'file', '2019-05-14 13:48:31.826000', 0, '2019-05-14 13:48:31', '2019-05-14 13:48:31');
INSERT INTO `message` VALUES (601, 210, 0, 'aa', 'user', '2019-05-14 13:49:21.209000', 0, '2019-05-14 13:49:20', '2019-05-14 13:49:20');
INSERT INTO `message` VALUES (602, 210, 0, 'a', 'user', '2019-05-14 13:50:17.750000', 0, '2019-05-14 13:50:17', '2019-05-14 13:50:17');
INSERT INTO `message` VALUES (603, 210, 0, 'dd', 'user', '2019-05-14 13:51:53.547000', 0, '2019-05-14 13:51:52', '2019-05-14 13:51:52');
INSERT INTO `message` VALUES (604, 210, 0, '<a href=\"https://localhost:8080/wechat/upload/file/36bdadd69eeb44138a0592a554a8968d.bat\" download=\"recovery-twrp一键刷入工具.bat\">下载</a>', 'file', '2019-05-14 13:52:00.316000', 0, '2019-05-14 13:51:59', '2019-05-14 13:51:59');
INSERT INTO `message` VALUES (605, 210, 0, '[文件：打开CMD命令行.bat]wenjian', 'file', '2019-05-14 13:52:32.207000', 0, '2019-05-14 13:52:31', '2019-05-14 13:52:31');
INSERT INTO `message` VALUES (606, 210, 0, 'a', 'user', '2019-05-14 13:52:37.812000', 0, '2019-05-14 13:52:36', '2019-05-14 13:52:36');
INSERT INTO `message` VALUES (607, 210, 0, '[文件：recovery-twrp一键刷入工具.bat]wenjian', 'file', '2019-05-14 13:53:10.044000', 0, '2019-05-14 13:53:08', '2019-05-14 13:53:08');
INSERT INTO `message` VALUES (608, 210, 0, 'sdasfasd[文件：打开CMD命令行.bat]wenjian', 'file', '2019-05-14 13:53:34.839000', 0, '2019-05-14 13:53:33', '2019-05-14 13:53:33');
INSERT INTO `message` VALUES (609, 210, 0, 'fsa[文件：recovery-twrp一键刷入工具.bat]wenjian', 'file', '2019-05-14 13:54:22.597000', 0, '2019-05-14 13:54:21', '2019-05-14 13:54:21');
INSERT INTO `message` VALUES (610, 210, 0, 'zz[文件：打开CMD命令行.bat]wenjian', 'user', '2019-05-14 13:55:27.405000', 0, '2019-05-14 13:55:26', '2019-05-14 13:55:26');
INSERT INTO `message` VALUES (611, 210, 0, '[文件：打开CMD命令行.bat]<a href=\"https://localhost:8080/wechat/upload/file/13bc9964678243f08205b826e7f4742d.bat\" download=\"打开CMD命令行.bat\">下载</a>', 'user', '2019-05-14 13:57:18.630000', 0, '2019-05-14 13:57:17', '2019-05-14 13:57:17');
INSERT INTO `message` VALUES (612, 210, 0, '[文件：打开CMD命令行.bat]<a href=\"https://localhost:8080/wechat/upload/file/e3048f195fbf4e3f9fc7f858a020f76a.bat\" download=\"打开CMD命令行.bat\">下载</a>', 'user', '2019-05-14 13:58:44.370000', 0, '2019-05-14 13:58:43', '2019-05-14 13:58:43');
INSERT INTO `message` VALUES (613, 210, 0, '[文件：AdbWinApi.dll]<a href=\"https://localhost:8080/wechat/upload/file/0e7868d3d40c40508df3e0607c204856.dll\" download=\"AdbWinApi.dll\">下载</a>', 'user', '2019-05-14 13:59:00.179000', 0, '2019-05-14 13:58:59', '2019-05-14 13:58:59');
INSERT INTO `message` VALUES (614, 210, 0, '[文件：AdbWinApi.dll]<a href=\"https://localhost:8080/wechat//wechat/upload/file/4bf537db69844db78f6eda602b84d5ea.dll\" download=\"AdbWinApi.dll\">下载</a>', 'user', '2019-05-14 13:59:49.743000', 0, '2019-05-14 13:59:49', '2019-05-14 13:59:49');
INSERT INTO `message` VALUES (615, 210, 0, '[文件：misc.bin]<a href=\"https://localhost:8080/wechat/wechat/upload/file/79a9e4d25e284b82809c546f1a681d8e.bin\" download=\"misc.bin\">下载</a>', 'user', '2019-05-14 14:00:25.222000', 0, '2019-05-14 14:00:24', '2019-05-14 14:00:24');
INSERT INTO `message` VALUES (616, 210, 0, '[文件：recovery-twrp一键刷入工具.bat]<a href=\"http://localhost:8080/wechat/wechat/upload/file/cd732c53e8b743f1a632a27db15369eb.bat\" download=\"recovery-twrp一键刷入工具.bat\">下载</a>', 'user', '2019-05-14 14:01:26.153000', 0, '2019-05-14 14:01:25', '2019-05-14 14:01:25');
INSERT INTO `message` VALUES (617, 210, 0, '[文件：fastboot.exe]<a href=\"http://localhost:8080/wechat/wechat/upload/file/3812c376b6c94aaca66724c6a66528a6.exe\" download=\"fastboot.exe\">下载</a>', 'file', '2019-05-14 14:07:01.995000', 0, '2019-05-14 14:07:01', '2019-05-14 14:07:01');
INSERT INTO `message` VALUES (618, 210, 0, '[文件：打开CMD命令行.bat]<ahref=http://localhost:8080/wechat/wechat/upload/file/6ae5c049f2dc4780841977c8014efd88.batdownload=打开CMD命令行.bat>下载</a>', 'file', '2019-05-14 14:40:40.707000', 0, '2019-05-14 14:40:40', '2019-05-14 14:40:40');
INSERT INTO `message` VALUES (619, 210, 0, '[文件：打开CMD命令行.bat]<ahref=http://localhost:8080/wechat/wechat/upload/file/41298be0547d414cb557155efafab4d7.batdownload=打开CMD命令行.bat>下载</a>', 'file', '2019-05-14 14:41:59.459000', 0, '2019-05-14 14:41:59', '2019-05-14 14:41:59');
INSERT INTO `message` VALUES (620, 210, 0, '<ahref=http://localhost:8080/wechat/wechat/upload/file/6c385f1b1b934fd5a357b747589ddde3.batdownload=打开CMD命令行.bat>下载</a>', 'file', '2019-05-14 14:42:58.739000', 0, '2019-05-14 14:42:58', '2019-05-14 14:42:58');
INSERT INTO `message` VALUES (621, 210, 0, '[文件：打开CMD命令行.bat]<ahref=\"http://localhost:8080/wechat/wechat/upload/file/1ec58a36986248ad8f0f651c6d543bdc.bat\"download=\"打开CMD命令行.bat\">下载</a>', 'file', '2019-05-14 14:43:53.797000', 0, '2019-05-14 14:43:53', '2019-05-14 14:43:53');
INSERT INTO `message` VALUES (622, 210, 0, '[文件：打开CMD命令行.bat]<a href=\"http://localhost:8080/wechat/wechat/upload/file/d48f37b40b834569841240923275dad6.bat\" download=\"打开CMD命令行.bat\">下载</a>', 'file', '2019-05-14 14:45:02.879000', 0, '2019-05-14 14:45:02', '2019-05-14 14:45:02');
INSERT INTO `message` VALUES (623, 210, 0, '[文件：recovery-twrp一键刷入工具.bat]<a href=\"http://localhost:8080/wechat/wechat/upload/file/3089670add894d9588092d074a41bc52.bat\" download=\"recovery-twrp一键刷入工具.bat\">下载</a>', 'file', '2019-05-14 14:47:48.647000', 0, '2019-05-14 14:47:48', '2019-05-14 14:47:48');
INSERT INTO `message` VALUES (624, 210, 0, '[文件：无标题.png]<a href=\"http://localhost:8080/wechat/wechat/upload/file/e5e421d99c3047d889bfceda73b59ebb.png\" download=\"无标题.png\">下载</a>', 'file', '2019-05-14 15:18:17.926000', 0, '2019-05-14 15:18:17', '2019-05-14 15:18:17');
INSERT INTO `message` VALUES (625, 210, 0, '[文件：无标题.png]<img src=\"/wechat/upload/photo/cb78151bba9142c5a67f87badaeef9d6.jpg\"\n         style=\"position: absolute;height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'file', '2019-05-14 15:19:27.283000', 0, '2019-05-14 15:19:27', '2019-05-14 15:19:27');
INSERT INTO `message` VALUES (626, 210, 0, '<img src=\"/wechat/upload/photo/cb78151bba9142c5a67f87badaeef9d6.jpg\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'file', '2019-05-14 15:21:06.394000', 0, '2019-05-14 15:21:06', '2019-05-14 15:21:06');
INSERT INTO `message` VALUES (627, 210, 0, '<img src=\"/wechat/upload/file/cb78151bba9142c5a67f87badaeef9d6.jpg\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'file', '2019-05-14 15:21:58.933000', 0, '2019-05-14 15:21:58', '2019-05-14 15:21:58');
INSERT INTO `message` VALUES (628, 210, 0, '[文件：无标题.png]<a href=\"http://localhost:8080/wechat/wechat/upload/file/5c764333c4174cc1a9dcaff8728c17ed.png\" download=\"无标题.png\">下载</a>', 'file', '2019-05-14 15:23:27.292000', 0, '2019-05-14 15:23:26', '2019-05-14 15:23:26');
INSERT INTO `message` VALUES (629, 210, 0, '<img src=\"http://localhost:8080/wechat/wechat/upload/file/8c45069927524dbb8ffeb4318e57b21e.png\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'file', '2019-05-14 15:28:09.270000', 0, '2019-05-14 15:28:09', '2019-05-14 15:28:09');
INSERT INTO `message` VALUES (630, 210, 0, '<img src=\"/wechat/upload/file/be589c0773cb4e46bbb224650cd3b3aa.png\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'file', '2019-05-14 15:29:33.698000', 0, '2019-05-14 15:29:33', '2019-05-14 15:29:33');
INSERT INTO `message` VALUES (631, 210, 0, '[文件：无标题.png]<a href=\"http://localhost:8080/wechat/wechat/upload/file/5b78b26f07a543a8bff246cde9cf1389.png\" download=\"无标题.png\">下载</a>', 'file', '2019-05-14 15:33:18.773000', 0, '2019-05-14 15:33:19', '2019-05-14 15:33:19');
INSERT INTO `message` VALUES (632, 210, 0, '[文件：3.C推荐书籍及C之歌.doc]<a href=\"http://localhost:8080/wechat/wechat/upload/file/66fcb570c5eb486189d4ec48b273e721.doc\" download=\"3.C推荐书籍及C之歌.doc\">下载</a>', 'file', '2019-05-14 15:34:04.506000', 0, '2019-05-14 15:34:04', '2019-05-14 15:34:04');
INSERT INTO `message` VALUES (633, 210, 0, '<img src=\"/wechat/upload/file/0463cc6bd8514fa0b287bff2c02618e5.jpg\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'file', '2019-05-14 15:34:40.165000', 0, '2019-05-14 15:34:40', '2019-05-14 15:34:40');
INSERT INTO `message` VALUES (634, 210, 0, '<img src=\"/wechat/upload/file/ea794129daf14038ac8b536c8863e45d.png\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'file', '2019-05-14 15:38:22.394000', 0, '2019-05-14 15:38:22', '2019-05-14 15:38:22');
INSERT INTO `message` VALUES (635, 210, 0, '<img src=\"/wechat/upload/file/2317312c890a44809abc987b222e2c74.png\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'img', '2019-05-14 15:39:01.552000', 0, '2019-05-14 15:39:01', '2019-05-14 15:39:01');
INSERT INTO `message` VALUES (636, 210, 0, '<img src=\"/wechat/upload/file/85757b11d4c043b08adcf7998d460b91.jpg\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'img', '2019-05-14 15:39:09.783000', 0, '2019-05-14 15:39:09', '2019-05-14 15:39:09');
INSERT INTO `message` VALUES (637, 210, 0, '<img src=\"/wechat/upload/file/5a63a4ea41e844ea8c98ade0a71c204d.png\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'img', '2019-05-14 15:45:03.954000', 0, '2019-05-14 15:45:03', '2019-05-14 15:45:03');
INSERT INTO `message` VALUES (638, 210, 0, '<img src=\"/wechat/upload/file/6d160d2a8a6148898c156841c122003e.jpg\"\n         style=\"height: 100%;width: 100%;max-height:200px;max-width:200px;\">\n', 'img', '2019-05-14 15:45:18.622000', 0, '2019-05-14 15:45:18', '2019-05-14 15:45:18');
INSERT INTO `message` VALUES (639, 433, 0, '[文件：fastboot.exe]<a href=\"http://localhost:8080/wechat/wechat/upload/file/2ce3e2fe944a4e4d90f7ed9294d67824.exe\" download=\"fastboot.exe\">下载</a>', 'file', '2019-05-14 15:45:31.972000', 0, '2019-05-14 15:45:32', '2019-05-14 15:45:32');
INSERT INTO `message` VALUES (640, 445, 104, '', 'user', '2019-05-14 17:14:31.921000', 0, '2019-05-14 17:14:31', '2019-05-14 17:14:31');
INSERT INTO `message` VALUES (641, 446, 104, '', 'user', '2019-05-14 17:27:33.085000', 0, '2019-05-14 17:27:31', '2019-05-14 17:27:31');
INSERT INTO `message` VALUES (642, 447, 104, '', 'user', '2019-05-14 17:59:54.972000', 0, '2019-05-14 17:59:53', '2019-05-14 17:59:53');
INSERT INTO `message` VALUES (643, 448, 104, '', 'user', '2019-05-14 20:36:38.388000', 0, '2019-05-14 20:37:11', '2019-05-14 20:37:11');
INSERT INTO `message` VALUES (644, 449, 104, '', 'user', '2019-05-14 21:08:40.789000', 0, '2019-05-14 21:08:39', '2019-05-14 21:08:39');
INSERT INTO `message` VALUES (645, 449, 104, '', 'user', '2019-05-14 21:10:31.309000', 0, '2019-05-14 21:14:17', '2019-05-14 21:14:17');
INSERT INTO `message` VALUES (646, 450, 104, '大家好', 'user', '2019-05-14 21:16:16.674000', 0, '2019-05-14 21:16:20', '2019-05-14 21:16:20');
INSERT INTO `message` VALUES (647, 452, 104, 'aaa', 'user', '2019-05-14 21:50:35.041000', 0, '2019-05-14 21:50:36', '2019-05-14 21:50:36');
INSERT INTO `message` VALUES (648, 210, 104, 'jj', 'user', '2019-05-14 21:53:08.283000', 0, '2019-05-14 21:53:07', '2019-05-14 21:53:07');
INSERT INTO `message` VALUES (649, 210, 104, 'kk', 'user', '2019-05-14 21:53:14.179000', 0, '2019-05-14 21:53:14', '2019-05-14 21:53:14');
INSERT INTO `message` VALUES (650, 210, 104, 'kk', 'user', '2019-05-14 21:53:15.809000', 0, '2019-05-14 21:53:14', '2019-05-14 21:53:14');
INSERT INTO `message` VALUES (651, 210, 104, 'kk', 'user', '2019-05-14 21:53:16.800000', 0, '2019-05-14 21:53:15', '2019-05-14 21:53:15');
INSERT INTO `message` VALUES (652, 210, 104, 'kk', 'user', '2019-05-14 21:53:17.698000', 0, '2019-05-14 21:53:16', '2019-05-14 21:53:16');
INSERT INTO `message` VALUES (653, 210, 104, 'll', 'user', '2019-05-14 21:53:27.208000', 0, '2019-05-14 21:53:26', '2019-05-14 21:53:26');
INSERT INTO `message` VALUES (654, 454, 104, 'aaa', 'user', '2019-05-14 22:08:16.667000', 0, '2019-05-14 22:08:15', '2019-05-14 22:08:15');
INSERT INTO `message` VALUES (655, 455, 104, 'aaaaaa', 'user', '2019-05-14 22:12:20.821000', 0, '2019-05-14 22:12:19', '2019-05-14 22:12:19');
INSERT INTO `message` VALUES (656, 456, 104, 'bbbbb', 'user', '2019-05-14 22:21:29.525000', 0, '2019-05-14 22:21:28', '2019-05-14 22:21:28');
INSERT INTO `message` VALUES (657, 457, 104, 'ssss', 'user', '2019-05-14 22:30:15.636000', 0, '2019-05-14 22:30:14', '2019-05-14 22:30:14');
INSERT INTO `message` VALUES (658, 458, 104, 'qqq', 'user', '2019-05-14 23:15:58.794000', 0, '2019-05-14 23:15:58', '2019-05-14 23:15:58');
INSERT INTO `message` VALUES (659, 459, 104, 'wwww', 'user', '2019-05-14 23:29:25.389000', 0, '2019-05-14 23:29:24', '2019-05-14 23:29:24');
INSERT INTO `message` VALUES (660, 460, 104, 'hhh', 'user', '2019-05-14 23:36:40.589000', 0, '2019-05-14 23:36:39', '2019-05-14 23:36:39');

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of moment
-- ----------------------------
INSERT INTO `moment` VALUES (88, 0, 'com.hyc.wechat.dao.impl.DataSourceImpl.getConnection(DataSourceImpl.java:155)]连接池已创建连接数3空闲连接数2[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/upload.jpg[请求参数]：null[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/user.photo[请求参数]：null[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/[请求参数]：nullcom.mysql.cj.jdbc.ClientPreparedStatement:selectm.id,m.sender_id,m.chat_id,m.content,m.type,m.time,m.status,m.gmt_create,m.gmt_modifiedfrommessageasm,recordasrwherem.id=r.message_idandr.user_id=\'209\'andr.status=0orderbym.timed', '03530a39ca574e8882bf77a72b2d0bb4.png', '2019-05-09 15:56:55', 1, 1, 0, 0, 0, 0, '2019-05-09 15:56:55', '2019-05-09 15:56:59');
INSERT INTO `moment` VALUES (92, 0, 'com.hyc.wechat.dao.impl.DataSourceImpl.getConnection(DataSourceImpl.java:155)]连接池已创建连接数3空闲连接数2[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/upload.jpg[请求参数]：null[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/user.photo[请求参数]：null[INFO]-[com.hyc.wechat.controller.impl.filter.EncodingFilter.doFilter(EncodingFilter.java:77)][请求url]:/upload/photo/[请求参数]：nullcom.mysql.cj.jdbc.ClientPreparedStatement:selectm.id,m.sender_id,m.chat_id,m.content,m.type,m.time,m.status,m.gmt_create,m.gmt_modifiedfrommessageasm,recordasrwherem.id=r.message_idandr.user_id=\'209\'andr.status=0orderbym.timed', '6d200fc9151943f6a04f7f3406c7fd57.jpg', '2019-05-09 23:52:24', 10, 0, 0, 0, 0, 0, '2019-05-09 23:52:24', '2019-05-14 00:53:15');
INSERT INTO `moment` VALUES (94, 0, '哈哈哈', 'moment.jpg', '2019-05-10 01:15:54', 0, 0, 0, 0, 0, 0, '2019-05-10 01:15:54', '2019-05-10 01:15:55');
INSERT INTO `moment` VALUES (95, 0, '哈哈', 'moment.jpg', '2019-05-10 01:16:24', 1, 0, 0, 0, 0, 0, '2019-05-10 01:16:24', '2019-05-10 01:16:25');
INSERT INTO `moment` VALUES (96, 0, '我要发朋友圈了', '1edbd7cf72a84790b6b9a9a28db33f13.jpg', '2019-05-10 07:15:44', 0, 0, 0, 0, 0, 0, '2019-05-10 07:15:44', '2019-05-10 07:15:46');
INSERT INTO `moment` VALUES (97, 0, '一条朋友圈', '', '2019-05-13 18:38:39', 10, 0, 0, 0, 0, 0, '2019-05-13 18:38:39', '2019-05-13 18:38:39');
INSERT INTO `moment` VALUES (98, 0, '一条朋友圈', '', '2019-05-13 18:39:03', 10, 0, 0, 0, 0, 0, '2019-05-13 18:39:03', '2019-05-13 18:39:03');
INSERT INTO `moment` VALUES (99, 425, 'test2的朋友圈', '50cf62f9b9ae4bd89cc342ca50b6ec80.jpg', '2019-05-13 21:36:13', 1, 10, 0, 0, 0, 0, '2019-05-13 21:36:13', '2019-05-13 21:36:16');

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
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (87, 0, 88, 1, 0, 0, 0, 0, '2019-05-09 15:56:57', '2019-05-09 15:56:57');
INSERT INTO `news` VALUES (88, 210, 92, 0, 0, 0, 0, 0, '2019-05-09 23:52:24', '2019-05-09 23:52:24');
INSERT INTO `news` VALUES (89, 0, 92, 0, 0, 0, 0, 0, '2019-05-09 23:52:25', '2019-05-09 23:52:25');
INSERT INTO `news` VALUES (91, 210, 94, 0, 0, 0, 0, 0, '2019-05-10 01:15:55', '2019-05-10 01:15:55');
INSERT INTO `news` VALUES (92, 0, 94, 0, 0, 0, 0, 0, '2019-05-10 01:15:55', '2019-05-10 01:15:55');
INSERT INTO `news` VALUES (93, 210, 95, 1, 0, 0, 0, 0, '2019-05-10 01:16:25', '2019-05-10 01:16:25');
INSERT INTO `news` VALUES (94, 0, 95, 0, 0, 0, 0, 0, '2019-05-10 01:16:25', '2019-05-10 01:16:25');
INSERT INTO `news` VALUES (95, 210, 96, 0, 0, 0, 0, 0, '2019-05-10 07:15:45', '2019-05-10 07:15:45');
INSERT INTO `news` VALUES (96, 0, 96, 0, 0, 0, 0, 0, '2019-05-10 07:15:45', '2019-05-10 07:15:45');
INSERT INTO `news` VALUES (97, 0, 99, 0, 0, 0, 0, 0, '2019-05-13 21:36:14', '2019-05-13 21:36:14');
INSERT INTO `news` VALUES (98, 210, 99, 1, 0, 0, 0, 0, '2019-05-13 21:36:14', '2019-05-13 21:36:14');
INSERT INTO `news` VALUES (99, 425, 99, 0, 0, 0, 0, 0, '2019-05-13 21:36:14', '2019-05-13 21:36:14');

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
) ENGINE = InnoDB AUTO_INCREMENT = 16590 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (16126, 0, 560, 1, '2019-05-13 23:20:37', '2019-05-13 23:21:06');
INSERT INTO `record` VALUES (16127, 210, 560, 1, '2019-05-13 23:20:37', '2019-05-14 02:38:53');
INSERT INTO `record` VALUES (16128, 422, 560, 0, '2019-05-13 23:20:38', '2019-05-13 23:20:38');
INSERT INTO `record` VALUES (16129, 425, 560, 0, '2019-05-13 23:20:38', '2019-05-13 23:20:38');
INSERT INTO `record` VALUES (16130, 430, 560, 1, '2019-05-13 23:20:38', '2019-05-13 23:21:18');
INSERT INTO `record` VALUES (16131, 0, 561, 1, '2019-05-13 23:20:44', '2019-05-13 23:21:06');
INSERT INTO `record` VALUES (16132, 210, 561, 1, '2019-05-13 23:20:44', '2019-05-14 02:38:53');
INSERT INTO `record` VALUES (16133, 422, 561, 0, '2019-05-13 23:20:45', '2019-05-13 23:20:45');
INSERT INTO `record` VALUES (16134, 425, 561, 0, '2019-05-13 23:20:45', '2019-05-13 23:20:45');
INSERT INTO `record` VALUES (16135, 430, 561, 1, '2019-05-13 23:20:45', '2019-05-13 23:21:18');
INSERT INTO `record` VALUES (16156, 0, 566, 1, '2019-05-13 23:22:49', '2019-05-13 23:23:36');
INSERT INTO `record` VALUES (16157, 210, 566, 1, '2019-05-13 23:22:50', '2019-05-14 02:38:53');
INSERT INTO `record` VALUES (16158, 422, 566, 0, '2019-05-13 23:22:50', '2019-05-13 23:22:50');
INSERT INTO `record` VALUES (16159, 425, 566, 0, '2019-05-13 23:22:50', '2019-05-13 23:22:50');
INSERT INTO `record` VALUES (16160, 430, 566, 1, '2019-05-13 23:22:51', '2019-05-13 23:32:03');
INSERT INTO `record` VALUES (16161, 430, 567, 1, '2019-05-13 23:23:28', '2019-05-13 23:23:31');
INSERT INTO `record` VALUES (16162, 0, 567, 1, '2019-05-13 23:23:28', '2019-05-13 23:40:04');
INSERT INTO `record` VALUES (16203, 430, 576, 0, '2019-05-13 23:40:12', '2019-05-13 23:40:12');
INSERT INTO `record` VALUES (16204, 0, 576, 0, '2019-05-13 23:40:12', '2019-05-13 23:40:12');
INSERT INTO `record` VALUES (16205, 0, 577, 0, '2019-05-14 11:54:12', '2019-05-14 11:54:12');
INSERT INTO `record` VALUES (16206, 210, 577, 1, '2019-05-14 11:54:13', '2019-05-14 11:54:59');
INSERT INTO `record` VALUES (16207, 422, 577, 0, '2019-05-14 11:54:13', '2019-05-14 11:54:13');
INSERT INTO `record` VALUES (16208, 425, 577, 0, '2019-05-14 11:54:13', '2019-05-14 11:54:13');
INSERT INTO `record` VALUES (16209, 430, 577, 0, '2019-05-14 11:54:14', '2019-05-14 11:54:14');
INSERT INTO `record` VALUES (16210, 0, 578, 0, '2019-05-14 11:55:12', '2019-05-14 11:55:12');
INSERT INTO `record` VALUES (16211, 210, 578, 1, '2019-05-14 11:55:12', '2019-05-14 12:38:40');
INSERT INTO `record` VALUES (16212, 422, 578, 0, '2019-05-14 11:55:13', '2019-05-14 11:55:13');
INSERT INTO `record` VALUES (16213, 425, 578, 0, '2019-05-14 11:55:13', '2019-05-14 11:55:13');
INSERT INTO `record` VALUES (16214, 430, 578, 0, '2019-05-14 11:55:14', '2019-05-14 11:55:14');
INSERT INTO `record` VALUES (16215, 0, 579, 0, '2019-05-14 11:55:44', '2019-05-14 11:55:44');
INSERT INTO `record` VALUES (16216, 210, 579, 1, '2019-05-14 11:55:44', '2019-05-14 12:38:40');
INSERT INTO `record` VALUES (16217, 422, 579, 0, '2019-05-14 11:55:44', '2019-05-14 11:55:44');
INSERT INTO `record` VALUES (16218, 425, 579, 0, '2019-05-14 11:55:45', '2019-05-14 11:55:45');
INSERT INTO `record` VALUES (16219, 430, 579, 0, '2019-05-14 11:55:45', '2019-05-14 11:55:45');
INSERT INTO `record` VALUES (16220, 0, 580, 0, '2019-05-14 11:55:46', '2019-05-14 11:55:46');
INSERT INTO `record` VALUES (16221, 210, 580, 1, '2019-05-14 11:55:47', '2019-05-14 12:38:40');
INSERT INTO `record` VALUES (16222, 422, 580, 0, '2019-05-14 11:55:47', '2019-05-14 11:55:47');
INSERT INTO `record` VALUES (16223, 425, 580, 0, '2019-05-14 11:55:47', '2019-05-14 11:55:47');
INSERT INTO `record` VALUES (16224, 430, 580, 0, '2019-05-14 11:55:48', '2019-05-14 11:55:48');
INSERT INTO `record` VALUES (16225, 0, 581, 0, '2019-05-14 11:56:11', '2019-05-14 11:56:11');
INSERT INTO `record` VALUES (16226, 210, 581, 1, '2019-05-14 11:56:11', '2019-05-14 12:38:40');
INSERT INTO `record` VALUES (16227, 422, 581, 0, '2019-05-14 11:56:11', '2019-05-14 11:56:11');
INSERT INTO `record` VALUES (16228, 425, 581, 0, '2019-05-14 11:56:12', '2019-05-14 11:56:12');
INSERT INTO `record` VALUES (16229, 430, 581, 0, '2019-05-14 11:56:12', '2019-05-14 11:56:12');
INSERT INTO `record` VALUES (16230, 0, 582, 0, '2019-05-14 11:57:40', '2019-05-14 11:57:40');
INSERT INTO `record` VALUES (16231, 210, 582, 1, '2019-05-14 11:57:40', '2019-05-14 12:38:40');
INSERT INTO `record` VALUES (16232, 422, 582, 0, '2019-05-14 11:57:41', '2019-05-14 11:57:41');
INSERT INTO `record` VALUES (16233, 425, 582, 0, '2019-05-14 11:57:41', '2019-05-14 11:57:41');
INSERT INTO `record` VALUES (16234, 430, 582, 0, '2019-05-14 11:57:41', '2019-05-14 11:57:41');
INSERT INTO `record` VALUES (16235, 0, 583, 0, '2019-05-14 11:58:31', '2019-05-14 11:58:31');
INSERT INTO `record` VALUES (16236, 210, 583, 1, '2019-05-14 11:58:31', '2019-05-14 12:38:40');
INSERT INTO `record` VALUES (16237, 422, 583, 0, '2019-05-14 11:58:32', '2019-05-14 11:58:32');
INSERT INTO `record` VALUES (16238, 425, 583, 0, '2019-05-14 11:58:33', '2019-05-14 11:58:33');
INSERT INTO `record` VALUES (16239, 430, 583, 0, '2019-05-14 11:58:33', '2019-05-14 11:58:33');
INSERT INTO `record` VALUES (16240, 0, 584, 0, '2019-05-14 12:38:44', '2019-05-14 12:38:44');
INSERT INTO `record` VALUES (16241, 210, 584, 1, '2019-05-14 12:38:45', '2019-05-14 12:38:53');
INSERT INTO `record` VALUES (16242, 422, 584, 0, '2019-05-14 12:38:45', '2019-05-14 12:38:45');
INSERT INTO `record` VALUES (16243, 425, 584, 0, '2019-05-14 12:38:45', '2019-05-14 12:38:45');
INSERT INTO `record` VALUES (16244, 430, 584, 0, '2019-05-14 12:38:45', '2019-05-14 12:38:45');
INSERT INTO `record` VALUES (16245, 0, 585, 0, '2019-05-14 12:39:26', '2019-05-14 12:39:26');
INSERT INTO `record` VALUES (16246, 210, 585, 1, '2019-05-14 12:39:26', '2019-05-14 12:40:16');
INSERT INTO `record` VALUES (16247, 422, 585, 0, '2019-05-14 12:39:26', '2019-05-14 12:39:26');
INSERT INTO `record` VALUES (16248, 425, 585, 0, '2019-05-14 12:39:26', '2019-05-14 12:39:26');
INSERT INTO `record` VALUES (16249, 430, 585, 0, '2019-05-14 12:39:26', '2019-05-14 12:39:26');
INSERT INTO `record` VALUES (16250, 0, 586, 0, '2019-05-14 12:40:07', '2019-05-14 12:40:07');
INSERT INTO `record` VALUES (16251, 210, 586, 1, '2019-05-14 12:40:07', '2019-05-14 12:40:16');
INSERT INTO `record` VALUES (16252, 422, 586, 0, '2019-05-14 12:40:07', '2019-05-14 12:40:07');
INSERT INTO `record` VALUES (16253, 425, 586, 0, '2019-05-14 12:40:07', '2019-05-14 12:40:07');
INSERT INTO `record` VALUES (16254, 430, 586, 0, '2019-05-14 12:40:07', '2019-05-14 12:40:07');
INSERT INTO `record` VALUES (16255, 0, 587, 0, '2019-05-14 12:40:24', '2019-05-14 12:40:24');
INSERT INTO `record` VALUES (16256, 210, 587, 1, '2019-05-14 12:40:24', '2019-05-14 12:51:46');
INSERT INTO `record` VALUES (16257, 422, 587, 0, '2019-05-14 12:40:24', '2019-05-14 12:40:24');
INSERT INTO `record` VALUES (16258, 425, 587, 0, '2019-05-14 12:40:24', '2019-05-14 12:40:24');
INSERT INTO `record` VALUES (16259, 430, 587, 0, '2019-05-14 12:40:24', '2019-05-14 12:40:24');
INSERT INTO `record` VALUES (16260, 0, 588, 0, '2019-05-14 12:40:48', '2019-05-14 12:40:48');
INSERT INTO `record` VALUES (16261, 210, 588, 1, '2019-05-14 12:40:49', '2019-05-14 12:51:46');
INSERT INTO `record` VALUES (16262, 422, 588, 0, '2019-05-14 12:40:49', '2019-05-14 12:40:49');
INSERT INTO `record` VALUES (16263, 425, 588, 0, '2019-05-14 12:40:49', '2019-05-14 12:40:49');
INSERT INTO `record` VALUES (16264, 430, 588, 0, '2019-05-14 12:40:49', '2019-05-14 12:40:49');
INSERT INTO `record` VALUES (16265, 0, 589, 0, '2019-05-14 12:44:08', '2019-05-14 12:44:08');
INSERT INTO `record` VALUES (16266, 210, 589, 1, '2019-05-14 12:44:08', '2019-05-14 12:51:46');
INSERT INTO `record` VALUES (16267, 422, 589, 0, '2019-05-14 12:44:08', '2019-05-14 12:44:08');
INSERT INTO `record` VALUES (16268, 425, 589, 0, '2019-05-14 12:44:08', '2019-05-14 12:44:08');
INSERT INTO `record` VALUES (16269, 430, 589, 0, '2019-05-14 12:44:08', '2019-05-14 12:44:08');
INSERT INTO `record` VALUES (16270, 0, 590, 0, '2019-05-14 12:44:31', '2019-05-14 12:44:31');
INSERT INTO `record` VALUES (16271, 210, 590, 1, '2019-05-14 12:44:31', '2019-05-14 12:51:46');
INSERT INTO `record` VALUES (16272, 422, 590, 0, '2019-05-14 12:44:31', '2019-05-14 12:44:31');
INSERT INTO `record` VALUES (16273, 425, 590, 0, '2019-05-14 12:44:31', '2019-05-14 12:44:31');
INSERT INTO `record` VALUES (16274, 430, 590, 0, '2019-05-14 12:44:31', '2019-05-14 12:44:31');
INSERT INTO `record` VALUES (16275, 0, 591, 0, '2019-05-14 13:05:04', '2019-05-14 13:05:04');
INSERT INTO `record` VALUES (16276, 210, 591, 1, '2019-05-14 13:05:04', '2019-05-14 13:06:48');
INSERT INTO `record` VALUES (16277, 422, 591, 0, '2019-05-14 13:05:05', '2019-05-14 13:05:05');
INSERT INTO `record` VALUES (16278, 425, 591, 0, '2019-05-14 13:05:05', '2019-05-14 13:05:05');
INSERT INTO `record` VALUES (16279, 430, 591, 0, '2019-05-14 13:05:05', '2019-05-14 13:05:05');
INSERT INTO `record` VALUES (16280, 0, 592, 0, '2019-05-14 13:21:54', '2019-05-14 13:21:54');
INSERT INTO `record` VALUES (16281, 210, 592, 1, '2019-05-14 13:21:54', '2019-05-14 13:25:30');
INSERT INTO `record` VALUES (16282, 422, 592, 0, '2019-05-14 13:21:54', '2019-05-14 13:21:54');
INSERT INTO `record` VALUES (16283, 425, 592, 0, '2019-05-14 13:21:54', '2019-05-14 13:21:54');
INSERT INTO `record` VALUES (16284, 430, 592, 0, '2019-05-14 13:21:55', '2019-05-14 13:21:55');
INSERT INTO `record` VALUES (16285, 0, 593, 0, '2019-05-14 13:23:22', '2019-05-14 13:23:22');
INSERT INTO `record` VALUES (16286, 210, 593, 1, '2019-05-14 13:23:22', '2019-05-14 13:25:30');
INSERT INTO `record` VALUES (16287, 422, 593, 0, '2019-05-14 13:23:23', '2019-05-14 13:23:23');
INSERT INTO `record` VALUES (16288, 425, 593, 0, '2019-05-14 13:23:23', '2019-05-14 13:23:23');
INSERT INTO `record` VALUES (16289, 430, 593, 0, '2019-05-14 13:23:23', '2019-05-14 13:23:23');
INSERT INTO `record` VALUES (16290, 0, 594, 0, '2019-05-14 13:25:43', '2019-05-14 13:25:43');
INSERT INTO `record` VALUES (16291, 210, 594, 1, '2019-05-14 13:25:44', '2019-05-14 13:28:17');
INSERT INTO `record` VALUES (16292, 422, 594, 0, '2019-05-14 13:25:44', '2019-05-14 13:25:44');
INSERT INTO `record` VALUES (16293, 425, 594, 0, '2019-05-14 13:25:44', '2019-05-14 13:25:44');
INSERT INTO `record` VALUES (16294, 430, 594, 0, '2019-05-14 13:25:44', '2019-05-14 13:25:44');
INSERT INTO `record` VALUES (16295, 0, 595, 0, '2019-05-14 13:36:09', '2019-05-14 13:36:09');
INSERT INTO `record` VALUES (16296, 210, 595, 1, '2019-05-14 13:36:09', '2019-05-14 13:39:05');
INSERT INTO `record` VALUES (16297, 422, 595, 0, '2019-05-14 13:36:09', '2019-05-14 13:36:09');
INSERT INTO `record` VALUES (16298, 425, 595, 0, '2019-05-14 13:36:10', '2019-05-14 13:36:10');
INSERT INTO `record` VALUES (16299, 430, 595, 0, '2019-05-14 13:36:10', '2019-05-14 13:36:10');
INSERT INTO `record` VALUES (16300, 0, 596, 0, '2019-05-14 13:39:12', '2019-05-14 13:39:12');
INSERT INTO `record` VALUES (16301, 210, 596, 1, '2019-05-14 13:39:12', '2019-05-14 13:39:27');
INSERT INTO `record` VALUES (16302, 422, 596, 0, '2019-05-14 13:39:12', '2019-05-14 13:39:12');
INSERT INTO `record` VALUES (16303, 425, 596, 0, '2019-05-14 13:39:13', '2019-05-14 13:39:13');
INSERT INTO `record` VALUES (16304, 430, 596, 0, '2019-05-14 13:39:13', '2019-05-14 13:39:13');
INSERT INTO `record` VALUES (16305, 0, 597, 0, '2019-05-14 13:41:34', '2019-05-14 13:41:34');
INSERT INTO `record` VALUES (16306, 210, 597, 1, '2019-05-14 13:41:34', '2019-05-14 13:42:37');
INSERT INTO `record` VALUES (16307, 422, 597, 0, '2019-05-14 13:41:34', '2019-05-14 13:41:34');
INSERT INTO `record` VALUES (16308, 425, 597, 0, '2019-05-14 13:41:34', '2019-05-14 13:41:34');
INSERT INTO `record` VALUES (16309, 430, 597, 0, '2019-05-14 13:41:35', '2019-05-14 13:41:35');
INSERT INTO `record` VALUES (16310, 0, 598, 0, '2019-05-14 13:42:43', '2019-05-14 13:42:43');
INSERT INTO `record` VALUES (16311, 210, 598, 1, '2019-05-14 13:42:43', '2019-05-14 13:43:41');
INSERT INTO `record` VALUES (16312, 422, 598, 0, '2019-05-14 13:42:43', '2019-05-14 13:42:43');
INSERT INTO `record` VALUES (16313, 425, 598, 0, '2019-05-14 13:42:43', '2019-05-14 13:42:43');
INSERT INTO `record` VALUES (16314, 430, 598, 0, '2019-05-14 13:42:44', '2019-05-14 13:42:44');
INSERT INTO `record` VALUES (16315, 0, 599, 0, '2019-05-14 13:47:08', '2019-05-14 13:47:08');
INSERT INTO `record` VALUES (16316, 210, 599, 1, '2019-05-14 13:47:08', '2019-05-14 13:48:13');
INSERT INTO `record` VALUES (16317, 422, 599, 0, '2019-05-14 13:47:08', '2019-05-14 13:47:08');
INSERT INTO `record` VALUES (16318, 425, 599, 0, '2019-05-14 13:47:08', '2019-05-14 13:47:08');
INSERT INTO `record` VALUES (16319, 430, 599, 0, '2019-05-14 13:47:09', '2019-05-14 13:47:09');
INSERT INTO `record` VALUES (16320, 0, 600, 0, '2019-05-14 13:48:32', '2019-05-14 13:48:32');
INSERT INTO `record` VALUES (16321, 210, 600, 1, '2019-05-14 13:48:32', '2019-05-14 13:49:17');
INSERT INTO `record` VALUES (16322, 422, 600, 0, '2019-05-14 13:48:32', '2019-05-14 13:48:32');
INSERT INTO `record` VALUES (16323, 425, 600, 0, '2019-05-14 13:48:32', '2019-05-14 13:48:32');
INSERT INTO `record` VALUES (16324, 430, 600, 0, '2019-05-14 13:48:33', '2019-05-14 13:48:33');
INSERT INTO `record` VALUES (16325, 0, 601, 0, '2019-05-14 13:49:20', '2019-05-14 13:49:20');
INSERT INTO `record` VALUES (16326, 210, 601, 1, '2019-05-14 13:49:21', '2019-05-14 13:51:47');
INSERT INTO `record` VALUES (16327, 422, 601, 0, '2019-05-14 13:49:21', '2019-05-14 13:49:21');
INSERT INTO `record` VALUES (16328, 425, 601, 0, '2019-05-14 13:49:21', '2019-05-14 13:49:21');
INSERT INTO `record` VALUES (16329, 430, 601, 0, '2019-05-14 13:49:21', '2019-05-14 13:49:21');
INSERT INTO `record` VALUES (16330, 0, 602, 0, '2019-05-14 13:50:18', '2019-05-14 13:50:18');
INSERT INTO `record` VALUES (16331, 210, 602, 1, '2019-05-14 13:50:18', '2019-05-14 13:51:47');
INSERT INTO `record` VALUES (16332, 422, 602, 0, '2019-05-14 13:50:18', '2019-05-14 13:50:18');
INSERT INTO `record` VALUES (16333, 425, 602, 0, '2019-05-14 13:50:18', '2019-05-14 13:50:18');
INSERT INTO `record` VALUES (16334, 430, 602, 0, '2019-05-14 13:50:19', '2019-05-14 13:50:19');
INSERT INTO `record` VALUES (16335, 0, 603, 0, '2019-05-14 13:51:53', '2019-05-14 13:51:53');
INSERT INTO `record` VALUES (16336, 210, 603, 1, '2019-05-14 13:51:53', '2019-05-14 13:52:26');
INSERT INTO `record` VALUES (16337, 422, 603, 0, '2019-05-14 13:51:53', '2019-05-14 13:51:53');
INSERT INTO `record` VALUES (16338, 425, 603, 0, '2019-05-14 13:51:53', '2019-05-14 13:51:53');
INSERT INTO `record` VALUES (16339, 430, 603, 0, '2019-05-14 13:51:54', '2019-05-14 13:51:54');
INSERT INTO `record` VALUES (16340, 0, 604, 0, '2019-05-14 13:52:00', '2019-05-14 13:52:00');
INSERT INTO `record` VALUES (16341, 210, 604, 1, '2019-05-14 13:52:00', '2019-05-14 13:52:26');
INSERT INTO `record` VALUES (16342, 422, 604, 0, '2019-05-14 13:52:00', '2019-05-14 13:52:00');
INSERT INTO `record` VALUES (16343, 425, 604, 0, '2019-05-14 13:52:01', '2019-05-14 13:52:01');
INSERT INTO `record` VALUES (16344, 430, 604, 0, '2019-05-14 13:52:01', '2019-05-14 13:52:01');
INSERT INTO `record` VALUES (16345, 0, 605, 0, '2019-05-14 13:52:32', '2019-05-14 13:52:32');
INSERT INTO `record` VALUES (16346, 210, 605, 1, '2019-05-14 13:52:32', '2019-05-14 13:53:01');
INSERT INTO `record` VALUES (16347, 422, 605, 0, '2019-05-14 13:52:32', '2019-05-14 13:52:32');
INSERT INTO `record` VALUES (16348, 425, 605, 0, '2019-05-14 13:52:33', '2019-05-14 13:52:33');
INSERT INTO `record` VALUES (16349, 430, 605, 0, '2019-05-14 13:52:33', '2019-05-14 13:52:33');
INSERT INTO `record` VALUES (16350, 0, 606, 0, '2019-05-14 13:52:37', '2019-05-14 13:52:37');
INSERT INTO `record` VALUES (16351, 210, 606, 1, '2019-05-14 13:52:37', '2019-05-14 13:53:01');
INSERT INTO `record` VALUES (16352, 422, 606, 0, '2019-05-14 13:52:37', '2019-05-14 13:52:37');
INSERT INTO `record` VALUES (16353, 425, 606, 0, '2019-05-14 13:52:37', '2019-05-14 13:52:37');
INSERT INTO `record` VALUES (16354, 430, 606, 0, '2019-05-14 13:52:38', '2019-05-14 13:52:38');
INSERT INTO `record` VALUES (16355, 0, 607, 0, '2019-05-14 13:53:09', '2019-05-14 13:53:09');
INSERT INTO `record` VALUES (16356, 210, 607, 1, '2019-05-14 13:53:09', '2019-05-14 13:54:15');
INSERT INTO `record` VALUES (16357, 422, 607, 0, '2019-05-14 13:53:09', '2019-05-14 13:53:09');
INSERT INTO `record` VALUES (16358, 425, 607, 0, '2019-05-14 13:53:10', '2019-05-14 13:53:10');
INSERT INTO `record` VALUES (16359, 430, 607, 0, '2019-05-14 13:53:10', '2019-05-14 13:53:10');
INSERT INTO `record` VALUES (16360, 0, 608, 0, '2019-05-14 13:53:34', '2019-05-14 13:53:34');
INSERT INTO `record` VALUES (16361, 210, 608, 1, '2019-05-14 13:53:34', '2019-05-14 13:54:15');
INSERT INTO `record` VALUES (16362, 422, 608, 0, '2019-05-14 13:53:34', '2019-05-14 13:53:34');
INSERT INTO `record` VALUES (16363, 425, 608, 0, '2019-05-14 13:53:34', '2019-05-14 13:53:34');
INSERT INTO `record` VALUES (16364, 430, 608, 0, '2019-05-14 13:53:35', '2019-05-14 13:53:35');
INSERT INTO `record` VALUES (16365, 0, 609, 0, '2019-05-14 13:54:22', '2019-05-14 13:54:22');
INSERT INTO `record` VALUES (16366, 210, 609, 1, '2019-05-14 13:54:22', '2019-05-14 13:55:20');
INSERT INTO `record` VALUES (16367, 422, 609, 0, '2019-05-14 13:54:22', '2019-05-14 13:54:22');
INSERT INTO `record` VALUES (16368, 425, 609, 0, '2019-05-14 13:54:22', '2019-05-14 13:54:22');
INSERT INTO `record` VALUES (16369, 430, 609, 0, '2019-05-14 13:54:23', '2019-05-14 13:54:23');
INSERT INTO `record` VALUES (16370, 0, 610, 0, '2019-05-14 13:55:26', '2019-05-14 13:55:26');
INSERT INTO `record` VALUES (16371, 210, 610, 1, '2019-05-14 13:55:27', '2019-05-14 13:57:13');
INSERT INTO `record` VALUES (16372, 422, 610, 0, '2019-05-14 13:55:27', '2019-05-14 13:55:27');
INSERT INTO `record` VALUES (16373, 425, 610, 0, '2019-05-14 13:55:27', '2019-05-14 13:55:27');
INSERT INTO `record` VALUES (16374, 430, 610, 0, '2019-05-14 13:55:27', '2019-05-14 13:55:27');
INSERT INTO `record` VALUES (16375, 0, 611, 0, '2019-05-14 13:57:18', '2019-05-14 13:57:18');
INSERT INTO `record` VALUES (16376, 210, 611, 1, '2019-05-14 13:57:18', '2019-05-14 13:57:28');
INSERT INTO `record` VALUES (16377, 422, 611, 0, '2019-05-14 13:57:18', '2019-05-14 13:57:18');
INSERT INTO `record` VALUES (16378, 425, 611, 0, '2019-05-14 13:57:19', '2019-05-14 13:57:19');
INSERT INTO `record` VALUES (16379, 430, 611, 0, '2019-05-14 13:57:19', '2019-05-14 13:57:19');
INSERT INTO `record` VALUES (16380, 0, 612, 0, '2019-05-14 13:58:44', '2019-05-14 13:58:44');
INSERT INTO `record` VALUES (16381, 210, 612, 1, '2019-05-14 13:58:44', '2019-05-14 13:58:51');
INSERT INTO `record` VALUES (16382, 422, 612, 0, '2019-05-14 13:58:44', '2019-05-14 13:58:44');
INSERT INTO `record` VALUES (16383, 425, 612, 0, '2019-05-14 13:58:44', '2019-05-14 13:58:44');
INSERT INTO `record` VALUES (16384, 430, 612, 0, '2019-05-14 13:58:45', '2019-05-14 13:58:45');
INSERT INTO `record` VALUES (16385, 0, 613, 0, '2019-05-14 13:59:00', '2019-05-14 13:59:00');
INSERT INTO `record` VALUES (16386, 210, 613, 1, '2019-05-14 13:59:00', '2019-05-14 13:59:34');
INSERT INTO `record` VALUES (16387, 422, 613, 0, '2019-05-14 13:59:00', '2019-05-14 13:59:00');
INSERT INTO `record` VALUES (16388, 425, 613, 0, '2019-05-14 13:59:00', '2019-05-14 13:59:00');
INSERT INTO `record` VALUES (16389, 430, 613, 0, '2019-05-14 13:59:00', '2019-05-14 13:59:00');
INSERT INTO `record` VALUES (16390, 0, 614, 0, '2019-05-14 13:59:49', '2019-05-14 13:59:49');
INSERT INTO `record` VALUES (16391, 210, 614, 1, '2019-05-14 13:59:50', '2019-05-14 14:00:18');
INSERT INTO `record` VALUES (16392, 422, 614, 0, '2019-05-14 13:59:50', '2019-05-14 13:59:50');
INSERT INTO `record` VALUES (16393, 425, 614, 0, '2019-05-14 13:59:50', '2019-05-14 13:59:50');
INSERT INTO `record` VALUES (16394, 430, 614, 0, '2019-05-14 13:59:50', '2019-05-14 13:59:50');
INSERT INTO `record` VALUES (16395, 0, 615, 0, '2019-05-14 14:00:25', '2019-05-14 14:00:25');
INSERT INTO `record` VALUES (16396, 210, 615, 1, '2019-05-14 14:00:25', '2019-05-14 14:01:19');
INSERT INTO `record` VALUES (16397, 422, 615, 0, '2019-05-14 14:00:25', '2019-05-14 14:00:25');
INSERT INTO `record` VALUES (16398, 425, 615, 0, '2019-05-14 14:00:25', '2019-05-14 14:00:25');
INSERT INTO `record` VALUES (16399, 430, 615, 0, '2019-05-14 14:00:25', '2019-05-14 14:00:25');
INSERT INTO `record` VALUES (16400, 0, 616, 0, '2019-05-14 14:01:26', '2019-05-14 14:01:26');
INSERT INTO `record` VALUES (16401, 210, 616, 1, '2019-05-14 14:01:26', '2019-05-14 14:05:05');
INSERT INTO `record` VALUES (16402, 422, 616, 0, '2019-05-14 14:01:26', '2019-05-14 14:01:26');
INSERT INTO `record` VALUES (16403, 425, 616, 0, '2019-05-14 14:01:26', '2019-05-14 14:01:26');
INSERT INTO `record` VALUES (16404, 430, 616, 0, '2019-05-14 14:01:26', '2019-05-14 14:01:26');
INSERT INTO `record` VALUES (16405, 0, 617, 0, '2019-05-14 14:07:02', '2019-05-14 14:07:02');
INSERT INTO `record` VALUES (16406, 210, 617, 1, '2019-05-14 14:07:02', '2019-05-14 14:40:30');
INSERT INTO `record` VALUES (16407, 422, 617, 0, '2019-05-14 14:07:02', '2019-05-14 14:07:02');
INSERT INTO `record` VALUES (16408, 425, 617, 0, '2019-05-14 14:07:02', '2019-05-14 14:07:02');
INSERT INTO `record` VALUES (16409, 430, 617, 0, '2019-05-14 14:07:03', '2019-05-14 14:07:03');
INSERT INTO `record` VALUES (16410, 0, 618, 0, '2019-05-14 14:40:41', '2019-05-14 14:40:41');
INSERT INTO `record` VALUES (16411, 210, 618, 1, '2019-05-14 14:40:41', '2019-05-14 14:41:52');
INSERT INTO `record` VALUES (16412, 422, 618, 0, '2019-05-14 14:40:41', '2019-05-14 14:40:41');
INSERT INTO `record` VALUES (16413, 425, 618, 0, '2019-05-14 14:40:42', '2019-05-14 14:40:42');
INSERT INTO `record` VALUES (16414, 430, 618, 0, '2019-05-14 14:40:42', '2019-05-14 14:40:42');
INSERT INTO `record` VALUES (16415, 0, 619, 0, '2019-05-14 14:41:59', '2019-05-14 14:41:59');
INSERT INTO `record` VALUES (16416, 210, 619, 1, '2019-05-14 14:41:59', '2019-05-14 14:42:41');
INSERT INTO `record` VALUES (16417, 422, 619, 0, '2019-05-14 14:42:00', '2019-05-14 14:42:00');
INSERT INTO `record` VALUES (16418, 425, 619, 0, '2019-05-14 14:42:00', '2019-05-14 14:42:00');
INSERT INTO `record` VALUES (16419, 430, 619, 0, '2019-05-14 14:42:00', '2019-05-14 14:42:00');
INSERT INTO `record` VALUES (16420, 0, 620, 0, '2019-05-14 14:42:59', '2019-05-14 14:42:59');
INSERT INTO `record` VALUES (16421, 210, 620, 1, '2019-05-14 14:42:59', '2019-05-14 14:43:47');
INSERT INTO `record` VALUES (16422, 422, 620, 0, '2019-05-14 14:42:59', '2019-05-14 14:42:59');
INSERT INTO `record` VALUES (16423, 425, 620, 0, '2019-05-14 14:42:59', '2019-05-14 14:42:59');
INSERT INTO `record` VALUES (16424, 430, 620, 0, '2019-05-14 14:43:00', '2019-05-14 14:43:00');
INSERT INTO `record` VALUES (16425, 0, 621, 0, '2019-05-14 14:43:53', '2019-05-14 14:43:53');
INSERT INTO `record` VALUES (16426, 210, 621, 1, '2019-05-14 14:43:54', '2019-05-14 14:44:56');
INSERT INTO `record` VALUES (16427, 422, 621, 0, '2019-05-14 14:43:54', '2019-05-14 14:43:54');
INSERT INTO `record` VALUES (16428, 425, 621, 0, '2019-05-14 14:43:54', '2019-05-14 14:43:54');
INSERT INTO `record` VALUES (16429, 430, 621, 0, '2019-05-14 14:43:54', '2019-05-14 14:43:54');
INSERT INTO `record` VALUES (16430, 0, 622, 0, '2019-05-14 14:45:03', '2019-05-14 14:45:03');
INSERT INTO `record` VALUES (16431, 210, 622, 1, '2019-05-14 14:45:03', '2019-05-14 15:17:55');
INSERT INTO `record` VALUES (16432, 422, 622, 0, '2019-05-14 14:45:03', '2019-05-14 14:45:03');
INSERT INTO `record` VALUES (16433, 425, 622, 0, '2019-05-14 14:45:03', '2019-05-14 14:45:03');
INSERT INTO `record` VALUES (16434, 430, 622, 0, '2019-05-14 14:45:04', '2019-05-14 14:45:04');
INSERT INTO `record` VALUES (16435, 0, 623, 0, '2019-05-14 14:47:49', '2019-05-14 14:47:49');
INSERT INTO `record` VALUES (16436, 210, 623, 1, '2019-05-14 14:47:49', '2019-05-14 15:17:55');
INSERT INTO `record` VALUES (16437, 422, 623, 0, '2019-05-14 14:47:49', '2019-05-14 14:47:49');
INSERT INTO `record` VALUES (16438, 425, 623, 0, '2019-05-14 14:47:49', '2019-05-14 14:47:49');
INSERT INTO `record` VALUES (16439, 430, 623, 0, '2019-05-14 14:47:50', '2019-05-14 14:47:50');
INSERT INTO `record` VALUES (16440, 0, 624, 0, '2019-05-14 15:18:18', '2019-05-14 15:18:18');
INSERT INTO `record` VALUES (16441, 210, 624, 1, '2019-05-14 15:18:18', '2019-05-14 15:19:17');
INSERT INTO `record` VALUES (16442, 422, 624, 0, '2019-05-14 15:18:18', '2019-05-14 15:18:18');
INSERT INTO `record` VALUES (16443, 425, 624, 0, '2019-05-14 15:18:18', '2019-05-14 15:18:18');
INSERT INTO `record` VALUES (16444, 430, 624, 0, '2019-05-14 15:18:19', '2019-05-14 15:18:19');
INSERT INTO `record` VALUES (16445, 0, 625, 0, '2019-05-14 15:19:28', '2019-05-14 15:19:28');
INSERT INTO `record` VALUES (16446, 210, 625, 1, '2019-05-14 15:19:28', '2019-05-14 15:21:00');
INSERT INTO `record` VALUES (16447, 422, 625, 0, '2019-05-14 15:19:28', '2019-05-14 15:19:28');
INSERT INTO `record` VALUES (16448, 425, 625, 0, '2019-05-14 15:19:28', '2019-05-14 15:19:28');
INSERT INTO `record` VALUES (16449, 430, 625, 0, '2019-05-14 15:19:28', '2019-05-14 15:19:28');
INSERT INTO `record` VALUES (16450, 0, 626, 0, '2019-05-14 15:21:07', '2019-05-14 15:21:07');
INSERT INTO `record` VALUES (16451, 210, 626, 1, '2019-05-14 15:21:07', '2019-05-14 15:21:52');
INSERT INTO `record` VALUES (16452, 422, 626, 0, '2019-05-14 15:21:07', '2019-05-14 15:21:07');
INSERT INTO `record` VALUES (16453, 425, 626, 0, '2019-05-14 15:21:08', '2019-05-14 15:21:08');
INSERT INTO `record` VALUES (16454, 430, 626, 0, '2019-05-14 15:21:08', '2019-05-14 15:21:08');
INSERT INTO `record` VALUES (16455, 0, 627, 0, '2019-05-14 15:21:59', '2019-05-14 15:21:59');
INSERT INTO `record` VALUES (16456, 210, 627, 1, '2019-05-14 15:21:59', '2019-05-14 15:28:02');
INSERT INTO `record` VALUES (16457, 422, 627, 0, '2019-05-14 15:22:00', '2019-05-14 15:22:00');
INSERT INTO `record` VALUES (16458, 425, 627, 0, '2019-05-14 15:22:00', '2019-05-14 15:22:00');
INSERT INTO `record` VALUES (16459, 430, 627, 0, '2019-05-14 15:22:00', '2019-05-14 15:22:00');
INSERT INTO `record` VALUES (16460, 0, 628, 0, '2019-05-14 15:23:27', '2019-05-14 15:23:27');
INSERT INTO `record` VALUES (16461, 210, 628, 1, '2019-05-14 15:23:27', '2019-05-14 15:28:02');
INSERT INTO `record` VALUES (16462, 422, 628, 0, '2019-05-14 15:23:27', '2019-05-14 15:23:27');
INSERT INTO `record` VALUES (16463, 425, 628, 0, '2019-05-14 15:23:28', '2019-05-14 15:23:28');
INSERT INTO `record` VALUES (16464, 430, 628, 0, '2019-05-14 15:23:28', '2019-05-14 15:23:28');
INSERT INTO `record` VALUES (16465, 0, 629, 0, '2019-05-14 15:28:10', '2019-05-14 15:28:10');
INSERT INTO `record` VALUES (16466, 210, 629, 1, '2019-05-14 15:28:10', '2019-05-14 15:29:28');
INSERT INTO `record` VALUES (16467, 422, 629, 0, '2019-05-14 15:28:10', '2019-05-14 15:28:10');
INSERT INTO `record` VALUES (16468, 425, 629, 0, '2019-05-14 15:28:10', '2019-05-14 15:28:10');
INSERT INTO `record` VALUES (16469, 430, 629, 0, '2019-05-14 15:28:10', '2019-05-14 15:28:10');
INSERT INTO `record` VALUES (16470, 0, 630, 0, '2019-05-14 15:29:33', '2019-05-14 15:29:33');
INSERT INTO `record` VALUES (16471, 210, 630, 1, '2019-05-14 15:29:34', '2019-05-14 15:33:12');
INSERT INTO `record` VALUES (16472, 422, 630, 0, '2019-05-14 15:29:34', '2019-05-14 15:29:34');
INSERT INTO `record` VALUES (16473, 425, 630, 0, '2019-05-14 15:29:34', '2019-05-14 15:29:34');
INSERT INTO `record` VALUES (16474, 430, 630, 0, '2019-05-14 15:29:35', '2019-05-14 15:29:35');
INSERT INTO `record` VALUES (16475, 0, 631, 0, '2019-05-14 15:33:19', '2019-05-14 15:33:19');
INSERT INTO `record` VALUES (16476, 210, 631, 1, '2019-05-14 15:33:20', '2019-05-14 15:35:36');
INSERT INTO `record` VALUES (16477, 422, 631, 0, '2019-05-14 15:33:20', '2019-05-14 15:33:20');
INSERT INTO `record` VALUES (16478, 425, 631, 0, '2019-05-14 15:33:20', '2019-05-14 15:33:20');
INSERT INTO `record` VALUES (16479, 430, 631, 0, '2019-05-14 15:33:20', '2019-05-14 15:33:20');
INSERT INTO `record` VALUES (16480, 0, 632, 0, '2019-05-14 15:34:04', '2019-05-14 15:34:04');
INSERT INTO `record` VALUES (16481, 210, 632, 1, '2019-05-14 15:34:05', '2019-05-14 15:35:36');
INSERT INTO `record` VALUES (16482, 422, 632, 0, '2019-05-14 15:34:05', '2019-05-14 15:34:05');
INSERT INTO `record` VALUES (16483, 425, 632, 0, '2019-05-14 15:34:05', '2019-05-14 15:34:05');
INSERT INTO `record` VALUES (16484, 430, 632, 0, '2019-05-14 15:34:05', '2019-05-14 15:34:05');
INSERT INTO `record` VALUES (16485, 0, 633, 0, '2019-05-14 15:34:40', '2019-05-14 15:34:40');
INSERT INTO `record` VALUES (16486, 210, 633, 1, '2019-05-14 15:34:40', '2019-05-14 15:35:36');
INSERT INTO `record` VALUES (16487, 422, 633, 0, '2019-05-14 15:34:41', '2019-05-14 15:34:41');
INSERT INTO `record` VALUES (16488, 425, 633, 0, '2019-05-14 15:34:41', '2019-05-14 15:34:41');
INSERT INTO `record` VALUES (16489, 430, 633, 0, '2019-05-14 15:34:41', '2019-05-14 15:34:41');
INSERT INTO `record` VALUES (16490, 0, 634, 0, '2019-05-14 15:38:22', '2019-05-14 15:38:22');
INSERT INTO `record` VALUES (16491, 210, 634, 1, '2019-05-14 15:38:23', '2019-05-14 15:38:54');
INSERT INTO `record` VALUES (16492, 422, 634, 0, '2019-05-14 15:38:23', '2019-05-14 15:38:23');
INSERT INTO `record` VALUES (16493, 425, 634, 0, '2019-05-14 15:38:23', '2019-05-14 15:38:23');
INSERT INTO `record` VALUES (16494, 430, 634, 0, '2019-05-14 15:38:23', '2019-05-14 15:38:23');
INSERT INTO `record` VALUES (16495, 0, 635, 0, '2019-05-14 15:39:02', '2019-05-14 15:39:02');
INSERT INTO `record` VALUES (16496, 210, 635, 1, '2019-05-14 15:39:02', '2019-05-14 15:44:55');
INSERT INTO `record` VALUES (16497, 422, 635, 0, '2019-05-14 15:39:03', '2019-05-14 15:39:03');
INSERT INTO `record` VALUES (16498, 425, 635, 0, '2019-05-14 15:39:03', '2019-05-14 15:39:03');
INSERT INTO `record` VALUES (16499, 430, 635, 0, '2019-05-14 15:39:03', '2019-05-14 15:39:03');
INSERT INTO `record` VALUES (16500, 0, 636, 0, '2019-05-14 15:39:10', '2019-05-14 15:39:10');
INSERT INTO `record` VALUES (16501, 210, 636, 1, '2019-05-14 15:39:10', '2019-05-14 15:44:55');
INSERT INTO `record` VALUES (16502, 422, 636, 0, '2019-05-14 15:39:11', '2019-05-14 15:39:11');
INSERT INTO `record` VALUES (16503, 425, 636, 0, '2019-05-14 15:39:11', '2019-05-14 15:39:11');
INSERT INTO `record` VALUES (16504, 430, 636, 0, '2019-05-14 15:39:11', '2019-05-14 15:39:11');
INSERT INTO `record` VALUES (16505, 0, 637, 0, '2019-05-14 15:45:04', '2019-05-14 15:45:04');
INSERT INTO `record` VALUES (16506, 210, 637, 1, '2019-05-14 15:45:04', '2019-05-14 17:12:56');
INSERT INTO `record` VALUES (16507, 422, 637, 0, '2019-05-14 15:45:04', '2019-05-14 15:45:04');
INSERT INTO `record` VALUES (16508, 425, 637, 0, '2019-05-14 15:45:04', '2019-05-14 15:45:04');
INSERT INTO `record` VALUES (16509, 430, 637, 0, '2019-05-14 15:45:04', '2019-05-14 15:45:04');
INSERT INTO `record` VALUES (16510, 433, 637, 1, '2019-05-14 15:45:05', '2019-05-14 15:46:36');
INSERT INTO `record` VALUES (16511, 0, 638, 0, '2019-05-14 15:45:19', '2019-05-14 15:45:19');
INSERT INTO `record` VALUES (16512, 210, 638, 1, '2019-05-14 15:45:19', '2019-05-14 17:12:56');
INSERT INTO `record` VALUES (16513, 422, 638, 0, '2019-05-14 15:45:19', '2019-05-14 15:45:19');
INSERT INTO `record` VALUES (16514, 425, 638, 0, '2019-05-14 15:45:19', '2019-05-14 15:45:19');
INSERT INTO `record` VALUES (16515, 430, 638, 0, '2019-05-14 15:45:20', '2019-05-14 15:45:20');
INSERT INTO `record` VALUES (16516, 433, 638, 1, '2019-05-14 15:45:20', '2019-05-14 15:46:36');
INSERT INTO `record` VALUES (16517, 0, 639, 0, '2019-05-14 15:45:32', '2019-05-14 15:45:32');
INSERT INTO `record` VALUES (16518, 210, 639, 1, '2019-05-14 15:45:33', '2019-05-14 17:12:56');
INSERT INTO `record` VALUES (16519, 422, 639, 0, '2019-05-14 15:45:33', '2019-05-14 15:45:33');
INSERT INTO `record` VALUES (16520, 425, 639, 0, '2019-05-14 15:45:33', '2019-05-14 15:45:33');
INSERT INTO `record` VALUES (16521, 430, 639, 0, '2019-05-14 15:45:33', '2019-05-14 15:45:33');
INSERT INTO `record` VALUES (16522, 433, 639, 1, '2019-05-14 15:45:33', '2019-05-14 15:46:36');
INSERT INTO `record` VALUES (16523, 210, 640, 1, '2019-05-14 17:14:32', '2019-05-14 18:00:59');
INSERT INTO `record` VALUES (16524, 445, 640, 1, '2019-05-14 17:14:32', '2019-05-14 17:14:58');
INSERT INTO `record` VALUES (16525, 210, 641, 1, '2019-05-14 17:27:32', '2019-05-14 18:00:59');
INSERT INTO `record` VALUES (16526, 445, 641, 0, '2019-05-14 17:27:32', '2019-05-14 17:27:32');
INSERT INTO `record` VALUES (16527, 446, 641, 1, '2019-05-14 17:27:32', '2019-05-14 17:27:41');
INSERT INTO `record` VALUES (16528, 210, 642, 1, '2019-05-14 17:59:54', '2019-05-14 18:00:59');
INSERT INTO `record` VALUES (16529, 445, 642, 0, '2019-05-14 17:59:54', '2019-05-14 17:59:54');
INSERT INTO `record` VALUES (16530, 446, 642, 0, '2019-05-14 17:59:54', '2019-05-14 17:59:54');
INSERT INTO `record` VALUES (16531, 447, 642, 1, '2019-05-14 17:59:54', '2019-05-14 18:00:40');
INSERT INTO `record` VALUES (16532, 210, 643, 1, '2019-05-14 20:37:12', '2019-05-14 21:08:59');
INSERT INTO `record` VALUES (16533, 445, 643, 0, '2019-05-14 20:37:12', '2019-05-14 20:37:12');
INSERT INTO `record` VALUES (16534, 446, 643, 0, '2019-05-14 20:37:12', '2019-05-14 20:37:12');
INSERT INTO `record` VALUES (16535, 448, 643, 0, '2019-05-14 20:37:12', '2019-05-14 20:37:12');
INSERT INTO `record` VALUES (16536, 210, 644, 1, '2019-05-14 21:08:40', '2019-05-14 21:08:59');
INSERT INTO `record` VALUES (16537, 445, 644, 0, '2019-05-14 21:08:40', '2019-05-14 21:08:40');
INSERT INTO `record` VALUES (16538, 446, 644, 0, '2019-05-14 21:08:40', '2019-05-14 21:08:40');
INSERT INTO `record` VALUES (16539, 448, 644, 0, '2019-05-14 21:08:40', '2019-05-14 21:08:40');
INSERT INTO `record` VALUES (16540, 449, 644, 1, '2019-05-14 21:08:40', '2019-05-14 21:08:45');
INSERT INTO `record` VALUES (16541, 210, 645, 1, '2019-05-14 21:14:17', '2019-05-14 21:14:52');
INSERT INTO `record` VALUES (16542, 445, 645, 0, '2019-05-14 21:14:18', '2019-05-14 21:14:18');
INSERT INTO `record` VALUES (16543, 446, 645, 0, '2019-05-14 21:14:18', '2019-05-14 21:14:18');
INSERT INTO `record` VALUES (16544, 448, 645, 0, '2019-05-14 21:14:18', '2019-05-14 21:14:18');
INSERT INTO `record` VALUES (16545, 449, 645, 0, '2019-05-14 21:14:18', '2019-05-14 21:14:18');
INSERT INTO `record` VALUES (16546, 210, 646, 1, '2019-05-14 21:16:20', '2019-05-14 21:16:48');
INSERT INTO `record` VALUES (16547, 445, 646, 0, '2019-05-14 21:16:21', '2019-05-14 21:16:21');
INSERT INTO `record` VALUES (16548, 446, 646, 0, '2019-05-14 21:16:21', '2019-05-14 21:16:21');
INSERT INTO `record` VALUES (16549, 448, 646, 0, '2019-05-14 21:16:21', '2019-05-14 21:16:21');
INSERT INTO `record` VALUES (16550, 449, 646, 0, '2019-05-14 21:16:21', '2019-05-14 21:16:21');
INSERT INTO `record` VALUES (16551, 450, 646, 1, '2019-05-14 21:16:21', '2019-05-14 21:16:31');
INSERT INTO `record` VALUES (16552, 210, 647, 1, '2019-05-14 21:50:37', '2019-05-14 22:02:40');
INSERT INTO `record` VALUES (16553, 452, 647, 1, '2019-05-14 21:50:37', '2019-05-14 21:51:30');
INSERT INTO `record` VALUES (16554, 210, 648, 1, '2019-05-14 21:53:08', '2019-05-14 22:02:40');
INSERT INTO `record` VALUES (16555, 452, 648, 0, '2019-05-14 21:53:08', '2019-05-14 21:53:08');
INSERT INTO `record` VALUES (16556, 210, 649, 1, '2019-05-14 21:53:14', '2019-05-14 22:02:40');
INSERT INTO `record` VALUES (16557, 452, 649, 0, '2019-05-14 21:53:14', '2019-05-14 21:53:14');
INSERT INTO `record` VALUES (16558, 210, 650, 1, '2019-05-14 21:53:15', '2019-05-14 22:02:40');
INSERT INTO `record` VALUES (16559, 452, 650, 0, '2019-05-14 21:53:15', '2019-05-14 21:53:15');
INSERT INTO `record` VALUES (16560, 210, 651, 1, '2019-05-14 21:53:16', '2019-05-14 22:02:40');
INSERT INTO `record` VALUES (16561, 452, 651, 0, '2019-05-14 21:53:16', '2019-05-14 21:53:16');
INSERT INTO `record` VALUES (16562, 210, 652, 1, '2019-05-14 21:53:17', '2019-05-14 22:02:40');
INSERT INTO `record` VALUES (16563, 452, 652, 0, '2019-05-14 21:53:17', '2019-05-14 21:53:17');
INSERT INTO `record` VALUES (16564, 210, 653, 1, '2019-05-14 21:53:27', '2019-05-14 22:02:40');
INSERT INTO `record` VALUES (16565, 452, 653, 0, '2019-05-14 21:53:27', '2019-05-14 21:53:27');
INSERT INTO `record` VALUES (16566, 210, 654, 1, '2019-05-14 22:08:16', '2019-05-14 22:08:21');
INSERT INTO `record` VALUES (16567, 454, 654, 1, '2019-05-14 22:08:16', '2019-05-14 22:08:38');
INSERT INTO `record` VALUES (16568, 210, 655, 1, '2019-05-14 22:12:20', '2019-05-14 22:14:05');
INSERT INTO `record` VALUES (16569, 455, 655, 0, '2019-05-14 22:12:20', '2019-05-14 22:12:20');
INSERT INTO `record` VALUES (16570, 210, 656, 1, '2019-05-14 22:21:29', '2019-05-14 22:23:12');
INSERT INTO `record` VALUES (16571, 456, 656, 0, '2019-05-14 22:21:29', '2019-05-14 22:21:29');
INSERT INTO `record` VALUES (16572, 210, 657, 1, '2019-05-14 22:30:14', '2019-05-14 22:30:35');
INSERT INTO `record` VALUES (16573, 456, 657, 0, '2019-05-14 22:30:15', '2019-05-14 22:30:15');
INSERT INTO `record` VALUES (16574, 457, 657, 1, '2019-05-14 22:30:15', '2019-05-14 22:30:45');
INSERT INTO `record` VALUES (16575, 210, 658, 1, '2019-05-14 23:15:58', '2019-05-14 23:36:16');
INSERT INTO `record` VALUES (16576, 456, 658, 0, '2019-05-14 23:15:58', '2019-05-14 23:15:58');
INSERT INTO `record` VALUES (16577, 457, 658, 0, '2019-05-14 23:15:58', '2019-05-14 23:15:58');
INSERT INTO `record` VALUES (16578, 458, 658, 1, '2019-05-14 23:15:58', '2019-05-14 23:18:10');
INSERT INTO `record` VALUES (16579, 210, 659, 1, '2019-05-14 23:29:25', '2019-05-14 23:36:16');
INSERT INTO `record` VALUES (16580, 456, 659, 0, '2019-05-14 23:29:25', '2019-05-14 23:29:25');
INSERT INTO `record` VALUES (16581, 457, 659, 0, '2019-05-14 23:29:25', '2019-05-14 23:29:25');
INSERT INTO `record` VALUES (16582, 458, 659, 0, '2019-05-14 23:29:25', '2019-05-14 23:29:25');
INSERT INTO `record` VALUES (16583, 459, 659, 1, '2019-05-14 23:29:25', '2019-05-14 23:29:34');
INSERT INTO `record` VALUES (16584, 210, 660, 0, '2019-05-14 23:36:40', '2019-05-14 23:36:40');
INSERT INTO `record` VALUES (16585, 456, 660, 0, '2019-05-14 23:36:40', '2019-05-14 23:36:40');
INSERT INTO `record` VALUES (16586, 457, 660, 0, '2019-05-14 23:36:40', '2019-05-14 23:36:40');
INSERT INTO `record` VALUES (16587, 458, 660, 0, '2019-05-14 23:36:40', '2019-05-14 23:36:40');
INSERT INTO `record` VALUES (16588, 459, 660, 0, '2019-05-14 23:36:40', '2019-05-14 23:36:40');
INSERT INTO `record` VALUES (16589, 460, 660, 1, '2019-05-14 23:36:40', '2019-05-14 23:36:45');

-- ----------------------------
-- Table structure for remark
-- ----------------------------
DROP TABLE IF EXISTS `remark`;
CREATE TABLE `remark`  (
  `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(10) UNSIGNED NOT NULL COMMENT '评论者id',
  `moment_id` bigint(10) UNSIGNED NOT NULL COMMENT '评论对象id',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发表时间',
  `love` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `collect` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏量',
  `reply` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复数',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_user_id_7`(`user_id`) USING BTREE,
  INDEX `fk_target_id_2`(`moment_id`) USING BTREE,
  CONSTRAINT `fk_target_id_1` FOREIGN KEY (`moment_id`) REFERENCES `moment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_id_7` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of remark
-- ----------------------------
INSERT INTO `remark` VALUES (3, 0, 88, '朋友圈的评论', '2019-05-14 10:28:54', 0, 0, 0, 0, '2019-05-14 02:04:54', '2019-05-14 02:04:54');
INSERT INTO `remark` VALUES (4, 210, 99, '来自test5的评论', '2019-05-14 10:28:54', 0, 0, 0, 0, '2019-05-14 02:12:30', '2019-05-14 02:12:30');
INSERT INTO `remark` VALUES (5, 210, 99, '来自test5的第二条评论', '2019-05-14 10:28:54', 0, 0, 0, 0, '2019-05-14 02:13:07', '2019-05-14 02:13:07');
INSERT INTO `remark` VALUES (6, 210, 99, '第三条评论', '2019-05-14 10:28:54', 0, 0, 0, 0, '2019-05-14 03:59:07', '2019-05-14 10:28:20');
INSERT INTO `remark` VALUES (7, 210, 99, '第四条评论', '2019-05-14 10:28:54', 0, 0, 0, 0, '2019-05-14 04:01:52', '2019-05-14 10:28:21');
INSERT INTO `remark` VALUES (8, 210, 99, '第五条评论', '2019-05-14 10:28:54', 0, 0, 0, 0, '2019-05-14 10:25:40', '2019-05-14 10:28:39');
INSERT INTO `remark` VALUES (10, 210, 99, 'aaa', '2019-05-15 00:00:12', 0, 0, 0, 0, '2019-05-15 00:00:14', '2019-05-15 00:00:14');
INSERT INTO `remark` VALUES (11, 210, 99, 'aa', '2019-05-15 00:03:59', 0, 0, 0, 0, '2019-05-15 00:03:59', '2019-05-15 00:03:59');
INSERT INTO `remark` VALUES (12, 210, 99, 'aaaaaa', '2019-05-15 00:04:13', 0, 0, 0, 0, '2019-05-15 00:04:13', '2019-05-15 00:04:13');
INSERT INTO `remark` VALUES (13, 210, 99, 'sasas', '2019-05-15 00:06:40', 0, 0, 0, 0, '2019-05-15 00:06:41', '2019-05-15 00:06:41');

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
) ENGINE = InnoDB AUTO_INCREMENT = 461 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (0, '系统账号', '未设置', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', 'fff', '系统账号', '5ba192771ba0468ca785e51a1cedffaf.jpg', 'd4d63b2a383c47fbb8a6a2a744ad3282.jpg', '', '离线', 0, '2019-05-09 15:52:49', '2019-05-13 21:37:57');
INSERT INTO `user` VALUES (210, 'test5@qq.com', '未设置', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', '<a href=\"https://vuejs.org/images/logo.png\" download=\"2017.png\">下载 vue 的 LOGO</a>', 'test5', '16c80bc4e99040d88f2ff9c5efe83da5.png', 'cb78151bba9142c5a67f87badaeef9d6.jpg', '', '离线', 0, '2019-05-09 16:09:50', '2019-05-14 11:59:34');
INSERT INTO `user` VALUES (421, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 17:16:25', '2019-05-13 17:16:25');
INSERT INTO `user` VALUES (422, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 17:22:14', '2019-05-13 17:22:14');
INSERT INTO `user` VALUES (423, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 17:23:38', '2019-05-13 17:23:38');
INSERT INTO `user` VALUES (424, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 17:26:25', '2019-05-13 17:26:25');
INSERT INTO `user` VALUES (425, 'test2@qq.com', '未设置', '', 'Ftek/KdELdo62TyacmWX5A==', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', 'test2@qq.com', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 17:30:18', '2019-05-13 17:30:18');
INSERT INTO `user` VALUES (426, '', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', 'testasdf中文', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 18:38:38', '2019-05-13 18:38:38');
INSERT INTO `user` VALUES (427, '', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', 'testasdf中文', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 18:39:01', '2019-05-13 18:39:01');
INSERT INTO `user` VALUES (428, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 23:04:54', '2019-05-13 23:04:54');
INSERT INTO `user` VALUES (429, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 23:05:29', '2019-05-13 23:05:29');
INSERT INTO `user` VALUES (430, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 23:13:17', '2019-05-13 23:13:17');
INSERT INTO `user` VALUES (431, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-13 23:17:59', '2019-05-13 23:17:59');
INSERT INTO `user` VALUES (432, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 15:39:27', '2019-05-14 15:39:27');
INSERT INTO `user` VALUES (433, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 15:39:34', '2019-05-14 15:39:34');
INSERT INTO `user` VALUES (434, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 15:39:41', '2019-05-14 15:39:41');
INSERT INTO `user` VALUES (435, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 15:39:46', '2019-05-14 15:39:46');
INSERT INTO `user` VALUES (436, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 15:40:12', '2019-05-14 15:40:12');
INSERT INTO `user` VALUES (437, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 15:41:10', '2019-05-14 15:41:10');
INSERT INTO `user` VALUES (438, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 16:29:19', '2019-05-14 16:29:19');
INSERT INTO `user` VALUES (439, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 16:30:49', '2019-05-14 16:30:49');
INSERT INTO `user` VALUES (440, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 16:34:36', '2019-05-14 16:34:36');
INSERT INTO `user` VALUES (441, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 16:36:06', '2019-05-14 16:36:06');
INSERT INTO `user` VALUES (442, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 16:38:04', '2019-05-14 16:38:04');
INSERT INTO `user` VALUES (443, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 16:39:42', '2019-05-14 16:39:42');
INSERT INTO `user` VALUES (444, 'visitor@wechat.com', '未设置', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 16:40:21', '2019-05-14 16:40:21');
INSERT INTO `user` VALUES (445, 'visitor@wechat.com', 'b4fb0ee970d94129b28b88e33b1c0f5d', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 17:10:33', '2019-05-14 17:10:33');
INSERT INTO `user` VALUES (446, 'visitor@wechat.com', '52ad20c705e0426aa8d37e8b43169af1', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 17:26:43', '2019-05-14 17:26:43');
INSERT INTO `user` VALUES (447, 'visitor@wechat.com', '87a07966ae504ca7960e665e33a06720', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 17:58:43', '2019-05-14 17:58:43');
INSERT INTO `user` VALUES (448, 'visitor@wechat.com', '681c1dbbd3244b71962ebae02884308c', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 20:35:32', '2019-05-14 20:35:32');
INSERT INTO `user` VALUES (449, 'visitor@wechat.com', '56ad3feca2c743a2ba5c8830328a462f', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 21:05:25', '2019-05-14 21:05:25');
INSERT INTO `user` VALUES (450, 'visitor@wechat.com', 'b855cb5b0ba54744bd17e2e738545b46', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 21:15:43', '2019-05-14 21:15:43');
INSERT INTO `user` VALUES (451, 'visitor@wechat.com', '5cbc74421e914c13b05bdd9fb72c2c88', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 21:33:53', '2019-05-14 21:33:53');
INSERT INTO `user` VALUES (452, 'visitor@wechat.com', '020090d1e7ba458d8a6640d20a15bc55', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 21:50:00', '2019-05-14 21:50:00');
INSERT INTO `user` VALUES (453, 'visitor@wechat.com', '9659bd64a6fa4eebb3b07d5eaffbc895', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 22:02:07', '2019-05-14 22:02:07');
INSERT INTO `user` VALUES (454, 'visitor@wechat.com', 'c3c13ffca5704f489640573e3edf44c3', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 22:02:07', '2019-05-14 22:02:07');
INSERT INTO `user` VALUES (455, 'visitor@wechat.com', 'd8adc457b7b2405fa8328461131665a9', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 22:11:28', '2019-05-14 22:11:28');
INSERT INTO `user` VALUES (456, 'visitor@wechat.com', 'f4fae62cd18d438fa937fadb03e84802', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 22:20:51', '2019-05-14 22:20:51');
INSERT INTO `user` VALUES (457, 'visitor@wechat.com', '0524e9763034442984cc8dd18d10e2e9', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 22:29:26', '2019-05-14 22:29:26');
INSERT INTO `user` VALUES (458, 'visitor@wechat.com', '35aebb68e7f542c883ef2546cd243113', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 23:14:29', '2019-05-14 23:14:29');
INSERT INTO `user` VALUES (459, 'visitor@wechat.com', 'fc4a948e30a14be58dab260b3efd7fbe', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 23:28:08', '2019-05-14 23:28:08');
INSERT INTO `user` VALUES (460, 'visitor@wechat.com', '4e7c436009cc4ba7887308fe1199b9b7', '', '1234', '未设置', '大家好，我是练习时长两年半的个人练习生,喜欢唱、跳、rap、篮球', '游客', 'user_photo.jpg', '', '', '离线', 0, '2019-05-14 23:34:31', '2019-05-14 23:34:31');

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
