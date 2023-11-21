-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: neatlogicos
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `captcha`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `captcha` (
  `session_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录session_id',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '验证码',
  `expired_time` timestamp NULL DEFAULT NULL COMMENT '超时时间点',
  PRIMARY KEY (`session_id`) USING BTREE,
  KEY `idx_expired_time` (`expired_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='登录验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha`
--

/*!40000 ALTER TABLE `captcha` DISABLE KEYS */;
/*!40000 ALTER TABLE `captcha` ENABLE KEYS */;

--
-- Table structure for table `changelog_audit`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changelog_audit` (
  `version` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本',
  `tenant_uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户uuid,主库是0',
  `module_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块id',
  `sql_hash` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sql hash,防止重跑',
  `sql_status` tinyint(1) DEFAULT '1' COMMENT 'sql执行状态',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '异常信息',
  `ignored` tinyint(1) DEFAULT '0' COMMENT '是否忽略，0:不忽略，1:已忽略，默认不忽略',
  `lcd` timestamp(3) NULL DEFAULT NULL COMMENT '执行时间',
  PRIMARY KEY (`tenant_uuid`,`module_id`,`version`,`sql_hash`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changelog_audit`
--

/*!40000 ALTER TABLE `changelog_audit` DISABLE KEYS */;
INSERT INTO `changelog_audit` VALUES ('2023-10-23','demo','deploy','01f9f91a41037f1ced17bb8e05649c79',0,'  ✖demo·deploy.2023-10-23·neatlogic_tenant.sql: Error executing: ALTER TABLE `deploy_app_env_auto_config` ADD COLUMN `type` enum(\'text\',\'password\') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT \'text\' COMMENT \'变量类型\' AFTER `key`\n.  Cause: java.sql.SQLSyntaxErrorException: Duplicate column name \'type\'\n',1,'2023-11-10 02:32:44.000');
/*!40000 ALTER TABLE `changelog_audit` ENABLE KEYS */;

--
-- Table structure for table `changelog_audit_detail`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changelog_audit_detail` (
  `hash` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sql 哈希值',
  `sql` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'sql ',
  PRIMARY KEY (`hash`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changelog_audit_detail`
--

/*!40000 ALTER TABLE `changelog_audit_detail` DISABLE KEYS */;
INSERT INTO `changelog_audit_detail` VALUES ('01f9f91a41037f1ced17bb8e05649c79','ALTER TABLE `deploy_app_env_auto_config` ADD COLUMN `type` enum(\'text\',\'password\') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT \'text\' COMMENT \'变量类型\' AFTER `key`;');
/*!40000 ALTER TABLE `changelog_audit_detail` ENABLE KEYS */;

--
-- Table structure for table `datasource`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `datasource` (
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `tenant_uuid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '租户uuid',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据源url',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
  `driver` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据库驱动',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主机ip',
  `port` int DEFAULT NULL COMMENT '端口',
  PRIMARY KEY (`tenant_id`) USING BTREE,
  UNIQUE KEY `uk_tenant_uuid` (`tenant_uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='数据源';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datasource`
--

/*!40000 ALTER TABLE `datasource` DISABLE KEYS */;
INSERT INTO `datasource` VALUES (1,'demo','jdbc:mysql://{host}:{port}/{dbname}?characterEncoding=UTF-8&jdbcCompliantTruncation=false&allowMultiQueries=true&useSSL=false&&serverTimeZone=Asia/Shanghai','root','neatlogic@901','com.mysql.cj.jdbc.Driver','127.0.0.1',3306);
/*!40000 ALTER TABLE `datasource` ENABLE KEYS */;

--
-- Table structure for table `documentonline_config`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentonline_config` (
  `file_path` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档路径',
  `module_group` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块组标识',
  `menu` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单路由',
  `anchor_point` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '锚点',
  PRIMARY KEY (`file_path`,`module_group`,`menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentonline_config`
--

/*!40000 ALTER TABLE `documentonline_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `documentonline_config` ENABLE KEYS */;

--
-- Table structure for table `master_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_user` (
  `uuid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pinyin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `role` enum('','MASTER_ADMIN','MASTER_MANAGER') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_email_active` tinyint(1) DEFAULT NULL,
  `active_email_time` timestamp(3) NULL DEFAULT NULL COMMENT '激活邮件发送时间',
  `fcd` timestamp(3) NULL DEFAULT NULL COMMENT '创建时间',
  `email_send_count` int DEFAULT '0' COMMENT '邮件发送次数',
  `is_subscribe` tinyint DEFAULT '1' COMMENT '是否订阅',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_user`
--

/*!40000 ALTER TABLE `master_user` DISABLE KEYS */;
INSERT INTO `master_user` VALUES ('111','admin','管理员','admin',NULL,NULL,1,NULL,0,NULL,'2023-09-07 09:28:57.000',0,1);
/*!40000 ALTER TABLE `master_user` ENABLE KEYS */;

--
-- Table structure for table `master_user_password`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_user_password` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_uuid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户密码',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `is_active` tinyint(1) DEFAULT NULL COMMENT '有效性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_user_password`
--

/*!40000 ALTER TABLE `master_user_password` DISABLE KEYS */;
INSERT INTO `master_user_password` VALUES (111,'111','admin','{MD5}e10adc3949ba59abbe56e057f20f883e',NULL,1);
/*!40000 ALTER TABLE `master_user_password` ENABLE KEYS */;

--
-- Table structure for table `master_user_session`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_user_session` (
  `user_uuid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `visit_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_uuid`) USING HASH
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_user_session`
--

/*!40000 ALTER TABLE `master_user_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_user_session` ENABLE KEYS */;

--
-- Table structure for table `mongodb`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mongodb` (
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `tenant_uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户uuid',
  `database` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据库名称',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码',
  `host` varchar(1025) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '主机ip',
  `option` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '选择项',
  `auth_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '存放租户管理用于认证的信息',
  PRIMARY KEY (`tenant_id`) USING BTREE,
  UNIQUE KEY `uk_tenant_uuid` (`tenant_uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='mogodb数据库信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mongodb`
--

/*!40000 ALTER TABLE `mongodb` DISABLE KEYS */;
INSERT INTO `mongodb` VALUES (1,'demo','autoexec','autoexec','mongodbPwd','127.0.0.1:27017','authSource=autoexec',NULL);
/*!40000 ALTER TABLE `mongodb` ENABLE KEYS */;

--
-- Table structure for table `server_counter`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_counter` (
  `from_server_id` int NOT NULL COMMENT '发送服务器id',
  `to_server_id` int NOT NULL COMMENT '目标服务器id',
  `counter` int NOT NULL COMMENT '计数器',
  PRIMARY KEY (`from_server_id`,`to_server_id`) USING HASH
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='服务器计数统计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_counter`
--

/*!40000 ALTER TABLE `server_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `server_counter` ENABLE KEYS */;

--
-- Table structure for table `server_status`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_status` (
  `host` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '服务器ip地址',
  `server_id` int NOT NULL COMMENT 'config.properties文件的schedule.server.id',
  `status` enum('startup','stop') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'startup' COMMENT '服务器状态，启动或停机',
  `heartbeat_rate` int DEFAULT NULL COMMENT '心跳频率（分钟）',
  `heartbeat_threshold` int DEFAULT NULL COMMENT '心跳阈值',
  `heartbeat_time` timestamp(3) NULL DEFAULT NULL COMMENT '心跳时间',
  `fcu` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `fcd` timestamp(3) NULL DEFAULT NULL COMMENT '创建时间',
  `lcu` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `lcd` timestamp(3) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`server_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='服务器状态';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_status`
--

/*!40000 ALTER TABLE `server_status` DISABLE KEYS */;
INSERT INTO `server_status` VALUES ('http://192.168.0.104:8282',1,'startup',3,5,'2023-09-07 09:28:57.937','system','2023-09-07 09:28:57.937','system','2023-09-07 09:28:57.937'),('http://192.168.0.97:8282',97,'startup',3,5,'2023-09-07 09:28:57.944','system','2023-09-07 09:28:57.944','system','2023-09-07 09:28:57.944'),(NULL,168,'startup',3,5,'2023-11-10 02:33:18.566','system','2023-11-10 02:33:18.566',NULL,NULL),(NULL,8341,'startup',3,5,'2023-09-07 09:28:57.949','system','2023-09-07 09:28:57.949','system','2023-09-07 09:28:57.949');
/*!40000 ALTER TABLE `server_status` ENABLE KEYS */;

--
-- Table structure for table `tenant`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant` (
  `id` bigint NOT NULL COMMENT 'id',
  `uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'uuid',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '租户名',
  `is_active` tinyint(1) DEFAULT '1' COMMENT '1:启用，0:禁用',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '租户状态',
  `expire_date` timestamp(3) NULL DEFAULT NULL COMMENT '有效期',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '创建租户异常',
  `is_need_demo` tinyint(1) DEFAULT NULL COMMENT '创建租户是否携带demo数据',
  `visit_time` timestamp(3) NULL DEFAULT NULL COMMENT '租户当天第一次访问时间',
  `fcd` timestamp(3) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_uuid` (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant`
--

/*!40000 ALTER TABLE `tenant` DISABLE KEYS */;
INSERT INTO `tenant` VALUES (1,'demo','demo',1,NULL,NULL,NULL,NULL,NULL,'2023-09-07 09:28:58.000',NULL);
/*!40000 ALTER TABLE `tenant` ENABLE KEYS */;

--
-- Table structure for table `tenant_audit`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_audit` (
  `id` bigint NOT NULL COMMENT '自增id',
  `group_id` bigint DEFAULT NULL COMMENT '分组id',
  `tenant_uuid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户uuid',
  `module_group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模块组',
  `module_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块id',
  `start_time` timestamp(3) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp(3) NULL DEFAULT NULL COMMENT '结束时间',
  `result_hash` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'result_hash',
  `error_hash` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'error_hash',
  `status` enum('doing','done') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `sql_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户审计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_audit`
--

/*!40000 ALTER TABLE `tenant_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_audit` ENABLE KEYS */;

--
-- Table structure for table `tenant_audit_detail`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_audit_detail` (
  `hash` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'hash码',
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '内容',
  PRIMARY KEY (`hash`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户审计详细信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_audit_detail`
--

/*!40000 ALTER TABLE `tenant_audit_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_audit_detail` ENABLE KEYS */;

--
-- Table structure for table `tenant_module`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_module` (
  `tenant_uuid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户uuid',
  `module_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块id',
  `ddl_status` tinyint(1) DEFAULT '0' COMMENT 'ddl执行状态,1:成功 0:未开始 -1 :失败',
  `dml_status` tinyint(1) DEFAULT '0' COMMENT 'dml执行状态,1:成功 0:未开始 -1:失败',
  `version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版本',
  `fcd` timestamp(3) NULL DEFAULT NULL COMMENT '添加日期',
  `lcd` timestamp(3) NULL DEFAULT NULL COMMENT '更新日期',
  PRIMARY KEY (`tenant_uuid`,`module_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_module`
--

/*!40000 ALTER TABLE `tenant_module` DISABLE KEYS */;
INSERT INTO `tenant_module` VALUES ('demo','autoexec',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','change',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','cmdb',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','codehub',0,0,'2023-11-09','2023-11-10 02:30:14.000','2023-11-10 02:30:14.000'),('demo','dashboard',0,0,'2023-11-09','2023-11-10 02:30:14.000','2023-11-10 02:30:14.000'),('demo','deploy',0,0,'2023-10-23','2023-11-10 02:30:13.000','2023-11-10 02:33:09.000'),('demo','diagram',0,0,'2023-11-09','2023-11-10 02:30:14.000','2023-11-10 02:30:14.000'),('demo','dr',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','event',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','framework',0,0,'2023-10-11-01','2023-11-10 02:30:14.000','2023-11-10 02:33:09.000'),('demo','inspect',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','knowledge',0,0,'2023-11-09','2023-11-10 02:30:14.000','2023-11-10 02:30:14.000'),('demo','master',0,0,'2023-11-09','2023-11-10 02:30:14.000','2023-11-10 02:30:14.000'),('demo','pbc',0,0,'2023-11-09','2023-11-10 02:30:14.000','2023-11-10 02:30:14.000'),('demo','process',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','rdm',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','report',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000'),('demo','tagent',0,0,'2023-11-09','2023-11-10 02:30:14.000','2023-11-10 02:30:14.000'),('demo','tenant',0,0,'2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000');
/*!40000 ALTER TABLE `tenant_module` ENABLE KEYS */;

--
-- Table structure for table `tenant_module_dmlsql`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_module_dmlsql` (
  `tenant_uuid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户uuid',
  `module_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块id',
  `sql_uuid` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sql md5',
  `sql_status` tinyint(1) DEFAULT NULL COMMENT 'sql执行状态,1:已执行',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '类型',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '错误原因',
  `fcd` timestamp(3) NULL DEFAULT NULL COMMENT '执行时间',
  PRIMARY KEY (`tenant_uuid`,`module_id`,`sql_uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_module_dmlsql`
--

/*!40000 ALTER TABLE `tenant_module_dmlsql` DISABLE KEYS */;
INSERT INTO `tenant_module_dmlsql` VALUES ('demo','autoexec','038d51270b71e5eae9478c3b39ae4a23',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','086287af2952394bba5daaa350606aa0',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','0be6c9c79a87f45a26e3b8c3817e6144',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','0e575c05df25066a6f3f7097d415f64c',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','117f8221e136a4531cb16c2054a50932',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','138ff53b63d6cafcd75fe5cb658fffe2',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','173a6cc3418df151cdedd53b15c34ec0',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','1a24b2b4be26a0520fa20fd675983500',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','2531463e9f87e92064455077bd868b71',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','27f10652528ec8eed27dd9f2f23b2376',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','2943284b17dd38001093c8f3afd540fe',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','29b089228795445f0838a7034dc952ec',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','2bd7f6695052665eaa614ea38de6bbac',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','2cf912263e9dc6544f2e0b3233cf577e',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','30ff1406dcedfe7c546e7409b02150c9',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','3368f2f05d7519e5d48da0d5d75fa3c7',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','337816d886703d85733efa722b4b13b4',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','366ad27514e5254319c6a49d92da468d',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','37c1c09e79b2d33271eb435b45fca7d8',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','3abadd95160f35082987d15407f25751',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','3ea3c113a59bdca3c5aa93d56ae60e1f',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','3f210cd1c1de883e1f5c6800d9de48f6',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','489acd48eb268a5e2339aad427ce8138',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','4d8de83fa2d58ced8353e9d159688542',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','4e9170afaf27f713ea4236a148f42833',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','5489444a8503768db52edabbef39b061',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','548a08bdd66f1964a734ac0ac15eae85',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','568e4f6860651f54f3128a7beeddac8c',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','57c6a5f9b53ca96c948c022f85fd1b8b',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','5c5dd9144b33b657cf0e37ab4a0b43b2',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','5c8f55d8a90e3e321b0aa5655c329adb',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','5ef18d1b0c2b94a53c1598fcc6009131',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','614ffd6e6f0c5f0a6612cceeca63c4c2',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','688a876f84e4420dd4d02b6c90c40b7c',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','6945a9d5f286161b87a4e144d296d39d',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','699defc59169e3c38690c45d89abb2b7',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','6f688f7bec8ad0f8798b7e45b2139c8a',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','6fc59ffacc5e8ffbbc66886a32316529',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','70ffb97336a7b776e4207b25e725ef62',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','794aab3060f092dd3386f92138895a87',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','7a25f67495c13e645208f157e4638d6a',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','7f2b7ac97a108eb34b3ab6f58d6b1435',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','8265284f0464fd3cffd59bb0a6b62a18',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','846a1dd12455552c841f997cddc01f3a',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','9256037520d0c44a79d2ac6a0abb36d1',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','950f3cc2319ce46141aff43f66c35a9e',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','99289859eda11b3cc6c4a3a943df4b3b',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','9958df72d96f22ba859ddaa8c57de9cf',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','9eb31a9d03ea2bcff835908c840992f7',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','9fcfda137705330ea0fafd5bac8c436f',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','a3c848f35b3054eff4df4851fb97d3cc',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','a59ff1ea5fa4b0157ef88b413b0af429',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','a9edb39911b8503bb87c804bdae25ecd',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','ac259d15980150bb1bec4adb2e2787b9',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','b22aac0fffe29db2856108dc93b87bce',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','b5547c723434a083a72ef62e663b10b1',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','b8801d04031cee6276a9a2ab0d9fe178',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','bafeee295ae9e7047cbef0aa1d6d7259',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','bb548521e416b41b6100fc423444c1bb',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','c01a102d782e9a434c4d34cf69d1c80c',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','c0588e9c788e1d1f8723a342fcaf6f9f',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','c0f5c397b3ae93f7ae2645fa45393758',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','c2785f2ee631f1fbf816c77254e3df39',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','c52d8d167224a7a0bdb09bb9c044c070',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','cc14f3364652fcf92e206631eb38b439',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','cf8775a18e6054792cbef38051a91c13',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','d0af66226f929ac3abad3e3f35ddff51',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','dbbaf5f64a0eeb411e20d32771b58961',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','dd7630b53173251445b2aa472c937ffc',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','e0b3d50e7d17445700828cf58f3640f5',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','e57646f4a5528780c9518dc4a1ddc0e1',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','autoexec','e90191859100fc0dcd9336bd0e995e89',1,'sqlscript·dml',NULL,'2023-11-10 02:33:11.000'),('demo','autoexec','ec2c4984233bebd22f5391da47bc0603',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','f2bb30f96be7c06cb8f1917f172a57ce',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','autoexec','f55491f57410557264aac04492c0232c',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','cmdb','0b964978ad69ad17ed4c3170c07988e4',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','0e537ccb7cef726f737e1a69dceb7d01',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','13a44b409b89b049827a560693b7aafb',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','cmdb','1874d684120f2c0c2518134c2d50ec66',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','1a74b078ef99659c95eb22e86eb2a613',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','35e3051f6cc5eca647e2eb67878cb436',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','3b25c5872999d6316335c6ce9297e691',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','4d8de83fa2d58ced8353e9d159688542',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','cmdb','53dc745f64c1c872347421bf4781b76c',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','5692c65120b8817aa6bdf30ee0ef1dbb',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','6c2ff72755ac09ed47d98e44ee964780',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','8134af2e5f99b68e8223dfe28fd427b3',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','8908ea275a59c06e09b9b2877ff38976',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','909bf29d7429ac469851c3d39f4c2c63',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','94447f8ad45b7e2031af63b6ce0b4e28',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','cmdb','9e45c25f79989fcfdbf9545c3fa7c86e',1,'sqlscript·dml',NULL,'2023-11-10 02:33:12.000'),('demo','cmdb','abf570451a176b1862cc32d5cae6f8ac',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','b83254f4f4722e97140dcefe5cba97af',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','c36d97e73e1f169b1b1de83be291c5ae',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','d14c7809bcd002798b72bbbd262121b2',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','d6b711c71643d36640d65ad1e7ec6ea9',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','d926eb9c558c7b254129a430db068620',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','da371b1c165c1f4962c7403e3b1aa517',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','de27cc0d0475191bca7a45db485591c7',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','cmdb','e9f51a547a37d950ba3144c1198bec10',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','deploy','12a9cac793987de1b9cfb7aabcbc5b28',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','deploy','3972c707e22dc125ed3c5d18db888061',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','deploy','448f1bf308194b5ae8dada4b48fb11ac',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','deploy','5a2ff51919d22ce6ce81e6a3e2a03624',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','deploy','5dbd1ff557c57353b93ce641b6716a70',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','deploy','69da3f76f2f464263f7f531f99c2710e',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','deploy','6e95e11ba87d3902d97efae414c98ddb',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','deploy','801a13d6d4fb0abc0248d1d5431fccfb',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','deploy','8080e6871058b687d7c93294768264d4',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','deploy','c1c2d9462902fb6a13b23911412dafa6',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','deploy','df3c91d3ec45a97bfa0d987e0fe0a041',1,'sqlscript·dml',NULL,'2023-11-10 02:33:13.000'),('demo','deploy','e3432933f2fb0a92ea10da503c9f37eb',1,'sqlscript·dml',NULL,'2023-11-10 02:33:14.000'),('demo','process','0d2d383625c7b705556b8af6c6451c0b',1,'sqlscript·dml',NULL,'2023-11-10 02:33:09.000'),('demo','process','2d23062a97dd367c73fa2cd3d69a020b',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','process','4d8de83fa2d58ced8353e9d159688542',1,'sqlscript·dml',NULL,'2023-11-10 02:33:09.000'),('demo','process','4deac8341bb6da458e81fbaaa3b6cd3f',1,'sqlscript·dml',NULL,'2023-11-10 02:33:09.000'),('demo','process','623145e1da54f3c66f9422f5b9bd1759',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','process','6b43c7f4cb14e3c8c444af5d068416a6',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','process','98077b19723f0d6df9ba7eaf13088fac',1,'sqlscript·dml',NULL,'2023-11-10 02:33:09.000'),('demo','process','abbd4967768ad751e869f951ae780120',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','process','bfb15cc9a564c272b8a4605baa57dd03',1,'sqlscript·dml',NULL,'2023-11-10 02:33:10.000'),('demo','process','c25890ac99663ce244bee170caac21ea',1,'sqlscript·dml',NULL,'2023-11-10 02:33:09.000'),('demo','process','f2bb30f96be7c06cb8f1917f172a57ce',1,'sqlscript·dml',NULL,'2023-11-10 02:33:09.000'),('demo','process','f55491f57410557264aac04492c0232c',1,'sqlscript·dml',NULL,'2023-11-10 02:33:09.000'),('demo','process','f8b17e1d0006a3719ba97adc79924e1c',1,'sqlscript·dml',NULL,'2023-11-10 02:33:09.000');
/*!40000 ALTER TABLE `tenant_module_dmlsql` ENABLE KEYS */;

--
-- Table structure for table `tenant_module_dmlsql_detail`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_module_dmlsql_detail` (
  `hash` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'sql 唯一标识hash',
  `sql` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'sql 语句',
  PRIMARY KEY (`hash`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_module_dmlsql_detail`
--

/*!40000 ALTER TABLE `tenant_module_dmlsql_detail` DISABLE KEYS */;
INSERT INTO `tenant_module_dmlsql_detail` VALUES ('038d51270b71e5eae9478c3b39ae4a23','INSERT ignore INTO `autoexec_type_authority` VALUES (4, \'review\', \'common\', 0x616C6C75736572);'),('086287af2952394bba5daaa350606aa0','INSERT ignore INTO `autoexec_type_authority` VALUES (5, \'add\', \'common\', 0x616C6C75736572);'),('0b964978ad69ad17ed4c3170c07988e4','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_appmodule\',\'应用模块场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.025\',479610550624256,\'{\\\"fieldMappingList\\\":[{\\\"field\\\":\\\"'),('0be6c9c79a87f45a26e3b8c3817e6144','INSERT ignore INTO `autoexec_type_authority` VALUES (650702242193408, \'review\', \'common\', 0x616C6C75736572);'),('0d2d383625c7b705556b8af6c6451c0b','-- Records of process_workcenter'),('0e537ccb7cef726f737e1a69dceb7d01','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_ipobject_env_appmodule\',\'IP软硬件环境和模块场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.229\',442011534499840,\'{\\\"fieldMappingLi'),('0e575c05df25066a6f3f7097d415f64c','INSERT ignore INTO `autoexec_type` VALUES (477319286235136, \'BASIC\', \'基础工具\', \'2021-10-20 13:48:13.780\', \'fccf704231734072a1bf80d90b2d1de2\', \'custom\');'),('117f8221e136a4531cb16c2054a50932','INSERT ignore INTO `autoexec_type_authority` VALUES (2, \'review\', \'common\', 0x616C6C75736572);'),('12a9cac793987de1b9cfb7aabcbc5b28','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (11,1);'),('138ff53b63d6cafcd75fe5cb658fffe2','INSERT ignore INTO `autoexec_type` VALUES (681687327449088, \'START_STOP\', \'服务启动停止\', \'2022-07-29 13:11:02.169\', \'c8dea216f5bd49349db05cbc87db2f9a\', NULL);'),('13a44b409b89b049827a560693b7aafb','-- Records of cmdb_resourcecenter_entity'),('173a6cc3418df151cdedd53b15c34ec0','INSERT ignore INTO `autoexec_type_authority` VALUES (681687327449088, \'\', \'common\', 0x616C6C75736572);'),('1874d684120f2c0c2518134c2d50ec66','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_ipobject_detail\',\'资产清单视图\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.218\',442011534499840,\'{\\\"fieldMappingList\\\":[{\\\"fiel'),('1a24b2b4be26a0520fa20fd675983500','INSERT ignore INTO `autoexec_type_authority` VALUES (6, \'add\', \'common\', 0x616C6C75736572);'),('1a74b078ef99659c95eb22e86eb2a613','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_env\',\'环境视图\',\'ready\',\'\',NULL,\'2023-08-22 20:01:13.913\',479551469658112,\'{\\\"fieldMappingList\\\":[{\\\"field\\\":\\\"id\\\",\\\"f'),('2531463e9f87e92064455077bd868b71','INSERT ignore INTO `autoexec_type_authority` VALUES (705753186836480, \'\', \'common\', 0x616C6C75736572);'),('27f10652528ec8eed27dd9f2f23b2376','INSERT ignore INTO `autoexec_type_authority` VALUES (12, \'review\', \'common\', 0x616C6C75736572);'),('2943284b17dd38001093c8f3afd540fe','INSERT ignore INTO `autoexec_type` VALUES (650702242193408, \'TEMP\', \'临时处理\', \'2022-06-16 19:09:12.444\', \'c8dea216f5bd49349db05cbc87db2f9a\', NULL);'),('29b089228795445f0838a7034dc952ec','INSERT ignore INTO `autoexec_type_authority` VALUES (1, \'review\', \'common\', 0x616C6C75736572);'),('2bd7f6695052665eaa614ea38de6bbac','INSERT ignore INTO `autoexec_type_authority` VALUES (651160662843392, \'\', \'common\', 0x616C6C75736572);'),('2cf912263e9dc6544f2e0b3233cf577e','INSERT ignore INTO `autoexec_type_authority` VALUES (650702242193408, \'\', \'common\', 0x616C6C75736572);'),('2d23062a97dd367c73fa2cd3d69a020b','INSERT ignore INTO `process_workcenter_authority` VALUES (\'doneOfMineProcessTask\', \'common\', \'alluser\');'),('30ff1406dcedfe7c546e7409b02150c9','INSERT ignore INTO `autoexec_type_authority` VALUES (13, \'add\', \'common\', 0x616C6C75736572);'),('3368f2f05d7519e5d48da0d5d75fa3c7','INSERT ignore INTO `autoexec_type_authority` VALUES (1, \'\', \'common\', 0x616C6C75736572);'),('337816d886703d85733efa722b4b13b4','INSERT ignore INTO `autoexec_type_authority` VALUES (6, \'review\', \'common\', 0x616C6C75736572);'),('35e3051f6cc5eca647e2eb67878cb436','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_state\',\'资产状态基本信息场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.376\',479550169423872,\'{\\\"fieldMappingList\\\":[{\\\"field\\\":\\\"'),('366ad27514e5254319c6a49d92da468d','INSERT ignore INTO `autoexec_type_authority` VALUES (2, \'add\', \'common\', 0x616C6C75736572);'),('37c1c09e79b2d33271eb435b45fca7d8','INSERT ignore INTO `autoexec_type_authority` VALUES (477316341833728, \'\', \'common\', 0x616C6C75736572);'),('3972c707e22dc125ed3c5d18db888061','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (477316643823616,1);'),('3abadd95160f35082987d15407f25751','INSERT ignore INTO `autoexec_type_authority` VALUES (5, \'review\', \'common\', 0x616C6C75736572);'),('3b25c5872999d6316335c6ce9297e691','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_os_softwareservice_env_appmodule\',\'操作系统与软件服务、环境、模块场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.320\',479593471418368,\'{\\'),('3ea3c113a59bdca3c5aa93d56ae60e1f','INSERT ignore INTO `autoexec_type_authority` VALUES (650702107975680, \'review\', \'common\', 0x616C6C75736572);'),('3f210cd1c1de883e1f5c6800d9de48f6','INSERT ignore INTO `autoexec_type_authority` VALUES (8, \'add\', \'common\', 0x616C6C75736572);'),('448f1bf308194b5ae8dada4b48fb11ac','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (13,1);'),('489acd48eb268a5e2339aad427ce8138','INSERT ignore INTO `autoexec_type_authority` VALUES (477317709176833, \'review\', \'common\', 0x616C6C75736572);'),('4d8de83fa2d58ced8353e9d159688542','-- ----------------------------'),('4deac8341bb6da458e81fbaaa3b6cd3f','INSERT ignore INTO `process_workcenter` VALUES (\'doneOfMineProcessTask\', \'我的已办\', \'factory\', 3, \'{\\n        \\\"handlerType\\\": \\\"simple\\\",\\n        \\\"startTimeCondition\\\": {\\n            \\\"timeRange\\\": \\\"1\\\",\\n            \\\"timeUnit\\\": \\\"year\\\"\\n        },\\n'),('4e9170afaf27f713ea4236a148f42833','INSERT ignore INTO `autoexec_type_authority` VALUES (13, \'review\', \'common\', 0x616C6C75736572);'),('53dc745f64c1c872347421bf4781b76c','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_ipobject_env_appmodule_appsystem\',\'IP软硬件环境和模块及应用场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.241\',442011534499840,\'{\\\"f'),('5489444a8503768db52edabbef39b061','INSERT ignore INTO `autoexec_type_authority` VALUES (477316643823616, \'review\', \'common\', 0x616C6C75736572);'),('548a08bdd66f1964a734ac0ac15eae85','-- Records of autoexec_type_authority'),('568e4f6860651f54f3128a7beeddac8c','INSERT ignore INTO `autoexec_type_authority` VALUES (2, \'\', \'common\', 0x616C6C75736572);'),('5692c65120b8817aa6bdf30ee0ef1dbb','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_softwareservice_ports\',\'软件服务服务端口场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.366\',478816686317568,\'{\\\"fieldMappingList\\'),('57c6a5f9b53ca96c948c022f85fd1b8b','INSERT ignore INTO `autoexec_type_authority` VALUES (705753186836480, \'review\', \'common\', 0x616C6C75736572);'),('5a2ff51919d22ce6ce81e6a3e2a03624','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (651160662843392,1);'),('5c5dd9144b33b657cf0e37ab4a0b43b2','INSERT ignore INTO `autoexec_type_authority` VALUES (477316643823616, \'\', \'common\', 0x616C6C75736572);'),('5c8f55d8a90e3e321b0aa5655c329adb','INSERT ignore INTO `autoexec_type` VALUES (651160662843392, \'NATIVE\', \'调度器内置工具\', \'2022-06-17 10:20:00.627\', \'c8dea216f5bd49349db05cbc87db2f9a\', NULL);'),('5dbd1ff557c57353b93ce641b6716a70','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (9,1);'),('5ef18d1b0c2b94a53c1598fcc6009131','INSERT ignore INTO `autoexec_type_authority` VALUES (12, \'add\', \'common\', 0x616C6C75736572);'),('614ffd6e6f0c5f0a6612cceeca63c4c2','INSERT ignore INTO `autoexec_type` VALUES (477319135240192, \'RESOURCES\', \'环境部署\', \'2021-10-20 13:47:55.312\', \'fccf704231734072a1bf80d90b2d1de2\', \'custom\');'),('623145e1da54f3c66f9422f5b9bd1759','INSERT ignore INTO `process_workcenter_authority` VALUES (\'allProcessTask\', \'common\', \'alluser\');'),('688a876f84e4420dd4d02b6c90c40b7c','INSERT ignore INTO `autoexec_type_authority` VALUES (10, \'add\', \'common\', 0x616C6C75736572);'),('6945a9d5f286161b87a4e144d296d39d','INSERT ignore INTO `autoexec_type_authority` VALUES (10, \'review\', \'common\', 0x616C6C75736572);'),('699defc59169e3c38690c45d89abb2b7','INSERT ignore INTO `autoexec_type` VALUES (705753186836480, \'INSTALL\', \'软件安装配置\', \'2022-08-31 18:05:36.908\', \'c8dea216f5bd49349db05cbc87db2f9a\', NULL);'),('69da3f76f2f464263f7f531f99c2710e','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (6,1);'),('6b43c7f4cb14e3c8c444af5d068416a6','INSERT ignore INTO `process_workcenter_authority` VALUES (\'processingOfMineProcessTask\', \'common\', \'alluser\');'),('6c2ff72755ac09ed47d98e44ee964780','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_dbinstance_detail_cluster\',\'DB实例详情及集群场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.148\',479596491317248,\'{\\\"fieldMapping'),('6e95e11ba87d3902d97efae414c98ddb','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (681687327449088,1);'),('6f688f7bec8ad0f8798b7e45b2139c8a','INSERT ignore INTO `autoexec_type` VALUES (477318548037632, \'SCAN\', \'系统扫描\', \'2021-10-20 13:46:45.640\', \'fccf704231734072a1bf80d90b2d1de2\', \'custom\');'),('6fc59ffacc5e8ffbbc66886a32316529','INSERT ignore INTO `autoexec_type_authority` VALUES (7, \'review\', \'common\', 0x616C6C75736572);'),('70ffb97336a7b776e4207b25e725ef62','INSERT ignore INTO `autoexec_type` VALUES (477317709176833, \'BACKUP\', \'备份\', \'2021-10-20 13:45:05.085\', \'fccf704231734072a1bf80d90b2d1de2\', \'custom\');'),('794aab3060f092dd3386f92138895a87','INSERT ignore INTO `autoexec_type_authority` VALUES (11, \'review\', \'common\', 0x616C6C75736572);'),('7a25f67495c13e645208f157e4638d6a','INSERT ignore INTO `autoexec_type_authority` VALUES (9, \'\', \'common\', 0x616C6C75736572);'),('7f2b7ac97a108eb34b3ab6f58d6b1435','INSERT ignore INTO `autoexec_type` VALUES (477316341833728, \'DR_SWITCH\', \'灾备切换\', \'2021-10-20 13:42:22.115\', \'fccf704231734072a1bf80d90b2d1de2\', \'custom\');'),('801a13d6d4fb0abc0248d1d5431fccfb','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (5,1);'),('8080e6871058b687d7c93294768264d4','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (477319286235136,1);'),('8134af2e5f99b68e8223dfe28fd427b3','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_os_softwareservice_env_appmodule_appsystem\',\'操作系统与软件服务、环境、模块及应用场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.334\',479593'),('8265284f0464fd3cffd59bb0a6b62a18','INSERT ignore INTO `autoexec_type_authority` VALUES (4, \'add\', \'common\', 0x616C6C75736572);'),('846a1dd12455552c841f997cddc01f3a','INSERT ignore INTO `autoexec_type_authority` VALUES (1, \'add\', \'common\', 0x616C6C75736572);'),('8908ea275a59c06e09b9b2877ff38976','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_database_ip_port_env_appmodule\',\'DB库IP端口环境和模块场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.097\',482462291255296,\'{\\\"fiel'),('909bf29d7429ac469851c3d39f4c2c63','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_appsystem_appmodule\',\'应用系统应用模块场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.075\',479609502048256,\'{\\\"fieldMappingList\\\":'),('9256037520d0c44a79d2ac6a0abb36d1','INSERT ignore INTO `autoexec_type` VALUES (477316643823616, \'SQL_FILE\', \'SQL处理\', \'2021-10-20 13:42:58.377\', \'fccf704231734072a1bf80d90b2d1de2\', \'custom\');'),('94447f8ad45b7e2031af63b6ce0b4e28','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_appinstance_env_appmodule_appsystem\',\'应用实例环境和模块及应用场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:17.991\',479603630022656,\'{\\'),('950f3cc2319ce46141aff43f66c35a9e','INSERT ignore INTO `autoexec_type` VALUES (477318304768000, \'BIZ_JOBS\', \'作业调度\', \'2021-10-20 13:46:16.276\', \'fccf704231734072a1bf80d90b2d1de2\', \'custom\');'),('98077b19723f0d6df9ba7eaf13088fac','INSERT ignore INTO `process_workcenter` VALUES (\'draftProcessTask\', \'我的草稿\', \'factory\', 4, \'{\\n        \\\"handlerType\\\": \\\"simple\\\",\\n        \\\"startTimeCondition\\\": {\\n            \\\"timeRange\\\": \\\"1\\\",\\n            \\\"timeUnit\\\": \\\"year\\\"\\n        },\\n     '),('99289859eda11b3cc6c4a3a943df4b3b','INSERT ignore INTO `autoexec_type_authority` VALUES (3, \'add\', \'common\', 0x616C6C75736572);'),('9958df72d96f22ba859ddaa8c57de9cf','INSERT ignore INTO `autoexec_type_authority` VALUES (9, \'add\', \'common\', 0x616C6C75736572);'),('9e45c25f79989fcfdbf9545c3fa7c86e','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_appinstance_detail_cluster\',\'应用实例详情及集群场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:17.962\',479603630022656,\'{\\\"fieldMappin'),('9eb31a9d03ea2bcff835908c840992f7','INSERT ignore INTO `autoexec_type_authority` VALUES (3, \'\', \'common\', 0x616C6C75736572);'),('9fcfda137705330ea0fafd5bac8c436f','INSERT ignore INTO `autoexec_type_authority` VALUES (477316341833728, \'review\', \'common\', 0x616C6C75736572);'),('a3c848f35b3054eff4df4851fb97d3cc','INSERT ignore INTO `autoexec_type_authority` VALUES (681687327449088, \'review\', \'common\', 0x616C6C75736572);'),('a59ff1ea5fa4b0157ef88b413b0af429','INSERT ignore INTO `autoexec_type_authority` VALUES (477318304768000, \'\', \'common\', 0x616C6C75736572);'),('a9edb39911b8503bb87c804bdae25ecd','INSERT ignore INTO `autoexec_type_authority` VALUES (11, \'add\', \'common\', 0x616C6C75736572);'),('abbd4967768ad751e869f951ae780120','-- Records of process_workcenter_authority'),('abf570451a176b1862cc32d5cae6f8ac','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_appmodule_appsystem\',\'模块和应用场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.046\',479610550624256,\'{\\\"fieldMappingList\\\":[{\\'),('ac259d15980150bb1bec4adb2e2787b9','INSERT ignore INTO `autoexec_type_authority` VALUES (477317977612288, \'review\', \'common\', 0x616C6C75736572);'),('b22aac0fffe29db2856108dc93b87bce','INSERT ignore INTO `autoexec_type_authority` VALUES (651160662843392, \'review\', \'common\', 0x616C6C75736572);'),('b5547c723434a083a72ef62e663b10b1','INSERT ignore INTO `autoexec_type_authority` VALUES (477319286235136, \'review\', \'common\', 0x616C6C75736572);'),('b83254f4f4722e97140dcefe5cba97af','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_osservice_ports\',\'操作系统服务端口场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.277\',479593471418368,\'{\\\"fieldMappingList\\\":[{\\\"'),('b8801d04031cee6276a9a2ab0d9fe178','INSERT ignore INTO `autoexec_type_authority` VALUES (8, \'review\', \'common\', 0x616C6C75736572);'),('bafeee295ae9e7047cbef0aa1d6d7259','INSERT ignore INTO `autoexec_type_authority` VALUES (9, \'review\', \'common\', 0x616C6C75736572);'),('bb548521e416b41b6100fc423444c1bb','INSERT ignore INTO `autoexec_type_authority` VALUES (3, \'review\', \'common\', 0x616C6C75736572);'),('bfb15cc9a564c272b8a4605baa57dd03','INSERT ignore INTO `process_workcenter_authority` VALUES (\'draftProcessTask\', \'common\', \'alluser\');'),('c01a102d782e9a434c4d34cf69d1c80c','INSERT ignore INTO `autoexec_type` VALUES (9, \'BUILD\', \'编译打包\', NULL, \'system\', \'factory\');'),('c0588e9c788e1d1f8723a342fcaf6f9f','INSERT ignore INTO `autoexec_type_authority` VALUES (650702107975680, \'\', \'common\', 0x616C6C75736572);'),('c0f5c397b3ae93f7ae2645fa45393758','INSERT ignore INTO `autoexec_type_authority` VALUES (477317977612288, \'\', \'common\', 0x616C6C75736572);'),('c1c2d9462902fb6a13b23911412dafa6','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (7,1);'),('c25890ac99663ce244bee170caac21ea','INSERT ignore INTO `process_workcenter` VALUES (\'allProcessTask\', \'所有工单\', \'factory\', 1, \'{\\n        \\\"conditionGroupList\\\": [],\\n        \\\"conditionGroupRelList\\\": [],\\n        \\\"startTimeCondition\\\": {\\n            \\\"timeRange\\\": \\\"1\\\",\\n            \\\"ti'),('c2785f2ee631f1fbf816c77254e3df39','INSERT ignore INTO `autoexec_type` VALUES (2, \'CMDB\', \'自动采集\', \'2022-12-09 15:24:05.728\', \'system\', \'factory\');'),('c36d97e73e1f169b1b1de83be291c5ae','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_softwareservice_os\',\'软件服务与操作系统场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.347\',478816686317568,\'{\\\"fieldMappingList\\\":'),('c52d8d167224a7a0bdb09bb9c044c070','-- Records of autoexec_type'),('cc14f3364652fcf92e206631eb38b439','INSERT ignore INTO `autoexec_type` VALUES (1, \'INSPECT\', \'巡检\', \'2022-12-09 15:24:05.728\', \'system\', \'factory\');'),('cf8775a18e6054792cbef38051a91c13','INSERT ignore INTO `autoexec_type_authority` VALUES (14, \'review\', \'common\', 0x616C6C75736572);'),('d0af66226f929ac3abad3e3f35ddff51','INSERT ignore INTO `autoexec_type_authority` VALUES (477317709176833, \'\', \'common\', 0x616C6C75736572);'),('d14c7809bcd002798b72bbbd262121b2','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_ipobject_ip_port\',\'IP软硬件IP和端口场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.259\',442011534499840,\'{\\\"fieldMappingList\\\":['),('d6b711c71643d36640d65ad1e7ec6ea9','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_ipobject_id\',\'IP软硬件ID场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.250\',442011534499840,\'{\\\"fieldMappingList\\\":[{\\\"field'),('d926eb9c558c7b254129a430db068620','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_os_detail_cluster\',\'操作系统详情及集群场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.307\',479593471418368,\'{\\\"fieldMappingList\\\":['),('da371b1c165c1f4962c7403e3b1aa517','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_appsystem\',\'应用系统场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.063\',479609502048256,\'{\\\"fieldMappingList\\\":[{\\\"field\\\":\\\"'),('dbbaf5f64a0eeb411e20d32771b58961','INSERT ignore INTO `autoexec_type` VALUES (477317977612288, \'DEPLOY\', \'自动发布\', \'2021-10-20 13:45:37.074\', \'fccf704231734072a1bf80d90b2d1de2\', \'custom\');'),('dd7630b53173251445b2aa472c937ffc','INSERT ignore INTO `autoexec_type_authority` VALUES (477318304768000, \'review\', \'common\', 0x616C6C75736572);'),('de27cc0d0475191bca7a45db485591c7','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_appinstance_ip_port_env_appmodule\',\'应用实例IP端口环境和模块场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.007\',479603630022656,\'{\\\"'),('df3c91d3ec45a97bfa0d987e0fe0a041','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (2,0);'),('e0b3d50e7d17445700828cf58f3640f5','INSERT ignore INTO `autoexec_type_authority` VALUES (7, \'add\', \'common\', 0x616C6C75736572);'),('e3432933f2fb0a92ea10da503c9f37eb','insert ignore into `deploy_type_status`(`type_id`,`is_active`) values (477317977612288,1);'),('e57646f4a5528780c9518dc4a1ddc0e1','INSERT ignore INTO `autoexec_type_authority` VALUES (477319286235136, \'\', \'common\', 0x616C6C75736572);'),('e90191859100fc0dcd9336bd0e995e89','INSERT ignore INTO `autoexec_type_authority` VALUES (14, \'add\', \'common\', 0x616C6C75736572);'),('e9f51a547a37d950ba3144c1198bec10','insert ignore into `cmdb_resourcecenter_entity`(`name`,`label`,`status`,`error`,`description`,`init_time`,`ci_id`,`config`) values (\'scence_vendor\',\'厂商基本信息场景\',\'ready\',\'\',NULL,\'2023-08-22 19:59:18.389\',480863598731264,\'{\\\"fieldMappingList\\\":[{\\\"field\\\":\\\"i'),('ec2c4984233bebd22f5391da47bc0603','INSERT ignore INTO `autoexec_type` VALUES (650702107975680, \'TEST\', \'测试用工具\', \'2022-12-09 15:24:05.728\', \'system\', \'factory\');'),('f2bb30f96be7c06cb8f1917f172a57ce','BEGIN;'),('f55491f57410557264aac04492c0232c','COMMIT;'),('f8b17e1d0006a3719ba97adc79924e1c','INSERT ignore INTO `process_workcenter` VALUES (\'processingOfMineProcessTask\', \'我的待办\', \'factory\', 2, \'{\\n        \\\"conditionGroupList\\\": [],\\n        \\\"conditionGroupRelList\\\": [],\\n        \\\"startTimeCondition\\\": {\\n            \\\"timeRange\\\": \\\"1\\\",\\n   ');
/*!40000 ALTER TABLE `tenant_module_dmlsql_detail` ENABLE KEYS */;

--
-- Table structure for table `tenant_modulegroup`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_modulegroup` (
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `tenant_uuid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '租户uuid',
  `module_group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模块组',
  PRIMARY KEY (`tenant_id`,`module_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='租户模块组关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_modulegroup`
--

/*!40000 ALTER TABLE `tenant_modulegroup` DISABLE KEYS */;
INSERT INTO `tenant_modulegroup` VALUES (1,'demo','autoexec'),(1,'demo','cmdb'),(1,'demo','dashboard'),(1,'demo','deploy'),(1,'demo','inspect'),(1,'demo','knowledge'),(1,'demo','pbc'),(1,'demo','process'),(1,'demo','rdm'),(1,'demo','report');
/*!40000 ALTER TABLE `tenant_modulegroup` ENABLE KEYS */;

--
-- Table structure for table `version`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `version` (
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本',
  `fcd` timestamp(3) NULL DEFAULT NULL COMMENT '创建时间',
  `lcd` timestamp(3) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`version`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='neatlogic 库版本';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES ('2023-11-09','2023-11-10 02:30:13.000','2023-11-10 02:30:13.000');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-22  4:00:02
