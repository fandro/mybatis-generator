/*
 Test DataBase
 DataBase name is dbmer;

 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50713
 Source Host           : localhost
 Source Database       : dbmer

 Target Server Type    : MySQL
 Target Server Version : 50713
 File Encoding         : utf-8

 Date: 08/24/2016 18:21:34 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `biz_column`
-- ----------------------------
DROP TABLE IF EXISTS `biz_column`;
CREATE TABLE `biz_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(255) DEFAULT 'TODO 添加列名' COMMENT '列名',
  `cn_name` varchar(255) DEFAULT NULL,
  `data_type` varchar(100) DEFAULT NULL COMMENT '数据类型',
  `not_null` bit(64) DEFAULT b'0' COMMENT '是否允许为空',
  `default_value` varchar(100) DEFAULT NULL COMMENT '默认值',
  `comment` varchar(500) DEFAULT 'TODO添加列描述' COMMENT '列注释',
  `biz_database_id` int(11) DEFAULT '0' COMMENT '所属数据库id',
  `biz_table_id` int(11) DEFAULT '0' COMMENT '所属表id',
  `key_type` tinyint(255) DEFAULT '0' COMMENT '0:不是键，1：主键，2：外键',
  `ref_table_id` int(11) DEFAULT '0' COMMENT '关联表名',
  `ref_column_id` int(11) DEFAULT '0' COMMENT '关联列的id',
  `is_deprecated` bit(64) DEFAULT b'0' COMMENT '0:否，1：是。是否不推荐使用',
  `is_deleted` bit(64) DEFAULT b'1' COMMENT '0:否，1：是。该列已经从数据库中删除',
  `update_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `order_by` int(11) DEFAULT '0' COMMENT '字段显示顺序',
  PRIMARY KEY (`id`),
  KEY `fk_table` (`biz_table_id`),
  KEY `fk_column` (`ref_column_id`),
  CONSTRAINT `fk_column` FOREIGN KEY (`ref_column_id`) REFERENCES `biz_column` (`id`),
  CONSTRAINT `fk_table` FOREIGN KEY (`biz_table_id`) REFERENCES `biz_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='列信息';

-- ----------------------------
--  Table structure for `biz_database`
-- ----------------------------
DROP TABLE IF EXISTS `biz_database`;
CREATE TABLE `biz_database` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(255) DEFAULT NULL COMMENT '数据库名称',
  `cn_name` varchar(255) DEFAULT 'TODO 添加数据库中文名称' COMMENT '数据库中文名称',
  `comment` varchar(500) DEFAULT 'TODO添加数据描述' COMMENT '注释',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商业逻辑相关数据库';

-- ----------------------------
--  Table structure for `biz_module`
-- ----------------------------
DROP TABLE IF EXISTS `biz_module`;
CREATE TABLE `biz_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(255) DEFAULT '业务模块名称' COMMENT '业务模块名称',
  `comment` varchar(500) DEFAULT 'TODO业务模块说明' COMMENT '业务模块说明',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL,
  `creator_id` int(11) DEFAULT '0' COMMENT '创建者id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='业务模块';

-- ----------------------------
--  Table structure for `biz_module_table_relation`
-- ----------------------------
DROP TABLE IF EXISTS `biz_module_table_relation`;
CREATE TABLE `biz_module_table_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `biz_table_id` int(255) DEFAULT '0' COMMENT '表id',
  `biz_module_id` int(255) DEFAULT '0' COMMENT '业务模块id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_biz_module_table_relation` (`biz_table_id`),
  KEY `fk_biz_module_table_relation_1` (`biz_module_id`),
  CONSTRAINT `fk_biz_module_table_relation` FOREIGN KEY (`biz_table_id`) REFERENCES `biz_table` (`id`),
  CONSTRAINT `fk_biz_module_table_relation_1` FOREIGN KEY (`biz_module_id`) REFERENCES `biz_module` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='业务模块';

-- ----------------------------
--  Table structure for `biz_table`
-- ----------------------------
DROP TABLE IF EXISTS `biz_table`;
CREATE TABLE `biz_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(255) DEFAULT 'TODO 添加表名' COMMENT '表称',
  `cn_name` varchar(255) DEFAULT 'TODO 添加表的中文名称' COMMENT '表的中文名称',
  `comment` varchar(500) DEFAULT 'TODO添加表描述' COMMENT '注释',
  `biz_database_id` int(11) DEFAULT '0' COMMENT '所属数据库id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_biz_table` (`biz_database_id`),
  CONSTRAINT `fk_biz_table` FOREIGN KEY (`biz_database_id`) REFERENCES `biz_database` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商业逻辑相关表';

-- ----------------------------
--  Table structure for `biz_table_relation`
-- ----------------------------
DROP TABLE IF EXISTS `biz_table_relation`;
CREATE TABLE `biz_table_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `table_id` int(11) DEFAULT NULL,
  `ref_table_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_table_relation` (`table_id`),
  KEY `fk_ref_table` (`ref_table_id`),
  CONSTRAINT `fk_ref_table` FOREIGN KEY (`ref_table_id`) REFERENCES `biz_table` (`id`),
  CONSTRAINT `fk_table_relation` FOREIGN KEY (`table_id`) REFERENCES `biz_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `biz_user_module_relation`
-- ----------------------------
DROP TABLE IF EXISTS `biz_user_module_relation`;
CREATE TABLE `biz_user_module_relation` (
  `id` int(11) NOT NULL,
  `biz_user_id` int(11) DEFAULT NULL,
  `biz_module_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_biz_user_module_relation` (`biz_user_id`),
  KEY `fk_biz_user_module_relation_1` (`biz_module_id`),
  CONSTRAINT `fk_biz_user_module_relation` FOREIGN KEY (`biz_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_biz_user_module_relation_1` FOREIGN KEY (`biz_module_id`) REFERENCES `biz_module` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `pass_word` varchar(255) DEFAULT NULL COMMENT '登录密码',
  `default_database_id` int(11) DEFAULT '0' COMMENT '默认数据库id',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
