/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : phqadmin

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 24/04/2020 12:51:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `login_time` int(11) NOT NULL DEFAULT 0,
  `login_ip` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `UQE_admin_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'root', '1fc01bded8e2c31329b80241457cb47b', '[]', 1587019899, 'localhost:8181');
INSERT INTO `admin` VALUES (2, 'admin', '0b178dfde1b181b81d01ffb628f9c9bd', '[5]', 1585142529, 'localhost:8181');

-- ----------------------------
-- Table structure for api
-- ----------------------------
DROP TABLE IF EXISTS `api`;
CREATE TABLE `api`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `router` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `visit` tinyint(1) NOT NULL DEFAULT 0,
  `sign` tinyint(1) NOT NULL DEFAULT 1,
  `struct` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mapping_methods` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_show` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UQE_api_id`(`id`) USING BTREE,
  UNIQUE INDEX `UQE_api_router`(`router`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api
-- ----------------------------
INSERT INTO `api` VALUES (1, '后台登录', '_admin_api_login', '/admin/api/login', 0, 1, 'adminApi.Login', 'post:Login', 1);
INSERT INTO `api` VALUES (2, '获取管理员列表', '_admin_api_admin_list', '/admin/api/admin/list', 2, 1, 'adminApi.Admin', 'post:List', 1);
INSERT INTO `api` VALUES (3, '添加管理员', '_admin_api_admin_add', '/admin/api/admin/add', 2, 1, 'adminApi.Admin', 'post:Add', 1);
INSERT INTO `api` VALUES (4, '删除管理员', '_admin_api_admin_del', '/admin/api/admin/del', 2, 1, 'adminApi.Admin', 'post:Del', 1);
INSERT INTO `api` VALUES (5, '修改管理员', '_admin_api_admin_edit', '/admin/api/admin/edit', 2, 1, 'adminApi.Admin', 'post:Edit', 1);
INSERT INTO `api` VALUES (6, '获取管理员信息', '_admin_api_admin_info', '/admin/api/admin/info', 1, 1, 'adminApi.Admin', 'post:Info', 1);
INSERT INTO `api` VALUES (7, '管理员修改密码', '_admin_api_admin_edit_pass', '/admin/api/admin/edit/pass', 1, 1, 'adminApi.Admin', 'post:EditPass', 1);
INSERT INTO `api` VALUES (8, '获取前端导航', '_admin_api_admin_auth', '/admin/api/admin/auth', 1, 1, 'adminApi.Admin', 'post:AuthList', 1);
INSERT INTO `api` VALUES (9, '获取图标列表（分页）', '_admin_api_icon_list_paginate', '/admin/api/icon/list/:page_size/:page', 2, 1, 'adminApi.Icon', 'post:PageList', 1);
INSERT INTO `api` VALUES (10, '添加图标', '_admin_api_icon_add', '/admin/api/icon/add', 2, 1, 'adminApi.Icon', 'post:Add', 1);
INSERT INTO `api` VALUES (11, '删除图标', '_admin_api_icon_del', '/admin/api/icon/del', 2, 1, 'adminApi.Icon', 'post:Del', 1);
INSERT INTO `api` VALUES (12, '获取会员列表（分页）', '_admin_api_user_list_paginate', '/admin/api/user/list/:page_size/:page', 2, 1, 'adminApi.User', 'post:List', 1);
INSERT INTO `api` VALUES (13, '获取导航菜单列表', '_admin_api_auth_list', '/admin/api/auth/list', 3, 1, 'adminApi.Auth', 'post:List', 1);
INSERT INTO `api` VALUES (14, '添加导航菜单', '_admin_api_auth_add', '/admin/api/auth/add', 3, 1, 'adminApi.Auth', 'post:Add', 1);
INSERT INTO `api` VALUES (15, '修改导航菜单', '_admin_api_auth_edit', '/admin/api/auth/edit', 3, 1, 'adminApi.Auth', 'post:Edit', 1);
INSERT INTO `api` VALUES (16, '删除导航菜单', '_admin_api_auth_del', '/admin/api/auth/del', 3, 1, 'adminApi.Auth', 'post:Del', 1);
INSERT INTO `api` VALUES (18, '上传图片', '_admin_api_files_upload_img', '/admin/api/files/upload/img', 2, 0, 'adminApi.FileClass', 'post:UploadImage', 1);
INSERT INTO `api` VALUES (19, '添加文件分类', '_admin_api_files_add_class', '/admin/api/files/add/class', 2, 1, 'adminApi.FileClass', 'post:Add', 1);
INSERT INTO `api` VALUES (20, '修改文件分类', '_admin_api_files_edit_class', '/admin/api/files/edit/class', 2, 1, 'adminApi.FileClass', 'post:Edit', 1);
INSERT INTO `api` VALUES (21, '获取文件分类列表', '_admin_api_files_list_class', '/admin/api/files/list/class', 2, 1, 'adminApi.FileClass', 'post:List', 1);
INSERT INTO `api` VALUES (22, '删除文件分类', '_admin_api_files_del_class', '/admin/api/files/del/class', 2, 1, 'adminApi.FileClass', 'post:Del', 1);
INSERT INTO `api` VALUES (23, '获取图片列表（分页）', '_admin_api_files_list_paginate', '/admin/api/files/list/:page_size/:page', 2, 1, 'adminApi.Files', 'post:PageList', 1);
INSERT INTO `api` VALUES (24, '删除图片', '_admin_api_files_del', '/admin/api/files/del', 2, 1, 'adminApi.Files', 'post:Del', 1);
INSERT INTO `api` VALUES (25, '获取角色列表', '_admin_api_role_list', '/admin/api/role/list', 2, 1, 'adminApi.Role', 'post:List', 1);
INSERT INTO `api` VALUES (26, '获取指定权限导航列表', '_admin_api_role_auth_list', '/admin/api/role/auth-list', 2, 1, 'adminApi.Role', 'post:AuthList', 1);
INSERT INTO `api` VALUES (27, '删除角色', '_admin_api_role_del', '/admin/api/role/del', 2, 1, 'adminApi.Role', 'post:Del', 1);
INSERT INTO `api` VALUES (28, '修改角色', '_admin_api_role_edit', '/admin/api/role/edit', 2, 1, 'adminApi.Role', 'post:Edit', 1);
INSERT INTO `api` VALUES (29, '添加角色', '_admin_api_role_add', '/admin/api/role/add', 2, 1, 'adminApi.Role', 'post:Add', 1);
INSERT INTO `api` VALUES (30, '获取数据库备份列表', '_admin_api_sql_list', '/admin/api/sql/list', 2, 1, 'adminApi.Admin', 'post:ListSql', 1);
INSERT INTO `api` VALUES (31, '备份数据库', '_admin_api_sql_exprot', '/admin/api/sql/exprot', 2, 1, 'adminApi.Admin', 'post:ExportSqL', 1);
INSERT INTO `api` VALUES (32, '恢复数据库备份', '_admin_api_sql_improt', '/admin/api/sql/improt', 2, 1, 'adminApi.Admin', 'post:ImportSqL', 1);
INSERT INTO `api` VALUES (33, '删除数据库备份', '_admin_api_sql_del', '/admin/api/sql/del', 2, 1, 'adminApi.Admin', 'post:DelSqL', 1);
INSERT INTO `api` VALUES (34, '删除API接口', '_admin_api_api_del', '/admin/api/api/del', 3, 1, 'adminApi.Api', 'post:Del', 1);
INSERT INTO `api` VALUES (35, '修改API接口', '_admin_api_api_edit', '/admin/api/api/edit', 3, 1, 'adminApi.Api', 'post:Edit', 1);
INSERT INTO `api` VALUES (36, '添加API接口', '_admin_api_api_add', '/admin/api/api/add', 3, 1, 'adminApi.Api', 'post:Add', 1);
INSERT INTO `api` VALUES (37, '获取API接口列表（分页）', '_admin_api_api_list_paginate', '/admin/api/api/list/:page_size/:page', 3, 1, 'adminApi.Api', 'post:PageList', 1);
INSERT INTO `api` VALUES (38, '获取API接口列表', '_admin_api_api_list', '/admin/api/api/list', 2, 1, 'adminApi.Api', 'post:List', 1);
INSERT INTO `api` VALUES (39, '获取UI权限列表', '_admin_api_admin_ui_auth', '/admin/api/admin/ui_auth', 1, 1, 'adminApi.Admin', 'post:ActionAuthList', 1);
INSERT INTO `api` VALUES (40, '备份数据库下载', '_admin_api_sql_download', '/admin/api/sql/download', 2, 1, 'adminApi.Admin', 'post:DownloadSql', 1);

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `router` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `visit` tinyint(1) NOT NULL DEFAULT 0,
  `auth_type` tinyint(1) NOT NULL DEFAULT 0,
  `is_show` tinyint(1) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UQE_auth_id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES (3, 0, '首页', 'fa fa-home', '/index', 1, 0, 1, 3);
INSERT INTO `auth` VALUES (4, 0, '系统与安全', 'fa fa-address-card', '', 2, 0, 1, 4);
INSERT INTO `auth` VALUES (5, 0, '附件管理', 'fa fa-folder-open', '', 2, 0, 1, 5);
INSERT INTO `auth` VALUES (6, 0, '用户管理', 'fa fa-user', '', 2, 0, 1, 6);
INSERT INTO `auth` VALUES (7, 4, '管理员管理', 'fa fa-user', '/admin', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (8, 4, '角色管理', 'fa fa-address-book', '/role', 2, 0, 1, 1);
INSERT INTO `auth` VALUES (9, 4, '权限管理', 'fa fa-gears', '', 3, 0, 1, 2);
INSERT INTO `auth` VALUES (10, 5, '图标管理', 'fa fa-info-circle', '/icon', 2, 0, 1, 1);
INSERT INTO `auth` VALUES (11, 6, '会员列表', 'fa fa-users', '/user', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (17, 5, '图片管理', 'fa fa-file-image-o', '/images', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (18, 4, '数据备份恢复', 'fa fa-server', '/sql', 2, 0, 1, 3);
INSERT INTO `auth` VALUES (24, 9, '路由权限管理', 'fa fa-chain-broken', '/auth', 3, 0, 1, 0);
INSERT INTO `auth` VALUES (25, 9, '数据权限管理', 'fa fa-link', '/api', 3, 0, 1, 1);
INSERT INTO `auth` VALUES (26, 0, '找不到页面', '', '/not-find', 0, 1, 1, 0);
INSERT INTO `auth` VALUES (27, 0, '后台登录', '', '/login', 0, 1, 1, 1);
INSERT INTO `auth` VALUES (28, 0, '后台主页', '', '/', 1, 1, 1, 2);

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL DEFAULT 0,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `send_num` int(11) NULL DEFAULT 0,
  `src` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `add_time` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UQE_files_id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for files_class
-- ----------------------------
DROP TABLE IF EXISTS `files_class`;
CREATE TABLE `files_class`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UQE_files_class_id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for icon
-- ----------------------------
DROP TABLE IF EXISTS `icon`;
CREATE TABLE `icon`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UQE_icon_id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 500 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of icon
-- ----------------------------
INSERT INTO `icon` VALUES (1, NULL, 'fa fa-address-book');
INSERT INTO `icon` VALUES (2, NULL, 'fa fa-address-book-o');
INSERT INTO `icon` VALUES (3, NULL, 'fa fa-address-card');
INSERT INTO `icon` VALUES (4, NULL, 'fa fa-address-card-o');
INSERT INTO `icon` VALUES (7, NULL, 'fa fa-drivers-license');
INSERT INTO `icon` VALUES (8, NULL, 'fa fa-drivers-license-o');
INSERT INTO `icon` VALUES (10, NULL, 'fa fa-envelope-open');
INSERT INTO `icon` VALUES (11, NULL, 'fa fa-envelope-open-o');
INSERT INTO `icon` VALUES (12, NULL, 'fa fa-etsy');
INSERT INTO `icon` VALUES (13, NULL, 'fa fa-free-code-camp');
INSERT INTO `icon` VALUES (14, NULL, 'fa fa-grav');
INSERT INTO `icon` VALUES (15, NULL, 'fa fa-handshake-o');
INSERT INTO `icon` VALUES (16, NULL, 'fa fa-id-badge');
INSERT INTO `icon` VALUES (17, NULL, 'fa fa-id-card');
INSERT INTO `icon` VALUES (18, NULL, 'fa fa-id-card-o');
INSERT INTO `icon` VALUES (19, NULL, 'fa fa-imdb');
INSERT INTO `icon` VALUES (20, NULL, 'fa fa-linode');
INSERT INTO `icon` VALUES (23, NULL, 'fa fa-podcast');
INSERT INTO `icon` VALUES (24, NULL, 'fa fa-quora');
INSERT INTO `icon` VALUES (25, NULL, 'fa fa-ravelry');
INSERT INTO `icon` VALUES (29, NULL, 'fa fa-telegram');
INSERT INTO `icon` VALUES (30, NULL, 'fa fa-thermometer');
INSERT INTO `icon` VALUES (31, NULL, 'fa fa-times-rectangle');
INSERT INTO `icon` VALUES (32, NULL, 'fa fa-times-rectangle-o');
INSERT INTO `icon` VALUES (33, NULL, 'fa fa-user-circle');
INSERT INTO `icon` VALUES (34, NULL, 'fa fa-user-circle-o');
INSERT INTO `icon` VALUES (35, NULL, 'fa fa-thermometer-half');
INSERT INTO `icon` VALUES (36, NULL, 'fa fa-user-o');
INSERT INTO `icon` VALUES (37, NULL, 'fa fa-window-maximize');
INSERT INTO `icon` VALUES (38, NULL, 'fa fa-window-minimize');
INSERT INTO `icon` VALUES (39, NULL, 'fa fa-window-restore');
INSERT INTO `icon` VALUES (40, NULL, 'fa fa-wpexplorer');
INSERT INTO `icon` VALUES (41, NULL, 'fa fa-adjust');
INSERT INTO `icon` VALUES (42, NULL, 'fa fa-anchor');
INSERT INTO `icon` VALUES (43, NULL, 'fa fa-archive');
INSERT INTO `icon` VALUES (44, NULL, 'fa fa-area-chart');
INSERT INTO `icon` VALUES (53, NULL, 'fa fa-automobile');
INSERT INTO `icon` VALUES (55, NULL, 'fa fa-ban');
INSERT INTO `icon` VALUES (57, NULL, 'fa fa-bar-chart');
INSERT INTO `icon` VALUES (58, NULL, 'fa fa-barcode');
INSERT INTO `icon` VALUES (59, NULL, 'fa fa-bars');
INSERT INTO `icon` VALUES (65, NULL, 'fa fa-battery-4');
INSERT INTO `icon` VALUES (67, NULL, 'fa fa-beer');
INSERT INTO `icon` VALUES (68, NULL, 'fa fa-bell');
INSERT INTO `icon` VALUES (69, NULL, 'fa fa-bell-o');
INSERT INTO `icon` VALUES (77, NULL, 'fa fa-bluetooth-b');
INSERT INTO `icon` VALUES (78, NULL, 'fa fa-bolt');
INSERT INTO `icon` VALUES (79, NULL, 'fa fa-bomb');
INSERT INTO `icon` VALUES (80, NULL, 'fa fa-book');
INSERT INTO `icon` VALUES (81, NULL, 'fa fa-bookmark');
INSERT INTO `icon` VALUES (82, NULL, 'fa fa-bookmark-o');
INSERT INTO `icon` VALUES (83, NULL, 'fa fa-braille');
INSERT INTO `icon` VALUES (84, NULL, 'fa fa-briefcase');
INSERT INTO `icon` VALUES (85, NULL, 'fa fa-bug');
INSERT INTO `icon` VALUES (86, NULL, 'fa fa-building');
INSERT INTO `icon` VALUES (87, NULL, 'fa fa-building-o');
INSERT INTO `icon` VALUES (88, NULL, 'fa fa-bullhorn');
INSERT INTO `icon` VALUES (89, NULL, 'fa fa-bullseye');
INSERT INTO `icon` VALUES (90, NULL, 'fa fa-bus');
INSERT INTO `icon` VALUES (91, NULL, 'fa fa-cab');
INSERT INTO `icon` VALUES (92, NULL, 'fa fa-calculator');
INSERT INTO `icon` VALUES (93, NULL, 'fa fa-calendar');
INSERT INTO `icon` VALUES (94, NULL, 'fa fa-calendar-check-o');
INSERT INTO `icon` VALUES (95, NULL, 'fa fa-camera');
INSERT INTO `icon` VALUES (97, NULL, 'fa fa-car');
INSERT INTO `icon` VALUES (98, NULL, 'fa fa-caret-square-o-down');
INSERT INTO `icon` VALUES (99, NULL, 'fa fa-cart-arrow-down');
INSERT INTO `icon` VALUES (100, NULL, 'fa fa-cart-plus');
INSERT INTO `icon` VALUES (101, NULL, 'fa fa-cc');
INSERT INTO `icon` VALUES (102, NULL, 'fa fa-certificate');
INSERT INTO `icon` VALUES (103, NULL, 'fa fa-check');
INSERT INTO `icon` VALUES (104, NULL, 'fa fa-check-circle');
INSERT INTO `icon` VALUES (105, NULL, 'fa fa-check-circle-o');
INSERT INTO `icon` VALUES (106, NULL, 'fa fa-check-square');
INSERT INTO `icon` VALUES (107, NULL, 'fa fa-check-square-o');
INSERT INTO `icon` VALUES (108, NULL, 'fa fa-child');
INSERT INTO `icon` VALUES (109, NULL, 'fa fa-circle');
INSERT INTO `icon` VALUES (110, NULL, 'fa fa-circle-o');
INSERT INTO `icon` VALUES (111, NULL, 'fa fa-circle-o-notch');
INSERT INTO `icon` VALUES (112, NULL, 'fa fa-circle-thin');
INSERT INTO `icon` VALUES (113, NULL, 'fa fa-clock-o');
INSERT INTO `icon` VALUES (114, NULL, 'fa fa-clone');
INSERT INTO `icon` VALUES (115, NULL, 'fa fa-close');
INSERT INTO `icon` VALUES (116, NULL, 'fa fa-cloud');
INSERT INTO `icon` VALUES (117, NULL, 'fa fa-cloud-download');
INSERT INTO `icon` VALUES (118, NULL, 'fa fa-cloud-upload');
INSERT INTO `icon` VALUES (119, NULL, 'fa fa-code');
INSERT INTO `icon` VALUES (120, NULL, 'fa fa-code-fork');
INSERT INTO `icon` VALUES (121, NULL, 'fa fa-coffee');
INSERT INTO `icon` VALUES (122, NULL, 'fa fa-cog');
INSERT INTO `icon` VALUES (123, NULL, 'fa fa-cogs');
INSERT INTO `icon` VALUES (124, NULL, 'fa fa-comment');
INSERT INTO `icon` VALUES (125, NULL, 'fa fa-comment-o');
INSERT INTO `icon` VALUES (126, NULL, 'fa fa-commenting');
INSERT INTO `icon` VALUES (127, NULL, 'fa fa-commenting-o');
INSERT INTO `icon` VALUES (128, NULL, 'fa fa-comments');
INSERT INTO `icon` VALUES (129, NULL, 'fa fa-comments-o');
INSERT INTO `icon` VALUES (130, NULL, 'fa fa-compass');
INSERT INTO `icon` VALUES (131, NULL, 'fa fa-copyright');
INSERT INTO `icon` VALUES (132, NULL, 'fa fa-creative-commons');
INSERT INTO `icon` VALUES (133, NULL, 'fa fa-credit-card');
INSERT INTO `icon` VALUES (134, NULL, 'fa fa-credit-card-alt');
INSERT INTO `icon` VALUES (135, NULL, 'fa fa-crop');
INSERT INTO `icon` VALUES (136, NULL, 'fa fa-crosshairs');
INSERT INTO `icon` VALUES (137, NULL, 'fa fa-cube');
INSERT INTO `icon` VALUES (138, NULL, 'fa fa-cubes');
INSERT INTO `icon` VALUES (139, NULL, 'fa fa-cutlery');
INSERT INTO `icon` VALUES (140, NULL, 'fa fa-dashboard');
INSERT INTO `icon` VALUES (141, NULL, 'fa fa-database');
INSERT INTO `icon` VALUES (142, NULL, 'fa fa-deaf');
INSERT INTO `icon` VALUES (143, NULL, 'fa fa-desktop');
INSERT INTO `icon` VALUES (144, NULL, 'fa fa-diamond');
INSERT INTO `icon` VALUES (145, NULL, 'fa fa-dot-circle-o');
INSERT INTO `icon` VALUES (146, NULL, 'fa fa-download');
INSERT INTO `icon` VALUES (147, NULL, 'fa fa-edit');
INSERT INTO `icon` VALUES (148, NULL, 'fa fa-ellipsis-h');
INSERT INTO `icon` VALUES (149, NULL, 'fa fa-ellipsis-v');
INSERT INTO `icon` VALUES (150, NULL, 'fa fa-envelope');
INSERT INTO `icon` VALUES (151, NULL, 'fa fa-envelope-o');
INSERT INTO `icon` VALUES (152, NULL, 'fa fa-eraser');
INSERT INTO `icon` VALUES (153, NULL, 'fa fa-exchange');
INSERT INTO `icon` VALUES (154, NULL, 'fa fa-exclamation');
INSERT INTO `icon` VALUES (155, NULL, 'fa fa-exclamation-circle');
INSERT INTO `icon` VALUES (156, NULL, 'fa fa-exclamation-triangle');
INSERT INTO `icon` VALUES (157, NULL, 'fa fa-external-link');
INSERT INTO `icon` VALUES (158, NULL, 'fa fa-external-link-square');
INSERT INTO `icon` VALUES (159, NULL, 'fa fa-eye');
INSERT INTO `icon` VALUES (160, NULL, 'fa fa-eye-slash');
INSERT INTO `icon` VALUES (161, NULL, 'fa fa-eyedropper');
INSERT INTO `icon` VALUES (162, NULL, 'fa fa-fax');
INSERT INTO `icon` VALUES (163, NULL, 'fa fa-feed');
INSERT INTO `icon` VALUES (164, NULL, 'fa fa-female');
INSERT INTO `icon` VALUES (165, NULL, 'fa fa-fighter-jet');
INSERT INTO `icon` VALUES (166, NULL, 'fa fa-file-image-o');
INSERT INTO `icon` VALUES (167, NULL, 'fa fa-file-archive-o');
INSERT INTO `icon` VALUES (168, NULL, 'fa fa-file-audio-o');
INSERT INTO `icon` VALUES (169, NULL, 'fa fa-file-code-o');
INSERT INTO `icon` VALUES (170, NULL, 'fa fa-file-excel-o');
INSERT INTO `icon` VALUES (171, NULL, 'fa fa-file-pdf-o');
INSERT INTO `icon` VALUES (172, NULL, 'fa fa-file-movie-o');
INSERT INTO `icon` VALUES (173, NULL, 'fa fa-film');
INSERT INTO `icon` VALUES (174, NULL, 'fa fa-filter');
INSERT INTO `icon` VALUES (175, NULL, 'fa fa-fire');
INSERT INTO `icon` VALUES (176, NULL, 'fa fa-fire-extinguisher');
INSERT INTO `icon` VALUES (177, NULL, 'fa fa-flag');
INSERT INTO `icon` VALUES (178, NULL, 'fa fa-flag-checkered');
INSERT INTO `icon` VALUES (179, NULL, 'fa fa-flag-o');
INSERT INTO `icon` VALUES (180, NULL, 'fa fa-flash');
INSERT INTO `icon` VALUES (181, NULL, 'fa fa-flask');
INSERT INTO `icon` VALUES (182, NULL, 'fa fa-folder');
INSERT INTO `icon` VALUES (183, NULL, 'fa fa-folder-o');
INSERT INTO `icon` VALUES (184, NULL, 'fa fa-folder-open');
INSERT INTO `icon` VALUES (185, NULL, 'fa fa-folder-open-o');
INSERT INTO `icon` VALUES (186, NULL, 'fa fa-frown-o');
INSERT INTO `icon` VALUES (187, NULL, 'fa fa-futbol-o');
INSERT INTO `icon` VALUES (188, NULL, 'fa fa-gamepad');
INSERT INTO `icon` VALUES (189, NULL, 'fa fa-gavel');
INSERT INTO `icon` VALUES (190, NULL, 'fa fa-gear');
INSERT INTO `icon` VALUES (191, NULL, 'fa fa-gears');
INSERT INTO `icon` VALUES (192, NULL, 'fa fa-gift');
INSERT INTO `icon` VALUES (193, NULL, 'fa fa-glass');
INSERT INTO `icon` VALUES (194, NULL, 'fa fa-globe');
INSERT INTO `icon` VALUES (195, NULL, 'fa fa-graduation-cap');
INSERT INTO `icon` VALUES (196, NULL, 'fa fa-group');
INSERT INTO `icon` VALUES (197, NULL, 'fa fa-hand-grab-o');
INSERT INTO `icon` VALUES (198, NULL, 'fa fa-hand-paper-o');
INSERT INTO `icon` VALUES (199, NULL, 'fa fa-hand-peace-o');
INSERT INTO `icon` VALUES (200, NULL, 'fa fa-hand-pointer-o');
INSERT INTO `icon` VALUES (201, NULL, 'fa fa-hand-rock-o');
INSERT INTO `icon` VALUES (202, NULL, 'fa fa-hashtag');
INSERT INTO `icon` VALUES (203, NULL, 'fa fa-hdd-o');
INSERT INTO `icon` VALUES (204, NULL, 'fa fa-headphones');
INSERT INTO `icon` VALUES (205, NULL, 'fa fa-heart');
INSERT INTO `icon` VALUES (206, NULL, 'fa fa-heart-o');
INSERT INTO `icon` VALUES (207, NULL, 'fa fa-heartbeat');
INSERT INTO `icon` VALUES (208, NULL, 'fa fa-history');
INSERT INTO `icon` VALUES (209, NULL, 'fa fa-home');
INSERT INTO `icon` VALUES (210, NULL, 'fa fa-hourglass');
INSERT INTO `icon` VALUES (211, NULL, 'fa fa-hourglass-1');
INSERT INTO `icon` VALUES (212, NULL, 'fa fa-hourglass-2');
INSERT INTO `icon` VALUES (213, NULL, 'fa fa-hourglass-3');
INSERT INTO `icon` VALUES (214, NULL, 'fa fa-hourglass-o');
INSERT INTO `icon` VALUES (215, NULL, 'fa fa-i-cursor');
INSERT INTO `icon` VALUES (216, NULL, 'fa fa-image');
INSERT INTO `icon` VALUES (217, NULL, 'fa fa-inbox');
INSERT INTO `icon` VALUES (218, NULL, 'fa fa-industry');
INSERT INTO `icon` VALUES (219, NULL, 'fa fa-info');
INSERT INTO `icon` VALUES (220, NULL, 'fa fa-info-circle');
INSERT INTO `icon` VALUES (221, NULL, 'fa fa-institution');
INSERT INTO `icon` VALUES (222, NULL, 'fa fa-key');
INSERT INTO `icon` VALUES (223, NULL, 'fa fa-leaf');
INSERT INTO `icon` VALUES (224, NULL, 'fa fa-legal');
INSERT INTO `icon` VALUES (225, NULL, 'fa fa-lemon-o');
INSERT INTO `icon` VALUES (226, NULL, 'fa fa-level-down');
INSERT INTO `icon` VALUES (227, NULL, 'fa fa-level-up');
INSERT INTO `icon` VALUES (228, NULL, 'fa fa-life-ring');
INSERT INTO `icon` VALUES (229, NULL, 'fa fa-lightbulb-o');
INSERT INTO `icon` VALUES (230, NULL, 'fa fa-line-chart');
INSERT INTO `icon` VALUES (231, NULL, 'fa fa-location-arrow');
INSERT INTO `icon` VALUES (232, NULL, 'fa fa-lock');
INSERT INTO `icon` VALUES (233, NULL, 'fa fa-low-vision');
INSERT INTO `icon` VALUES (234, NULL, 'fa fa-magic');
INSERT INTO `icon` VALUES (235, NULL, 'fa fa-magnet');
INSERT INTO `icon` VALUES (236, NULL, 'fa fa-mail-forward');
INSERT INTO `icon` VALUES (237, NULL, 'fa fa-mail-reply');
INSERT INTO `icon` VALUES (238, NULL, 'fa fa-mail-reply-all');
INSERT INTO `icon` VALUES (239, NULL, 'fa fa-male');
INSERT INTO `icon` VALUES (240, NULL, 'fa fa-map');
INSERT INTO `icon` VALUES (241, NULL, 'fa fa-map-marker');
INSERT INTO `icon` VALUES (242, NULL, 'fa fa-map-o');
INSERT INTO `icon` VALUES (243, NULL, 'fa fa-map-pin');
INSERT INTO `icon` VALUES (244, NULL, 'fa fa-map-signs');
INSERT INTO `icon` VALUES (245, NULL, 'fa fa-meh-o');
INSERT INTO `icon` VALUES (246, NULL, 'fa fa-microphone');
INSERT INTO `icon` VALUES (247, NULL, 'fa fa-microphone-slash');
INSERT INTO `icon` VALUES (248, NULL, 'fa fa-minus');
INSERT INTO `icon` VALUES (249, NULL, 'fa fa-minus-circle');
INSERT INTO `icon` VALUES (250, NULL, 'fa fa-minus-square');
INSERT INTO `icon` VALUES (251, NULL, 'fa fa-minus-square-o');
INSERT INTO `icon` VALUES (252, NULL, 'fa fa-mobile');
INSERT INTO `icon` VALUES (253, NULL, 'fa fa-mobile-phone');
INSERT INTO `icon` VALUES (254, NULL, 'fa fa-money');
INSERT INTO `icon` VALUES (255, NULL, 'fa fa-moon-o');
INSERT INTO `icon` VALUES (256, NULL, 'fa fa-mouse-pointer');
INSERT INTO `icon` VALUES (257, NULL, 'fa fa-motorcycle');
INSERT INTO `icon` VALUES (258, NULL, 'fa fa-music');
INSERT INTO `icon` VALUES (259, NULL, 'fa fa-navicon');
INSERT INTO `icon` VALUES (260, NULL, 'fa fa-newspaper-o');
INSERT INTO `icon` VALUES (261, NULL, 'fa fa-object-group');
INSERT INTO `icon` VALUES (262, NULL, 'fa fa-object-ungroup');
INSERT INTO `icon` VALUES (263, NULL, 'fa fa-paint-brush');
INSERT INTO `icon` VALUES (264, NULL, 'fa fa-paper-plane');
INSERT INTO `icon` VALUES (265, NULL, 'fa fa-paper-plane-o');
INSERT INTO `icon` VALUES (266, NULL, 'fa fa-paw');
INSERT INTO `icon` VALUES (267, NULL, 'fa fa-pencil');
INSERT INTO `icon` VALUES (268, NULL, 'fa fa-pencil-square');
INSERT INTO `icon` VALUES (269, NULL, 'fa fa-pencil-square-o');
INSERT INTO `icon` VALUES (270, NULL, 'fa fa-percent');
INSERT INTO `icon` VALUES (271, NULL, 'fa fa-phone');
INSERT INTO `icon` VALUES (272, NULL, 'fa fa-phone-square');
INSERT INTO `icon` VALUES (273, NULL, 'fa fa-picture-o');
INSERT INTO `icon` VALUES (274, NULL, 'fa fa-pie-chart');
INSERT INTO `icon` VALUES (275, NULL, 'fa fa-plane');
INSERT INTO `icon` VALUES (276, NULL, 'fa fa-plug');
INSERT INTO `icon` VALUES (277, NULL, 'fa fa-plus');
INSERT INTO `icon` VALUES (278, NULL, 'fa fa-plus-circle');
INSERT INTO `icon` VALUES (279, NULL, 'fa fa-plus-square');
INSERT INTO `icon` VALUES (280, NULL, 'fa fa-qrcode');
INSERT INTO `icon` VALUES (281, NULL, 'fa fa-puzzle-piece');
INSERT INTO `icon` VALUES (282, NULL, 'fa fa-print');
INSERT INTO `icon` VALUES (283, NULL, 'fa fa-power-off');
INSERT INTO `icon` VALUES (284, NULL, 'fa fa-question');
INSERT INTO `icon` VALUES (285, NULL, 'fa fa-question-circle');
INSERT INTO `icon` VALUES (286, NULL, 'fa fa-question-circle-o');
INSERT INTO `icon` VALUES (287, NULL, 'fa fa-quote-left');
INSERT INTO `icon` VALUES (288, NULL, 'fa fa-quote-right');
INSERT INTO `icon` VALUES (289, NULL, 'fa fa-random');
INSERT INTO `icon` VALUES (290, NULL, 'fa fa-recycle');
INSERT INTO `icon` VALUES (291, NULL, 'fa fa-refresh');
INSERT INTO `icon` VALUES (292, NULL, 'fa fa-registered');
INSERT INTO `icon` VALUES (293, NULL, 'fa fa-remove');
INSERT INTO `icon` VALUES (294, NULL, 'fa fa-reorder');
INSERT INTO `icon` VALUES (295, NULL, 'fa fa-reply');
INSERT INTO `icon` VALUES (296, NULL, 'fa fa-retweet');
INSERT INTO `icon` VALUES (297, NULL, 'fa fa-road');
INSERT INTO `icon` VALUES (298, NULL, 'fa fa-rocket');
INSERT INTO `icon` VALUES (299, NULL, 'fa fa-rss');
INSERT INTO `icon` VALUES (300, NULL, 'fa fa-rss-square');
INSERT INTO `icon` VALUES (301, NULL, 'fa fa-search');
INSERT INTO `icon` VALUES (302, NULL, 'fa fa-search-minus');
INSERT INTO `icon` VALUES (303, NULL, 'fa fa-search-plus');
INSERT INTO `icon` VALUES (304, NULL, 'fa fa-server');
INSERT INTO `icon` VALUES (305, NULL, 'fa fa-share-alt');
INSERT INTO `icon` VALUES (306, NULL, 'fa fa-share-alt-square');
INSERT INTO `icon` VALUES (307, NULL, 'fa fa-share-square');
INSERT INTO `icon` VALUES (308, NULL, 'fa fa-share-square-o');
INSERT INTO `icon` VALUES (309, NULL, 'fa fa-shield');
INSERT INTO `icon` VALUES (310, NULL, 'fa fa-ship');
INSERT INTO `icon` VALUES (311, NULL, 'fa fa-shopping-bag');
INSERT INTO `icon` VALUES (312, NULL, 'fa fa-shopping-basket');
INSERT INTO `icon` VALUES (313, NULL, 'fa fa-shopping-cart');
INSERT INTO `icon` VALUES (314, NULL, 'fa fa-sign-in');
INSERT INTO `icon` VALUES (315, NULL, 'fa fa-sign-out');
INSERT INTO `icon` VALUES (316, NULL, 'fa fa-signal');
INSERT INTO `icon` VALUES (317, NULL, 'fa fa-soccer-ball-o');
INSERT INTO `icon` VALUES (318, NULL, 'fa fa-sort');
INSERT INTO `icon` VALUES (319, NULL, 'fa fa-sort-alpha-asc');
INSERT INTO `icon` VALUES (320, NULL, 'fa fa-sort-alpha-desc');
INSERT INTO `icon` VALUES (321, NULL, 'fa fa-sort-amount-asc');
INSERT INTO `icon` VALUES (322, NULL, 'fa fa-sort-amount-desc');
INSERT INTO `icon` VALUES (323, NULL, 'fa fa-sort-asc');
INSERT INTO `icon` VALUES (324, NULL, 'fa fa-sort-desc');
INSERT INTO `icon` VALUES (325, NULL, 'fa fa-sort-down');
INSERT INTO `icon` VALUES (326, NULL, 'fa fa-sort-numeric-asc');
INSERT INTO `icon` VALUES (327, NULL, 'fa fa-sort-numeric-desc');
INSERT INTO `icon` VALUES (328, NULL, 'fa fa-sort-up');
INSERT INTO `icon` VALUES (329, NULL, 'fa fa-space-shuttle');
INSERT INTO `icon` VALUES (330, NULL, 'fa fa-spinner');
INSERT INTO `icon` VALUES (331, NULL, 'fa fa-spoon');
INSERT INTO `icon` VALUES (332, NULL, 'fa fa-square');
INSERT INTO `icon` VALUES (333, NULL, 'fa fa-square-o');
INSERT INTO `icon` VALUES (334, NULL, 'fa fa-star');
INSERT INTO `icon` VALUES (335, NULL, 'fa fa-star-half-o');
INSERT INTO `icon` VALUES (336, NULL, 'fa fa-star-half');
INSERT INTO `icon` VALUES (337, NULL, 'fa fa-star-o');
INSERT INTO `icon` VALUES (338, NULL, 'fa fa-sticky-note');
INSERT INTO `icon` VALUES (339, NULL, 'fa fa-sticky-note-o');
INSERT INTO `icon` VALUES (340, NULL, 'fa fa-street-view');
INSERT INTO `icon` VALUES (341, NULL, 'fa fa-suitcase');
INSERT INTO `icon` VALUES (342, NULL, 'fa fa-sun-o');
INSERT INTO `icon` VALUES (343, NULL, 'fa fa-tablet');
INSERT INTO `icon` VALUES (344, NULL, 'fa fa-tachometer');
INSERT INTO `icon` VALUES (345, NULL, 'fa fa-taxi');
INSERT INTO `icon` VALUES (346, NULL, 'fa fa-tasks');
INSERT INTO `icon` VALUES (347, NULL, 'fa fa-tags');
INSERT INTO `icon` VALUES (348, NULL, 'fa fa-tag');
INSERT INTO `icon` VALUES (349, NULL, 'fa fa-television');
INSERT INTO `icon` VALUES (350, NULL, 'fa fa-terminal');
INSERT INTO `icon` VALUES (351, NULL, 'fa fa-thumb-tack');
INSERT INTO `icon` VALUES (352, NULL, 'fa fa-thumbs-down');
INSERT INTO `icon` VALUES (353, NULL, 'fa fa-thumbs-o-down');
INSERT INTO `icon` VALUES (354, NULL, 'fa fa-thumbs-o-up');
INSERT INTO `icon` VALUES (355, NULL, 'fa fa-thumbs-up');
INSERT INTO `icon` VALUES (356, NULL, 'fa fa-ticket');
INSERT INTO `icon` VALUES (357, NULL, 'fa fa-times');
INSERT INTO `icon` VALUES (358, NULL, 'fa fa-times-circle');
INSERT INTO `icon` VALUES (359, NULL, 'fa fa-times-circle-o');
INSERT INTO `icon` VALUES (360, NULL, 'fa fa-tint');
INSERT INTO `icon` VALUES (361, NULL, 'fa fa-toggle-down');
INSERT INTO `icon` VALUES (362, NULL, 'fa fa-toggle-left');
INSERT INTO `icon` VALUES (363, NULL, 'fa fa-toggle-right');
INSERT INTO `icon` VALUES (364, NULL, 'fa fa-toggle-up');
INSERT INTO `icon` VALUES (365, NULL, 'fa fa-toggle-off');
INSERT INTO `icon` VALUES (366, NULL, 'fa fa-toggle-on');
INSERT INTO `icon` VALUES (367, NULL, 'fa fa-trademark');
INSERT INTO `icon` VALUES (368, NULL, 'fa fa-trash');
INSERT INTO `icon` VALUES (369, NULL, 'fa fa-trash-o');
INSERT INTO `icon` VALUES (370, NULL, 'fa fa-tree');
INSERT INTO `icon` VALUES (371, NULL, 'fa fa-trophy');
INSERT INTO `icon` VALUES (372, NULL, 'fa fa-truck');
INSERT INTO `icon` VALUES (373, NULL, 'fa fa-tty');
INSERT INTO `icon` VALUES (374, NULL, 'fa fa-tv');
INSERT INTO `icon` VALUES (375, NULL, 'fa fa-umbrella');
INSERT INTO `icon` VALUES (376, NULL, 'fa fa-universal-access');
INSERT INTO `icon` VALUES (377, NULL, 'fa fa-unlock');
INSERT INTO `icon` VALUES (378, NULL, 'fa fa-unlock-alt');
INSERT INTO `icon` VALUES (379, NULL, 'fa fa-unsorted');
INSERT INTO `icon` VALUES (380, NULL, 'fa fa-upload');
INSERT INTO `icon` VALUES (381, NULL, 'fa fa-user');
INSERT INTO `icon` VALUES (382, NULL, 'fa fa-user-times');
INSERT INTO `icon` VALUES (383, NULL, 'fa fa-users');
INSERT INTO `icon` VALUES (384, NULL, 'fa fa-vcard');
INSERT INTO `icon` VALUES (385, NULL, 'fa fa-vcard-o');
INSERT INTO `icon` VALUES (386, NULL, 'fa fa-video-camera');
INSERT INTO `icon` VALUES (387, NULL, 'fa fa-volume-control-phone');
INSERT INTO `icon` VALUES (388, NULL, 'fa fa-volume-down');
INSERT INTO `icon` VALUES (389, NULL, 'fa fa-volume-off');
INSERT INTO `icon` VALUES (390, NULL, 'fa fa-volume-up');
INSERT INTO `icon` VALUES (391, NULL, 'fa fa-warning');
INSERT INTO `icon` VALUES (392, NULL, 'fa fa-wheelchair');
INSERT INTO `icon` VALUES (393, NULL, 'fa fa-wheelchair-alt');
INSERT INTO `icon` VALUES (394, NULL, 'fa fa-wifi');
INSERT INTO `icon` VALUES (395, NULL, 'fa fa-wrench');
INSERT INTO `icon` VALUES (396, NULL, 'fa fa-genderless');
INSERT INTO `icon` VALUES (397, NULL, 'fa fa-intersex');
INSERT INTO `icon` VALUES (398, NULL, 'fa fa-mars');
INSERT INTO `icon` VALUES (399, NULL, 'fa fa-mars-double');
INSERT INTO `icon` VALUES (400, NULL, 'fa fa-mars-stroke');
INSERT INTO `icon` VALUES (401, NULL, 'fa fa-mars-stroke-h');
INSERT INTO `icon` VALUES (402, NULL, 'fa fa-mars-stroke-v');
INSERT INTO `icon` VALUES (403, NULL, 'fa fa-mercury');
INSERT INTO `icon` VALUES (404, NULL, 'fa fa-neuter');
INSERT INTO `icon` VALUES (405, NULL, 'fa fa-transgender');
INSERT INTO `icon` VALUES (406, NULL, 'fa fa-transgender-alt');
INSERT INTO `icon` VALUES (407, NULL, 'fa fa-venus');
INSERT INTO `icon` VALUES (408, NULL, 'fa fa-venus-double');
INSERT INTO `icon` VALUES (409, NULL, 'fa fa-venus-mars');
INSERT INTO `icon` VALUES (410, NULL, 'fa fa-file');
INSERT INTO `icon` VALUES (411, NULL, 'fa fa-file-o');
INSERT INTO `icon` VALUES (412, NULL, 'fa fa-file-text-o');
INSERT INTO `icon` VALUES (413, NULL, 'fa fa-file-text');
INSERT INTO `icon` VALUES (414, NULL, 'fa fa-plus-square-o');
INSERT INTO `icon` VALUES (415, NULL, 'fa fa-cc-amex');
INSERT INTO `icon` VALUES (416, NULL, 'fa fa-cc-diners-club');
INSERT INTO `icon` VALUES (417, NULL, 'fa fa-cc-discover');
INSERT INTO `icon` VALUES (418, NULL, 'fa fa-cc-jcb');
INSERT INTO `icon` VALUES (419, NULL, 'fa fa-cc-mastercard');
INSERT INTO `icon` VALUES (420, NULL, 'fa fa-cc-paypal');
INSERT INTO `icon` VALUES (421, NULL, 'fa fa-cc-stripe');
INSERT INTO `icon` VALUES (422, NULL, 'fa fa-cc-visa');
INSERT INTO `icon` VALUES (423, NULL, 'fa fa-google-wallet');
INSERT INTO `icon` VALUES (424, NULL, 'fa fa-paypal');
INSERT INTO `icon` VALUES (425, NULL, 'fa fa-bitcoin');
INSERT INTO `icon` VALUES (426, NULL, 'fa fa-btc');
INSERT INTO `icon` VALUES (427, NULL, 'fa fa-cny');
INSERT INTO `icon` VALUES (428, NULL, 'fa fa-dollar');
INSERT INTO `icon` VALUES (429, NULL, 'fa fa-eur');
INSERT INTO `icon` VALUES (430, NULL, 'fa fa-euro');
INSERT INTO `icon` VALUES (431, NULL, 'fa fa-gbp');
INSERT INTO `icon` VALUES (432, NULL, 'fa fa-gg');
INSERT INTO `icon` VALUES (433, NULL, 'fa fa-ils');
INSERT INTO `icon` VALUES (434, NULL, 'fa fa-inr');
INSERT INTO `icon` VALUES (435, NULL, 'fa fa-krw');
INSERT INTO `icon` VALUES (436, NULL, 'fa fa-th-large');
INSERT INTO `icon` VALUES (437, NULL, 'fa fa-th-list');
INSERT INTO `icon` VALUES (438, NULL, 'fa fa-repeat');
INSERT INTO `icon` VALUES (439, NULL, 'fa fa-undo');
INSERT INTO `icon` VALUES (440, NULL, 'fa fa-th');
INSERT INTO `icon` VALUES (441, NULL, 'fa fa-save');
INSERT INTO `icon` VALUES (442, NULL, 'fa fa-paste');
INSERT INTO `icon` VALUES (443, NULL, 'fa fa-list-alt');
INSERT INTO `icon` VALUES (444, NULL, 'fa fa-italic');
INSERT INTO `icon` VALUES (445, NULL, 'fa fa-font');
INSERT INTO `icon` VALUES (446, NULL, 'fa fa-link');
INSERT INTO `icon` VALUES (447, NULL, 'fa fa-bold');
INSERT INTO `icon` VALUES (448, NULL, 'fa fa-chain-broken');
INSERT INTO `icon` VALUES (449, NULL, 'fa fa-copy');
INSERT INTO `icon` VALUES (450, NULL, 'fa fa-angle-double-down');
INSERT INTO `icon` VALUES (451, NULL, 'fa fa-angle-double-left');
INSERT INTO `icon` VALUES (452, NULL, 'fa fa-angle-double-right');
INSERT INTO `icon` VALUES (453, NULL, 'fa fa-angle-double-up');
INSERT INTO `icon` VALUES (454, NULL, 'fa fa-angle-down');
INSERT INTO `icon` VALUES (455, NULL, 'fa fa-angle-left');
INSERT INTO `icon` VALUES (456, NULL, 'fa fa-angle-right');
INSERT INTO `icon` VALUES (457, NULL, 'fa fa-angle-up');
INSERT INTO `icon` VALUES (458, NULL, 'fa fa-arrow-circle-down');
INSERT INTO `icon` VALUES (459, NULL, 'fa fa-arrow-circle-left');
INSERT INTO `icon` VALUES (460, NULL, 'fa fa-arrow-circle-o-down');
INSERT INTO `icon` VALUES (461, NULL, 'fa fa-arrow-circle-o-left');
INSERT INTO `icon` VALUES (462, NULL, 'fa fa-arrow-circle-o-right');
INSERT INTO `icon` VALUES (463, NULL, 'fa fa-arrow-circle-o-up');
INSERT INTO `icon` VALUES (464, NULL, 'fa fa-arrow-circle-right');
INSERT INTO `icon` VALUES (465, NULL, 'fa fa-arrow-circle-up');
INSERT INTO `icon` VALUES (466, NULL, 'fa fa-arrow-down');
INSERT INTO `icon` VALUES (467, NULL, 'fa fa-arrow-left');
INSERT INTO `icon` VALUES (468, NULL, 'fa fa-arrow-right');
INSERT INTO `icon` VALUES (469, NULL, 'fa fa-arrow-up');
INSERT INTO `icon` VALUES (470, NULL, 'fa fa-chevron-circle-down');
INSERT INTO `icon` VALUES (471, NULL, 'fa fa-chevron-circle-left');
INSERT INTO `icon` VALUES (472, NULL, 'fa fa-chevron-circle-right');
INSERT INTO `icon` VALUES (473, NULL, 'fa fa-chevron-circle-up');
INSERT INTO `icon` VALUES (474, NULL, 'fa fa-caret-down');
INSERT INTO `icon` VALUES (475, NULL, 'fa fa-caret-left');
INSERT INTO `icon` VALUES (476, NULL, 'fa fa-caret-right');
INSERT INTO `icon` VALUES (477, NULL, 'fa fa-chevron-down');
INSERT INTO `icon` VALUES (478, NULL, 'fa fa-chevron-left');
INSERT INTO `icon` VALUES (479, NULL, 'fa fa-chevron-right');
INSERT INTO `icon` VALUES (480, NULL, 'fa fa-chevron-up');
INSERT INTO `icon` VALUES (481, NULL, 'fa fa-expand');
INSERT INTO `icon` VALUES (482, NULL, 'fa fa-backward');
INSERT INTO `icon` VALUES (483, NULL, 'fa fa-compress');
INSERT INTO `icon` VALUES (484, NULL, 'fa fa-eject');
INSERT INTO `icon` VALUES (485, NULL, 'fa fa-fast-backward');
INSERT INTO `icon` VALUES (486, NULL, 'fa fa-fast-forward');
INSERT INTO `icon` VALUES (487, NULL, 'fa fa-forward');
INSERT INTO `icon` VALUES (488, NULL, 'fa fa-pause');
INSERT INTO `icon` VALUES (489, NULL, 'fa fa-pause-circle');
INSERT INTO `icon` VALUES (490, NULL, 'fa fa-pause-circle-o');
INSERT INTO `icon` VALUES (491, NULL, 'fa fa-play');
INSERT INTO `icon` VALUES (492, NULL, 'fa fa-play-circle');
INSERT INTO `icon` VALUES (493, NULL, 'fa fa-play-circle-o');
INSERT INTO `icon` VALUES (494, NULL, 'fa fa-step-backward');
INSERT INTO `icon` VALUES (496, NULL, 'fa fa-stop');
INSERT INTO `icon` VALUES (497, NULL, 'fa fa-stop-circle');
INSERT INTO `icon` VALUES (498, NULL, 'fa fa-stop-circle-o');
INSERT INTO `icon` VALUES (499, NULL, 'fa fa-youtube-play');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `auth_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `auth_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `role_desc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UQE_role_id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (5, '超级管理员', '[4,7,8,18,5,17,10,6,11]', '[33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,13,12,11,10,9,5,4,3,2,38,40]', '拥有所有权限');
INSERT INTO `role` VALUES (7, '管理员', '[5,17,10,6,11]', '[23,22,21,20,19,10,9,12,18,11,24]', '管理员，拥有部分权限');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `money` decimal(11, 2) NOT NULL DEFAULT 0.00,
  `points` int(11) NOT NULL DEFAULT 0,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nickname` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sex` tinyint(1) NULL DEFAULT 0,
  `avatar_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `province` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `xcx_openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `gzh_openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `longitude` double(11, 8) NULL DEFAULT NULL,
  `latitude` double(11, 8) NULL DEFAULT NULL,
  `reg_time` int(11) NOT NULL DEFAULT 0,
  `login_time` int(11) NOT NULL DEFAULT 0,
  `login_rand` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `UQE_users_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
