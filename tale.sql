/*
 Navicat Premium Data Transfer

 Source Server         : server mysql 5.6
 Source Server Type    : MySQL
 Source Server Version : 50644
 Source Host           : 207.148.106.40:3306
 Source Schema         : tale

 Target Server Type    : MySQL
 Target Server Version : 50644
 File Encoding         : 65001

 Date: 25/12/2019 22:39:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_attach
-- ----------------------------
DROP TABLE IF EXISTS `t_attach`;
CREATE TABLE `t_attach` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) COLLATE utf8_bin NOT NULL,
  `ftype` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `fkey` varchar(100) COLLATE utf8_bin NOT NULL,
  `author_id` int(10) NOT NULL,
  `created` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_comments
-- ----------------------------
DROP TABLE IF EXISTS `t_comments`;
CREATE TABLE `t_comments` (
  `coid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `created` int(10) NOT NULL,
  `author` varchar(200) COLLATE utf8_bin NOT NULL,
  `author_id` int(10) DEFAULT '0',
  `owner_id` int(10) DEFAULT '0',
  `mail` varchar(200) COLLATE utf8_bin NOT NULL,
  `url` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `ip` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `agent` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `content` text COLLATE utf8_bin NOT NULL,
  `type` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `status` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `parent` int(10) DEFAULT '0',
  PRIMARY KEY (`coid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_contents
-- ----------------------------
DROP TABLE IF EXISTS `t_contents`;
CREATE TABLE `t_contents` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_bin NOT NULL,
  `slug` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `thumb_img` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `created` int(10) NOT NULL,
  `modified` int(10) DEFAULT NULL,
  `content` text COLLATE utf8_bin,
  `author_id` int(10) NOT NULL,
  `type` varchar(16) COLLATE utf8_bin NOT NULL,
  `status` varchar(16) COLLATE utf8_bin NOT NULL,
  `fmt_type` varchar(16) COLLATE utf8_bin DEFAULT 'markdown',
  `tags` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `categories` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `hits` int(10) DEFAULT '0',
  `comments_num` int(1) DEFAULT '0',
  `allow_comment` int(1) DEFAULT '1',
  `allow_ping` int(1) DEFAULT NULL,
  `allow_feed` int(1) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cid` (`cid`),
  UNIQUE KEY `idx_u_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_contents
-- ----------------------------
BEGIN;
INSERT INTO `t_contents` VALUES (1, '关于', 'about', NULL, 1487853610, 1487872488, '### Hello World\n\n这是我的关于页面\n\n### 当然还有其他\n\n具体你来写点什么吧', 1, 'page', 'publish', 'markdown', NULL, NULL, 0, 0, 1, 1, 1);
INSERT INTO `t_contents` VALUES (2, '第一篇文章', NULL, NULL, 1487861184, 1487872798, '## Hello  World.\n\n> 第一篇文章总得写点儿什么?...\n\n----------\n\n\n<!--more-->\n\n```java\npublic static void main(String[] args){\n    System.out.println(\"Hello Tale.\");\n}\n```', 1, 'post', 'publish', 'markdown', '', '默认分类', 10, 0, 1, 1, 1);
INSERT INTO `t_contents` VALUES (3, '友情链接', 'links', NULL, 1505643727, 1505643888, '## 友情链接\nguanyanqi', 1, 'page', 'publish', 'markdown', NULL, NULL, 0, 0, 1, 1, NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_logs
-- ----------------------------
DROP TABLE IF EXISTS `t_logs`;
CREATE TABLE `t_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(100) COLLATE utf8_bin NOT NULL,
  `data` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  `author_id` int(10) NOT NULL,
  `ip` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `created` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for t_metas
-- ----------------------------
DROP TABLE IF EXISTS `t_metas`;
CREATE TABLE `t_metas` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_bin NOT NULL,
  `slug` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(32) COLLATE utf8_bin NOT NULL,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `sort` int(4) DEFAULT '0',
  `parent` int(10) DEFAULT '0',
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_metas
-- ----------------------------
BEGIN;
INSERT INTO `t_metas` VALUES (1, '默认分类', NULL, 'category', NULL, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for t_options
-- ----------------------------
DROP TABLE IF EXISTS `t_options`;
CREATE TABLE `t_options` (
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `value` text COLLATE utf8_bin,
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_options
-- ----------------------------
BEGIN;
INSERT INTO `t_options` VALUES ('allow_comment_audit', 'true', '评论需要审核');
INSERT INTO `t_options` VALUES ('allow_install', 'false', '是否允许重新安装博客');
INSERT INTO `t_options` VALUES ('site_description', '博客系统', NULL);
INSERT INTO `t_options` VALUES ('site_keywords', '博客系统', NULL);
INSERT INTO `t_options` VALUES ('site_theme', 'default', NULL);
INSERT INTO `t_options` VALUES ('site_title', '博客系统', '');
INSERT INTO `t_options` VALUES ('social_github', '', NULL);
INSERT INTO `t_options` VALUES ('social_twitter', '', NULL);
INSERT INTO `t_options` VALUES ('social_weibo', '', NULL);
INSERT INTO `t_options` VALUES ('social_zhihu', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_relationships
-- ----------------------------
DROP TABLE IF EXISTS `t_relationships`;
CREATE TABLE `t_relationships` (
  `cid` int(10) NOT NULL,
  `mid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of t_relationships
-- ----------------------------
BEGIN;
INSERT INTO `t_relationships` VALUES (2, 1);
COMMIT;

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users` (
  `uid` int(11) NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `password` varchar(64) COLLATE utf8_bin NOT NULL,
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `home_url` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `screen_name` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `created` int(10) NOT NULL,
  `activated` int(10) DEFAULT NULL,
  `logged` int(10) DEFAULT NULL,
  `group_name` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

SET FOREIGN_KEY_CHECKS = 1;
