/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : phqadmin

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 10/10/2019 15:34:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `role` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色权限',
  `login_time` int(11) NOT NULL DEFAULT 0 COMMENT '上次登录时间',
  `login_ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上次登录IP',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '0b178dfde1b181b81d01ffb628f9c9bd', NULL, 1569723888, 'localhost:8181');
INSERT INTO `admin` VALUES (2, 'test123', '123456', '[5,6]', 0, '');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父id',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `crouter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端路由',
  `srouter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '后端路由',
  `auth` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限',
  `visit` tinyint(1) NOT NULL DEFAULT 0 COMMENT '访问权限 0公开，1登录，2权限，3,超级管理员',
  `auth_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '路由类型 0菜单，1操作（按钮）',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否显示',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES (1, 0, '首页', 'fa fa-home', '/index', '', '{\"add\":{\"show\":false,\"router\":\"\"},\"delete\":{\"show\":false,\"router\":\"\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":false,\"router\":\"\"}}', 1, 0, 1, 2);
INSERT INTO `auth` VALUES (2, 0, '系统与安全', 'fa fa-address-card', '', '', '{\"add\":{\"show\":false,\"router\":\"\"},\"delete\":{\"show\":false,\"router\":\"\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":false,\"router\":\"\"}}', 2, 0, 1, 3);
INSERT INTO `auth` VALUES (3, 0, '附件管理', 'fa fa-folder-open', '', '', '{\"add\":{\"show\":false,\"router\":\"\"},\"delete\":{\"show\":false,\"router\":\"\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":false,\"router\":\"\"}}', 2, 0, 1, 4);
INSERT INTO `auth` VALUES (4, 0, '用户管理', 'fa fa-user', '', '', '{\"add\":{\"show\":false,\"router\":\"\"},\"delete\":{\"show\":false,\"router\":\"\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":false,\"router\":\"\"}}', 2, 0, 1, 5);
INSERT INTO `auth` VALUES (5, 2, '管理员管理', 'fa fa-user', '/admin', '', '{\"add\":{\"show\":true,\"router\":\"/admin-api/admin/add\"},\"delete\":{\"show\":true,\"router\":\"/admin-api/admin/del\"},\"edit\":{\"show\":true,\"router\":\"/admin-api/admin/edit\"},\"select\":{\"show\":true,\"router\":\"/admin-api/admin/list\"}}', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (6, 2, '角色管理', 'fa fa-address-book', '/role', '', '{\"add\":{\"show\":true,\"router\":\"/admin-api/role/add\"},\"delete\":{\"show\":true,\"router\":\"/admin-api/role/del\"},\"edit\":{\"show\":true,\"router\":\"/admin-api/role/edit\"},\"select\":{\"show\":true,\"router\":\"/admin-api/auth/list@/admin-api/role/list\"}}', 2, 0, 1, 1);
INSERT INTO `auth` VALUES (7, 2, '权限管理', 'fa fa-gears', '/auth', '', '{\"add\":{\"show\":true,\"router\":\"/admin-api/auth/add\"},\"delete\":{\"show\":true,\"router\":\"/admin-api/auth/del\"},\"edit\":{\"show\":true,\"router\":\"/admin-api/auth/edit\"},\"select\":{\"show\":true,\"router\":\"/admin-api/auth/list\"}}', 3, 0, 1, 2);
INSERT INTO `auth` VALUES (8, 3, '图标管理', 'fa fa-info-circle', '/icon', '', '{\"add\":{\"show\":true,\"router\":\"/admin-api/icon/add\"},\"delete\":{\"show\":true,\"router\":\"/admin-api/icon/del\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":true,\"router\":\"/admin-api//icon/list\"}}', 2, 0, 1, 1);
INSERT INTO `auth` VALUES (9, 4, '会员列表', 'fa fa-users', '/user', '', '{\"add\":{\"show\":false,\"router\":\"\"},\"delete\":{\"show\":false,\"router\":\"\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":true,\"router\":\"/admin-api/user/list/*@/admin-api/user/total/money-points\"}}', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (10, 4, '充值记录', 'fa fa-cc-visa', '/paylog', '', '{\"add\":{\"show\":false,\"router\":\"\"},\"delete\":{\"show\":false,\"router\":\"\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":true,\"router\":\"/admin-api/user/pay/log/*\"}}', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (74, 0, '后台登录', '', '', '', '{\"add\":{\"show\":false,\"router\":\"\"},\"delete\":{\"show\":false,\"router\":\"\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":false,\"router\":\"\"}}', 1, 1, 0, 1);
INSERT INTO `auth` VALUES (75, 74, '管理员信息', '', '', '/admin-api/admin/info', NULL, 1, 1, 1, 0);
INSERT INTO `auth` VALUES (76, 74, '修改密码', '', '', '/admin-api/admin/edit/pass', NULL, 1, 1, 1, 0);
INSERT INTO `auth` VALUES (83, 0, '后台登录', '', '', '/admin-api/login', '{\"add\":{\"show\":false,\"router\":\"\"},\"delete\":{\"show\":false,\"router\":\"\"},\"edit\":{\"show\":false,\"router\":\"\"},\"select\":{\"show\":false,\"router\":\"\"}}', 0, 1, 1, 0);
INSERT INTO `auth` VALUES (84, 3, '图片管理', 'fa fa-file-image-o', '/images', '', '{\"add\":{\"show\":true,\"router\":\"/admin-api/files/upload/img@/admin-api/files/add/class\"},\"delete\":{\"show\":true,\"router\":\"/admin-api/files/del@/admin-api/files/del/class\"},\"edit\":{\"show\":true,\"router\":\"/admin-api/files/edit/class\"},\"select\":{\"show\":true,\"router\":\"/admin-api/files/list/class@/admin-api/files/list/*\"}}', 2, 0, 1, 0);

-- ----------------------------
-- Table structure for files
-- ----------------------------
DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL DEFAULT 0 COMMENT '所属分类文件id',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `send_num` int(11) NULL DEFAULT 0 COMMENT '使用数量',
  `src` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件地址',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '上传时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files
-- ----------------------------
INSERT INTO `files` VALUES (41, 11, 'd387497997c56f5b50d23b26a4bbc4ed.jpeg', 0, 'static/upload/2019/08/29/c078aba9067fdf3b278b39e1e0d8a325.jpeg', 1567047041);
INSERT INTO `files` VALUES (42, 12, '4637a9d92b1b3ec1f4c8988fa6ddccd4.jpeg', 0, 'static/upload/2019/08/29/a4a26b5c9130e1dda5ebcab7788b8c6c.jpeg', 1567047045);
INSERT INTO `files` VALUES (35, 1, '489777a9a7127281819d59b5d2fd6590a47747085ad2-2Up2xb_fw658.jpg', 0, 'static/upload/2019/08/29/88144e05dc9a66e1ca95817486decc67.jpg', 1567047019);
INSERT INTO `files` VALUES (36, 1, '1ebf046298c63e0179141c829e6853ac.jpg', 0, 'static/upload/2019/08/29/dfc7c020dc4f9af37ac877cce698544d.jpg', 1567047024);
INSERT INTO `files` VALUES (37, 1, 'd387497997c56f5b50d23b26a4bbc4ed.jpeg', 0, 'static/upload/2019/08/29/e302e55299045c6b1d3271cce8655bfd.jpeg', 1567047027);
INSERT INTO `files` VALUES (38, 11, 'a0cad5ab59385b921110453ff8f7e7fc.jpg', 0, 'static/upload/2019/08/29/05371a1160a70d1c6fcfb5399238184f.jpg', 1567047031);
INSERT INTO `files` VALUES (39, 11, '791079a226012362db1bd0470aaa9ced.jpeg', 0, 'static/upload/2019/08/29/60141d65dc6cd6622cbec766fecbb067.jpeg', 1567047034);
INSERT INTO `files` VALUES (40, 11, 'ee983ced5452141828d23fa968dfbcf5.jpeg', 0, 'static/upload/2019/08/29/ce3497c93adb3d75682f6800692bf549.jpeg', 1567047038);

-- ----------------------------
-- Table structure for files_class
-- ----------------------------
DROP TABLE IF EXISTS `files_class`;
CREATE TABLE `files_class`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父ID',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files_class
-- ----------------------------
INSERT INTO `files_class` VALUES (1, 0, '图片');
INSERT INTO `files_class` VALUES (11, 0, '商家入驻证件图片');
INSERT INTO `files_class` VALUES (12, 0, '测试');

-- ----------------------------
-- Table structure for icon
-- ----------------------------
DROP TABLE IF EXISTS `icon`;
CREATE TABLE `icon`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图标管理表',
  `title` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标样式',
  PRIMARY KEY (`id`) USING BTREE
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
  `role_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `auth_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '权限列表',
  `role_desc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (5, '管理员', '[{\"auth_id\":2,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":5,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":6,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":3,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":84,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":8,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":4,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":9,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":10,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true}]', '拥有所有权限');
INSERT INTO `role` VALUES (6, '测试管理', '[{\"auth_id\":2,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":5,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":6,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true}]', '如你所见');

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store`  (
  `store_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家名称',
  `sore_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家账号',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家登录密码',
  `pay_password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家提现密码',
  `money` decimal(11, 2) NOT NULL DEFAULT 0.00 COMMENT '商家余额（分）',
  `discount` float(3, 2) NOT NULL DEFAULT 0.00 COMMENT '商家让利折扣',
  `class_type_id` int(11) NOT NULL DEFAULT 0 COMMENT '商家所属分类id',
  `longitude` double(11, 8) NOT NULL DEFAULT 0.00000000 COMMENT '经度',
  `latitude` double(11, 8) NOT NULL DEFAULT 0.00000000 COMMENT '纬度',
  `address` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家地址',
  `phone` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家电话',
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '商家状态 0申请中，1开启，2拒绝申请，3关闭',
  `img_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家头像',
  `rate` tinyint(1) NOT NULL DEFAULT 0 COMMENT '评分',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `login_rand` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家登录随机字串',
  `start_time` int(11) NOT NULL DEFAULT 0 COMMENT '开店时间',
  `end_time` int(11) NOT NULL DEFAULT 0 COMMENT '关店时间',
  `close_info` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关店原因',
  `qr_img` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款二维码地址',
  `bus_time` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业时间',
  `desc` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家介绍',
  `id_bus_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业执照图片',
  `id_just_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证正面',
  `id_back_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证背面',
  `person_mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人手机',
  `avg_price` decimal(11, 2) NOT NULL DEFAULT 0.00 COMMENT '平均消费',
  PRIMARY KEY (`store_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机',
  `money` decimal(11, 2) NOT NULL DEFAULT 0.00 COMMENT '用户余额（分）',
  `points` int(11) NOT NULL DEFAULT 0 COMMENT '用户积分',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录密码',
  `nickname` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别',
  `avatar_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `province` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `xcx_openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小程序openid',
  `gzh_openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公众号openid',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信开放平台unionid',
  `longitude` double(11, 8) NULL DEFAULT NULL COMMENT '经度',
  `latitude` double(11, 8) NULL DEFAULT NULL COMMENT '纬度',
  `reg_time` int(11) NOT NULL DEFAULT 0 COMMENT '登录时间',
  `login_time` int(11) NOT NULL DEFAULT 0 COMMENT '上次登录时间',
  `login_rand` varchar(0) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录随机字串',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 934 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (29, '18288411141', 0.00, 0, '', '微笑是坚强的表现', 1, 'https://wx.qlogo.cn/mmopen/vi_32/McNeTxFVPvDyFibiaXJEd8p2IRepg5DFib2m7rGiaLwfBmOg3ydnV1qTjiavjbcw4Olj2HE7kzZMlDrEQFcj0d4V4Yg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (71, '', 0.00, 0, '', '小仕老师', 1, 'https://wx.qlogo.cn/mmopen/vi_32/icRPQLoicGwl2XtNEHkibpqC3CAhu4CibtgCIBicLPp9ibczrttVbxw0HhbqxcWiaqqVp1IgK8JAzpJEmItj4d1CHycWA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (72, '', 0.00, 0, '', '箫沐言', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK4RBEaUian1wxQe0UGGkmZ1Hj7fpiaZJCY7s3OicuulEqWzqXRI245elvTrDKM8a7ZoWGHGa9ajejSg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (73, '15087198784', 6.20, 0, '', '陪你到底', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Vnx6WC9JpjTz1rxAtYmr0lkncOSia9LIp4vZP2wo3u4UH527Vb3bKrHToVDd65SR6Tw9pOoa09MXlASR5TOTRjA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (74, '15176362163', 5.82, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/YqF3S64vHV41Wa9QbPwXFEeyjFl1UVKP9UTve4rrcham8qhUF5jladLvbhRS3eHmVzbSOZBEiaw5HgFkZknaOtw/132', '', '保定', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (75, '', 0.00, 0, '', '《侯》', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIxQoibT3WvrjDCXRT5zjTk6F0niatEmY0l4nWRTfctUxjBOnYt8pJHzwRWicWtyHh3jiagXaMviazNS7Q/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (76, '', 0.00, 0, '', '@小时光', 2, 'https://wx.qlogo.cn/mmopen/vi_32/E8EYG6Pmao1shCadpoXyqJia2apaib526DTBicg6DmibxwNiawDeBArGswpQqMicU85f0dib876Z6YlMLqeODXXAItUMg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (77, '15198206001', 0.00, 0, '', 'Jason', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI5UBszcXFib5k95eAgibWibql0KBR5cr4DZ4HFicnf3BYcDyAtDhV2jut6ht3HqIhXBchBllRaGvGfog/132', '', '成都', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (78, '', 0.00, 0, '', '小鲨鱼', 1, 'https://wx.qlogo.cn/mmopen/vi_32/BF6K1pR632XUhbXZk4e6viajsib0PmD0Ff3HOIR0JySTteTmBLyS6sex3aZ27OIiaoPMNhgw2Q0NkWMNiaXp0SicxjQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (79, '', 0.00, 0, '', '窜天猴', 1, 'https://wx.qlogo.cn/mmopen/vi_32/grfbuIthibqhzFrKATTuoUtHrwl4fw1UByAlI8mIc8cmNia73qIQibb2yhtdcK5LmqicYz88gyKGJtIX4ylrLvTibcw/132', '', '西安', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (80, '', 0.00, 0, '', '彭正仁', 0, 'https://wx.qlogo.cn/mmhead/gCCqib5ZaCdba8B4aReRpuuRpvPuh1dU9rpOdic5IeIxk/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (81, '', 0.00, 0, '', '菜鸟', 1, 'https://wx.qlogo.cn/mmopen/vi_32/9pIma6GM1oEyaF9ef6lGPDrHVApOT7DgvsMXm37QH72da09kfPXnImFBErHTIVPO0GIXgYwz13FfAJibFhkFCPg/132', '', '安顺', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (82, '', 0.00, 0, '', '太阳', 2, 'https://wx.qlogo.cn/mmopen/vi_32/BibNJMmWh0GgxicQ1XMesPRJ5icJVcKKbaVGiaicDSSesbvtG1OZmRrLByE8Tk43ja7QPhazFygPQ38MIv9icyqQ2Fqg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (83, '', 0.00, 0, '', 'A0活儿好', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJicsXftLvxY1ayAfwSEx7cibOpvdgOptImuzWhzLewoYw9NtQyALpLhzw8dLMiajNKn5uSNR2YuibVNw/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (84, '', 0.00, 0, '', '郭礼钰', 0, 'https://wx.qlogo.cn/mmhead/13UFmBH4xXygZBfeftTRf7zxTknk2E9tFclSl190G9o/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (85, '', 54.00, 0, '', '苦茶塘', 2, 'https://wx.qlogo.cn/mmopen/vi_32/XcfMKbpWP2ib9OCUSNSj63bRDz3icCzV4micfsz4L0ibhkN2QW82Fw3ZmTYdIQSvus16XxOKebf2J2iaibEQo8QjSBZQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (86, '13678700768', 0.00, 0, '', '꧁༺幽༒灵༻꧂', 1, 'https://wx.qlogo.cn/mmopen/vi_32/FpudwHOvLaF03692v1xb69FwkJ7A6uSYGCCib97wssLuicGht8ibicibw2yS43iaGFgzXB5icwtnRdTHzm8De2Y0vctuA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (87, '', 0.00, 0, '', '@#。', 0, 'https://wx.qlogo.cn/mmopen/vi_32/mBw9CRX8uGm2zAibmH1BI2sfrmkBAz6GUR0sxSAu1ZyCj65MmzVy3lvsgXmtoVOmf11jHR8W21QHTZb0JSDAV0Q/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (88, '', 0.00, 0, '', '小雨点', 1, 'https://wx.qlogo.cn/mmopen/vi_32/7xBGdWlVh7ndgPwDofb5TYWDFN71oNhvVK6mLpyTo9wlujxRAlkTxIwDG4mCRDvN8a9rtyhdPZQFtydGDFibgLQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (89, '', 0.00, 0, '', '壹吱', 2, 'https://wx.qlogo.cn/mmopen/vi_32/JYjlHG9g7VbOVJNsAbKOJygQ6V6thmMBhfA6SI9Qb2InsdkKyeXKGgol2VhmHib9bmdxXAYxwXK5icR4PVftGJCQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (90, '', 6.00, 0, '', '枼', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLDOibiapticcxa1cLQuurAoqkC8exUGt8bXsOxdCfOZspIpNWib8AYvZfbF7HubtttVdQemdqE2IWCXg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (91, '', 0.00, 0, '', '自然', 1, 'https://wx.qlogo.cn/mmopen/vi_32/rQlsHfibEGiaDH9SnoXHu1LCkEfK5FqKGwmN5nQZs0yStm49gctJn2KibBEd5OHSUqKK08V8brIJ3W6OaLHyGTb8Q/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (92, '', 1.00, 0, '', '何发敏        任~我~行', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PibCKPDKJtCpTCRibIQHpQcWf7K8tzJMIaJjs951hTp8ia9ibKqWUbwDKDrwGbicX53rBrnrXhrTevJ2XWZBFwxa6Ow/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (93, '', 0.72, 0, '', '℡可爱三秒.々', 2, 'https://wx.qlogo.cn/mmopen/vi_32/FmjAcibbIH7DHTWJ6OhqBa1s4crgvicXIa6h0p3gdDNaupd6GdTF1Gsiao9qiclYZlomuuY3HHiaEhzarkiclC2aJ6uA/132', '', '惠州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (94, '', 15.00, 0, '', '香蕉你个巴拉', 2, 'https://wx.qlogo.cn/mmopen/vi_32/R1pd7wGPOIDyUnNJaZHZkeE5KmF0KPtlDZkuVo71l7k50ibfaLhic637ywf0cXZ1T55BejABB78xjvJmXGCDeeiag/132', '', '丽江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (95, '', 0.00, 0, '', '从前的回忆', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ib4z4iaVQJmPabrZh18enMtlNh8zP3yrPice4hOVwiaPbN1Og20tgryOe5UWdcalY57a7icibia8HwDdJA4xZaLsUUqLg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (96, '', 0.00, 0, '', '我心向东', 1, 'https://wx.qlogo.cn/mmopen/vi_32/J2EwtLbDgtuj7ibc2ibiad5MNoFnh5zasBfQ81ribV9eou3Kno18yMiawDjInsdzZueZcia1M3WiaU95ywXQan3Kndnpg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (97, '', 0.00, 0, '', '胡杨', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep0AFA6YUtDVpryaDpdaEUsA4QgQvJCN7IObnUw3woMxhdRXfqrfNm7MZhIZFlC3uiaOibAUfX5icrwQ/132', '', '红桥', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (99, '', 0.00, 0, '', '谈笑风云', 1, 'https://wx.qlogo.cn/mmopen/vi_32/0VgOZ2B9CCvICQW3oicp1xib1L3NYFQTvw51ntLMevvicqrMqGnK8bI6pFrmV7mBxS9cbOyAwbDxxNF8Dbh3thnyQ/132', '', '乐山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (100, '', 0.00, 0, '', '小俊', 2, 'https://wx.qlogo.cn/mmopen/vi_32/9hr5RFL1AicbaugaMMu0kPia8v1MK2uNq1ZKTy35lZw9kYhQiah5anv9CJ9ZmwaAF5v55YIbTAmic2q7oEwiaqrQZHw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (101, '', 0.00, 0, '', '知足常乐', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep5OI1sNwvunCtOibKiaoNKGxs18flGvSkZ3uE88f0Eh7lSmicYibffYwTwDVX7XTiay6LX7YnNTfBHmvA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (102, '', 0.00, 0, '', '鲜华食品袁明瑞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/XQHNfRg7edzXiaFTSpdJBRKG42JI9TtYBI4TfSRSaQT3urVic2DWGjor09q9UibKOf14uzJKylauFbXGsmN7ibHAGg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (103, '', 0.00, 0, '', '百味干锅', 1, 'https://wx.qlogo.cn/mmopen/vi_32/icJODrpILVHWPt5O3TGHdjAub1mKoE6OsebIZrYIXE4Z52fRweeXvt9FoicH9jS1aFloh45M8DDd5RyQ7N4iaC8UQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (104, '', 0.00, 0, '', '超越梦想', 1, 'https://wx.qlogo.cn/mmopen/vi_32/vfl5KWjtVg126VtTiaa59fZvuneNxIxbdibkZgx1xywBTzLXT5eTzGATiaR6IeN48sdK82G0ED9fEUwQ9DfYQ86iaA/132', '', '楚雄', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (105, '', 0.00, 0, '', '杨', 1, 'https://wx.qlogo.cn/mmopen/vi_32/tRacv4iadjsffBmQHJprk2l1gLsc5dEFuCJcnLyc46NnALV2TU6rOnlMdOYlA4TFckorj1xYiby4GyhmhREqHkFw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (106, '', 0.00, 0, '', '小娟', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI6MGz2ggnAlT5aKH9vde0TTueW9qUnbXyqgmDHxlkPYW1I1xsmBYWZGqcI9XpR3fA3mYicAvZ05gQ/132', '', '黄冈', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (107, '', 0.00, 0, '', '润', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqqpiba7E8Jr8LFvBdcBVwppXpPOH4LPibkM2h8zmELib2NauKALcQico8q20wx6JibsCEzzp4tjqm4yuA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (108, '', 0.00, 0, '', '贵州烙锅店', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epvzVzhsRRNrKdiaB8QzMYpj6wjIT5wQHRicBSVN1EtibDs6G93S8btM74RicwkKRHKEGMM74j5tdp2CA/132', '', '毕节', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (109, '', 0.00, 0, '', '。', 1, 'https://wx.qlogo.cn/mmopen/vi_32/D1TJUIoBJPc25kZVicEzU2sggL8JTK7T7DKHEoW1ica2v2UMzTpRGAwa0ElCBlsicB8uxvic3iaFegwEED3b6y8V1Aw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (110, '13518701434', 1.00, 0, '', '照型师。邓先森', 1, 'https://wx.qlogo.cn/mmopen/vi_32/h8QOstJxSBArc9co5X4PX3jDf94L3AV6V8VnQMWjvvvVDaUEKvOfNGe3DmsAUCk60kzXqASZeOaG9iaOqtVnX0g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (111, '', 0.00, 0, '', '逐波', 1, 'https://wx.qlogo.cn/mmopen/vi_32/RNJfsfhsEic3z2kgnMMPrc0KUhMYgeGWpQvZEPWj5ubWRVzwquKkzU0Z8InRgqG4GibmTxySOicd78MM848qwCNqw/132', '', '云阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (112, '', 0.00, 0, '', '茶π', 1, 'https://wx.qlogo.cn/mmopen/vi_32/MOoJFfo1an9CwJa7XBxjJG6JPe1TenKBCLDicFNcj8S2WlZiaMJDdqlmovuyoib0Ov1oDSMs5lqaaLnLKtVFL5omg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (113, '', 0.00, 0, '', '苔花如米小，也学牡丹开', 1, 'https://wx.qlogo.cn/mmopen/vi_32/lQ5cl9ZxQNpvupGic02rkBzFXQv8jS0MSHBvuyOGo81ok1p4lUlCDcqvibLSToTFQCNj3NT18vnrpbObH5rvzTYQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (114, '', 0.00, 0, '', '明利', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PVkicBuXLwtFTQSKteBYlsvPjIQRp6zOlBGxRxOx5df0hSF3iaC7icmsw9envEdA2DgL1NWUR2BZxibxEo9GR9kysA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (115, '', 0.00, 0, '', '贝儿（大学生创业）', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKNSU1d3dXJANA5rrzUN65guzNFZJKU8APzxCUUSboHp82peWlnw41hbENbrpCQPN00wzhoBe2T4w/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (116, '', 0.00, 0, '', '羡慕别人不如做好自己', 1, 'https://wx.qlogo.cn/mmopen/vi_32/5Vf7tTBo99EuCKGIjDz0z6gGE3dM86qGYESfJiaBSLHIibk5Fia5GOdTwFCFesXlvGp5rUzcvpa2efyibN7gd5vicTg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (117, '', 0.00, 0, '', '食锅味', 1, 'https://wx.qlogo.cn/mmopen/vi_32/MLVw5bWa0HibTah7De2OG3tGkwDhbtgb2xAfGOh5xf8XlZctmArMTwl90cZxjaF7uicaC9wdWHvQKBQVvicWWAq0A/132', '', '楚雄', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (118, '', 0.00, 0, '', '嚭', 1, 'https://wx.qlogo.cn/mmopen/vi_32/eWGuCNEtUcYo6TMib5703AH0IwL90h132J9SRibLibKiceYX3T2EgaeMxgSBwA3MMeKDW8MBELpKHRicCKHN8PKHbRw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (119, '', 0.00, 0, '', '阿旃陀', 1, 'https://wx.qlogo.cn/mmopen/vi_32/KhfOd71y8o6MUJK9eFqxwlkaegnia3bImf25ibiaTfHFmiaOw0E9OMWicNuGBnrZxsYjJ7alSX4tPeMDheK2AElI3LA/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (120, '', 0.00, 0, '', '주운', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIWjdabiaIH7V6bAnP0TX0REvwAtyZuiaJrpZ2TdYLgYEs5bqKNaxAmJ0LclNn8SgeiaSdictiaF0I6t4g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (121, '', 0.00, 0, '', 'Kakarotto', 2, 'https://wx.qlogo.cn/mmopen/vi_32/6DIkDb7KAXibKLDgqCbUQq3EFNuECn69npRsyUQibCKPlqypmAQe2DcFcydPV5sT1lg2UBnLXibFJcGkDaWaoL8Pw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (122, '', 0.00, 0, '', '云南东红食品', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIeL53cMocjVmguj3qTtQdI6YAFrHvVhka6ybuPUkz6Jr35q7dXiatSqBrRFq7ic7rAz4CaNSsic0Dew/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (123, '', 0.00, 0, '', '微夏倾城', 2, 'https://wx.qlogo.cn/mmopen/vi_32/wSkpLicAbWAxKqHQAGBzDAMOVZXNh10xlJoicUAS3BybVLukUH5UibCY0l6IlhiaqpofGsiaUDKo4KnbWET81kQbzibA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (124, '', 0.00, 0, '', 'A活力无限客服经理王艺楠', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKb2tTOIkYHOrtlicofZntN6QXrGngv0E55eVoEw9iahibNJ4GDH2H5U7pZGK3gKNHUQHEalibUN6B4KQ/132', '', '渭南', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (125, '', 0.00, 0, '', '木木', 1, 'https://wx.qlogo.cn/mmopen/vi_32/uUNkAaonaeCA0nRcPTDd4tpbd4MvFGPicvEXlBjdqiaX2yxg1fjPwGoD28zaIz03Oticnx74NdrdaBYnAZepz7sJw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (126, '', 0.00, 0, '', '星偶像私人订制', 2, 'https://wx.qlogo.cn/mmopen/vi_32/EzsOiaxc7AyHYvTHSztpictoaPuc8zwX6PiaQSSKAic6oXBrSibf5iaibcBTicap1NtiauFMUuhrmnfJsL7mKjAwNwS0fibQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (127, '', 0.00, 0, '', 'あ紫￡梦&恋€星', 1, 'https://wx.qlogo.cn/mmopen/vi_32/5Pk8x2GP7egr1hpJYL7t9BuHFE3kLBicF3jWwVkxtc9HAmXEU2zugMX8UNGfseuiaoATKhufv2KVA5E7jSd1o8hA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (128, '', 2.00, 0, '', 'YOUNG  SUN阿辉', 1, 'https://wx.qlogo.cn/mmopen/vi_32/QGEEfDd06mGWDLzsAzZJwf7VJBJ5PE0KoNr3SdBJuicbiafHaf7Qiabm3A3FE9ewic1otGXymEb7qrJ7WRpicUQ6C1Q/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (129, '', 1.00, 0, '', 'a星座造型一阿雄', 1, 'https://wx.qlogo.cn/mmopen/vi_32/YlRUS6H7ic4q5l8pfKwOibpcH31yPnvNzUR7loJ11sDmBZpPdbqRA1cib0KNfy8Rk6Xg4h13fF9j2hsnxAvZDYAjg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (130, '', 0.00, 0, '', '感谢有你', 2, 'https://wx.qlogo.cn/mmopen/vi_32/UL2DHB3fsYwF5Q3ONef2GZibNxm95PyOjM4DxJKYn99OQw3SQgiaVDoaEKGRahpfErTAB1eSrdrc2fmw2aOxTibIA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (131, '', 0.00, 0, '', '云南东红食品15912478272', 0, 'https://wx.qlogo.cn/mmopen/vi_32/ZaChiax2zUPHOzoHujJ4gibz7L1vJAdv5vQa4Heibs3ImnFQWxclaHCWgCxgUiatmVsTTx79OIgpa3rFcEYibEJu6OA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (132, '', 0.00, 0, '', '丢了幸福的猪', 2, 'https://wx.qlogo.cn/mmopen/vi_32/dyogcxtG1icdtNm1GicB5gef81TJcsO75uNLIcW2PIAGjr4ctMeJDFxKQBiagma9CHyCicFNKX4aibP9RODW9tDIpsQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (133, '', 0.00, 0, '', '自由且孤独', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epfQLS1dDrJRHRsx4X1yJYllnAFFIE6r9UpWjSiamZEwNKdNG03CmQr8eFqat5XW6JcsOrnTGoqsFg/132', '', '宜宾', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (134, '', 0.00, 0, '', '高雅气', 2, 'https://wx.qlogo.cn/mmopen/vi_32/rpibGXelB989nNWwPCyoIicoJnUMkmKLvuTTsNQEBabXuN5ibVR8MGBmsap7aSic0g4orGD7YC2iaE9RajOW6aZa1sg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (135, '', 0.00, 0, '', '建水鸡脚王烧烤', 1, 'https://wx.qlogo.cn/mmopen/vi_32/rJia2ibMN7Vdib7yK3up9omds9pBleocOak5kiaSFor6y3KSmNjG8v43XgHa786faBK2SKtXTHBeshs5K9ibGoibjtzw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (136, '', 0.00, 0, '', '维他命、', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ibs3bZS6S6vHSpgn4ZzupdoUKpnytwiaRZdE0TMEt8k4RUlQMmc9aAH84zcw2ApuAfghYOqRH1s7gQqicn7RybSgQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (137, '', 0.00, 0, '', '若爱', 2, 'https://wx.qlogo.cn/mmopen/vi_32/MLnp5KzNDicn84ia6XaUSJrWOFVsALwrkZ7hjiaNzlvOZpxXb8yJARY1vYTWonKWmphC0vGfjhGsRAcXQib46H8icfQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (138, '', 0.00, 0, '', '十三郎。', 1, 'https://wx.qlogo.cn/mmopen/vi_32/JZzeFj5HPbibm8lNm2tiaz7R11cuhJfddESiayIMibjKANYPibiciaNhaK7cAVkr0KmYbmgxdz4FGOiccp4MfcJYPAZvTA/132', '', '成都', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (139, '', 0.00, 0, '', '蛋蛋', 0, 'https://wx.qlogo.cn/mmopen/vi_32/GHRdgayB7I3GmTvtCpoHENv6I5WaRG0naOxIAiaYRm1NKNDiciboNuMjG4khSxNQehd5Hfu145ibYG1tpLYfibiceS9g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (140, '', 0.00, 0, '', '东暖夏凉', 1, 'https://wx.qlogo.cn/mmopen/vi_32/KJUOWgZ6tc5wI4d5WW0AkWINAVXdzic2rlQtYul3icNgSp0rLiaN7ic5QFkev60QnHHiaLWvWBWaKia3QbjvWNFXr3yQ/132', '', '南充', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (141, '', 0.00, 0, '', '麻花小辫火锅店小美', 2, 'https://wx.qlogo.cn/mmopen/vi_32/vUkHlsHhFFLxHL8erpGb7m3WwksElmjcHG7p0xR68nuE6kLtXequ0lL3y9pQ7PwpCicn6QcxpBUgicxhq5tLJUAw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (142, '', 0.00, 0, '', '赵映媛.风生水起²⁰¹⁹', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Z25Q21OfnbUicKqEJh3XPCgsFBul7CFVnazsWrOhkShsreNVOhuUDzgYMKlRo3dK1BVEtRRbXCTXyOxvLGZIHpQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (143, '', 0.00, 0, '', '小万', 1, 'https://wx.qlogo.cn/mmopen/vi_32/c3m4GLJJ9gMos0xPor0SKkdmCicC15JXABfPDHTUMAibqSpQkwoE27s77b9rGKBkPH9VhpVM4oyEkwEIo7Op4lrA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (144, '', 0.00, 0, '', '燕知草', 1, 'https://wx.qlogo.cn/mmopen/vi_32/n1m5Nazov5wqmGKqXC9rXx4NRYbrqHx7MbLjibTewaMJ4oPOc2vCK8gibMxS9Wn71d79bpo90cjJsiaHyAI5AmGvw/132', '', '广州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (145, '', 0.00, 0, '', '大明', 1, 'https://wx.qlogo.cn/mmopen/vi_32/mh49eDyqRE7icW2ToiaLxS7x2DBBY2nLk7nDFia9MulceXqrT3xlrZ0Ekg72ox7mCNyHYu08dWyutWBOprSYODhFw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (146, '', 1.00, 0, '', '王波', 1, 'https://wx.qlogo.cn/mmopen/vi_32/oScwKDuxNRh8cCalbctdvPJsZ8FrCJGKUIcQfxWNicayb1r3o1bu62UDKiak4DMJWlfaHh436ZXYSB0Sm90deOgQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (147, '', 0.00, 0, '', '平价小炒', 1, 'https://wx.qlogo.cn/mmopen/vi_32/cjpk0t0ORHSo2cfHxjuPBhTfB2a636pSG63CYpLjopcfgpeicFFRRLMZ4LuWrCGJpWVVvX4kv5Ec0XMNz8k6D6A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (148, '18288968321', 0.00, 0, '', '宝兴楼（万科学府店）', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKSmsibjTzc8B63sM5JUqibuIu4UdNUEmQPcRqkzIpicU9wkkEFcvVxmJibXABo8hbJ2LIVL4lGUH3ljg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (149, '', 0.00, 0, '', '黄妈妈', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Ghkur8qAayTyp5WicHBSvGn8qhicdxBn8kX0BHa0u4pIqo84ejJFFJ6iaHfWKtm1ic9cKOBTu3oEw7jvAn7SOvg8Dg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (150, '', 0.00, 0, '', '飛℡₁₃₇₅₉₁₅₇₆₁₉', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ewyl90piajibITwjoronmJwS7N0A6l6f1Wc0TCGNAlHuMnFeJYRvxqzTTdR77qmdczWicm2Qt1WzAYxCibMgmDlOibA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (151, '', 0.00, 0, '', '会泽中草药种植运越经营地', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erickCaPQ3iavDU5ibicp7RHVT6kVLdUhB38y7PKHRMH7Pn5jqvy9xu97FxLk8HEUF1iaWF7z1B9MhSQvQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (152, '', 1.00, 0, '', '郭庆辉', 1, 'https://wx.qlogo.cn/mmopen/vi_32/RDROZoIycQDos7lRB5u17giaIDRgL5nSZPyOeYric8KdJNJFE8kWB3PMlLTEMQcqMk0AENWhjicbdiczZ9ALrm1aiaQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (153, '', 0.00, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/xhGGXWNJsicsicveqgEOgPCu8NufLMZpsrg4WzWRnFFRaIYhegnibictRLQibaSu6K7fjDAge7Q3w51KsNic8F0cfQGA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (154, '', 0.00, 0, '', '李政绍', 0, 'https://wx.qlogo.cn/mmhead/wsLbTgRR2iaqLDuVQynRa8txV7A4B7nzNFDK0vkEu5pQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (155, '', 0.00, 0, '', '楊议祥', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ZCMhhPuYohO81vARCejbBVfBARW4qxf8hAzz66InJqnNuJibwKcwYPNF0DQjiaC7MiaxrM6oF6ic0iaWmk9MqOzBflw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (156, '', 0.00, 0, '', '李晓露妈妈', 2, 'https://wx.qlogo.cn/mmopen/vi_32/cxlXiaGvBzQtmZU9oz6OSPxhHoRYic900d3MuqKQmNcExrzPHdk5FYI74N9UQLwpV55GgNQicvSrHWEy5DbcuLr7Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (157, '', 0.00, 0, '', 'A昆明灵性美业', 1, 'https://wx.qlogo.cn/mmopen/vi_32/tAs2knB1icde6YI9W23Ib3icavs66ARicF2BTCrXIseIQPKicUeyOUCwmgeu2d3xQvqIJiaRoXLWAhc2oWXoLGFWKtQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (158, '', 1.00, 0, '', '渣扎飞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/5ibZrWKF8grz1ic8GuIv20ibWibhicNeJQSep7gaENXygwibxzicw9ysiakeqQFZzHfksod4qbterG4DbUpzSxhCCIeNvw/132', '', '文山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (159, '', 0.00, 0, '', 'A火锅英雄 凯凯电脑 平安保险 李', 1, 'https://wx.qlogo.cn/mmopen/vi_32/uSYpqJrcJ3lYia6raHpmmorl4sRUheic9wCLNhyWh7ym2C7D5I2OV71ibGkZIiaHejUMn4JBhoU0lJHGOwbXykZXlg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (160, '', 0.00, 0, '', 'May.Z', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKAqGSJGAIgQLzk86PUgziaPUqKJyLn3n7OTfBk77FEqatvqtGG5wo38fsrERez96QteevktN2qT0Q/132', '', '广州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (161, '', 0.00, 0, '', '耀耀切开脑', 1, 'https://wx.qlogo.cn/mmopen/vi_32/micKtwicibasSgwF3p9D3odwlhd4ASIcmByicILy0PkFtEGOQe58UhbLd4TgbBYAwKpZmGjmeetnAlHvYWibStVw1yQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (162, '', 0.00, 0, '', '用心良苦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PbLFRZkCJ4KiagqkicQ9jp5UdvQlvkVQMEEsljvvOut37yT9TGNWLdwjbAq2xZ668Ejup9wV34U3ssuzn1qDlQkA/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (163, '', 0.00, 0, '', '川香浓饭店18288216607李知际', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PH3I8XibiaaCxibdJ7cYSOv5icGMtvrzWjZmXlk8rPbe2Yt63Ne9r3f8wXlLdKgky4icUInaukYBFe0xKHJRqXOlubQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (164, '', 0.00, 0, '', 'Alisa', 0, 'https://wx.qlogo.cn/mmopen/vi_32/kXpV5eSyHLEYFGfTzLNduiaIFSwzOOVE1IQH0JFZ5rylzliauIkgVmIuyCUOuJX8rJIsWDjrE7jdg80cC3uiaX5Gw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (165, '', 0.00, 0, '', '仪度     珊', 2, 'https://wx.qlogo.cn/mmopen/vi_32/sXV00X3a1BnUaojPuDibKAsobOswdqFBGF40v5htlMbIPmf3y1Gl3Agw7UN8xIBGYsBZ2Vh9EuiaLRaOHVPAFl1w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (166, '', 0.00, 0, '', '美食辣蜀汇', 2, 'https://wx.qlogo.cn/mmopen/vi_32/X3R4NRUtpEqt8qwOOAwJQGF9l49E8tCwsbUXoSfMLMJeTiaPcomQUE1CMQQjudkdZeicqRIcqVZBetzyiaDKDxVrA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (167, '', 0.00, 0, '', 'June', 2, 'https://wx.qlogo.cn/mmopen/vi_32/oia3iaFook2JFue327ics9gKPRBCxf2MjrZ7s6FpEhPCuPSTqtaEdUghV8MjSqkCWwfzKuVibWyPo7CWt29lZz3miaQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (168, '', 0.00, 0, '', 'soso', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Qp6EnXhUrLLAN3ia3byb9Q4UJchwDFbYnichcmYkicoMStKndh9obfWX1icTMy6thoBISnBlo7hetIVhrdoUUfJOZQ/132', '', '深圳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (169, '', 0.00, 0, '', '晓晓', 2, 'https://wx.qlogo.cn/mmopen/vi_32/tHAxgoAZ1HP4cdaHec6AVG7TXGKG27uF4XbR5sBzFoycaiaGwOQHWafwoLFiaCH0FhNsLxD0IBEibkiaL7ENib44Hng/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (170, '', 0.00, 0, '', '歌蒂斯美容美发创始人苏菲', 1, 'https://wx.qlogo.cn/mmopen/vi_32/RSwYKEWdSrSaib5UgWE06Uib1rXqmpq5zoLUicok1FMrMOu5qSM5yWvFbYlOjrOmdIQNFxbuib6dhpK1uJQHWKqaxQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (171, '', 1.00, 0, '', 'Tmhtj.com', 1, 'https://wx.qlogo.cn/mmopen/vi_32/BFBMu17McicicGWFtu6NnzjibycEzibKmYdTrZmjWTwu3rQSBWZHDVguPmHexl8wicaujbqCSFPToPdj1y4SGKUTs2A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (172, '', 1.00, 0, '', '微笑面对', 2, 'https://wx.qlogo.cn/mmopen/vi_32/TYDfpP1M6d8leNPjH3HCFH5fmmLV1nIdbianzics1GGLGUicISNfhrPSY2H2s5X9BhJCgf3kqhZUtTlLibuZcJDibJg/132', '', '济宁', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (173, '', 0.00, 0, '', '火锅菜', 0, 'https://wx.qlogo.cn/mmopen/vi_32/frDCXspmCeKOyiaib9qr2ibnNqf36hfbCfHv9qEXibBJUc3bSTdSrmoOENCPGhe040tzzicsyTTuxoGvLLYz40onyicw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (174, '', 0.00, 0, '', '尽人事 杨云凡 二十五', 1, 'https://wx.qlogo.cn/mmopen/vi_32/2nM9PaEsM4Xv6oEqicObUDESiaC50RXmmKTX3IjCffiaxCAqosSD5xO7khf2fjpmK0bKGtDzkotB7NAB5m0mJYSicQ/132', '', '大兴安岭', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (175, '', 0.00, 0, '', '娇', 2, 'https://wx.qlogo.cn/mmopen/vi_32/hP4XvwAqhicehUApRpFAcVQlQwBtAt08wejroZ7NAoFKuEDt7gq4dxWz30UQXTpQbEknf2md8bK5EmsaF6kEFtw/132', '', '福州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (176, '', 0.00, 0, '', '谢丽燕', 2, 'https://wx.qlogo.cn/mmopen/vi_32/iaqJE0vcYNFicvv64SXekiagDgUmfpPIFFiaydRNf8cY0POvMB28SoOEib26BWF8nibpFqvgnBSgOf3elT3Aic15PuHPA/132', '', '六盘水', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (177, '', 0.00, 0, '', '三二小龙虾', 2, 'https://wx.qlogo.cn/mmopen/vi_32/1ZTmzhXC6F2aLnytGfNxuF1fLvGeeU5ewoibn8WB8ux71XW3gibKPLuicBo2CQc2CibPRFHMqSRfgpPNfSKC8NokDw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (178, '', 0.00, 0, '', '《黄牛谷昭通小肉串农大店》清真', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIJ2bFk9MRACheGcAHqVmYtIqtxAAfib9tku3YlTcIqWicNWeVaW344v1VsktcFu0ymQEfHzT82k6oA/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (179, '', 0.00, 0, '', 'A0唐白虎点蚊香', 1, 'https://wx.qlogo.cn/mmopen/vi_32/6S79oKsrSouRbgawhA0UTakomfgtew6tWWqO1yXrg85ltJmicTgLYJsp8BWrMu89AwUKQG33ZtCja2ZI6KO43mQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (180, '', 0.00, 0, '', '追风', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJbGniabaCJSnu1YBRPc765bJNffUagjt30lYf89QDicaWwUGl2MupBqXBggj0ZgibB0Bj3HWVibfO0FA/132', '', '成都', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (181, '', 0.00, 0, '', '橘子夏c', 2, 'https://wx.qlogo.cn/mmopen/vi_32/vqvgQeHfIhqtJgbFtR0pC4emzbTBH5W1bWmBemP1jHXaiaRdwzXickwMbLS5v4OXZ3GibAM1XCeO7IRcicITmn1AyA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (182, '', 0.00, 0, '', '孟滔', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ZfCY8a8lWS3HB6IKsyouwoe4fic0PIw3s9DUGdMAOs6ESiaicic6573TuZlpteULCDp0aOLXXWKqqRNLIp7rWATAzw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (183, '', 0.00, 0, '', '本喵不吃鱼', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqSxntVLJ7wq6mB6g0iaUc3FSlficEZXiajx2qgadWXiatjzedJNejsEibwEkrGMicqPyGU5ATdZGyjbvOQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (184, '', 1.00, 0, '', '^缺￥爱^', 1, 'https://wx.qlogo.cn/mmopen/vi_32/E9qE87Z8DIuNbnWe8VA3hId7DfR6jKfJrpmGzMlTGaicvMetzF7GNkLhfV48rElT5poYqDlQl9uAmDAtYKqQPicQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (185, '', 0.00, 0, '', '小野马', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIe22JMVPsqzxlic3YBibP0VVtnWUAqSjBc2ibicZ4Ihbx12kXYib8mYv3EcD6Um0T31vL83zwNLAw5u4Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (186, '', 2.00, 0, '', '穿错鞋子', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Vx5Ca48Rwb5IXGCvUS2Sjia9RNicJT6YQAX3bIhbIo0hds2IW8pGN9BDFytQJicibicNHrNicRiciaOdians6Uu2UQu36qw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (187, '18487345010', 0.00, 0, '', '正是在下', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qkJGD8TVtkQFbUeBeyOunzaKGnZqWaCtURWlTlltJt7dG5ESRUFzupaiaka3S7XDNUn5bhYfnW0Kaj4Q2NmCyicA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (188, '13698743256', 0.00, 0, '', '我在微信上等你', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJMvDO0hfiatAIZX1SGQLVX2OasQe8tlJnbS6WEgFiauKKnPAx5JlFmlwfnbBdPH3U1uicWkavicRr3mg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (189, '18288727713', 0.00, 0, '', '飞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoNURGdEib9eZmND5AhyjWibPSOwEf0M5yy9rxftpLuu0x5EVDpUKyK3wnLwibgRgyDT73NelqeQQgrQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (190, '18787854443', 0.00, 0, '', '流', 1, 'https://wx.qlogo.cn/mmopen/vi_32/RU0MuxZevfIibv8300UQUITG4e29j8ic72ib8TboFiatWmyvbmLVEz8niaZqBMibdHcLEwPlt4CUzGpsbGVgK6U2c1Tg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (191, '17608801205', 1.00, 0, '', '莫黎', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PFaAUqJ9MibPgAL2Fsl6miaeQkSb9rVxytcD7ewfWJXyO5puXicHFmIZY6nn7p0dO18RSsY5ztCBhIZ4U21ibK8KHQ/132', '', '保山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (192, '', 148.00, 0, '', '拂晓', 2, 'https://wx.qlogo.cn/mmopen/vi_32/N2yGictSMB6gzQicGaybSjs9xEgvrUxFsnO4JqDNSx06SsmlxNlVPjP26qbYXRB48DMFQYts8xiajGgBqRG67gswQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (193, '13669769598', 0.00, 0, '', '何梦琳', 2, 'https://wx.qlogo.cn/mmopen/vi_32/lDhY8rfTHxeJo2qw3Xmekgiap5be32QHyOAtTB1doj674icmyr00WkCGWeKjZJbPic9YaTnwowRndfIE5niaYJ1Fcg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (194, '13668739275', 0.00, 0, '', '钱方', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Zk5Yib5Ux1Z8PwK7xZjB1L916ckYn7xBCUDtIibs96VwZ8iamlofrmfLDUVzeNsFzejlBM7vXxCJe1mfx4dfwSTaA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (195, '15911627993', 0.00, 0, '', '孙宏福15911627993', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ephyuqAymtlDH5SqHwM3e206FQh76R6Na3598BfxZib79MrP4IlgCqic8rCupV1qffGwDJqU5naKAUg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (196, '', 0.00, 0, '', '小阿方', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLtzkzxy7XfEprltSicxSrKIJS7IdRbJx5vnqHnHibDMOVnjH4HUHB7ibEomrV1NuV3rUVicAWTULPpfw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (197, '15368469178', 52.00, 0, '', '婊珏', 1, 'https://wx.qlogo.cn/mmopen/vi_32/xcB6mPP8PaMwnmkBzic2ibg6nt6OdmBA81V77Nqe74SSlaLCciby1yW6MgbcFA9wiaT671cELdUh62NhNE54skomBg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (198, '', 15.00, 0, '', '潘潘', 2, 'https://wx.qlogo.cn/mmopen/vi_32/x3cv9NnolicnOwNaSibDdWLLbAHC4icf1icj77CNlCSSBc46VLT9CVvuGC0J1RPf2I0y9zwyu9pOUhDd1l8pSYSBmA/132', '', '玉溪', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (199, '', 30.00, 0, '', '草莓棉花糖之默默', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo8fAM3OBZ17ww8vwYuNvG0fTVicZM4ypV1Iic0r3rkkhdib0wj0y71M4VOcG5QeibUat5Q6vHkN98xNg/132', '', '保定', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (200, '', 17.00, 0, '', '木子', 0, 'https://wx.qlogo.cn/mmopen/vi_32/yg3ZKg3Hl42PVlica6BAKXYGKGWDWQeNlEyGrw80b0EfwnjGn2YaKq8yVQ4odbI0EVqakicsIhbOEw7icu6GxXCqA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (201, '', 43.00, 0, '', '白色花椰菜', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ibqGBe6ddibd0EeG3zvLibDcJ6hzsPcQgHBTKd4mrY7DGjFqToD3nMJldAPuPxxoDnrvMKobiaQHickSAeVCBKVMzzQ/132', '', 'Kawasaki-shi ', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (202, '14788016431', 15.00, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Zg7pZ2EFScs80VhBQ5jibNibrDut6uEnscUFHHibCIvurOFFHKg45FYKVXugRKcfv8WeqJFJ3RnpVMQbgbe6SWA0g/132', '', '西双版纳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (203, '18314416917', 3.00, 0, '', '芷毓', 2, 'https://wx.qlogo.cn/mmopen/vi_32/xxXzy00hSf2fISAoic4OqLo8mkv1jVjmjc52TUI5LVwEGITXf1YCKHRm0tY93BicMqbbN5hsr1gzxqRvBw3jsUicg/132', '', '綦江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (204, '13888633098', 0.00, 0, '', '兰冲', 1, 'https://wx.qlogo.cn/mmopen/vi_32/8AdGbqzNET6fjZiaBUdzxeuXtH0ickibwv49Ty6FHsgNFKlsibqvUzX3eGmFFSASV8KYic4pLoPnTLo4hwaIC1lf3Ug/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (205, '', 28.00, 0, '', ' ', 1, 'https://wx.qlogo.cn/mmopen/vi_32/eU8kyWWkSFDqJ52zLzZXky96w4jxvBmces3YRdOxHRZWicFFOuQvibZhEQYTSPRDDUHQh0n1g5I0ic3pqMxOgo47w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (206, '', 15.00, 0, '', '无限循环小数', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEKDK97fhicl3RhfyqlmYNia1LYbLGADSyWv5EqiauPpvxvJMe0pOib1e3wv4p8lFY6h9VeicLXoCzOHicibA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (207, '18987169227', 2.00, 0, '', 'Amaranth。', 2, 'https://wx.qlogo.cn/mmopen/vi_32/xfhgk8wR3Drcliaib6JtV1XPulTedBjNTrDOCVVMkkxicJsb4kqqoGiaibcRQaAxwNGSkibLxLJcDl1ClpRiaIOB23W8A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (208, '18313945149', 0.00, 0, '', '西木整装 余育春', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK2u5JTRrkE8s3boc0N9zbrG4gwAeX5apvFicCHNsBqdkkakaRyaV71PCicWCwCc1j1FXXTNsSVbUuQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (209, '13888290160', 1.00, 0, '', '东籬白衣', 1, 'https://wx.qlogo.cn/mmopen/vi_32/AzOm0S5Ar1j1rCFtibx2FFWSgStZGe5QG5ekdicXB6Il9WAqQcDdjFvSTCjcQEyHeg9wo5WudUDIibZFauWfgGszw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (210, '17606926475', 5.00, 0, '', '凯里', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI6TmRIboYSwz89Pj2VmKDKvQGa4hCphop3rRkyZ9vuoBg6ZAgJD8NkmswYuEZuIRaJTFMXKlMf6g/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (211, '', 114.00, 0, '', '兔兔多..', 2, 'https://wx.qlogo.cn/mmopen/vi_32/pBeX5GQJcTNOZibicgX3Uoib2OF0BINj9NkJFkcibZicKoGl1IlicX6gt9loHiaj3ia5A50Pd78zFAtJS9C93Pk8q1kBEw/132', '', '许昌', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (212, '15662190812', 0.00, 0, '', '黄花菜', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep41Q9OMgmB7IBmvBCwWsGkibEGiaYAT7rxkbWM9yxSaJY513wLngELibFXFTowmOibIVBOZBDu5YsAZA/132', '', '延边', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (213, '', 0.00, 0, '', '张倩纬', 0, 'https://wx.qlogo.cn/mmhead/ia8Xiat95coIrVDJJfPhvSzDzqt9NiciaaUKONhbicgrDopA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (214, '13888845221', 7.00, 0, '', '潘师', 1, 'https://wx.qlogo.cn/mmopen/vi_32/B0P2cEhA11e0x3eDYXtmAP7MfNubMIYFlIo0UlOKnaN5PkfWwPial8qexRhHBVicBnCgNf8EVob0sXHGCydnzCyA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (215, '13769564331', 1.00, 0, '', '吉他不及TA', 1, 'https://wx.qlogo.cn/mmopen/vi_32/xCuSHusxZP9oh4aLQGluInEjnocBM4rol5nLVTiaq1IrG6j45kkELBVjwjo4YLiaiardRSAf2FdAtS0JA2E3V21ew/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (216, '', 0.00, 0, '', '〆晴栀 〆柠栀', 2, 'https://wx.qlogo.cn/mmopen/vi_32/PrghAhO9C0avuxzSwtk5q8ficiczhhbCLdqbhuckO9YMJqIk772IbSjkgb89Zv11NRkHyzialxUgfgvt3iaYJqibUSQ/132', '', '内江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (217, '18208716944', 0.00, 0, '', '咿呀咿呀一', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hsCnOklgv1lAEOJPBxjbyrjUAQDvRQibMTicR30EYItsWcRmUHaClyyofoLOvt0YxxH4XqDY695l4dibnW6L04T7g/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (218, '', 0.00, 0, '', '不忘初心', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJO0V8SrE5rCuyugpLQKKRQibo9XscDvXSia3aX3usoozdnn43oT8wL31DJ2JaRrCfSicZC2qVVxw8mA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (219, '15808871552', 0.00, 0, '', '【空】和【白】', 1, 'https://wx.qlogo.cn/mmopen/vi_32/pPM2P2pdJwya0e2HjOxCFot5xDwMoIJh01LuDWYGggxCAnBLQl5D111Q1CbX4w7UX5Fe2glGyPcH48tQO7rMyA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (220, '13888163933', 135.00, 0, '', '一朵云', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLxib1Z3Rq7AjEUP6UIn5d3UE5JzqKh6a3BuPnmZm1u3Gyejbz83rIqcKe0v00c6y0ENfI4fcfYYbA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (221, '', 45.00, 0, '', '精灵', 0, 'https://wx.qlogo.cn/mmopen/vi_32/lMCrUFT4fWb7t8YIJwMMI8klTfqc6aVHYOyKtXw1QCEC5oKkMxR97GykhYTwNOMdicvzYtDictZL6xbXa5E2z9ibA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (222, '', 155.00, 0, '', '久帆', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL2TWJCkujeBP40Jb16x2n0q8Hsf1yBQTJ3lvyZMvxq6qG0ia3TlstfckKHkyGhGbyjJGRYgy9sHFg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (223, '', 200.00, 0, '', 'Ho默', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIc9oVEW563Vuh5RsXVPNHIibQImOqQ2KiadeySBQRHbUHbtEp5yOrVpribKtoLZu5EtLKCeyn6egNwg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (224, '', 56.00, 0, '', '嘿，bro！', 1, 'https://wx.qlogo.cn/mmopen/vi_32/vguoxV6frlJJsrXEPFvopNibOHJboAQcILd68scA2xhfucV5piaEZlgyswHKz52UNr4icVqWibpgP0iaA7AWspUZuJA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (225, '', 15.00, 0, '', '小女汉子', 2, 'https://wx.qlogo.cn/mmopen/vi_32/qb1DTKftxIUrmtqwI59TP04sdngWnvWFic5qicQhpooj4E2JSsVttQuBKyfeibb1wNxiaibictq5yTWicXBCjc2JF6C3g/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (226, '', 13.00, 0, '', 'A. C.', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKIiaicGtg6Xas1SvIg6VAhQJ4c1NLhUA7MsJfZEkq6jTrZia3DuFibr3KXHGpfyxqFiaYeibOaV9cADhicg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (227, '', 0.00, 0, '', '初夏蔷薇花~金凤', 2, 'https://wx.qlogo.cn/mmopen/vi_32/FVbnsfkbudr1IvCn3RO3gsD2Z4jeU9ibSsg64SRRq9Nqt6iaxcc6QXpvwhCB7dAELu9SxUkqMNNjDWJNeMNP0JdQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (228, '', 46.00, 0, '', '赵圆润的狗', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKficy9MkomP40jEBiaibxBCyKqU9Qcs69Ly6Sful0ytk6AH32hCKL22bBBhlLgLDpTHN952gVI5yCuw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (229, '', 0.00, 0, '', '柠檬不酸很甜', 2, 'https://wx.qlogo.cn/mmopen/vi_32/nNo5AcveNK8oAfJFVewZnB2JbR2rABMhW06K9BOjj7HBibwKgQ1JQ4qPqTcmV14ia7wK1zQccPetMmoPxicjJVQdQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (230, '', 1.00, 0, '', '曾经有梦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/0iaGqqJtNGroUKvQfgCl8l4ticUBkiaAj6etoiabjdTUV92A3pDzlhsfDSMtfGpJTe16EpIVtu58wyRjnVSicN6eqUw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (231, '15288208498', 2.00, 0, '', '海盗船长', 1, 'https://wx.qlogo.cn/mmopen/vi_32/AxeprAw4A9yPryAzicRVlNLsvuO5AaCFhoN3K8kPwLiaAjGCuicqb51OD8EMvT77oYib83qO3vGRaPnkRXhnvDvd0w/132', '', '西双版纳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (232, '18787427322', 0.00, 0, '', '喵', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqt6kWhJMrTD0uJDCpCt4rLbd5JgIXraLSwOoP7JUWicyqhBMJFX6reUmcRsM4Xaplt0aYFbvvzNtQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (233, '18647070520', 13.00, 0, '', '只萌不软', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoNc4aUZJT2wwFdIeYMiaMOfFZYLnmtmT9yiaMm5FJN06bEYt20HXEkNlTv0hicZraTe790kzTbEBLqQ/132', '', '呼伦贝尔', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (234, '', 0.00, 0, '', 'HeET', 2, 'https://wx.qlogo.cn/mmopen/vi_32/BEGdCKc9mf5r32kDsSRAdMsTISbzxvGHobicrkrpBW1a8YfVHhMxqh25GcOdJqfWAcYO8WHzrIkxd6SzvmnI6fQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (235, '', 150.00, 0, '', '^wing', 1, 'https://wx.qlogo.cn/mmopen/vi_32/mrUuqBjQA6YyuBsvGQrbWxojhRcQUo1wNqYtVIBDUqcJO2MVZLX0DE0JlryO1B0YRvUGtFjGbkMm6Ks4D0iaNYg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (236, '', 13.00, 0, '', '???', 2, 'https://wx.qlogo.cn/mmopen/vi_32/upjAVUzpBHcSNOL47RTibGcicWsTE2GDnhmI56GKO53SeZSgiaK9K7JJgjpkI0ibYdfpg5KzibXeS0XC5X1akPswhjA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (237, '15182901757', 0.00, 0, '', '麦芽', 2, 'https://wx.qlogo.cn/mmopen/vi_32/RfXDGzwNudL8aPCP3NbpXF6Xs4cX1Z6pPmtWrZUOpLkWfU0zQqFmICrRbia9XAR6BIBop3aEszSCbM0RlaMJd5Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (238, '15126186793', 0.00, 0, '', 'So', 1, 'https://wx.qlogo.cn/mmopen/vi_32/iaEs4B4Wd4orr4B8GWp6vib03yYoWdUf7AEBiapibj0GhoYSXzptxOVibbllJoYWvbicDMnV7feiccUgrg5bzibrK8sicsw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (239, '14736463450', 11.00, 0, '', '颉', 1, 'https://wx.qlogo.cn/mmopen/vi_32/9iaqWHYPcMHPBYWrgLiaqKBAO8pMRSAt3Fj6DHFaicOSChH58vM7FYiclMewfTEG8n2s4hgCjlAJIsVUWYRckOpyyw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (240, '', 64.00, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ibWDZynVGa0otVMdiciaRpL8NwicHaYjSN3YbJB5CHJJvbicVlj3fhYaMCkMiaDaSqEuYH53yPFhSKYA8TEibbXAAscFA/132', '', '文山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (241, '18487183418', 38.00, 0, '', 'Lovely as I', 2, 'https://wx.qlogo.cn/mmopen/vi_32/RTGMMLLQt2EZELuXWqQy5gQAQlnQEibqbK1uKWw5DAqGImLga9AHribXKPgQb3bGHguEkyILh9zlXYibKkqJPlsTw/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (242, '15594797517', 0.00, 0, '', '你好 再见', 1, 'https://wx.qlogo.cn/mmopen/vi_32/jY52HuMUn7e1VmqNia6KP3rLjSbvpg1wQT52QuufxV0XOcibFUJabE8TsdOL1icezldd2h7sr3nnIREaugrAyogXA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (243, '13330559812', 34.00, 0, '', '一念执着￡', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLcTkJ22W7yH2bVfAeGE3cc0OG8dI8RHicyA1NoK7Skfx7AF6wKxQDKTo3GBY5FZvcG6tIibGvVfbsg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (244, '15887194917', 27.00, 0, '', '初拥', 2, 'https://wx.qlogo.cn/mmopen/vi_32/UrbOs55KvtJXgMkm8qqCaP44I6XicXSyNzYR3RXoiaP7Yg5hoTlK0To0ajXyRZ0KVDjy2mH3jOwXqzXArSAibiaFRw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (245, '', 40.00, 0, '', '???', 2, 'https://wx.qlogo.cn/mmopen/vi_32/qdv9iaYcbzWXYn6I0OZ1SkbG2jbzN4KwxdftoLm6bLPA9YHHF0Z3icZxmRdF8so9hj7tYodTxUMP9MNLKsYqPzmA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (246, '15123425414', 46.00, 0, '', 'small', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoZI49NMJnAc8P1qekVVMyCFeiciao0ibVQhP6F1evzc27hRwLyxN4DSW6ChDGqEDoWxjibQibkfmcEYVw/132', '', '巫山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (247, '', 0.00, 0, '', '周军', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJGyOYkcD9HMVS17obQpDAfJdSfMJugUMtrayeswqKgRrz5qP73YmvfagdiboU3Oqx3JqdgBFKBkQw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (248, '', 0.00, 0, '', '刘晨曦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/4tBibDDRI8C4mE4tdJHf8DQpXbictibs2jHGX66F51MyFiaxicgMoxIa8tsjk9CpIYltl8ibGH74Ux4D7UEPgmSZMayQ/132', '', '九江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (249, '', 25.00, 0, '', '嗯嗯哈', 2, 'https://wx.qlogo.cn/mmopen/vi_32/brT0wfIv1Wu7caABSNQzcOmr4vj9sNpTWgK0yOsPEziaooEHPg2ncS1gUVQnia0pQxrrdsibj9sRyYHQ0BDBkEtWg/132', '', '临沧', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (250, '13294946913', 15.00, 0, '', 'M r.黄', 1, 'https://wx.qlogo.cn/mmopen/vi_32/4wWXAgmIlDKzytZDB1eRiaFkDWAFoF49oHbSeudGbRQ4H8d9ABOiaD5TvX5iaBE9kwXqYnOEYDBv6LVMWljcyvczw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (251, '', 0.00, 0, '', '夏已微凉', 1, 'https://wx.qlogo.cn/mmopen/vi_32/9Cs0fouR6nxLIntCDS6yDT7UdWSsZ939Dxy0wBvufktKkSg0wm9Mr8NcAesa36EP7g8xTXxnjQAJDIIJ900iaibg/132', '', '泸州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (252, '', 0.00, 0, '', '候鸟', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ibL2TGViay8YKSIico1Vt5qHCcEN40YPHZP3UW7XX5Juhc4wTjIibU2xribtjRLp7icLhfRBA0C5gBNjricibtLBVhKibdQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (253, '18313577348', 75.00, 0, '', '^O^逍遥^O^', 1, 'https://wx.qlogo.cn/mmopen/vi_32/KpQQ2YdE9L24hILBqicByp7H6cAiaXjfph2VoFibQpGskUg2oZu0G0yBLLfGTtnLfUooO7Cic6icfP7OWZ5ibUmHYRqg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (254, '15126158366', 0.00, 0, '', 'Amanda', 2, 'https://wx.qlogo.cn/mmopen/vi_32/vTr4UOVYokmNKFibRiabKPB5dvzZib0MkJ9PkhHHsr6kUNsGM4n9gOVHw8kVngOwRicrxplwP0VImiaicbicfs155Y1ng/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (255, '18388821253', 0.00, 0, '', '此去经年', 2, 'https://wx.qlogo.cn/mmopen/vi_32/jbiaicTeiaQAWfjruhibKGQw7utxdc466vs85ZiaYBNibPaqDIOhA18DePAWrUjx1oaFMwqwf5S4DS2B6L6KfibjyibsCg/132', '', '丽江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (256, '', 0.00, 0, '', '施主请留步', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqJDx7syzw4SP7e1CiaRwce6eG6lslT8KkWE6pCpjvEpYxvydlvjeSkoSzowspauEibGdXS2wdvTWjA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (257, '15186051337', 0.00, 0, '', 'JIN', 2, 'https://wx.qlogo.cn/mmopen/vi_32/62PiaOEH2EWialzXEBqxqbXaUUGttIf5icQiaRUicfP78vRiblq4U5EBmnCh5g0tlxSWAr79NpE6XIZatR361SPuoD0w/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (258, '18487194071', 0.00, 0, '', '天天向上', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hEibddaXFhzw5kCmwJ8iaqkGPRXfKaBatlw9ia3or0KykNvJeoyiaaywEVLNEpLK0BZ4EK4bxdV2uas3UM442ftNOg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (259, '18314548672', 0.00, 0, '', '陪读小书童', 1, 'https://wx.qlogo.cn/mmopen/vi_32/NKIf1oOzicP9kzvZH15S83HdziaVXleKvFjrpibkwcRDkmibLhcWMKyt3Ct0kwK5dkTCDu7tI7nw3gmVjaxSNQEGcw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (260, '', 20.00, 0, '', 'zhao', 1, 'https://wx.qlogo.cn/mmopen/vi_32/NdMT1rC19qbIVVSYljW3gB2vbzic4bn8xARvJBB2LeuETMjY2eueuSfroP7yKs2V9eTZxdZNXVw3EO5JialmkZ5w/132', '', '阜阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (261, '', 0.00, 0, '', '滇镇王毕军特色小吃老板娘', 0, 'https://wx.qlogo.cn/mmopen/vi_32/9YRh0gX8z9zs1IhvYP8OsNrvxgtBkHnJtic7kHDoabI4chVryFBUYSH7hicNEGbsUyO4ibEwcaMvdARqqbjrcaFbA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (262, '13114265060', 37.70, 0, '', 'Young Tiger', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hNVMG2tFVzX4cVsPofaNxIdJnhg8Dib27QN0zWsfkDtGS4UInrmyAwAvQpYnWiaFGhMI0B0icWR3MNPqQNcZSJyYA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (263, '', 0.00, 0, '', '滇镇王毕军特色小吃', 2, 'https://wx.qlogo.cn/mmopen/vi_32/9tRJ5uIwClh2eJ07icib7RvxAFs8mibQ3Y4qm9sUK5VZMuddjOR6AbZVichy5aFGTycFEMoXCYHTkAaqaNaPCtibfGQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (264, '', 0.00, 0, '', '子君', 1, 'https://wx.qlogo.cn/mmopen/vi_32/wFlDjMh3e86hdcBoribolibBicFOiajgibM3srOf9rw05l88wG4cXqMPnb92svwaDeX9PFicYLU5b58QysdVWXiapUp6Q/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (265, '13888154671', 0.00, 0, '', '张云芳', 0, 'https://wx.qlogo.cn/mmopen/vi_32/nOibvZyGp82dZc7Micx9eTM8tZwtlibMicay7GDYuNyhWxuUsaRVsmNB4Xxr3icyEfzAFe8rBSe4f8ZzfwolFPSlITQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (266, '', 0.00, 0, '', '非淑女也，', 2, 'https://wx.qlogo.cn/mmopen/vi_32/m8avHAEOianUE1hOiaLM0L4z60jK7xlPH84QHia9Vh8fXgCdgEs8NUYXgCa3Dju5JBbAp0flcMGFKZSIgsp2JuhGA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (267, '18725092547', 0.00, 0, '', '云沐夕', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Xtl52aPYXGmQx8uWibKJQCwXoX62ZvtPm9Gr1piaicFBSntSErS6X0mrbsyKrN2vLiaNsb7r3KtjlyuuWSTTMN4LmA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (268, '', 93.00, 0, '', '李新平', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIpsDZlxGGzJeqnlmdTPibJHXFtyhq7FtWfqPzuvX74mtz6OHNyibPkKuuq5SVY3QVRIHTCw3sB21lQ/132', '', '邵阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (269, '', 102.00, 0, '', '云下公司刘玉堂', 1, 'https://wx.qlogo.cn/mmopen/vi_32/RkJ7EG2MmNWBrk1iavDo2Br1AnQhYOAyxKtZIpULeKaMkh9LKXnF46b65aiaIfAGOiacbKBLGsnqsjynIPqbOOjEA/132', '', '九龙城区', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (270, '', 14.00, 0, '', '神话小春哥', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ias9ibz2pcbEn9k65vN8vGKHqOtwhYbmnGlPWuKBFDFqAfJvPMbkz3nia3EYgomiaoXujRG9JEUIudnfklO6HsCibiaQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (271, '', 110.00, 0, '', 'yzq', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI4IEU2MQMqaYR3rno4IBkjbVsRJIFfOs3ZIJCqozCdtKj754oIXyVJdxD6YyBkFGzwY0bFVj1yGA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (272, '', 0.00, 0, '', '绿桦有害生物防治一杨凯', 1, 'https://wx.qlogo.cn/mmopen/vi_32/UpFOABKIoHyKaSiaScO0yCWZ5AWtNWyLv97d17X26a58ZdGia8dfIthNOZCBnu20zk96EL5L9fztpWhY4xyp6vEg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (273, '', 0.00, 0, '', '雨欣要开心', 0, 'https://wx.qlogo.cn/mmopen/vi_32/iaMhsEREDzich605691B5SuSicuoP4xn284hib2ibApzdHgU6U6jFibhs5wJPe5qDnG9icyvjtoHYp2NyCBSLnqQsEwFA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (274, '', 0.00, 0, '', '橙子味的橘子', 2, 'https://wx.qlogo.cn/mmopen/vi_32/8vurptbzGHicLdcYoWRLFWR4NtmoO1fQGtrzgSzCx1TicY4RHtLFgUYmvAZC28AMYZMARBiaUtolXpjZWfRcHgXzw/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (275, '', 0.00, 0, '', 'LLau-', 2, 'https://wx.qlogo.cn/mmopen/vi_32/1pLgxW6zZcxEYy9ytjjceAJI1ibOypRFEBFia5LXIkAqUL18XrU8zKBzhf6Id5ygraREUiaNCZGP8fiaN9Z2ntnH8A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (276, '', 99.00, 0, '', '野区养猪的男人', 0, 'https://wx.qlogo.cn/mmopen/vi_32/VdwAzW2yibzykzgaOibkheQUKltR5hyHzoswic1uuibgZJJJzJ6Zz7WYIvzVsZhS3I1TTDW8diclodPH2E4OcNggOpQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (277, '18083837579', 0.00, 0, '', '小米渣', 0, 'https://wx.qlogo.cn/mmopen/vi_32/SaExlbFiaibB0ME7Vq6Rta1uQHicAxeYZfhk20oxlOSnO2cxgW8YFfXPiawzZYVTiaIQCCYCFibnlXQTCxI6Dv7qfTCA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (278, '', 0.00, 0, '', '笑忘初', 2, 'https://wx.qlogo.cn/mmopen/vi_32/0uhFPogdWavYdmZwiaJhESpXOZOsfDV1NLl1iaSTb7kUnMxam0DeA8Rbjrk2bBVXLDXCgQGcIxf9KHSX2GH76sng/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (279, '', 0.00, 0, '', '惜缘', 2, 'https://wx.qlogo.cn/mmopen/vi_32/vKVnibuHop9JBEG1YK2Of8TOmjyh0JvVM3sDo3okwmrRwLHzZ9nHgQXib269GlRGib4piaiaSlnfH7EXqmgibROrtydw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (280, '', 0.00, 0, '', '优果颐', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKBKPF7QZfDgxBqgk2XOfG7I2RicnxaPJqssgMqJiaxcj1Ql2nHmXfTvI54zZP3cwBwm1pMsLsHJzBA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (281, '', 12.00, 0, '', '闫敬明', 1, 'https://wx.qlogo.cn/mmopen/vi_32/aq2BicJ2icHY1m46Z3sxaFOEsiaib8D4lPqiaySiblTuibCb9baWuw9RgwA5LGn1WaNibM8cQXQweuGicGwsocEDh1zwX3w/132', '', '宝鸡', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (282, '', 12.00, 0, '', '没有', 1, 'https://wx.qlogo.cn/mmopen/vi_32/2tPoLrBZUXLUGgibjvSaniaZ0oqx348Gn4xaX563lFv1X4GMKjs7rcYKib1yTZceiad9kbxPqhFozm90XKPjKkkiaeA/132', '', '洛阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (283, '', 36.00, 0, '', '忆缘', 1, 'https://wx.qlogo.cn/mmopen/vi_32/h7hzHoWzXTlUvsXqk9UuXiar5RMYzhag2qlHqnjq9ictwscWI5aibrju3WjAYRQeDDLM8PIsoT8icjtYOHbfQMUQbQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (284, '15587214089', 0.00, 0, '', '嗯哼', 2, 'https://wx.qlogo.cn/mmopen/vi_32/k8g3JxSJcA4kA9ibj8AEiaXc0ziagltbvAfYwZ5g83z6IwIrJbeg3nGoYI9MVspYqXKDVibT7FXtlaXicjLvbpp7nCQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (285, '', 48.00, 0, '', '飞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKh710nDibgrGRE8anRQmFeIWib5NSfgRqZRiaqSbe9JH3DHtJPz7VwbLwdYsjYXsIibrtVmzq7NshE1g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (286, '', 118.00, 0, '', '7 years', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqO8r1E4icDGtqp2qMP5bshGLyAg2tRspQQkRPBLysmI4aAvsR55mpnPDAVx9QRUc3gCNCDM48Q4ZQ/132', '', '休斯敦', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (287, '', 119.00, 0, '', 'LSY', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKpicd7oBkgoLKsWMRQxtMF8TNqWoMg3HYeeYoKLh8fcPcGE603hkTictQTheNx4QUjiclibLpeGpE7jg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (288, '', 36.00, 0, '', '盘王& PanWang', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLRjPmr2NG3ibCWXfRUER5OicgS6nfKicic5uia0R6YeEWZFbgZkKcvK4x4xd8iceew6FDDah4SrNTrjDAg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (289, '18388465945', 188.00, 0, '', '刘武超', 1, 'https://wx.qlogo.cn/mmopen/vi_32/k3QkU1pguR01gfcgoayY8fCamWPT1nPLafIoyX6TPz7bRmDibryx9Un0eWlHXMjPyCkn2XSAicIr0OFFSdYnGWJw/132', '', '玉溪', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (290, '', 143.00, 0, '', '韩韩', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKLGD178f1XPDpw0iaxBBsHLNNpDicpDB4yEzuharvmoVoDR1WiadmGMsDglnfO2kTURhKqvSr7e3GNw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (291, '', 102.00, 0, '', '小か丑', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKfLxAj43sGzFicjI3YFEyhtHPPJqZPejhl0ggFM1p1nLsjzGL6xFYzqvHG5ibetuK4gSpuj6ia1tsmg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (292, '', 110.00, 0, '', '何来亏欠', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoOYm2gziamYibq3JyaNlNn4eoKyUxnKbnY64aQwwQk5DopqfUQicTJg3NTiaL60Y7l14zPBRLlqaQcVA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (293, '', 126.00, 0, '', '无情的泪', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epDWwlc9Y8CryiaFZFG9KFe41LjJEownPyRiaw9AaCY29LDicSRNpDAkma4CU4ibrkGnOv8IdP7HXjZkA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (294, '', 36.00, 0, '', '心越严胜杰', 1, 'https://wx.qlogo.cn/mmopen/vi_32/y1hibQAugKnIbTfZcoX9Rzg4DG3Xnu8MldKswLYMPZzHFntFoXRPoLYFgeejaynd095QvwngwxHHXfibJtxIhvVg/132', '', '吉林', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (295, '', 0.00, 0, '', '陌上花开*已逝初年', 2, 'https://wx.qlogo.cn/mmopen/vi_32/fh1UODEK55iaft8GDCTknZGMNsyibjBSEMq3ZAWuJ6pPGTOMsK4xCZ909J58dqMcPTcJoTHQczqPLGJ13tksZICg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (296, '', 0.00, 0, '', '尽是幻想ヅ何来华丽', 1, 'https://wx.qlogo.cn/mmopen/vi_32/MLnp5KzNDicn84ia6XaUSJrUycxpoHXBM0MsM3n7rbJhVCZrIO8JlYTcVFsibWthAVAVnajV5ZicoarmMEn0ZrrgVg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (297, '18209817683', 0.00, 0, '', '撒野', 2, 'https://wx.qlogo.cn/mmopen/vi_32/vTYthGKYZ4jBEwxicrujtOf9nFDtAgNictFOiccJorBncSkhc2sTBC9WZGtkHvkelIBcn8nA0INjUTzePYvVibGrFg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (298, '', 85.00, 0, '', 'soul', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKUc3yetiaABLBicS4XgrtShh6icTxIanxByPcAKVLSxpSQyXV5dOu4mxWlic4DDPJUJj4H1RIXSVcMXA/132', '', '普洱', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (299, '', 0.00, 0, '', '致郁系男神', 1, 'https://wx.qlogo.cn/mmopen/vi_32/WTBgoQcB7PkSicGibUTtxZ9AW0gHaVjicrWibuS2ayUmHFdicU2wWCgBFRSpo1oNNIbxHckoMYfoncr8BicTx0GdORTw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (300, '', 0.00, 0, '', '败北收场', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eorlRs6xXZLs1ITiaw5IngbTTrTrpjVrN1ria47kdguFqdibFSoSvdo4YiapEeI3A7wsyiacvnSrUNV5Xg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (301, '', 104.00, 0, '', 'Oku', 1, 'https://wx.qlogo.cn/mmopen/vi_32/bQ63I1HcPInZsAHxdib4iaJTH0D6zwAySSfiaAWVYvA35jLibwCKfS3ycPYU5wzicJib8gjuSgJrQSYoicuKyibymDoTkA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (302, '15708767294', 5.00, 0, '', '散落在回想中的青春', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ajNVdqHZLLDRmuk8zGqvAbCHuQ6ApAicFs78Pju3EDedfEc3IsXM8Fibu77AZ22Hv7DXJBIDZEqtY7OP2v1jicCaw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (303, '', 0.00, 0, '', '忘', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL6r98LSMaBtv0uPA2icW349yf1Dpksia1ybh7G4vp3rBDacJJIQuJYvSCwRfFNibib6ibpcQKUiblIYTXQ/132', '', 'Clinton County', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (304, '', 0.00, 0, '', '李静***', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Af9RdL1LFfb7YSoY2I7L73ncPsYqbTj0D16QgaxiaNMxCeA1vLozOvsibxRz3icPFJYic0hggHVOiaicXJwlfzBeH2ng/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (305, '', 25.00, 0, '', '听闻爱情，十有九悲', 2, 'https://wx.qlogo.cn/mmopen/vi_32/d30oXBrMkDlyKVvWrUjEQKfTTz9fX8fVcOtwJUP0lcGCEMvuniavicod2je7GicPgC26dSTWArACHsK269aW8Ksyw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (306, '', 0.00, 0, '', '晤歌', 1, 'https://wx.qlogo.cn/mmopen/vi_32/dft91Bd6iaIP3QibmbL748el7eeg4XeZQY9iaFQBbDngnvef5ibnpt0Nt1PaDp2LJd1pcSRBskicjJrDODYtutzTPnA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (307, '', 0.00, 0, '', '是各各邱吖', 1, 'https://wx.qlogo.cn/mmopen/vi_32/CO8km7ANWDFtvAiaRGicRyo9Gko15wTStWdJDxwvMWzt1YEBEicXBz7xCh9RqY6icy5wy5SibRPsGuanksffSoU1wvQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (308, '', 0.00, 0, '', '保永华', 1, 'https://wx.qlogo.cn/mmopen/vi_32/7xlKG75W6IKzUqzbYP4oazQeYtibbgB2RgthIzXKyJSicQJ6E5Fry5tyJTuZ9CAXyOcPmdwhfTboQF0qt7Z1Xf8w/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (309, '', 0.00, 0, '', '潇&风', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJAASLxJicKbx8jlCOXAfibsiaBH0M5GvoSqIpqWnXIicNB3W9BfyYZicWPPPWiaA5vcibGI30vO7nmLnqyw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (310, '15637229751', 0.00, 0, '', '山川故里', 1, 'https://wx.qlogo.cn/mmopen/vi_32/1k8C2Y7bFUrRortbX9SlVZk6kgicHVvlhgCTicjDbvpZMGKhKDv2xOgaaeQEOLMEUy9ziaVz34JkPEep5qXwegOaQ/132', '', '安阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (311, '', 0.00, 0, '', '唯一', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwnQtsYlMYaq1ImAA4ldcblQRV6EsRAkJa30Cg6kRsxrryN5ibSmWuic3dV3WGeH1UNv8WTb7xrF6g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (312, '', 0.00, 0, '', '朱应德(云南裕峰晟选矿科技)', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Qr1nT4jEY0TLP5k8wic8kS5wodicD5nyFgJbqcXE6a1xzwgC7ROfLm9gStJxAeEdudLPe9JKkfsHnJ8SldhOmHibw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (313, '', 0.00, 0, '', '图兰朵', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIwMicg2NS5cMdicKjFJYtbdD7WmicT9UjKQGJXPjDBa3O2KMicYrDYMiakR5duFaGicu5EKnibVAzYEmH9g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (314, '', 0.00, 0, '', 'YZW', 1, 'https://wx.qlogo.cn/mmopen/vi_32/CRsrYzTlO9IWo50a2KOB9ibiaTEdmAfhkVrlnWI5as0B8Bfiaw94HrC2pP3TT4NOkQAVreHhVrCgNQPUTqicwS4TAw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (315, '', 0.00, 0, '', '初心', 1, 'https://wx.qlogo.cn/mmopen/vi_32/xicPQIBwaT8K5nOeAPicYUQhu6kHzTIvh0GFdxzPCW2icFQibYA0yklzsaibGJQzmLOBl5gveeODibP8wmHCaINdLZuQ/132', '', '宜宾', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (316, '', 0.00, 0, '', '谎言', 1, 'https://wx.qlogo.cn/mmopen/vi_32/wsRmxcKeyV24EYsnOTOPdey5ZEs30rlbxsmj1y99HCy5xt6ibelPQug40SHzsRdNRLG0o0IQ1tQqLmms8YO3mcA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (317, '', 0.00, 0, '', '不逗', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qJJslUSOa7tXXOf52ZzDbHwSnZKWUGs5xWfarX1lcghthwQ1iashiaI1W24Zx6r3TiaxwUaTyLUZ0BMbgiak9uTNJw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (318, '', 0.00, 0, '', 'cc', 1, 'https://wx.qlogo.cn/mmopen/vi_32/g0qZJQicHXZHB1Hbxo8sTxiaSk67wG9Ch9091K3HbsH6vdPhrNZFVN1wKqaBeSVtXdqecNXcCXiagvmh1zbZqNqAA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (319, '', 7.00, 0, '', '王丹', 2, 'https://wx.qlogo.cn/mmopen/vi_32/qfQ28xjl1lvqq0TlAzN1IuFL4Eu8t6z10orlDSnZ6icdVyK1kFrAZJxrUlbrYOoX1LYrwRbIFcbsASZtE3CIXVQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (320, '', 0.00, 0, '', '﹣ 0 ℃  梦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/5pbYCocYQvDgWXTWI9YphDWluibjKicicBtol0icjIhAQKiaBR3DcCFUKAuWSVYngta0xbGEfanXCVr81sMn576XiaCQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (321, '', 0.00, 0, '', '央堅单纯教主', 2, 'https://wx.qlogo.cn/mmopen/vi_32/dibodck32RprCe98mCJJZqpcSLHFP8d02icCicIzjkgicaqoaTiaG7n8NqytL4TZrYNVo39N8TH81YDibylFxia4xPgIA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (322, '', 0.00, 0, '', '沐', 1, 'https://wx.qlogo.cn/mmopen/vi_32/7z1MuS4VPrFadT00NeoJw8l79A7818CX42TUnWqxkyg8AB4P0MvO0HeU0LoJwL9OcxWKdsicBuy8WEq64J3OiaPw/132', '', '保山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (323, '', 0.00, 0, '', '~~', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erb9KD8YAjeD3S5diawJK1YZTLjm8ibt2cfz1PyLRg19x50nJIVDfdSwwhcZIVqfgPZOgTP1UtjZrAw/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (324, '', 0.00, 0, '', ' ǝnlq', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLqMrYJIibkCZLKcUkyiaTa72RsQTKllGku4DL2aNgsV4y0BaSWq5yRDrwfpuweBe0ktGjzg8tycmHA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (325, '', 0.00, 0, '', '武世杰', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ZaChiax2zUPHOzoHujJ4gib9ecickJG8JNs2oUwpWmR101SxuAKYFiapwq2SRoPGKjTYBHGEicRJ2pF51UkAOnn2Xhg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (326, '', 0.00, 0, '', '快乐一生', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKkpApOjdIb8zuvbc9lTiaqAibdEIZSNFxZIiaSeNuoRz7CuTd9UxS3WYhZCmkpG7bp8XdkicrUNjpoFA/132', '', '南充', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (327, '', 0.00, 0, '', '因吹斯汀', 2, 'https://wx.qlogo.cn/mmopen/vi_32/xflgp3fwp8xxzvnDJ8HhWu1j33Yfcia1VTGGV5icBzZ1kAkLe8fsGIcAqQ0D2OMdTAQvibvmmAeZd27RXMAtvFkHQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (328, '', 0.00, 0, '', '陈凡棋【先行者】', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83er1yvSqawx6usXYEyHBiaam9VIjmrdvuxOcjqIK3jRoqueQiaD6lBQDZSt6yoybcCwTBrZ7MTs9Y8Sg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (329, '', 0.00, 0, '', '阿长', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLOjxW6Q43TZ0pPhcIQvCVkVDTGyHoKZB9SSG89sKxmTccX7CAUj6EBp4yvMPwwVQo3LHKPTmpgPg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (330, '', 0.00, 0, '', '丁小胖', 2, 'https://wx.qlogo.cn/mmopen/vi_32/OxB7iaDnibrsof1T5icibLraHMibxtKhGb8R6wXfE0JwCXebtnv8tqvhCEWhRicJo6uX3ibuE4WbRwgKDdAz37coKmsGg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (331, '', 0.00, 0, '', '吢丕', 2, 'https://wx.qlogo.cn/mmopen/vi_32/WumuTJnZvPdDUvY9Vwz730PI7GWRUo2tcrPJWiaKu9MkMJSzpelBSAICeZfibKf8HRWhnQiaMzhibicxf6vcn5PPK9w/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (332, '', 0.00, 0, '', '吧啦吧啦', 2, 'https://wx.qlogo.cn/mmopen/vi_32/vmibOkjyGKINuQvLDibMEVgsUGm2llb3e1icqalTbjNADLDMayMYicyOlqwAicBtia3UDvcFlRrdA6EZwiactClLmY32g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (333, '', 0.00, 0, '', '西伯利亚狼', 1, 'https://wx.qlogo.cn/mmopen/vi_32/x36iaCpkG5picqLuDrfibM1micaichvKIFEt1sZJXsOe0G5uhqxcg3sJHPJNsricu9AlXLoKRKbGvMqA5u0p5M1xJj8Q/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (334, '', 0.00, 0, '', '阿珂', 0, 'https://wx.qlogo.cn/mmopen/vi_32/HNveqT529FslkgF4ibdicpJTPXQVskL2wewicQqpJCkz7DsXQ5vY10lhL4RId7S2775wIT26QdurLGR0wCHNwcibmA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (335, '', 0.00, 0, '', '周家文', 0, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erprLd9Z7PUgVvrSshcFkHTgMRhdKZ5yVhU4pLyrbOKwfvqRiaYwYHAryBsQGrs9M9HX9lrYNpa3qw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (336, '', 0.00, 0, '', '旭日东升', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLL4vG0dKgQl2fvyxU0y5ppiaUmMsVodCJkueIGPnFv33FVO3zwqenibaFMd5SyGDCPJq7rXIyygH2Q/132', '', '长沙', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (337, '', 0.00, 0, '', '博心', 1, 'https://wx.qlogo.cn/mmopen/vi_32/T6haJKNr42YtSfHbbltibhe6zut5WavPZPpOTdUlicDrvRdLoUKmpd1ibyjxvKVgIU6Y4rwYVCvCNwzW0nYlxhHcg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (338, '', 0.00, 0, '', '徐维翊', 1, 'https://wx.qlogo.cn/mmopen/vi_32/I807iciatNXWV3icLPFSylPGMzc1zar5XJuEKZB1ibd6VKpxALUIcFeX1GcYE2jktsiasJ7aVhoKibmAM18p04ibJHWicw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (339, '', 0.00, 0, '', '馝馞 ジ 勍 ぷ', 1, 'https://wx.qlogo.cn/mmopen/vi_32/y2smdnib7JELUC6zaARRGFdhawS5NdccBibZU0hQxbZKOraTtKqfU2VRKaluVBiagZvYicCLJubWlZuKNSffMaDgLA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (340, '', 0.00, 0, '', 'Indus', 2, 'https://wx.qlogo.cn/mmopen/vi_32/SJ1zT5MlUYYPHh5DdEZISAMZBkuawCvQbsOiaQ23Zpyykpj7GfshNPhlc3U6sNLrQmEvyKgtLNAQScEsoySlGcg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (341, '', 0.00, 0, '', '牛奶泡芙', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ZnH591fAmia0TDlia7JxGC7VHhxacAHE5N8GZaXR5xXRLQ8ea10BDlLgsjzicw51zFXSXISM5GlXXRcVS5rOHAwDA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (342, '', 0.00, 0, '', '你头发乱了喔', 2, 'https://wx.qlogo.cn/mmopen/vi_32/n8CCfmUfJlHN6UU8O4NzOEta1IxBSziaQhyh1yH8GTVBPaDqqvhyDaUD5y7A2J6miaVfUtCFXyVEzEzc3mCSz1AA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (343, '', 0.00, 0, '', '平生一顾', 2, 'https://wx.qlogo.cn/mmopen/vi_32/5C2aE3Lwhz4Vklz6stDjVgwh6pPeniaFoBk7QichpjO9u4iaZiaWMo1m8SoOLKAkr9a14LlUXLPHNIicnC1nIy43LpQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (344, '', 0.00, 0, '', '八九', 1, 'https://wx.qlogo.cn/mmopen/vi_32/T3LTf0LRDiaqF4L2iaJUrIIbicRXr12Yn5QOiaGhLjM3ndTAQz37vXpA3TZuQjYpAluWtqc1BgjmXocbnnAeWopRgw/132', '', '南平', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (345, '', 0.00, 0, '', '嗝', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLD9bH4yFiaOrEHkLYvGpPgT2LJgB8gkyVyw0dBJRqNylHX2pGXQPJPHjn5uPNWp5IfsRcWxvQtPOg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (346, '', 0.00, 0, '', '莹莹ya', 0, 'https://wx.qlogo.cn/mmopen/vi_32/ic3VaWmKlggXeECljOdZymTVYzib11brTxnL51ib6Fne7gX2HylRcDoXwTmHQickRICickMj8Ac0HXqj3ictPAVqELicQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (347, '', 0.00, 0, '', 'aurora.', 2, 'https://wx.qlogo.cn/mmopen/vi_32/8DpT1vXbXSLNiaTHHDotQiaEyRTJibqKuBVRdrA3SialJgxMBsGDDONmuIiaKPF3fL5EU1gMgFg3ichUnE0xGPV7GaNg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (348, '', 0.00, 0, '', 'A 陈小伟', 1, 'https://wx.qlogo.cn/mmopen/vi_32/jia1wLuNLpu6iaFUkcNUXSams7XIVoTbFiaBqGZ6Y2ojnWof8IAy0C8WOC0NgQdKzfsibqSIvPNTA2VhAHIgmEibiaeQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (349, '', 0.00, 0, '', '西原', 2, 'https://wx.qlogo.cn/mmopen/vi_32/5UeY0Znt6WAed7G1FlXRparr9gkvdeGaBq9SQz8ciaHXaSslibqBxia6XQtWOuPYbDkicEILMibb27g8HdxvgjzhLcQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (350, '', 0.00, 0, '', '詹姆斯哈登', 1, 'https://wx.qlogo.cn/mmopen/vi_32/yUw43BzFvOz2ZBgN2pwBXnFVBxDbj7Zf26dHScgOscl0UjYwPwknX520ibFJnacOoKFqrlrtStPahiccRPDbxL2w/132', '', '普洱', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (351, '', 0.00, 0, '', 'LILY', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epJ2MYVHUZuZjhZxMfE4GDBbiaEbo7JGibibu1HFdQoV63adJQaPibGbk0ea76mmCdQYGpcjlnf8BJQ2A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (352, '', 0.00, 0, '', '斯巴奇', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hv2mnlMicQCYMyCCeZdab1zkn3gvOAtnq6s3VSpvml2m1OUzhQRv96DOvepgPjU0pTtaqyd59lriaO20iaZRexM6w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (353, '', 0.00, 0, '', '王嘉譞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKuBBITVkpA72YqzTXn1jI8wBNwhmkPR33HdgpiaRiaF1QxyicgHVsicrfph49obAmJPUmbFhxBuic9Qfg/132', '', '滨海新区', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (354, '', 0.00, 0, '', '安之若素', 1, 'https://wx.qlogo.cn/mmopen/vi_32/QA5357KPEQYzjicR7zCDW6uUoMblfFHG1mELBnBMbZGPrukw2mS9TSibXYmpsqjdWC6AK6GL5pCWJBFDZWBOKoqg/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (355, '', 0.00, 0, '', 'Cool^', 1, 'https://wx.qlogo.cn/mmopen/vi_32/wqKl2aB5M4mLB9Ssuuudr68v0HaNsuM0BvHa29nCkNx9gZvDeaKu8GFPiawrQqDwbUS1t2SDQUEC8IcZHZJveHA/132', '', '新乡', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (356, '', 0.00, 0, '', '暧戀', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ibhBOSdFLHztFFVsC9nleYvtT0QIicmkrqq2LPZI4QUZElWHpIYRN9UjE4NnyibfuG8WPZuSF3UMf7yjY27NZHBaQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (357, '', 0.00, 0, '', '。。。。', 1, 'https://wx.qlogo.cn/mmopen/vi_32/GPPMhYl2gJWwGHTtWhKnKpso2EOg8SWOtoeeicxiazZnesTnKpibBYX1ib0Hp82cx810ad4rYqbgiamKGFibicsKahDPw/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (358, '', 0.00, 0, '', '养猪的大叔', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Mt4eS7OKDoznJmn3Vo2s8nNgZefibM2AnU0QBkf74ewiaRAQr2AnN0B4Nf3YysSZJOc70IPfiaLcc20QGqbHXK2fg/132', '', '临沧', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (359, '', 0.00, 0, '', '阿克杨彬', 1, 'https://wx.qlogo.cn/mmopen/vi_32/icxzd6g8NYDc6v1ObnVibhItCvYiaybcc961qO3lGBv04fM68bA1Ic6vicRYSlV66ttibO7mt25yaLAvG5teLzpaicjw/132', '', '丽江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (360, '', 0.00, 0, '', '养乐多', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIndvgxyPqhVBMhibApVaPibQfJbwrMbo0bRkxHDZL9QPQEMX8GUDspK9YRURctlpYLUFtx041hxwFA/132', '', '广州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (361, '', 0.00, 0, '', '中立的偏执狂', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJza5d5Drlg59lc0ibZRr6DWQIutuF3TDzBDHPkWvNAHeZLCyzYVA2X5U3w9tgIWicdVoJF8pLbbMtQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (362, '', 0.00, 0, '', 'y', 0, 'https://wx.qlogo.cn/mmopen/vi_32/8gKEgibsfxPmiaSSROXv46ibaiandibxmQl9ogvVpY0UjichlXrGKBLEkicfQcuzeIeEicgnvpHM3VSZ7F68YsfW1v78vg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (363, '', 0.00, 0, '', '墨菊', 2, 'https://wx.qlogo.cn/mmopen/vi_32/fWEJsGwBz4Sab4yia5uqicEpicHkOiavUHQenNxD2xWgbcBRvg7sPZtta2bfbNBlsib9uKbalAwHaPgnos76JRmZWGw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (364, '', 0.00, 0, '', '二先生', 1, 'https://wx.qlogo.cn/mmopen/vi_32/0HxeNwa51bA7uJoyFQ1GUjria3Jes8tspmbtGRIl7u8kOzXCZibYo2DdnDQKJe2HmOmulVAp4ekMlByRv3DOiccPA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (365, '', 0.00, 0, '', '丽丽', 2, 'https://wx.qlogo.cn/mmopen/vi_32/nw0UeLoWz95SFodVI8F4q4wMXTniaDmhUXXDBiaCTtR3HYyia4ywricqMcsdOP6OLQA52F0o8Zsl1V3nTicGG1ngfJg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (366, '', 0.00, 0, '', '燕子', 2, 'https://wx.qlogo.cn/mmopen/vi_32/uROvzNHswCnJb7Wzicch8jQCcIVNwxeeItTCcJAt3VXhtMbeQUOEL4RWOXJkZKXcZzcJh8lb2HnuzHxPFWe6DgA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (367, '', 0.00, 0, '', '幸运草', 0, 'https://wx.qlogo.cn/mmopen/vi_32/qcd1qydtPaPibB5ibFYFGA3ynTAWekMvfXnflBCCcTPFBN1uhOHrB06aEich8CC5QssF3MOKOJLndkvIib3vQhOqjQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (368, '', 0.00, 0, '', '金太郎市长', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL4uWB4jhcCIWaFLc1NlsZClyf7gUgl81V1G5lEepAQANIjGbq0RY686yqkUoscPJRPcvJOFngtaw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (369, '', 0.00, 0, '', '大小说家', 1, 'https://wx.qlogo.cn/mmopen/vi_32/RfXDGzwNudL8aPCP3NbpXJ4PHb4NUPcciayqrJhk7Wh2sYdofUibRZwPzaqFibnMY4pNwtBzbG3L3a8wnQ3SaCr3g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (370, '', 0.00, 0, '', '宿命', 1, 'https://wx.qlogo.cn/mmopen/vi_32/D8bkSANQeKRhItDM1OWcae6ln1t6ybAn317S8F9xcwvfsGQEMsL3IC2MTlzSUu1H9K74aUicOsE056xGBZCPXZA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (371, '', 0.00, 0, '', '、sunrise', 2, 'https://wx.qlogo.cn/mmopen/vi_32/jcMJkMe3pibiaP5MB8gPqmj5v1JVhVdYglTmwNEPLGBQ6EUibZRMJeU1Enib2KQbCQLtYtkNbBvrxib5Cia6Tsfic3q1g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (372, '', 0.00, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eokQwBXsuSUGjibWEFllkVa8ucVjmQ6fDYTlstfCLmNySiaBW7vUseOx4qHAxKMV9KBibtTFibTVv4YcA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (373, '', 0.00, 0, '', '有些话就把它放在心里', 2, 'https://wx.qlogo.cn/mmopen/vi_32/TpIiag8ibALLKNOAuUk5qatClfY2aeNgTqBiaW8cEicfQrfTXnRE3fPN44UaSLBqdbicDoD9PBsWXovfhHzPdL941gQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (374, '', 0.00, 0, '', 'Ayrton Senna', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIQ2TKe6G9348rgRTtuGicszAwUVc3g3zygWSU1nnLNrHwd0ibyV3u2QqoibTcRkF5Zw6jvEYVOuNAzw/132', '', '楚雄', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (375, '', 0.00, 0, '', '小尹', 2, 'https://wx.qlogo.cn/mmopen/vi_32/oFUbg57kRjU8KwYMK0mXlp6nWY1NGaX7hpCLHevrTGacONUGCzyHZaKbUb6XN9Ppicjd4sxQiacajCziaGJuucicMA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (376, '', 0.00, 0, '', '星痕', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PetqTaAkoQicYWjjhLTYAJLoibWEwT9RjkGOheibXOZvKkpB5x0Gm408jYJc7k6Vm24eHe7ticnkRIIMeQtN4lrjZg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (377, '', 0.00, 0, '', '乖.乖.女', 2, 'https://wx.qlogo.cn/mmopen/vi_32/xAay0OicqrsWz6pdnQY91DJTLX4zqGqy76EdSXkCDKuibXtSjxKKwd5XX9QgKdg0uRgmR6b3EQJiaTdicCTNLFDXsQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (378, '', 0.00, 0, '', '南派猫叔', 0, 'https://wx.qlogo.cn/mmopen/vi_32/iaMhsEREDzich605691B5SuWCLSib7ibN7BrfC7gibEStk1z3icNbrp5QpSrQFibTZofk0t1zZjC7BY5oVXC0U2tZA3Ag/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (379, '', 0.00, 0, '', '鱼视岩开', 0, 'https://wx.qlogo.cn/mmopen/vi_32/RbAKVeqqc2sk5TxsUxsArQRSspXbX2Z639D0icTgIqGWuNHzcicbFcws1uqZmIkBnnlJebFKeXvYmajzz5fqGZeQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (380, '', 0.00, 0, '', '单车风游', 1, 'https://wx.qlogo.cn/mmopen/vi_32/lq5CywI2scK8HprpxQefEia8fOpwcSTgZweeXHGMAqx2icoGquMG3hniagJEtpFRlvXUKqsO1dicRTqc3x1cicla2Xw/132', '', '成都', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (381, '', 0.00, 0, '', 'Joie', 2, 'https://wx.qlogo.cn/mmopen/vi_32/oeXIxcjL2KLwopqra0uqxLwNwyniadDPJQtekIqxcJDT1F3TqK7YXxYebvp4rR9YkQaBWGkuHnWjFI2jjcNRV9g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (382, '', 0.00, 0, '', '再无繁星当空', 2, 'https://wx.qlogo.cn/mmopen/vi_32/rJT9vW50gGt9oBqbCTkUTGJc5RegIbqaNr5rMstQx52raLG2TIV3Ffs55U6hicIgRIPibPzPZaMsUwAf7wtCMAwA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (383, '', 0.00, 0, '', '昌勇', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqfa5Lict1LHavC02Po243SasvMGrp0S7DfGWaIGvibdBF2F8yuztT7qBV671uLod0AeypCmzBtAlAA/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (384, '', 0.00, 0, '', '我的', 2, 'https://wx.qlogo.cn/mmopen/vi_32/XQNXn4GTjp0ICmbIdE1nMXyGVgcP32fyn3jOgvPMTGbJoRQfBLXEicmjxjibGeeIvFQMAnS3kgd88V8QvatCMCZQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (385, '', 0.00, 0, '', 'ZTT', 2, 'https://wx.qlogo.cn/mmopen/vi_32/BKL5DtYzdAvibWusmiaDZNm4A1hNgr7N0eiceo95xf3JKoNaCZJgnq7IVdfGh4epic6DWpAFoOOeeibgUGxWczTPyhg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (386, '', 0.00, 0, '', 'zinor', 2, 'https://wx.qlogo.cn/mmopen/vi_32/81fL1GYWneA6icwxPVpO0zGotcVVQpXhFJxq9aPHtfeHDBVhO1lB6SyMp0SCC9Yiaaw4Fgicmno45jkTBPcvIw3Sw/132', '', '曼彻斯特', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (387, '', 0.00, 0, '', '37℃', 1, 'https://wx.qlogo.cn/mmopen/vi_32/JOVZ6gXF5RV5zwpWeEiaxf8MJ5RgNJfPgkwurfUqjGHLkbic0tKxKSzhyxryEt8Viawy8xa9PGiaibiajFs6picA56B3g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (388, '', 0.00, 0, '', '胡景皓', 1, 'https://wx.qlogo.cn/mmopen/vi_32/yXaibrlmqneEESIXTxfjjVQR2Vzt3GEXSnnrH2YnKvtV4UsEPoysPDibTJhettXDYmC9DtWIwheXzwGo0yCico7BQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (389, '', 0.00, 0, '', '迷鹿', 2, 'https://wx.qlogo.cn/mmopen/vi_32/59jYzxzCWwIR91nPa4F0rHw8ufLyiayktGqfEV9qakcBfH7XAYZggFTxa88nE4S1jal6rXFfqRudLR31wH14LZQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (390, '', 0.00, 0, '', '果果', 2, 'https://wx.qlogo.cn/mmopen/vi_32/GSNVktRY5t4PhGMww3hYKO7hLSmLDbDJtxbj8UY85BzqkbmDeEzGQYqibNicNwxJ9nrGFacibic8JEIZ6O04SjB4gw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (391, '', 0.00, 0, '', 'LYF', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqblt82XJ8b6ibVQnK0U4cd9Hib4VibtY3o0cgUSLkW9t8pmgmQWc41DicMBF6KYLOhI1zc6ib6h0eg3WA/132', '', '临沧', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (392, '', 0.00, 0, '', 'Stars', 1, 'https://wx.qlogo.cn/mmopen/vi_32/XFaqQuklDChNuZhAj31TNAtENwZ32BOaQSvpl9axE5Pj0OLvua6XPD41axyKTib2ibBVR2D14H4EFzNr19EODV4w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (393, '', 0.00, 0, '', '风和日丽', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKTKIO1ZOvG1RR1XSct6qNsjibrgJVXk36ibDcZULtZ4Og7f6zZXKBV6lf9WTqrDnUzZ3dRWlmXL2zw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (394, '', 0.00, 0, '', 'A晨曦', 2, 'https://wx.qlogo.cn/mmopen/vi_32/9T22gkImiau7QHDTgPYzb88fm3W1qPIHLX5EPpP8IVibw227XdSm7fKjDibkkU1ENlbJQibg3nAAxgGqvgJkyoCO0A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (395, '', 0.00, 0, '', '℡夏沫的晨曦&', 2, 'https://wx.qlogo.cn/mmopen/vi_32/7biciaBfMAZU9H35na28hAG2wFzer2Bw7jgcH0ZusGrVvgBIeZNaib6ezwu26maMYAyMbL0b1FWibyFR26w5WkfibNA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (396, '', 0.00, 0, '', '发美创始人张东飞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/bZgKiczib7FWAW6AM76e82JlrzfOptlKLPJicjeRiaGNzHG2Whia8m6zGqnPKPBCG1vvVYeGPoFXW3dpHQDFSdQlMww/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (397, '', 0.00, 0, '', '马街滋补罗非鱼庄', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIjTlXUOibjFdGnVMxQyiacJRX3U6xNBd2tmUbMHXVWYkBYgibzpRozIBJfT4IxHibeHib5ceFkeIeuq3A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (398, '', 0.00, 0, '', '阳海燕', 0, 'https://wx.qlogo.cn/mmopen/vi_32/r9AACegHquY7TAYmaZHXrzmHm1yZyEqdibZgjvpdcTNAkLicyq2Yl2VwzB5icrO8VqibWbCIkBQBCFB7qrx0mkHDqw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (399, '', 0.00, 0, '', '好好先生Mr杨', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIrz7FPX3iapZrEcwSF6jdRhACSbb4N7QeHfB6wXPXMLqcQ8AzS0L4hR7n2RTkia5ZiaP4320MWmhlvQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (400, '', 0.00, 0, '', '往事', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Qm9JAf9gn9yz7MoWyT86Wia28nicVzaPyiawlicFSzDeC6eslIuNYmT85fl2yWbTnPZNC85f9iaaFnJugyEQY6LxDsQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (401, '', 0.00, 0, '', '时光凉透初时模样', 2, 'https://wx.qlogo.cn/mmopen/vi_32/LRdETtYlrLnN20YSDoQ1cG22tTYy9HNz472vCYA9tcPSXdfDicicAic3QCN4813v1gGolyjXcWeKBuE17Hliayn8BQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (402, '', 0.00, 0, '', '生命在于折腾', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hib5bbuJu0U27CpDYeoAertepfkfQwzC5GslVAfEKTgDibs6hDXKBc7aBDAzibpT52rgL9ULHYicbsQh0onVWTIjSA/132', '', '保山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (403, '', 0.00, 0, '', '赵祖卫', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLfogWrXZbZJtPiayLSCZD6A4lmgKiaaIKaDKe24KSP6rkQW6pcEfNSRvjN844iajf3ma8ibSPTiav8PNg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (404, '', 0.00, 0, '', '彬锅', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ia6nyJ33Dz1cv7zVPaic3Pn7A3KhPTib0ia940KLv18QkasUHcA0EzqpUEj8exbQe6QonzatKNsXJSo0qXlIVkYaEQ/132', '', '邵阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (405, '', 0.00, 0, '', '一片绿叶', 0, 'https://wx.qlogo.cn/mmopen/vi_32/HicVQvLOicE0QOrwZsjp3kro35aFh8OlBTP11v2OOibjXJgTJmEcpPNrQFQibmkdqglrmOhXbzXGzWFdx36ibwvLInw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (406, '', 0.00, 0, '', '小虫虫', 0, 'https://wx.qlogo.cn/mmopen/vi_32/0iaGqqJtNGroUKvQfgCl8l2onbhZI2SJAAtlCeR6nNO41AhZe3Kgcp2JPraiaLRCJuaq2NeLS0zN4ibUd41QhIbJw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (407, '', 0.00, 0, '', '猪猪侠', 1, 'https://wx.qlogo.cn/mmopen/vi_32/B8m4uFxoA6o6Mvc6t8a7ugBSPVXwKSaFZKOa0DTaY6icMoMdnEc0ibqPgl9K3Y7HHhX6uk1G6yFOZibNliaylahWsw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (408, '', 0.00, 0, '', '飛蓮', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLGquhS1VXdlmbJe4aC2eeXS4TcbmzHMWT2dQibK3jxpksDA1amK0jSJW5Cdc6sVR9r3eDgWSuGmgg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (409, '', 0.00, 0, '', '_ 太阳不及我暖心', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ZefBwGrK5TrNHX5Jib9kuLRenc9JsVw921xd3ib8ibhce96MbLcXhB3ictyp1VsUSCh53HEOygpbuKPzyGwqlDBtHA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (410, '', 0.00, 0, '', '对方正在输入', 1, 'https://wx.qlogo.cn/mmopen/vi_32/TlSoNOCicNTm1Ifc7x0kEL0BJom18TibZ8EJYqVbpa5RmTNjecicZAj7XjjegaYyjemkoO6Mjibp2jOvXcVUAktZaw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (411, '', 0.00, 0, '', '小木头', 1, 'https://wx.qlogo.cn/mmopen/vi_32/7tOE5Bx9tmrE4YDZOJib57cDmMyDMmRZt8zicHEnys70ypsGvCw4ZOLXZS0EVY6vlfSzwOJ6rF2OlLD3nhv7NPvg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (412, '', 0.00, 0, '', 'ZZZZZZZZZZZZZQ', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ib2uK591wUknb8nUWXCVKwEfuTjssp7cu5nSDzChjXN8xTrXS9lTVxz6ZglH5P1VO63ORtlLsMUssaCetw3zeIg/132', '', '成都', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (413, '', 0.00, 0, '', '张飞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/GMicZNukn3SemAVqa0e04icicztklAOa8gZJ84n4ghIiasaDVlic9PegwibTe0tzmTlt7Mevu9kiaVbIUXl5YbAjCPzzw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (414, '', 0.00, 0, '', '王玉', 2, 'https://wx.qlogo.cn/mmopen/vi_32/qOo60WjoSFI7q5kEEQwHEGW3cBmsTicuIU4yWCAficOwxdQJmSeeUcGg6UicAqkiccIwlUH75r3vQ7fV6ptW6cI5KQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (415, '', 16.00, 0, '', '呲呲', 2, 'https://wx.qlogo.cn/mmopen/vi_32/TQVqmOUR8aSPUfPsgFBoPUwhw1HvlbzcRVDUp7ET1FUJEr0c4niaM7M21T9L5bOVtj7N0p01FQdWyMKRKiaHiaVQw/132', '', '临沧', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (416, '', 0.00, 0, '', 'WL', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo5iafplDeabByg1CPj95cicZxu1WBaz0pMaOtr327y4Yk7YFM88shxVpu2SHXqlC9HJnNb7jE1kSjw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (417, '', 0.00, 0, '', '兰', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIf1MJUd0NM5WUDB6oWKPOs1iavVTcNiarnlhUTuyZUeIaUx0CzKtiaI2q3BGKrFicmbBGa6vqZwh8yeA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (418, '', 0.00, 0, '', '我', 1, 'https://wx.qlogo.cn/mmopen/vi_32/gtWV8CvyuwDjZVKCaiaibRI3KvaR3d50nqZQeFIRBFGWHHJAx3WXXcVvvG2blmjxGANTchGm5rWJlgmXvrmlLPRg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (419, '', 0.00, 0, '', '油菜花.', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erqg9KUAzYZib0uP8L4wIXVP5wZudqYIzgxwicCvjRSEB3rjaibS0WAAwJtwAicSMPr4NK8VBCDOicRVIg/132', '', '温州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (420, '', 0.00, 0, '', '小Rain', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erHwadIOH9SaJBJOzTmKPWOngGsKSq3s9YndFZUJCqblvCnzT0k4ByEssbgsXxuSwn1qfBBygM2gQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (421, '', 0.00, 0, '', '25°笑', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ITYeDM36YsRzoAfwOBFGVib89gqAbrtKGWicd9X7dHPLAYglSpoQjH8Vib2pvHibjQAKD5FZUicVzttwOHfpx854fiaw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (422, '', 18.00, 0, '', '走召', 1, 'https://wx.qlogo.cn/mmopen/vi_32/7ZgfpsWTMc0yj722HXfbAZ9COEVD1E8N3fNEibN0SQpC4sxb7zOMFCibqibN0EG3mmcb18NDvcAubiaZggFxlGu6dg/132', '', '丽江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (423, '', 0.00, 0, '', '末班车', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Qp6EnXhUrLIL5XBMFCCS4ObZ4s10F6gBHZ9W1iclZdRic9NLLGL6qbGIUgs7icT955PHYoxFcp9yYbN5KvQfszlkg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (424, '', 0.00, 0, '', '???', 0, 'https://wx.qlogo.cn/mmopen/vi_32/tqEPpuyfZicMyjPMTOHBlrKhKmsaserjJaukGUaibmgRb1zZIxYianNeKkurTy3icXFM54JN8ZBdMaECrQ2Lxn1I0g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (425, '', 0.00, 0, '', '我只喜欢你', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKTD1hqhiaEFCQYxicGdFUC6LIyMX7pia9xAdEaLic3DHTLsXmICicapJqQJvPk9zQIicPayCDj8xL6HmmA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (426, '', 0.00, 0, '', '格维童颜 抗衰美肤养生工作室', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJicftDiaSTbbRqevd75b4s9WLMxnVQ0On37clkaYUlI7hm2bgPQkopQH7cQ65FSO4FPHrHJpuuRhdw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (427, '', 0.00, 0, '', '俞佩君', 2, 'https://wx.qlogo.cn/mmopen/vi_32/G2MYhBrkplWT3zliagOoqD6SoVA4ykWBgYQADvUw0FjgfDaocjNFXDFdFUtvxJNC6ibaUJh51v3EJ0no5NnEq9YA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (428, '', 0.00, 0, '', '舒褶羽化-剑阁影魂', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep9rThiaNMtBB5mfJ8r78VjeMBZ2Z4VftKRQz3yt0sqI1fichcTpyoV1c8bOoYDOzunaUAafibTGLfug/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (429, '', 0.00, 0, '', 'AA云游租车', 1, 'https://wx.qlogo.cn/mmopen/vi_32/XicnR7trxibf3mE24HfYZnwgFPF2yQicATViaaFPfxiaHpGjrl2seo7MHoo5YvrxOX1Yiar7sIeosD3KS1xJJqWa2Img/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (430, '', 0.00, 0, '', 'Jason', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLkvWr2n1ypYAPeV1U3t5CEuYBNsWKREVPQqZptC8ic8KKTCVHAEaozw9ZME2ZVoliaH4iammpOby1Dg/132', '', '成都', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (431, '', 0.00, 0, '', '龙溪儿', 2, 'https://wx.qlogo.cn/mmopen/vi_32/rlJYmuWttc51FDWg4eNjMwSoh7fIhKWCeBia8ByOm91kibKA5zhHsVea1wiafZ2kUxIZhnwMRSBNGpTdje8nRJdIQ/132', '', '文山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (432, '', 0.00, 0, '', '嘀嗒', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erMT0ClIEe3WzyR97VjF6wzfeIJoVPAuwnO4wASd8yspv2sW2o19Of2fshTQqN4FnSRXmayickstJQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (433, '', 0.00, 0, '', '不忘初心', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ajNVdqHZLLBDowrHvkxuNhvDAyiahU9rcmXqGiaQ1onQibN3j1CthWmtYtuFkQUXMibo8ibVGVKdfXBiayeeGzlbjOMQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (434, '', 0.00, 0, '', '穿小白鞋的大胡子', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epherEfVrWjeicHAm7iaZaBrTUFYqmJZutHfibzqZaBXe0LJGBI9O2MiaDqHafNtxf8ME2gEBYMT4DAEg/132', '', '衡阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (435, '', 0.00, 0, '', '空白页', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epeNC8EUyicDWXbbcKjH7JeRhB0kq8t83AeZgqibnfkBkcOKw7uyibakow3D73REjiaAjnfNxlSvaVUdQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (436, '', 0.00, 0, '', '李.', 2, 'https://wx.qlogo.cn/mmopen/vi_32/LE4WHKjYVUaQbR5nV6p7PJQ1AiamHwHiaUu4bjYUsEq26icarwDPwicQsKMCmOPcEbNnt8kEJaKggPXXn2sAicIK4HA/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (437, '', 0.00, 0, '', 'Y@虎', 1, 'https://wx.qlogo.cn/mmopen/vi_32/OxB7iaDnibrsofFxNoXWZp6r5cEgGhkp0pkMMZGOApVDJrIAxI7cicERyTGTPNibPaxh8ToYsqGQ9Nz0H3dJA7ialZg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (438, '', 0.00, 0, '', '木什么杨.', 2, 'https://wx.qlogo.cn/mmopen/vi_32/cWsjb4OsJYDIhFLBnL2fSMnXSDNtIRcVHrN27dlicNgY3vZoIPPQTfgx9ibO2cL2hZib9KTrPbcmpSRVtBtEkwg0A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (439, '', 0.00, 0, '', '小河马', 2, 'https://wx.qlogo.cn/mmopen/vi_32/lvAJNicQ6crpKOIu7v7mUCqBIN6rgVQpJLwlxgBAaTd54c8iaO71siaU4xMVxbQ7MhGuAXXwPtHLrr5lUdTQWiabibQ/132', '', '大理', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (440, '', 0.00, 0, '', '淡墨无殇', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ugBoV3VerYOYUMYPKddaV4f4CZf91NzG9txMBWlW6ibNX29xtDOfh4j5xKBejOic8bqP6nqHPos60YficjiaeSprnw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (441, '', 0.00, 0, '', '乖欣~', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKfsdaiargZibEkeGQA6OicV5MORaxIrFTv1OkdD9MPv0l0AIIDuptxxumYicEBWbBdD9Ribl8qcRKysVQ/132', '', '成都', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (442, '', 0.00, 0, '', '杨子必不可能挂科', 2, 'https://wx.qlogo.cn/mmopen/vi_32/icniaGmw8xibowpTB8Wrs7J4AhbcMyvnSAXKxHtSDgegPhbHbQUZ5AcrFC2qTYdmMxSG01854tV17dLXsAw57rsgQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (443, '', 0.00, 0, '', '知寒', 2, 'https://wx.qlogo.cn/mmopen/vi_32/QmPfTHok0Ywcgg8nlW2jugiarwoSjzz94qJ0Jjt1icHojUaywpNZDzdTMOUsggBKP5cETunn1RgDQiaYzqXUSCcEg/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (444, '', 0.00, 0, '', 'Letitbe.', 2, 'https://wx.qlogo.cn/mmopen/vi_32/yYZhfAalibh3eppXHLm92hoKpCaE01huEmvBR9Y0ibZlFRB7VG9bN9dJyz57ouykjCfy5AOAPicicMzqPpKR0F5Gow/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (445, '', 0.00, 0, '', '桃', 2, 'https://wx.qlogo.cn/mmopen/vi_32/nwvu4iafwicqibIrF9H2P74oTerzDnloUU4bQHafof8HIhC12yTwWcQvA0R8ibjsoT4IRfm77YkYGP8PCKXJE1ZphQ/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (446, '', 0.00, 0, '', 'piero', 0, 'https://wx.qlogo.cn/mmopen/vi_32/aaWpgv6exm63CuOWcXSqASYDTQIRqZ36KdUtT5pJ92zG7QyZqebFWH9hnedRT0NkWHcJXslDlhpUibDICnjvOnQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (447, '', 0.00, 0, '', '转山', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJicBUhsn4DdJlDmdxZ7tRyaPlD5pncJSvZxrCRH6fct8OK32onxdmhGZoeq3fGccfaq6YB04fcNgg/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (448, '', 0.00, 0, '', '小克', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIowbz5xxVOJa9pRHt5vmab0icxxiakyl4F9vh7aq74ym09KQOaRFMdaAmL9xfL0iaFqZq5Vf9s2731g/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (449, '', 0.00, 0, '', '麻烦帮我关下太阳', 2, 'https://wx.qlogo.cn/mmopen/vi_32/pT8N8xDYtwYtdleCoN1eibrWiaNQPImraiblPxtRxsR4iaG55icMI0h8azFLSPoZXtDTDCCDzyg2YB1iaB3wYIwWBrdw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (450, '', 0.00, 0, '', 'planet', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJFogiawUASWXEGicyRQhWD7ibYHCVFWXBYtcKKjzE7BZsbCdPZsibKnMZGrPAmwfw8B1FA2ThSGPN37Q/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (451, '', 0.00, 0, '', '.', 0, 'https://wx.qlogo.cn/mmopen/vi_32/yVnR3tm0wluwciasN3JIibCMrVMnsp0K19icYcS05oIL828TxuOv5GJPMPia1Dn51BkJ6iaQobBp4tctN0wPicNMJx5Q/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (452, '', 0.00, 0, '', '小丑卡西', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erRNnahQR4xalU52kuFjibU37BKWLMGia25zLmxHMN1DAxlcrm4j8qe6JYiciaeADJeebBVh6uniak4MJA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (453, '', 0.00, 0, '', '祝良辰( •̀∀•́ )', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqFVuKTvnntIdibPwEAia31TM49QXAKQU6JCOnwPWL4FaTVxcI83ww8rKcJibNJ3G3Iv9ju9Em0WkvaQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (454, '', 0.00, 0, '', '般若夕阳红', 1, 'https://wx.qlogo.cn/mmopen/vi_32/iaYxdibObXmibpic7LLmYYOIgxbxfK3K5J16e3icMH8FJO5xn18lmWLnqW5Gg5M4VmrJ5VyOZmppdyIOHTYNyzPP6ibw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (455, '', 0.00, 0, '', '彦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKRnQqczkNiadBxPGXS63ia5B5XRibflKaCbkRJW8jAfc4FanJzOrq0gTKc1CyCoIHQ0LmwiaPfowb9KQ/132', '', 'Philadelphia City', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (456, '', 0.00, 0, '', '随口敷衍', 2, 'https://wx.qlogo.cn/mmopen/vi_32/AIdAmibzdhn7WZzhlbYkLTGvwiaIQajQwzrOg3AOrpun2K2KVBFziceYpct0KCgOfBttpNHddX9eGKhibr6icVBR1nA/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (457, '', 0.00, 0, '', 'HC', 1, 'https://wx.qlogo.cn/mmopen/vi_32/9skLJRgjLbBJRnQfbqicyEqOnY5RiboMqrjviau7MfG4lsiaMqLwC67zjuFmW0IvksicsHibYFJGJ0FsXz0ANoaI79Lw/132', '', '武汉', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (458, '', 0.00, 0, '', ':-I', 2, 'https://wx.qlogo.cn/mmopen/vi_32/e73xbFhLtPhoqcul8XbbTMqVA1UGNzkia6licGLsOx3z1lnD9Hz74OW0Eic6GTLicknPFPEv90DKuIobVUxJMUsEbw/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (459, '', 0.00, 0, '', 'Ms.J', 2, 'https://wx.qlogo.cn/mmopen/vi_32/BJjGmy4ooNjC023BEbNAbGVbmzxuJVuzZN9K23BicTmVMGibV458B4FicrK4YOUJMfJT0ZKOvoaU8BbKibxhQ6OF2w/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (460, '', 0.00, 0, '', 'Sxinxuan', 2, 'https://wx.qlogo.cn/mmopen/vi_32/IH6bDs4IGb4X17YBOXTacWia3Jl8l1aL33hEFPtEb3kopdu4VI0PgjTBMqJTXbvxicaxkiblUafQ1pNQk3abxtwNg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (461, '', 0.00, 0, '', '木子欧凯', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ay4ru1t5KsGiabYAAcLRevNQfgv4vL2sVbzoCk7Mib3TyTSicUL9jlyvykxeTsaDcFBn1vw2jrPuStU11aOv2YvHQ/132', '', '南京', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (462, '', 0.00, 0, '', '叶卡捷琳英', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLHdJ89mLJkzO0YIUQUoOzfGLSP57K4KcQIAzllib3IyuRShWeKJquXhlFH5jOgh1YYo66micmms7Fg/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (463, '', 0.00, 0, '', '东林钓具', 2, 'https://wx.qlogo.cn/mmopen/vi_32/gYmdRqw4N8hHeSjtB2NNxicHhCRKyYNeqg2K0diaibaLPzygjhKhtbYbicttS1ztJW3J9ThdRPrbKvnSHuRPWlIC4Q/132', '', '成都', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (464, '', 0.00, 0, '', '薇。。', 2, 'https://wx.qlogo.cn/mmopen/vi_32/b6PdJ9k2Ag1zViaGCyquPkrVBBm99pLTSPYuyiapTAU4VYVIsxybFibrh025IEqsdrwEuo7DFDxDrIqcXSXvth2Ng/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (465, '', 0.00, 0, '', '.', 0, 'https://wx.qlogo.cn/mmopen/vi_32/g4wzd5sQZzDyeVEKaSH8OofhaarSUFFVA7rnr4IVkluIiaZ57AA6jCEI5KicPTAf9KPzbGYu9tYgHposvzLXVr8w/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (466, '', 0.00, 0, '', 'MIAN', 2, 'https://wx.qlogo.cn/mmopen/vi_32/P7OOxjt3vNH2ECbDFJKCjw0ovWjLpbyibsMWemFvhic3Red814kjm1qwa4jpyza2GFaLrWgGS0icJVJf9NTTqgTyg/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (467, '', 0.00, 0, '', 'Apink医美小箱猪（支持花呗）', 2, 'https://wx.qlogo.cn/mmopen/vi_32/BMIsAZopI13FcT5iaAUht3W8ribxOC3h45hUX9WetYs58Niauib22OqloTINLeQuGR3IlZgM7xEhULHs3UuILu3ukg/132', '', '大邱', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (468, '', 0.00, 0, '', '路人甲', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eohDLSVevG2ReRKd0z9HuTeMcM1TD1FiammaqHZUIiaqFF9iaZ1BvuZfFu4jduEuGtgkWXODT7nnCbjQ/132', '', '连云港', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (469, '', 0.00, 0, '', '', 1, 'https://wx.qlogo.cn/mmopen/vi_32/pOcXwyENQTwzj9o9XIXCb54ibhO4JaDfuTXBx9ECF64ewEas2XPX3NXFQm6m3pd1mvnSwnLSI0IKR4CtOVFplUg/132', '', '因为年轻所以积累', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (470, '', 0.00, 0, '', '哇哇', 2, 'https://wx.qlogo.cn/mmopen/vi_32/WeaY3JibkyfAUabvkoqLLIicThIdCxhoJE8RhM9uWPxlCEJyQh95sxdDyEtEVKicZwzXTRF0L05YmaVXvaf7diae3A/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (471, '', 0.00, 0, '', '搁浅', 1, 'https://wx.qlogo.cn/mmopen/vi_32/p8Ol8e7ZsKb2DRTQObpVGanVSn3xaia51f3ic0cGEZLBiaic53vayNlVaWia7Xzv71iaoK0MibaGSg7RqZAhXRNrt0xuQ/132', '', '楚雄', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (472, '', 0.00, 0, '', '猪三岁', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Ko0Gf6N4wrTIroRsM0n8jzZhBGiaC09nttZHga3HrHB3ooe14fEn8WAldKEH7iaqSnwgLzRSOcQn90kLpUgDicOWg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (473, '', 0.00, 0, '', '你是人间的四月天', 1, 'https://wx.qlogo.cn/mmopen/vi_32/K9vqsMkGlGqhTZicRMjYvyGuxHQIDugEZGCE8ibJq1IsOJqC1tkwMCUqiazCWTGiauOHMOhAQ5ZMHcNc1CvicdaLyicw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (474, '', 0.00, 0, '', '傻瓜', 1, 'https://wx.qlogo.cn/mmopen/vi_32/8nHWR2KkJracrp0SuicOf9ofthS2LFrZMsL8rb593sseoZGkPCDk3tEErnnLcUQicq6vz1EljvNBBzODiaZmFYkQg/132', '', '朗塞斯顿', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (475, '', 0.00, 0, '', '小粑粑', 1, 'https://wx.qlogo.cn/mmopen/vi_32/5sOtwnsC98icjVxrhbA3iagE7VLnmZicALhMCPlG0JleTm9iagVAbI8bpulUnJtFeRS1tz5J2UHdEQ4AY37rZO0oqA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (476, '', 0.00, 0, '', '刘老二', 1, 'https://wx.qlogo.cn/mmopen/vi_32/8R3rKudsCiciaecdzByO52qxjgCibRSKoyXCXyxPEACMRl3lE73uxDPtE86zZUVNsImc8Bib254w1pBSNPrhiavMztQ/132', '', '云阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (477, '', 0.00, 0, '', '天之涯', 1, 'https://wx.qlogo.cn/mmopen/vi_32/GUicVG1cvtflxfUd6cNPWE9Qse85scvhDArjSw5jT5dx9063ddpdsV8hZQDds3o0Pb0rz6m47TiaicibkazY3cpEOA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (478, '', 0.00, 0, '', 'しろちゃん', 2, 'https://wx.qlogo.cn/mmopen/vi_32/arkPXmFNGCYO5FMafdXzTvvr2JxQRXOgu7wiaNQtUtLA9YzkZc1ic9sUw0X08sUzKOQczBKhEq2lnQ1O37ydibSzg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (479, '', 0.00, 0, '', '一生无悔', 1, 'https://wx.qlogo.cn/mmopen/vi_32/CdS6vowicLRZbf3R9SsYS8VHqySD09u1Hf83jVlT9UUiaq0mX8XHGgSTOL2r2Ld04sh8B2tbFZ34zHFLKHombApQ/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (480, '', 0.00, 0, '', 'ABC', 0, 'https://wx.qlogo.cn/mmopen/vi_32/sWJX4YJIuhibOOScX09NbBhC9OMSr8wpdlDuCQX7qMAX8fQgr8WoicTR1B3mBUQ9WvE9gsKWkl8vf6n7iaDI2xBYw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (481, '', 0.00, 0, '', '小葫芦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/mMhqrvyZWoJA1dnUVB4b5uCk66WcfAibYzhkkkicF4sKNxaLo8qmV5WMTb93AeChcOC3OL29TiclqPibcsmRldzVVg/132', '', '楚雄', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (482, '', 0.00, 0, '', '☞☜', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83er6libFmJh69G5cto6b5U3w1TA9reOa0lCbA97YWztsZ9wwCdRKfNvPGX0G7ovyT6U2ib5xBhJ65mkQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (483, '', 0.00, 0, '', 'gczlalala', 0, 'https://wx.qlogo.cn/mmopen/vi_32/kbJUSTclrJRibkO5HpTysBkVXPgwvXWFjP2fbf9FeHKollsWIWquNIQnJwJdS4I2LatcMDRiabKHYRCjrSZk2mpA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (484, '', 0.00, 0, '', '烟村归渡', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epeiaBa4BwckM7PkUYm8iaeYTFasGXIafy7ulqV6Pdhulu6ficASXC8Olpz7y4yyRel6Imia14w8icbpfg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (485, '', 0.00, 0, '', '疾楓', 1, 'https://wx.qlogo.cn/mmopen/vi_32/C6wFNSKeCM7faAX9DibQPNAyeIgFibNdFpwNmeMXVQuFlbreECHD3qXm7xW4U4EPeaEyicMNT5icdQbzFpeSsj7q1g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (486, '', 0.00, 0, '', '时遇', 2, 'https://wx.qlogo.cn/mmopen/vi_32/EVWTgS5ImLcM8szI63LOasjBica5Wia1UCQMlI5yqAIia3CYtibaCAdgzLRB8255NWuD4IhcFG3XbKMgyt8R4ANuVA/132', '', '昌平', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (487, '', 0.00, 0, '', '小白～', 2, 'https://wx.qlogo.cn/mmopen/vi_32/aoxUzQzd3YBJj1oWycwIDHStoNNDaVcodjGiboP22ScaXapQKFuU80OWoFRnMprJVKG4Cp4zMlC4mFLtoSMPDOw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (488, '', 0.00, 0, '', '十七', 2, 'https://wx.qlogo.cn/mmopen/vi_32/sOsm4iaE6Ws5FgHohYrycRmzqskP9C0otR3nL1kf9kXT1sB6ric6nQw5VDcA3M89ugSJEkibQLP6VwJ2icAFfcpDNg/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (489, '', 0.00, 0, '', '東', 1, 'https://wx.qlogo.cn/mmopen/vi_32/wPHrRnWMCiahiaOFBkm1iceT5iaj0l4MdG9y85pw2YFicYvNIFiaq4rbs0MFibMf6icibcic5mJ4burs8zRtH3ToMFRHYhIA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (490, '', 0.00, 0, '', '杨杨', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ALsk7hCeFjk19gySVyTngwn8o55YspGkXicFibshnJ4ALhWQ1UYYk9KdeTtZFVvfc6gxOyr9g0yHoWKrQozbmFFg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (491, '', 0.00, 0, '', '晋儿', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKRffcghKzpLVk1JRJ14BYleBFErIagYaRHQvnsmFPiadCGAEK7GicKYZibmWKOiageMOUmDTDrAljTmA/132', '', '珀斯', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (492, '', 0.00, 0, '', '☆', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK008ibNySWj2D6oSz8I7oUThPVrOdANzp0nBthpiaEQ3OwdpMjjcv7xwpWiaxbRuG6bdmVDRwbNq7pA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (493, '', 0.00, 0, '', '璇 ゛', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIhn9GSWxDQ1JOoz7Q7H1GsPvykO8WL6T38PGXBMQvWyL5qUCmkLoicxwVZQXeUV0noXSsP8dv2h1Q/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (494, '', 0.00, 0, '', '专业的网课找我来做', 1, 'https://wx.qlogo.cn/mmopen/vi_32/icjOiaZH42dIo5f70oibHiajqGpnykvGoMu5JIr9SMzhcbDoZQ6oUnsNANQAkYbBibRZ6DMooSZpyGgPFqtibHQc1E6A/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (495, '', 0.00, 0, '', 'AAA学车顾问梦博工作室', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Sk2M0rC0Tiawuf4mtk00n2zEBhrsqgAVIhR15EYu2TT6KLIviclZPeMicBhchuOCuM44IEyiaH19DLJk9W3iaqPfGLw/132', '', '无锡', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (496, '', 0.00, 0, '', '嗯哼', 2, 'https://wx.qlogo.cn/mmopen/vi_32/WmFWNeOgHXv1Tm6RPQAKianic0vibzhhVM58gRibNIIvrMiaoC04wesvGDRSibIIvicd4KwTJW2zkRAmqSAp8CFUBGjlw/132', '', '江北', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (497, '', 0.00, 0, '', '蒋少¹⁵⁹¹¹⁶⁴⁸⁸⁹⁶礼遇', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hMDDAiblhCf9cu66H4Rb6P90EjoNuCakhcyDBweDuDmicEG5FH0MJrQ2ia1Q36biaGtBdN6KDmx80RE4rkB3e6CyOw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (498, '', 0.00, 0, '', '慧敏（33）', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKqg5poqcBugnWJpk4WEyDz1IVUpeI5gYBrHnI6kVWfcqqwQ5nsPQjRwjNCbV8icMoY9570Z7HdJiaQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (499, '', 0.00, 0, '', '荼蘼', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ib3nSb0JGKjxdb93bANkWgeictRjvqXIUDKXvX89WibwBD2icL5UianS2FXGDH9o4ngXrmOmo18eyEmC9xWU2wAWnaA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (500, '', 0.00, 0, '', 'Zi', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoib7ZfFtxicMCDJ6iabNtK1h6hwPh7PDCWOMficmw0IJcs2Vib4SYXqGj2uWAMW2KbGZE32MahkFGM0vA/132', '', '保山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (501, '', 0.00, 0, '', '枯木逢春', 1, 'https://wx.qlogo.cn/mmopen/vi_32/U51UoFVbbYZt4JzmHIpgFqQMEfCbQDoZodQPTRoLyrDdWpNQYwnzrWR4gfiar4fu5FWUibphyr4MjEXEpdm7Ew9A/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (502, '', 0.00, 0, '', '瓜虫大叔', 1, 'https://wx.qlogo.cn/mmopen/vi_32/0qflj9EnAAS4mdWmL6QibH6ql5A1ib9R3Hbgo9qH7T0XU4axNRYZLLyw0iaCZQECicuhiczAzsXObMZqT4Aia8xCYdXw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (503, '', 0.00, 0, '', 'Azarias', 1, 'https://wx.qlogo.cn/mmopen/vi_32/CicCPt4tfibj3LgibHn0qRp8SujjibI3yuxRONLdZ0zTxOSicxHPlNQuAxjkooWTImDhRDH16pbugeKIVOJvnLibsbvA/132', '', '深圳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (504, '', 0.00, 0, '', '岱博', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoibsMY3ibLicVnh1fX214b1xicJ30q3x05q8HU8zGUFhy3mOJnYoOq7MNTjUbjkT39TahrxgPlv7KOVQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (505, '', 0.00, 0, '', '扎西达瓦བཀྲ་ཤིས་ཟླ་བ', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKYPpOWCGE1MiciceicicLkOVwOczJp1Z0pVRahYoVLr3UREyfswbkgf9873EI6Ic8Xn0TNQ61gkdCYbg/132', '', '迪庆', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (506, '', 0.00, 0, '', '随波逐流', 1, 'https://wx.qlogo.cn/mmopen/vi_32/16ZDP2RdE8s95ofVNQT1lnfCmp1sst4dkQ71DYxVNgbUpBV34ceyiboKIMdH9Hib3Expts6ZItqenH08CFmneQkw/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (507, '', 0.00, 0, '', '恶魔', 1, 'https://wx.qlogo.cn/mmopen/vi_32/2mMhyEbKBJAVMKcOmNbVUic8BcBbciasLN1aOwkArJsAR7BicsOlYzLcQ6NXoVIWU8637S4ibNEBM6AVqiaNeCQaF3g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (508, '', 0.00, 0, '', '都康堂R创始人徐永书', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q4uAeNibqiaHQoXgE4ia9kVafx8CVv81heiaMH41AHWnDPnOgJda7DwXvbFqg5L9FymAudwbXzAiaT7IuoiaRyvZ1rnQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (509, '', 0.00, 0, '', 'LIE', 1, 'https://wx.qlogo.cn/mmopen/vi_32/FtibaMRsSGqUF481rMHibdc1XLsvIJ8BT7aExfo0uwiavrQ8q73rz7F9ZABda5evBJNYOW0icsYsH7jAAh3fHrFxFA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (510, '', 0.00, 0, '', 'yk', 2, 'https://wx.qlogo.cn/mmopen/vi_32/mrL17qoib6shCx5yyAPk2Ze8ib6RQlbwpicibVbrd8by3GyHraBruXCPp1oPSnnjXSucxvgaqP8ib2qyCnHkeUQvXkQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (511, '', 0.00, 0, '', '小武先生', 1, 'https://wx.qlogo.cn/mmopen/vi_32/coa3iaYYy5IZYHJLE90lDMbIZr9XqLpH5QrCcfyoibTuxathBuibrLslyv5k1QcTjMod2M3JCXY1lovxdEV7uIStA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (512, '', 0.00, 0, '', '羊咩先生', 1, 'https://wx.qlogo.cn/mmopen/vi_32/BF6K1pR632XUhbXZk4e6vjPsT086m2VCglVVu7colXEhfgQkQT9nGrmiaNDXvuDFeicBv2ovvk0eNXSMTGzKOXXA/132', '', '鹰潭', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (513, '', 0.00, 0, '', '鸡翅膀', 2, 'https://wx.qlogo.cn/mmopen/vi_32/b3xo8U8MN7tcW4AWUIOyicF1YibqFuWjIryHj2icU9u5icMekicEv4YvHTbzbd4NbjqANtBBhzG07ib7HEkDFXYc533A/132', '', '海淀', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (514, '', 0.00, 0, '', '我要飞得很高', 1, 'https://wx.qlogo.cn/mmopen/vi_32/3KBRk6M04InhZB7pibibsbgvfrFZQHxaxnUdsbNjguheaUD8c5A7ia5SsB6yY80PzGB5ZIbicBtoUkIBPt6a4A1FKw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (515, '', 0.00, 0, '', 'Rome°泪ル | take°眼ル', 2, 'https://wx.qlogo.cn/mmopen/vi_32/1Kj9ECUNiaic2jDb7TDWUEVHBkdiaxn3sV8kQ0Q18xlzOqgHuibIMYmibkTSL6YqEvrg52Cvsat6Kgdnq3RXOJXrWAQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (516, '', 0.00, 0, '', '柒砡', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eohXZJrLW8VhyPIrTBoZ1ZFwBdI0UIwtROtbMMn17umpPBzrlibia2nWgOS0PqjyKq8YeroP66QysRw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (517, '', 0.00, 0, '', '胡臣', 1, 'https://wx.qlogo.cn/mmopen/vi_32/SHqEZ2sgPBOnT5bQeic5QsMAGh4hZbAZFLbHiam6EicXuibXfqUtibWEEzS51lgSlcLMHSmH8WtcKbnXOia4p2Ky82kg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (518, '', 0.00, 0, '', '丹', 2, 'https://wx.qlogo.cn/mmopen/vi_32/V0Lhfe7z1gV9pBrwibhzdNqVzWGVBCwG9UiaMFrSE3gia7xib1PtOoDB3FiaLsnGJV06ian6KodZY8INYyRccFWrIxqQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (519, '', 0.00, 0, '', 'ღ°她ꦿོ࿐', 1, 'https://wx.qlogo.cn/mmopen/vi_32/miasuZCYoSxw2MOvGz4ALKHpxGiaV2jp1ALrqOJCPPicoticulcMqkSUNxH03EOFk1sRpIwty3tjlPiceqRpbr4QzsA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (520, '', 0.00, 0, '', '阿诗雅  独角兽企业蜜芽合伙人', 2, 'https://wx.qlogo.cn/mmopen/vi_32/M4Utr94D3mljLHmZ6qbBAbquAAibxwBPk0LhaALkeqq1PTcOiafxFjSdD1qJXsQqMB3iaHricic2tzTqePEpyVu027A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (521, '', 0.00, 0, '', '爱我的人呢！', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKYIUCibic7rYzxrk9hGMmb0WwuqVicxMpjsAibnFH8pneeia2GZUoxTEuPWD7P74kPQucLU9W9iaRggxFQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (522, '18388094590', 0.00, 0, '', '炜炜', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJWhQIZmBOj9K7vnupKqAUU9zAUWkDibicbXxQhwsJO7K0BEv5SceToXT64MhRe99WFXicOcj0ibNIjtA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (523, '', 0.00, 0, '', '萬事勝意', 1, 'https://wx.qlogo.cn/mmopen/vi_32/EulyJmVjicLO1rSsc5wASN3dibibia4CCKnibU8poDEfJn8dzLnicrZLmW4e3wn407kFKWic6ZTb7HfljbJR7H28ZRVgA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (524, '', 0.00, 0, '', '青翠恬', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ffzZRTchayAxvPVstELmJsNynYJaWk7ibTsshTbGs1pmvwxbgGrp0a4RGjDheSKSwZ0vNrpG3mnQdQt8eEDyMmQ/132', '', '抚州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (525, '', 0.00, 0, '', '夏末之殇', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqzydaEaQPyAI7O0ibNUBTusQBFbA7sAB6qEwicyBCgv2LK94aXEv6DVuL4LyBCJA2wRibQhc0WHibAYg/132', '', '西宁', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (526, '', 0.00, 0, '', 'ATF', 1, 'https://wx.qlogo.cn/mmopen/vi_32/AibRv6m45gN1KVduWVnBP2l01P2E658uIbU3icj9huyYa3T5dP9SicrzvE1wARsUiaXQaX6vRRiaFrFDo4ubrcfBUaA/132', '', '眉山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (527, '', 0.00, 0, '', '薄荷柠檬', 2, 'https://wx.qlogo.cn/mmopen/vi_32/LolibcprEEgPkgn48jRwWZqSicuKG0LCz8aHe3ZNZM85r8WicuwSCZoVKjtRd9zsJFsLsupqANvUPVghTsRokmRCA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (528, '', 0.00, 0, '', '杨康', 1, 'https://wx.qlogo.cn/mmopen/vi_32/MUsmJ8v66jqbPmJwibYXibsntuQIlovNIYptkOFgjdx1I0PprpFs8pYyBUzjq1ibdvyicib1iby7DYnKgiahFxg4ucduQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (529, '', 0.00, 0, '', '、小小毕', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKdDbtca7qibO1m2w4ibZVHtQDvtyVqMmyJtiaViahXIKnpD6H4tjcy1yaQ01BogXhEVm4qv06G1HWT8g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (530, '', 0.00, 0, '', '张斌', 1, 'https://wx.qlogo.cn/mmopen/vi_32/TqWRSGGkNyPSHbA0L6nGzkqmH4zZQ4GPMx2IdA3kmr5hvwZfJUR0iat9PiagIyia0ZAiaz43OrRzhgHLZLrjL90fhw/132', '', '西双版纳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (531, '', 0.00, 0, '', '故人归-形象设计', 1, 'https://wx.qlogo.cn/mmopen/vi_32/0DtUCTzj3GVg837xBfwmhibI8tItEiacrs8DQVmbmYA3neUGtZT9iaiaWlUO4qp56oF55QOdQDugLe11t2nGibwP44g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (532, '', 0.00, 0, '', 'vio', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKc9pV6H5WTbibD7ic1u08hb6yWiaqxYibgWEs6MBfloZmzqSqGbrPyzKh86b7jWSJIAPsCLYt24l4vIg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (533, '', 0.00, 0, '', 'mmss', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKshoicviawHruXQ5rsrXmic7R503Z30shoDgm3jpb62fm1s0GlTqnsZpPcKu3C5ADaicFicxTOsrPkPiaA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (534, '', 0.00, 0, '', '彦小彬', 0, 'https://wx.qlogo.cn/mmopen/vi_32/yCITyWC1icMgvUs1KYRdvaK1Sic9ibclfkba18HoOko5SN1NFpr9wrXQdiclkuGl0lGibZa9nIlVpj9yAbCGUhicibUiaw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (535, '', 0.00, 0, '', '李启仕', 1, 'https://wx.qlogo.cn/mmopen/vi_32/XFBcMkia5h7wQCqbFzaHzFHrqicvhDsPechDu2ugaicXSbhpTuHfkiaPhqg7XzAibvo2mrLtYFRrk61qN41T0HRZ0pQ/132', '', '南宁', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (536, '', 0.00, 0, '', '十一', 1, 'https://wx.qlogo.cn/mmopen/vi_32/HCrRLicK8jw84ibDgHJ6nHfJq5iaic6BslCvwOibkpe69dGXEoVibMsTvpoYRTKaBUv4zA4AFTzWmjCibLbtWdicntfhUQ/132', '', '玉溪', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (537, '', 0.00, 0, '', '王延洋', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIwaGKvCSoNfxT6JHRPVYu1DoynhwjwVrQyVv1HIVTnfARCm3AxCmosTjJU1ibN4ianD0LicHkJ2iaQGg/132', '', '邯郸', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (538, '', 0.00, 0, '', '龙文章', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoyZJ4TAebNv2HsxGd0sgYicYwlZXMoqicuwlhC85rpibwbC5BCIicls5E82nX0SaNumD2qTicP4pqCaSw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (539, '', 0.00, 0, '', '老喻', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJFqSGmzUpUga1pqFDAQ6t1vtRR9Ts5QS2f7dsIYWqpib0erpC4smTaYxZPjBafibKyKI2o6MAMEo8w/132', '', '丽江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (540, '', 0.00, 0, '', '哇咔咔', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEJ9Fo3Mngt1GZqwb8OZ3zMDrDPweY3M4oQHUaxl6fKj7AocrOBSV6XBMW2JXr9SuaVbMWI5RBI7AQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (541, '', 0.00, 0, '', '崔志文', 1, 'https://wx.qlogo.cn/mmopen/vi_32/5P36n2coC4kSd3ofUW2TwAib2uxNbp2ybiabLrWPlHCBDkSgOkfSNneiaOR46pibSJXM1zmM58YofepkU1eoyhdCjQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (542, '', 0.00, 0, '', 'a。。。。！', 1, 'https://wx.qlogo.cn/mmopen/vi_32/k9EcdAibQN35E0pDog4JUohBl3FQ4ibZ2MMxXlmGSFnUKlDfs6Os8p8bvPmLwtnrVD0A20krwphia7zvKuUU50aicA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (543, '', 0.00, 0, '', '一路顺风', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLgiaEEG6c1pPBvZK0k6wawzyhxnOCichBZ3qdLTFT3BRiaR7fzwCvnHMCpkyCib1zB6ATuGk1AibquEkw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (544, '', 0.00, 0, '', '继续学习', 1, 'https://wx.qlogo.cn/mmopen/vi_32/vHv4cWPL7eibmoiaBnkPrk1BExCxLKibs0KbXyY5JOoDt1v8VA2XqcTMq994Dia71KB2oRcSuibYXoPboUjkllVUA3w/132', '', '文山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (545, '', 0.00, 0, '', '天府鱼宴', 2, 'https://wx.qlogo.cn/mmopen/vi_32/jENs36A5rTUvsnaMI1O0WHFLFoEyuvnk3zkiaQjFic1sIiaQxRkBaTFEbPPUWpcToicuGHV68vdBMvVL2G5p67jAsA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (546, '', 0.00, 0, '', 'M.Chic', 2, 'https://wx.qlogo.cn/mmopen/vi_32/sbQM5gich1ucgO3qTJXGLewA79q3gIYMl4jdiaTqFbhBdib07skicibZd66lFzyjff87bicdFkP2Gd92dXbibZ3EU4Ctw/132', '', '神农架', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (547, '', 0.00, 0, '', 'AAA艺臣护肤造型306', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKP02vhVpuXoOQA3SdT9NAHiaTLvKHyabZPn9oFUKjzcy71vFQqKzblmkZJ2ZxDLKZicGuDqRCxVhaQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (548, '', 0.00, 0, '', '天青色', 1, 'https://wx.qlogo.cn/mmopen/vi_32/erDIOSYyiaLJxiaDKcuQgQ48dzypZBtqFicheE06YpXX6YiaIJSsUeiagfcH9PHhlKibQZJ4T7FyfwZPJI4GzZEEmGAg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (549, '13150700996', 0.00, 0, '', 'Alice', 2, 'https://wx.qlogo.cn/mmopen/vi_32/IkGzW1ayjAVW5C5t8Pick1uggiaLAfHJ4mILAEKA3T3jt4JEmyA80na8gyDh5ia6Deq4tkNK5tv4LTaZibxZEjnTcw/132', '', '玉溪', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (550, '', 0.00, 0, '', 'Ryn', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqzWibb1WfXAnITDbBFibUvY8z3dib2zjHCTfRlIjVemcHrMkJZQibNEONByYBotK9ITQD0My1Eo3Kecg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (551, '', 0.00, 0, '', 'JING。', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqNeiaUSyXBTHbGBmusCmiaoanujiaWKMkk3t7QjpVISDS9zadJNr2btXfvzLibnzmOrxbmg4icFvAjMrQ/132', '', '玉溪', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (552, '', 0.00, 0, '', '古月', 1, 'https://wx.qlogo.cn/mmopen/vi_32/LSaye4QSpOlibMAo37g0TDUS3ddT81Vrb3BbgtuKXMIyQUgL997KZp8zAxPzoSWaz5aCpgs5aoRq7IdoqFmJVSA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (553, '', 0.00, 0, '', '冥', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI4Fm4pKoFGSTcP6Id0RoW5ib9scCriaPiabxzbiaqwE5XMl556b8atrNwoHdeHYHd1bEaSEvfynpEMTw/132', '', '阜阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (554, '', 0.00, 0, '', '枫影', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJMNE0GVgZOI7jsmice1UFHAtnaAlWdqITdo8g2wILFCI5cIBdKDNy3erCyP6iabOzmu8A5zlIUAibsw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (555, '', 0.00, 0, '', '南非小黑人', 1, 'https://wx.qlogo.cn/mmopen/vi_32/V4OoicJJze5pazPvjMb9Iicd3rCRWOP1HNL98JeegSOL0A451tiaS69ldgkMt5hq7hcB7Fw02rm0busrn9J9X5zaw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (556, '', 0.00, 0, '', '海艺', 1, 'https://wx.qlogo.cn/mmopen/vi_32/QTUfeke9r639zXFWicYvYxMYF4GJYiaOsTSdoVv1SfCsnhuWZvre3BNLX41AwYu2AibGKliceiaUppDJxbt3t29Ualg/132', '', '崇左', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (557, '', 0.00, 0, '', '西瓜太阳', 2, 'https://wx.qlogo.cn/mmopen/vi_32/WGCyQ3lw9JZwreD2v1ngohr3XnhoxlK9LaAj4Hp9OfdPopF3n4BekHDkRVnIYD9dKj9jbOuPyHOwRp7ta50srQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (558, '', 0.00, 0, '', 'DDDDJH', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKH9MPVEiaWMRdib9H5LYCJQBUbBbqYjhJUX5HKaOy4ByMlddHa47rYLicoibEMbcO0jEDsnLCKC7lqOg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (559, '', 0.00, 0, '', '梅穿酷仔', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qxiaCOXR7FDq2BeLFLoLIATYbriaR8KGysHiakK6ia4AzLqcmzxbIc4gkzXTBmBu2sSD6pQ2HTP28vvywQod8JMVew/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (560, '', 1.00, 0, '', '静待茶香', 1, 'https://wx.qlogo.cn/mmopen/vi_32/rNI4oh1zoWCetMJhJzK5icpliaeqfDveFaflYKSlL59NSBRlouHfFMQSctlDYB3vh7dEdS2JhhIGYeiaVxTh1ahibw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (561, '', 0.00, 0, '', 'Cool kid。', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJ1AEfZQAxIxG5P1x9K4LgicQMRp0vZUDrgPFRTp9Cuw1DDWcM8a7tnuryPqTsiaOlWT85Cwia7aKg5w/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (562, '', 0.00, 0, '', '阿聪', 1, 'https://wx.qlogo.cn/mmopen/vi_32/6nwhmVyMVObLpqGDicoWyI9D8ttQ6ykB9UZcUSgpk3CPxEQsorDf9DRuxSFVE7NLz8oZTqOumiamplg5xftvMMwA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (563, '', 0.00, 0, '', '补补高教育', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ROwM7icAjBeSsic7OPrmIUaDACOT4aQN9sVTJiclWkjLmpThQ8xf3HCEXFAvCx3lTkbXicIJzJWozmKLBzzENrDVyA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (564, '', 0.00, 0, '', '冷眸丶', 2, 'https://wx.qlogo.cn/mmopen/vi_32/v6J5c9H1YISPNQfgpgsUQiaBWvpWPUn58UJyqkJiawLq4xyedy9kn4iavUEicKTCSZuegticqhLmMKzVcREPl3Bnickg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (565, '', 0.00, 0, '', '云厨阿飞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/loVyFiaRialvK5ZRSUhZH3EmVs5H4iaG7kOywQicqTdryIuGDiaxiadERUslkH1o9o5ccicbUanpzib3tdIw2YWxlrpicQw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (566, '', 0.00, 0, '', '滇镇王毕军破酥包子店老板娘', 2, 'https://wx.qlogo.cn/mmopen/vi_32/9ybarwVF9Am95I96OwKiaibaVibMgvmZLxN8ZmdC03sAxlHaGKQpiagUsunDRCEKDjHCibPVnicsD7ocWDibgybHnkkMw/132', '', '达尔文', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (567, '', 0.00, 0, '', '行d', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKyzHNnqCDOXX2PDytZyOicMgsWxHEoxRtib6nl7Qj5OmWZIiaSZzThbrMI3MPRSDDAgQum6rfic5ZvXw/132', '', '普洱', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (568, '', 0.00, 0, '', '唔生', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJaFedLkjhXADOE4cTqT2dg7DjrUAACsRGB3RWvrv1wuVXPUWApE1EwgAub2z8FDibHx5UP5ibW5XXg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (569, '', 0.00, 0, '', '梅子', 2, 'https://wx.qlogo.cn/mmopen/vi_32/iaJqf6gRaefXltlWsmMiaewJ1sYJsbejmAs3ErV28IoXbKrNEW7PI092wn587o4Ro3j13FqHcmjCGhfUZUljEPmA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (570, '', 0.00, 0, '', 'Z', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erLXSEr6uaibdbKlJbkLoFb5ibRX5ayU1IStwIf9O2OtHLEaObW6FpeZmheKyZ8ovv2aUsKQKHbpkrQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (571, '', 0.00, 0, '', '勿忘心安', 1, 'https://wx.qlogo.cn/mmopen/vi_32/2vzZyDRH052IqscEjb7Zsa2k5pWCpnI1EeUyaYXeiakl0y50XLMCr3lSuvZRfMK71wYvBricOshDBX5BTmzn1xmQ/132', '', '宝鸡', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (572, '', 0.00, 0, '', '卿', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep1wAhgpLEwNSsPYjGwdlGWibnibKagMNIbKLQ2hGhM0kPuh0cy0HAb0HgiaIv93iab3gUWbOichfyvryQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (573, '', 0.00, 0, '', '喏~', 1, 'https://wx.qlogo.cn/mmopen/vi_32/d7rxNicajyZLXUYR3iad5JcUEluCkBVCUaicGnGnRnh1uFCO5gOCZnsUcmDCjp2oyulDBjM6azBS7PhToH6YhXkFA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (574, '', 0.00, 0, '', '信仰', 2, 'https://wx.qlogo.cn/mmopen/vi_32/MLstCRRApdn3JEwctMlK2ZWBibGUeicLagsBIJBjrjYnqdt1mCUrCBMARZxBFzzFY0QwWe91l3nIO9975kmfkmow/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (575, '', 0.00, 0, '', 'A、练就丨张揖（不喝酒）', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJEtwyQAB7tPk2owTAYicuEkryy0RTe3bLTQ5aC4B82iaFsDOXaUE1ASBB8icwVpklyAYnWoY1iaSI4Sw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (576, '', 0.00, 0, '', '李太秀丶', 2, 'https://wx.qlogo.cn/mmopen/vi_32/k5KI75am0alKxoVEK4QeemtxfCqGwG7YxQdbTBxn10FX1gaTDl3rl1XKdxRTEzMQlhIvlmLzfCUEmNaZSNzQ0Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (577, '', 0.00, 0, '', '@MJ-阿军', 1, 'https://wx.qlogo.cn/mmopen/vi_32/tMrqzs7qJicJmSUoeWBcMxiaHW6vmBz3jRaPibnmLXUricoYTVUYayB2bwLymkd9AHwnKkZCu4rYt0gTCPyvN3iclLg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (578, '13529303864', 25.00, 0, '', '王保全', 1, 'https://wx.qlogo.cn/mmopen/vi_32/lr8u86oMtF62x9voafz61L9FSL030cWibAMPHcibwKsaUaGWuSeQQD7SGKU2a43KPicPXsKhAg2BaKpvXAQNnH52g/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (579, '', 0.00, 0, '', '诚诚实实张某人', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eotN8v0aCJxlicMZm9Mv4WA3ytHS3UNHbukAI4hW12IHvTsBAwH1P2fUJWFSUHMTWva4o8fbqvycvg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (580, '', 0.00, 0, '', '梅老五', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ibWDZynVGa0otVMdiciaRpL8GQPkWHpjU6bL8UwBh0Ynv5IV7GM20bLvYFSxiawia9w0KZwicLoeiad4qHB1VTk0jfZrA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (581, '', 0.00, 0, '', '左小溢', 2, 'https://wx.qlogo.cn/mmopen/vi_32/lgPvsXor4SKDRTRtMCJYNkrPhUT5Jm7yQgdfDYgGqs7SjMaQm2bWZeUyaPCbZYnWkuHy1CeJXpefOU9gRbe2AA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (582, '', 0.00, 0, '', 'AIMYON', 1, 'https://wx.qlogo.cn/mmopen/vi_32/l4zlY4krNhaZSrn4WbIqJTS9l4gjFIvZ25PL8pOjboMuTq0hKYoalhmzyHHMwoXIypjomhRdFuJxgF3lhwicK2g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (583, '', 0.00, 0, '', '熊向峰', 1, 'https://wx.qlogo.cn/mmopen/vi_32/IWOnxcOM4TMzc3yHjibibfRJC4CMosrzPNcibvd92Ko1GkHmBq1yz8fYtia3bh3eXLuuWfbQh0eVsYAuAQdKsArfSg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (584, '', 0.00, 0, '', '流霜浸月', 1, 'https://wx.qlogo.cn/mmopen/vi_32/iaYD9Xwfs6jiau2wPUJ1nWEkgbonkicUdWXaMID7VibCVwFVpYWYRdqqR2NIUXa0B1nQia84mREe8fDz0GFea9QGw9A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (585, '', 0.00, 0, '', '十指扣流年シ', 1, 'https://wx.qlogo.cn/mmopen/vi_32/fU4YNhGuWrj244ciavSzJFK4Aibr2K8BicW7vt4AcYicc0htTRdBI86fK6Wetia4eUjlfAYssBNwW7Obt21KedLILgg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (586, '', 0.00, 0, '', '@MJ-洗护总监-阿迪', 2, 'https://wx.qlogo.cn/mmopen/vi_32/kgbnqZwJaicdBeSjpQ4WTeL0z9bMbgsibx800np3GQxziaoNlo9LWaHTy9mVDqTJBh8Pw78Z6ZYJKdD3ySP8UYTlg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (587, '', 0.00, 0, '', '赵宏伟', 1, 'https://wx.qlogo.cn/mmopen/vi_32/WMrZONicS3AicKbibPuOTFk5erJSwECgY5lhpNNlDSESwpUtgicv43n2HUDPnDjMaGexicamiclMENbUQVvLwfyVRnoQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (588, '', 0.00, 0, '', 'w    y', 1, 'https://wx.qlogo.cn/mmopen/vi_32/aSzCicAibCOj10vA5UCsRr0tF780rYodFUpWrQDmul03nvOq81UfHhFgics5Xib4mIHhmicvicAEY4srGsKjXWU7ibnnQ/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (589, '', 0.00, 0, '', 'SilK.Bes造型', 1, 'https://wx.qlogo.cn/mmopen/vi_32/m5BW6yiby0fKXkx4973MMqiavNRv7HiacYnsib00CpiaD5vE6jv1kcWONyScaWEg625pQs4XlML2gst4dEQgZl5t9cw/132', '', '台州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (590, '', 0.00, 0, '', '追梦人', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ZSn4jJEJafqlD8bxhaNjH5hjHhQ4iaMh877acbxAc7Adc0mZv9k3W7ZkUK2oW5NiaFmaM2sk9ARHKrTyrPRiaS9Ww/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (591, '', 0.00, 0, '', '贾冬东', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLvAdJkRpp141ty2ibohy676YEIIkiatoBoHHz7mu9kLS2fUNg34wFKN2Dnhen8U5XoM2G8DMKEOuEA/132', '', '福州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (592, '', 0.00, 0, '', '罗铭', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Ewr0KSmB9yOQic5x33pcElfDSSp4pv1hiapoZ6PMeIHqWIK1Rqss64ibv2SBJyaMltx0AykTmgIhofSkzr54ht8Bw/132', '', '德宏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (593, '', 0.00, 0, '', 'A阿东、小区媒体', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLAxVVHGypicSWZEy1HDogMuSiaa2IysEIGsswltxg58QcxPCpgxEkBOlXK4OJhvLjBuxfxibiayFkCrg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (594, '', 0.00, 0, '', '何静波', 1, '', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (595, '', 0.00, 0, '', '周大人', 1, 'https://wx.qlogo.cn/mmopen/vi_32/EtQ5bno0zTQ49OMdfEvZ5dZnWAS20mEuibOlMCg6KF90CaFt69DRYBPHS23kxAbRHAiaFb3UGBkXpfbvWxftS1ww/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (596, '', 0.00, 0, '', '影子', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL9x3uHgQNZ6evp6hOicqLOusoB2w8WjxKsc7qkdW8NJMUMMrrZlBqlqgFIEcJA9Mex14LicUJ9ZIicA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (597, '', 0.00, 0, '', '花瓣雨', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLDKPNzVFAucwzsNBMibWjQDFcKtsLsAGIv4WJCD33nRvuyhHqOfRZVwIw9FsUGb32tPN3EZmbOicvQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (598, '', 0.00, 0, '', 'Joker〰', 1, 'https://wx.qlogo.cn/mmopen/vi_32/nXFfejDoHc8e7jRkDppkFliaXlaxMsKHEFWE4iaF1Lz0aH4AHLR9eDpurJAaRAQQfMicE5dCdxI0TIRTzfRJicKKpA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (599, '', 0.00, 0, '', 'MI L-代尔', 1, 'https://wx.qlogo.cn/mmopen/vi_32/RghNH0djiboo26hfSHcoL6pyUh5h3fiasEet3hZRv0jWlPHwfaVZenxdnYtAtDP2ug0BKTcmPQsV4lvU8ibliarib0w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (600, '', 0.00, 0, '', '曜灵', 1, 'https://wx.qlogo.cn/mmopen/vi_32/xj72jAVvludl4DkX8iaFQD2D7zibExv9cHHA1ZaaPRMOBUnfgHrKGsKo36MiaIF5ZpyQV231Oia9zickBrQdhGQZ21g/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (601, '', 0.00, 0, '', '筑', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ejYCwJUWUpicPKEO9VAVJjtT1THkfYJv4NkUIl0icWv3jqjiagTw3k38Eaibniac7xU6tCo6mauuD6foa4esr9R9H0Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (602, '', 0.00, 0, '', '罗平', 1, 'https://wx.qlogo.cn/mmopen/vi_32/KG4wJNib9gPXicFXzuLiazjbW8VLueiarnB8TpT73UAspUoBwSxErlzibX5a5icrtMCQGTz5XpQUPvWOpOoJfiayKsnHA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (603, '', 0.00, 0, '', '小米线', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DnLBDicibShDarEJ6nKWfvuyY6GibicaR7BEEBoZFFRiafQ5uOBmunBXlIMzOPJD20Lfz0pYCJhkhgNFvtVWm3s00Yw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (604, '', 0.00, 0, '', '土豆', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Y1Wt5iceA4hmNGH6GFBFjKGsxBO2DUoGpWTYfnkOHIEEwGBUCgiaeJPu68TfkAaXFomLDeuiaRXv0LVvkpZVgBgdw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (605, '', 0.00, 0, '', '刘祥18388707923', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLOm1icUJnDyacYnWA59SZib9zEF5raKDX4UCo3sUDicIPiawMRTb9pEK3sNN9SCZBvd2KwKZxZO08iaWA/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (606, '18887038659', 2.50, 0, '', '正宗酸菜牛肉昆明长润店', 2, 'https://wx.qlogo.cn/mmopen/vi_32/u9uBfzwMCbIicuxIpHmS3M4qSsSdqVRVfa5PMOu23BlQS6icIGhEQbbEqXc5JPrelW4dfHtRCD0n4O2qdncPuVyg/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (607, '', 0.00, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/0YQCKM93Bn0RrO8ZHmdpcHlQ26MDa4XdvbtdTP7VSvK1ZH1DgdfkCmB6F8yEiczCkwBIud4BLVTfUTNQPaVXKxA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (608, '', 0.00, 0, '', '博', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eq7ibMNLwEaIibTpDKtLvnSnWCI4KDiawMhcML8EcHHYDzb1sLpzmZXesXsal5HA04iacZIM7EICzLnhA/132', '', '西城', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (609, '', 0.00, 0, '', '瑾、瑜', 0, 'https://wx.qlogo.cn/mmopen/vi_32/95toQN7kMtojLSCgyecHKNG00DxvzB56DKl98J8xs8ToZXll5SibLTvWIRTOaRz9Q3nmua04gaSbNqPk8icpqBnQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (610, '', 0.00, 0, '', '移花接木……式戀', 1, 'https://wx.qlogo.cn/mmopen/vi_32/WGCyQ3lw9JZwreD2v1ngoqMNTFsuUXX6crsc3Of1yiceGkY1ASZa5BTTmEJL6aB9QoNZXz2ProGRARvCJryyYUg/132', '', '普洱', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (611, '', 0.00, 0, '', '开心就好', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLgmyMricXtV1KCSmHSO6iciaVnLQqI5t0iaLDT52bavSp8OEaibgVDjH2b4Jrzj7CbGbex5Z9GkIH206A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (612, '', 0.00, 0, '', 'Arain', 2, 'https://wx.qlogo.cn/mmopen/vi_32/SCtahh4mBt3mVg7vssP6GHK8r4LqvkeJy8BEFVYH9sKvYun2UjqYDK1crc7UlhgsZdFR2b7N9RWn8IGypphMgw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (613, '', 0.00, 0, '', '狸和猫', 2, 'https://wx.qlogo.cn/mmopen/vi_32/2DUrqgCTIITKudKrhtTt3jvXfARiaQibT92swMXRKlXcCDo1z1c0rsqf9OZHNQu9J0yK2CQxmKDgocABbLVuFGug/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (614, '', 0.00, 0, '', 'S', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epfQ0zburSYJsfb12lnZAW4ADFbsTm5yJGW7egG1e6OzB6Ul3DXqc27mgSVNBYEMibbCzicYRgz2iaLw/132', '', '六安', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (615, '', 0.00, 0, '', 'Y', 1, 'https://wx.qlogo.cn/mmopen/vi_32/IXvlCGQhcG4VSXmu0q8YPQuibS3ETibCF3GNr4NNWFP1EBwxOg1PkJXjtSz0uKNMInWzT2XOAgpjZhZRtwhic0D7g/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (616, '', 0.00, 0, '', 'K', 1, 'https://wx.qlogo.cn/mmopen/vi_32/3s31upu6rw3qI9kQKQO3XF3GAAqTLy4qbaDj4Et9evf2kjza5x9Y3Qv5icvJH4we1eaNicTXj3DEW5FxjwNbXVSg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (617, '', 0.00, 0, '', '啦啦啦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKChBPibu0ZicspRkWJgREjRGiae0XPcAjBdPX7FSZzWGQvjtNgoPmIZTw8lo2ib54BHucqW56JRs5Eeg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (618, '', 0.00, 0, '', '.蒧', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ic7iavxDDNWTgpG5Xh9YxPwwviby4eF1tTv3F2NaavY4Eywvpiac18Ue6nVkkKnxSOC3pTQITdibARLrd4NvOqbf6DQ/132', '', '西安', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (619, '', 0.00, 0, '', '清欢', 2, 'https://wx.qlogo.cn/mmopen/vi_32/QVceiat5EC5ID6dLicTEkukpo9UCXwoFMv97kJwmd8NwtF0fUNZr5Hj7S2WdUMH7F3pvxFtLX2mDledGPcMdohnQ/132', '', '宝鸡', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (620, '', 0.00, 0, '', '张志远', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIje5ul8SicPiaKDbMxd3u43QNHqhibzj1usIDnaias7TicKgg6JxIT4xXmbsz7ceY2gUUSvRxcHicXoJgw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (621, '', 0.00, 0, '', '任性、小', 2, 'https://wx.qlogo.cn/mmopen/vi_32/AHESC3WcfiaakJdWzNJuaNjwclibu2EKQ20NVjSOV74AHJoZelerBn4K3oT7XCxnibneeic0ptqvVahBDwdp4bIqpQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (622, '', 0.00, 0, '', '追逐', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJJAbbmbKTjClib91RJ7MZjTqBTOMJvbMcYNfTVNYD5v2985CoxAviaC5klTOvf8asHs7xoxKUlEoJQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (623, '', 0.00, 0, '', '风雨无阻', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLGRNx7hrqyGSial2pgsjia3DQJMZ3LKgfxphP8VArQwBoqP4Qb433nLic6u4tvZ3iaXSibjQ3ibvYY12dQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (624, '', 0.00, 0, '', '痛并快乐着', 1, 'https://wx.qlogo.cn/mmopen/vi_32/BeGIP6S39alnK89rY5Q4hlSBGVQ3duic8XednIos1iayZH8bpUJDkbnw0ea3N7iazROODafXozONVk7gUs0M3svdw/132', '', '保山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (625, '', 1.00, 0, '', '本应肚子鸡欢迎你订餐13577176130', 2, 'https://wx.qlogo.cn/mmopen/vi_32/o1UTXECe5TMZricy0twBRun37lQ1MC5XqVzkRicQQpJIKmGVV6GCxOtHLU9cpceicylzsqSdI52nnlU26o1nG2j0Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (626, '', 0.00, 0, '', '半仙昂.', 1, 'https://wx.qlogo.cn/mmopen/vi_32/cM11JAe4bgZ51M9aNxqrdyN1WdSD4iaovtgomLudsOxAybgfTnJmncuNwiaTIzThefjGolGUDP2cicHEjdZvcLcibg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (627, '', 0.00, 0, '', '海坛大排档', 0, 'https://wx.qlogo.cn/mmopen/vi_32/JI2aMOh1ibv2p218uIZ6Vc7e9RIPjiabicuyJ3ERS66wNXyXg5T5aarcgVb1GgCmry1661wwNBYPsyDicHxtINgopA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (628, '', 0.00, 0, '', '蠱 .', 2, 'https://wx.qlogo.cn/mmopen/vi_32/MrvdTlqgkrydFNiahgfUvicBcibSCiag9J92ecXXlu055n6kEpTECEkibmK2Bso0oJLH8R7yag6iaNp7dMNOWwibbgUmA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (629, '', 0.00, 0, '', 'Rinon', 2, 'https://wx.qlogo.cn/mmopen/vi_32/F9OhURz9YVXlNHu2MRP7z9KibTLT0Tn5tUw5KAgIlxf4uW5X2YKWdVkzuWhxBXOx1T3mURCLYiazjQ9XxgBnbN9w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (630, '', 0.00, 0, '', '唐瑞', 1, 'https://wx.qlogo.cn/mmopen/vi_32/jhxw8km3TMa9tSibP13MBP0wf8UkFtic0AxmmHjzUyeZLGer7ricib6Plic5185sDxwny8tSnG1pUWiaAbqXnEnGc0Dg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (631, '', 0.00, 0, '', '泊君', 1, 'https://wx.qlogo.cn/mmopen/vi_32/nnhEnDRLbibGNiadMePbwsw7eyWlJ4zXictJSCkoDgx1OQguV3ytZkA2GGb0L62soTKzs5H6ccHNMFEfdmCnbibZTg/132', '', '洛阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (632, '', 0.00, 0, '', '鸈籆', 1, 'https://wx.qlogo.cn/mmopen/vi_32/yRdQmGhVVXLEIVA4OQeXL1YCH5CK8d6NEjJjgDic1oCzuEaDHtx8XbiaF9jAU81BYP1SlPB5JmN5bO4p5K7Eya0Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (633, '', 0.00, 0, '', '新龙', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTINq7lboAqSyVtG8Mxw9lbF6X7gAmhuAhYiaYhENInicDeFzWKvCpibibNDNAVVtRpLic36AjGfGibngDXg/132', '', '玉溪', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (634, '', 0.00, 0, '', '沁', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLtbKXtcNibJiawMicw6DlQIXPaZH5BMS9VzNrEPcYfUaF9xgAjB8QumhohZ1YCPkD4fBHJcNDVzpgZQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (635, '', 0.00, 0, '', '方秀泽', 1, 'https://wx.qlogo.cn/mmopen/vi_32/F7gugrUQT4snavA8SscndZuHn4m0DxWO40CkqEpVFQ3t6KNnxDtA1EDAJt3sG9icNjU0ttKy8swNZxdSn6n72UA/132', '', '克拉玛依', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (636, '', 0.00, 0, '', '上瘾', 0, 'https://wx.qlogo.cn/mmopen/vi_32/UnlnsM9JHfibK7tYwVGLFy72gibH7SyHFib0aueyVD0kI45SUb7l93dzibsGibKVyC9VNSFtnlapURjefAfcy2zvQWw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (637, '', 0.00, 0, '', '小太阳', 2, 'https://wx.qlogo.cn/mmopen/vi_32/VFq4a5J91PZ3jFXXFBKfqmxIMZTVSvu4iazCG0aZCHUAuU2DxibDdFM6miauuAXaYWmrnTRE9QmPN4XiaEduynBPGA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (638, '', 0.00, 0, '', '金色童年', 2, 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEJ12mDsk1tU1K4a50VRvhPy1KwDIibeP9vVDl5hfbPUagvSkhyytOjTtiazWTJNNx2iakWHtzFWe1YdA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (639, '', 0.00, 0, '', '大川', 1, 'https://wx.qlogo.cn/mmopen/vi_32/u2xwh1eSB3Q3X8D9qJiaiaiaF68ziau8rKY5JiaE3leibaYeI6OAartWKK5AqSuyFChJBoumDzIRLKqom9fgicav9yJ7A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (640, '', 0.00, 0, '', 'wwhh', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJzy1X92WgzTJWZkagPDlZ5xnppygAuPKLnLYxpE2yaTjoIJUiaMoqXFd7wDR7tS9rXFajrLRibtAmw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (641, '', 0.00, 0, '', '陈石文', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLx4jXDGtGsse2XTv0qXLicnvEPQCKzOHkXpxXkLqRoQZpYVOoTvQGuy60OBcmBdzArBA0ZQ0kBNbQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (642, '', 0.00, 0, '', '随缘', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DNvcNK5DkdNknQ5qGeWS3XlzBfomUpRffD1WXM2hr5ZSicAEa2ibuo7rQ1DtcALl4xKWbOAl3icfdn7LEEj9S7KwA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (643, '', 0.00, 0, '', '运营喵-鸥鹰', 2, 'https://wx.qlogo.cn/mmopen/vi_32/cUEbJyQUAuicciaPhWgodEiapqjoo79J77gux9jt8xbKVZiaiaANJLZpAhnlPYUhcauRs894QtuAmONUpGfCOica4htQ/132', '', '屯门区', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (644, '', 0.00, 0, '', 'Paranoid', 1, 'https://wx.qlogo.cn/mmopen/vi_32/wrJnAtAI9iaOHcBTG1UzlootWRcZSfPHfOZFaZicMQSDASxic2fPtl9SmUfvzBwdUmS7pVnRkMadY7w0UQyHsbmvg/132', '', '广州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (645, '', 0.00, 0, '', '金蕊', 2, 'https://wx.qlogo.cn/mmopen/vi_32/UNiaYnrtgEqIYCGNEFIjqjMic0shibyMceKibhcicR8GNYRrdx02RBLQWEjJmLb8xibOQb8OoKUMicSFicicDh5aB3M851A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (646, '', 0.00, 0, '', '兜兜', 2, 'https://wx.qlogo.cn/mmopen/vi_32/4A4VfKDKx2hxfjMcCzGRaeHM6pXETicju7IjhlAOcHZlFFNwkYIBlNOq928ZsUuYHyI9laUiaJo5C48IyV7S0BicA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (647, '', 0.00, 0, '', '常婷', 2, 'https://wx.qlogo.cn/mmopen/vi_32/54JfxbQOib3P92ErJN1mpGtCDjKZ4WWON1wGsicm06Ie8qvG9mhusvvIibLIwqMNFgkIYgOZE7AxdSVs858TenmXA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (648, '', 0.00, 0, '', '墨殇ღ残阳', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKolFX0XdToWA1VrVGJ0dYNfOJic5r1PrshdotclQeBzFtXnqSib8CeewRda2sY64zgF2vnYmCywyhg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (649, '', 0.00, 0, '', '珂开心啊', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJeX1YJL8L0x0xIVSyJYUdQNDTBCtwgsAHJUpPDaR4L6vQkDAR80licgS1Lb2r5EzPF5w8c5nQudTg/132', '', '郑州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (650, '', 0.00, 0, '', 'Dark', 1, 'https://wx.qlogo.cn/mmopen/vi_32/cdphfCQdAAv7pFIpbH9NL51ljZC6y4WgSV5ibNHK6pZiaicc1wr0XlzSha1L9nbibartQ83afEakDHUUeYfmrYXLXA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (651, '', 0.00, 0, '', '小小思', 2, 'https://wx.qlogo.cn/mmopen/vi_32/4PLs10x1rSS6QKtav671Pd2jQauvTrpygfGKPKJicDNlYS9Rgs8icdmyfp53D2tfZXbZiacTEL4AhwcLUfddc1GGQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (652, '', 0.00, 0, '', '老中医', 1, 'https://wx.qlogo.cn/mmopen/vi_32/iaj85Pia2KvictEHwSsvNLxeOSgpaiaolqibcqG189dZzBDl5P4Z2zaM47WGD9Dw3n4iacLNCWNEP13WdbBDM7kaBMRQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (653, '', 1.00, 0, '', '严家地晓鸡汤', 0, 'https://wx.qlogo.cn/mmopen/vi_32/40x5mwM2VrtnEibBlVKSdBSuiaZ2Ov9By3coLtlbK54ezZtDEb0rze2P85v4dkQgm5SW7UJSGOOXzfLshsLngQmA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (654, '', 0.00, 0, '', '卞苓苓的渣子', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Ipyczxk6UWnqV4ROqZ4xU0uY3WibNc6NZAmDKRhyAejebYRTKuv5I69mWdbuGTSHFhOqGjLRTXn1rFdc7Q6C9wg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (655, '', 0.00, 0, '', '傲娇小公主', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKf9NpkBqP58KAkOkPqKuMmE3YiczjvQciazcUUK9o1EvumzDmy6oJ2Tibn4WBV2Xg56iaibMk85J6MpKA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (656, '', 0.00, 0, '', '雪儿', 2, 'https://wx.qlogo.cn/mmopen/vi_32/tnre5zNFtfLDc5PJDTeFO7fiaqFV7faV8Gf7UBUib6vwC1YMeXW23Qq5O1Rpw2bxWoVNGPVpt3ibcjDo9lCPAEEMg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (657, '', 0.00, 0, '', '凉城丶', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIDFicolsCEn0HPZtlSqicNAYKAeYSeJyCpgKNn2k9CQiaeWxGwxobYo6gzY3R02sHeibyxBE3pP43xYA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (658, '', 0.00, 0, '', '杨晓羽', 0, 'https://wx.qlogo.cn/mmopen/vi_32/poZsSoOXrPMQx7WljrzVxYocWFJfONBbicN1JaWDV4X8GwH0OeDlqeBergRLWCZVzFMsowSiaKoV5cE5xZo5Lgfw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (659, '', 0.00, 0, '', '蜗牛莫茉', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL8mt5gsZhJibyz6UZ6FlpC19F4LKXG9blfibMMpbIdcQ0r4up1WrnlCfPVSIdoliagfOt01xF5uIfow/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (660, '', 0.00, 0, '', '纵横四海', 1, 'https://wx.qlogo.cn/mmopen/vi_32/IaXEm3BPDJfcV0wM7LAYW9SITCsicF6Q0p3Zl0pBnDI9Ms5Cpg8LBQYbG3IDX9wec5TK3S8xAravNZibWtcHrk4g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (661, '', 0.00, 0, '', '春燕', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Qj7bXNj4Xtgo2gUc4kd8eHtNiarhPhCnZ47FLN0Ij1EhEIuicmsIZ7ysENYIPe9wicDeUdvF4JdItN2kBHK0I75jw/132', '', '大理', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (662, '', 0.00, 0, '', 'Lucky&Baby', 2, 'https://wx.qlogo.cn/mmopen/vi_32/47ibHECEmPfxx98n87GZ3m7MxxRFj5IMffNmsnkUrzLlWeoocCoUcMeP0P9H45wecSBnOO6q44OICrvYpIqSUqw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (663, '', 0.00, 0, '', '街头PUNK', 0, 'https://wx.qlogo.cn/mmopen/vi_32/KCwvjicqndD2LzIib34v3YFJDrJslhb2rLZFn4ia4N5lvI450pZKoGriamqFmKxxvjfrcCKCxaZh4JE996WCrHkickA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (664, '', 0.00, 0, '', 'Star＊蓉', 2, 'https://wx.qlogo.cn/mmopen/vi_32/JNEuG337hyx4thic85tkBjhhXffRQvywyqGIEPRb4CiaCcPTQtPTTLpMQbMDl7YUpvzpYF3uEOjZSiatWBfJDPaFQ/132', '', '大理', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (665, '', 0.00, 0, '', '等&¥¥', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoibzoZibZZfahSDOtc2h4qGl5THGznqd6yXAzgWj6qOJC03Z9zY9UdiaH13t00KDnSCLhMNjgwTnNRQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (666, '', 0.00, 0, '', '燃曦', 2, 'https://wx.qlogo.cn/mmopen/vi_32/YtictVvlT9o3FYDeQp41LlUhjbTuz7pdzC4nnBhTg7dX8p47fqicLdBYenAYTw8OlyMViaqjGnRlriaZDLVAR4lYXw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (667, '', 0.00, 0, '', '涅槃', 1, 'https://wx.qlogo.cn/mmopen/vi_32/eFicQf6JHnEtk82pb9qdoCRZoQUpQzb6icMOg5JQEkPyI1EWciaKJQVmN53eHBfZ5G3IXz3tQia1RKjaMru5YyDSMA/132', '', '徐汇', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (668, '18587350368', 0.00, 0, '', '时光之行', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ic7iavxDDNWTgpG5Xh9YxPwicscLZggmLfVsak7qBkEVoNn4HicUhSQ1B6qytL5Qs2k7AoFz2Bf4PP6Th2fhibR3Gbg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (669, '', 110.00, 0, '', '兔子', 1, 'https://wx.qlogo.cn/mmopen/vi_32/R3hvIy3IO5E5woznH4MwZumkibmtE5Zp7Gk3obGOQJ5SAnKTaqnkws68RdPa2GBB9om1alxlOibp1yKYDB8nR8QA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (670, '', 0.00, 0, '', '卡农', 2, 'https://wx.qlogo.cn/mmopen/vi_32/ycwKq33R7NvwgosL09posrvFxl8l2FUE1ZRnZu8A5gWhhzUzJYQbfiatMibQNhXWkdqZAlqxTGae6qnTgIjLQELw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (671, '', 170.00, 0, '', '西凤酒思璇商贸15288131768', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qnZg70jW2ib2ckzxCZsPAL758aic5kGL9w6YsbXytIH9ll9GRicuFkX2kutufYTubnWrVXiaBtx7u9AQuoKlPibDabg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (672, '', 0.00, 0, '', '海洋之星', 1, 'https://wx.qlogo.cn/mmopen/vi_32/7KicBb4FXf9iake1PTkvlgpVjw1Vr1UIU63mD3CicbORwia5aGmRXib7Y6WGPZ4EQsoPXkuJmObNAMpqztHad1QPpuw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (673, '', 0.00, 0, '', '精武鸭脖', 0, 'https://wx.qlogo.cn/mmopen/vi_32/sfMKiaHzSHkIibxs0ILScTg9YhdYKGq0mSz0yxlgw0TNgZQqyh01r8JmNLXAQPGrJBeb4ticOxeCNp8PlCTbWaNUg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (674, '', 0.00, 0, '', 'A@@@@@元霸', 1, 'https://wx.qlogo.cn/mmopen/vi_32/8bUM784D85nBrNS01uMdlbSgazSNPYVkMyxPBPavlmhp72aeg67sVaeyNEUHUfOibEHiadRZ3TkPmOJR4vRh8ibEA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (675, '15282196399', 20.00, 0, '', '岁月不饶人', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ibDmMye8Y8nTdMDAVAgMHSLTCraNI5riaozMpajB1Ndo12SaCGKbcR3jyFFM9Q9iaksiaeRYZY75GL3JXLEpaM3Sicw/132', '', '内江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (676, '', 0.00, 0, '', '三岁就很帅', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJVsGvqgby9gAMZMY684PUds9tXyjOtAjlgvUhMM6nQc8tdQlWUuprpbc6ia2QY7Ot4p1gODNvOhMQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (677, '', 20.00, 0, '', '杨秀峰', 1, 'https://wx.qlogo.cn/mmopen/vi_32/n9zsxFsf5vlvhFfkMeOeXMhUVxxypdx8Y4ibib1S0meJ2icoMTU2WkDN3UhTSQWWdj5VIj4vHuPutnibqRicX0Szib8Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (678, '', 57.00, 0, '', '尼古拉斯～威武嘛你', 1, 'https://wx.qlogo.cn/mmopen/vi_32/2rzRXkJlqQXGoJDPx93IfZ7Jvp5LWzvdS5lA4pKDHZf9QOWDZHhotcMFrfgONzZhrD42WRUTGtBpvqMuQYpW1A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (679, '', 0.00, 0, '', 'A装修', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qesguulPEAkeUsCn27HeMSnplSDLUicL2Z4e1uJibq3Ax8p71iaEQNecWuOjpTezIDCIROkEeLem4TnCEbB4GfFKQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (680, '', 0.00, 0, '', '治愈少女', 2, 'https://wx.qlogo.cn/mmopen/vi_32/p9wib6Fia27XWBORv6AEf3n61Ihz5ZRJhj0WFHhCg3D7ccEKk8uyNiaMvTUYK8Gybu7K6oEnG7VRNkv44w0lmDibzQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (681, '', 0.00, 0, '', '周超', 1, 'https://wx.qlogo.cn/mmopen/vi_32/HMuHCjwyfmVXP5Zx72MBmHaA55fcFYP99hT9DibmaHAWmibnsbia5gFuAVbhhOPO8JySjPibMau8icGgW40ib27eYTYg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (682, '', 0.00, 0, '', '椰子树', 0, 'https://wx.qlogo.cn/mmopen/vi_32/hDxCswUpGO2ObphqF61ImW7fjWSiaW0JhPAv16EBaUNTKNtJtwDhxrd2m5tia9e8TQAJSW1xJbGKCz3TcDXUZtzA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (683, '', 0.00, 0, '', '玺闲居酒店', 0, 'https://wx.qlogo.cn/mmopen/vi_32/fXUod7hEFadF6OSnj0yrt6IzJElCME8Slq3c5Slic3Uwiariau6YictYg9pMcmen2mfAho0wWoyth2hRDXf8c6vrLA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (684, '', 15.00, 0, '', '7.', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoohHZ1sorh0Cgic5131uUEDaaf3vDfht63BNxz2B6iavsa5D5923uzYreqaIfianPZ2EoDEyDrM4G0A/132', '', '沈阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (685, '', 0.00, 0, '', '简单的喜欢', 2, 'https://wx.qlogo.cn/mmopen/vi_32/NqmSCNQNPoekdaRX12lDqVlhIoW23K1uhatc81wJiaqCJWkzFcn6yBic5SVBrnib27LAhlqwwRbok6KF7va1aTzSw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (686, '', 0.00, 0, '', '旅行者', 1, 'https://wx.qlogo.cn/mmopen/vi_32/iafWBnD4ZODhbLPBqBrt4kb13KC5tgqw4orQze9MgYA5sGpWaY5q5meXGS130FnoPNV29mrWYzKqt626FES2wsQ/132', '', '保定', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (687, '', 0.00, 0, '', '莫念@心所愛', 1, 'https://wx.qlogo.cn/mmopen/vi_32/WPWRDeXmGJTVyo0CaceHQ0RkHJriaxmVFPV4L2aPpv6grQoK4QXmd9Zz4VibBLiaLCRMyUnic4EEsTMkdgYRMN5XwA/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (688, '', 0.00, 0, '', '小坤', 1, 'https://wx.qlogo.cn/mmopen/vi_32/2at61HO4OFBb518IkhECo7GiaZZ9QC4TtFzmzuo7thw1FCcucEHjPlK4GcEZbYeOkw80AFy8g0qDiajN1xgD97pA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (689, '', 0.00, 0, '', '三姑爷的腿毛', 1, 'https://wx.qlogo.cn/mmopen/vi_32/dfU8BEMl6H8s1XkKXFMNWeFIJj4DswHsAQgoe9tib8xD6m88U6fIblgzlr6aPG7nib1ibvVUsiaWPzElz1QsOCL5JA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (690, '', 0.00, 0, '', '信仰', 1, 'https://wx.qlogo.cn/mmopen/vi_32/EL7iaV7AsQf0B3BMxCPxYObqDeLpSzavEVrpibMF1ibq6pKdPibicytz53yUIpATWt2PHVrocMId4BkXXS0XClEKGvQ/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (691, '', 0.00, 0, '', '鸿利旅馆', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLNIgapuvTmRynr8wFP4SbRIx2MnugWVOj8dW3LzjMnnqCQrGicUzI0ib9FVVRkA4dwA0HUzx15XjKA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (692, '', 0.00, 0, '', '~反思昨天~把握今天~', 2, 'https://wx.qlogo.cn/mmopen/vi_32/JOzFpia1ol5WDoLvJOCtWNbAedIwhoFlbPbxqItkhoHXMbgcKOeK0RCIUU1ox0WyiaC378tyevaygflXvXQazVEQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (693, '13708447669', 0.00, 0, '', '老周', 1, 'https://wx.qlogo.cn/mmopen/vi_32/8MUL0DdibAv7wdEnoaDdfM4Julo8Pnh4GZr3ZrE2ySgILnOIHibr7drnKO4Q6hOCzIrDmkceUiceL9cHZPhQLIpFw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (694, '', 0.00, 0, '', 'Y*', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Dj2yEfO27vWxITiaS7wGQE6BZorib4OO5BWgpIuaMdIvRl8weSSFfReHOvVTCSQpN5ZYib0JnAz7s6jFdNPtIzn9A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (695, '', 0.10, 0, '', '习惯就好', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Sd5o1PcEQEXZBf1OLa4hqFh16XCr65qPFn3HibpcMI3mhmeSTPX6p9dy8PPYJ7CXczqm4bVWrMibA3IdzddQF9Dw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (696, '', 0.00, 0, '', 'SEE  YOU', 1, 'https://wx.qlogo.cn/mmopen/vi_32/lQ1HcxQ49phs0W8U5blh5icNryRicM0nr0ZkTZHtUTtlPeoQykwibNBYibucRImzdGGVHLI1cuULm3gur4kc4TgpOQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (697, '', 0.00, 0, '', 'Monica', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epGhcTibyH7n2ULxnrZUW0dT92zShMbkyFfvjjmz3CpEuAeN0ECWvF5ia6n8iazZFXkEz9wic5BLv1OQA/132', '', '保山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (698, '', 0.00, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/KzQJ0pNwG94IM43qh67gU3ympzunjltdlNDZtuaAsH9F8NUuoibIXqWtBsXA0vucd0KQ0weaQLT7O1vKwf2jecA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (699, '', 0.00, 0, '', 'Clausius', 1, 'https://wx.qlogo.cn/mmopen/vi_32/WwaGjhABeBtGw1wAAFuOTVhtaoliaWOzIydo6t5oeNXiaCv7ECjuiaxkYmlyJhG70MUU6OXzxEzXB3U9dz8tk8Faw/132', '', '朝阳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (700, '', 1.00, 0, '', '人自娱', 1, 'https://wx.qlogo.cn/mmopen/vi_32/0Sjo1xMMInQdHTGTVMo093oTCzrkmRn2w5h9ZWslTNG3q3ICylLU2oNwX7f7MUiaDT5N6lQpXYA1UtfQ0jDgF9w/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (701, '', 0.00, 0, '', '南梦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/dnM0o5GRukpviaPOXeEqoeK7FhL5e5yWicAFLMtuzp2pNa7Dbu8JpLpicSLcXuQjfomMKhXqS3YuoH7JicAnBZ1jUw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (702, '', 0.00, 0, '', '&灬斌', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep71qXibPKNsWDtXQLCq0NMk8NMbibScXjjs5bsknkWIQ2V3T3ODlhj6H9CTfria5W9gxhicc1ib1Eicgsg/132', '', '宝山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (703, '18587257427', 0.00, 0, '', 'Siesta', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ToAEjYKohHoyx4wNVrERdh5I5gJIS1fVGskyoxCS4uC1RV0uxd6Z5BstAnYST9dsj3AQuAoyHHzww54AQs8VrQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (704, '', 0.00, 0, '', 'ふ', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLNa1FRoAfGEZIogN8Zo408me5Ck1DDXrnhwfCmN7VluBDvIcoayxic6cXYVQFXmhgicpfKDjjhztLw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (705, '', 0.00, 0, '', '简简单单', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ZnH591fAmia0TDlia7JxGC7T7lGzqJLbqaBIeic66eTdg2mzO2NOplge2Xia7hSszzGPibJEiasMbVCv6ft1OHwPibFeQ/132', '', '大理', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (706, '', 0.00, 0, '', '℡怎让你如烟', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hv2mnlMicQCYMyCCeZdab17icwNDibF4dBQOaicGNibia1ReTQXLBfC9NnUolOtsFpB9ANMsH9dauibKd1UlT0fJl99Qg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (707, '', 0.00, 0, '', '老三', 1, 'https://wx.qlogo.cn/mmopen/vi_32/XK0Nfj9hY1QiaT9FgMh4GxoBITG9CaEF1n9BQsobm8MoqPa4mFiajlvlt3Rwk4BqcCdejjUm2JNZZhBc0zqCxaAw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (708, '', 0.00, 0, '', '帅帅的熊', 0, 'https://wx.qlogo.cn/mmopen/vi_32/GYDTx7cnhFOaH11owkWwNdbh5ZJIP5WsFvG15q2ibloTicQicCrdMFB3wMw5rx1QxBPpaTjxLll2z1CWfSQZk502A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (709, '', 0.00, 0, '', '默陌', 2, 'https://wx.qlogo.cn/mmopen/vi_32/8DZibQ1UyBwzNTWY6rq9xgicbMguib5JkU2XggGy1NoMBsLJmbfQPDic2aEmhcbqvmYBIqLiaXEoXSZcAxEwhIToNVw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (710, '', 0.00, 0, '', '默屿离鸢', 1, 'https://wx.qlogo.cn/mmopen/vi_32/8LQRFkVYfOsdVmUzxdog4t5674TGGuJ9Ds2VicwJ7OgibuSVO3Zovx3es3hHyImq6UlfyCpzS7XI9ytEyONJDDjQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (711, '', 0.00, 0, '', '扶桑古树', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q59x78KMMIanSnb7Co9O8BPTdq0ON4VeNqHph918lBuiaJkQLgboQZhbbH4dIawjGiaTkrnu7ich656gYON90u8EA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (712, '', 0.00, 0, '', '迷彩的青春', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ptgSXJah2kicQ4XuPF7Dd3jNOia5aaMcyPIOTQ4p1M5O1uA1Xvo5pawEq2h2NtyyQn6iarEYDmLq4zfshno8de4ibA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (713, '', 76.00, 0, '', '和大', 1, 'https://wx.qlogo.cn/mmopen/vi_32/GWeBoibVCzHjD2BKNwQQtFcdsCIAHetv4QiaVPzia2B0iaNogO3ZDusTQP9HIjHPYLcco8r08ATaq1Njs1VGzuxLdw/132', '', '迪庆', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (714, '', 0.00, 0, '', '衡炜陈镜宇律师', 1, 'https://wx.qlogo.cn/mmopen/vi_32/WURLia647wPkjbVRu8ibQgxChdjgjDedyKIcZI1jvcNdJLov8y5VPJ972olTf7uF5VN1DXusT0LHQklzHF0R48Nw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (715, '', 0.00, 0, '', '努力中', 1, 'https://wx.qlogo.cn/mmopen/vi_32/zGlAIG1D96BjgL7J0ykoIuN3vm3mEe4LQ2iaboNgsX3Brv7VdaB4mQHw0p56aKkZh7kChhPXicdjiarNIy8gCBOzg/132', '', '深圳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (716, '', 0.00, 0, '', '守望者', 1, 'https://wx.qlogo.cn/mmopen/vi_32/KrBu8pUcAGmz8Sdanq9ictyCutcxVavibdrox5szrVicVzmGKP8mDrRFTwCn5b6EoeRKWWCetBe9flibOicQ9yQE8wQ/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (717, '', 2.00, 0, '', '向   钱看象厚赚', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLQaJia9OJhoIDRiaElnEFnROXFZ1ORUoXunRsHvQyFYDaycNEwQiahOov3ndd0CpE81KkUmM6YIe9zA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (718, '', 0.00, 0, '', '《～微笑使者～》', 2, 'https://wx.qlogo.cn/mmopen/vi_32/3XrUESN4ON5Fibmu3fWMIVH1m84CV3rNkt2TEib69AM4lroDTOlXdLibRibwvSfFm21ibCKRMTWnrrbrJHuqG6B9dNg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (719, '', 0.00, 0, '', '和为贵', 1, 'https://wx.qlogo.cn/mmopen/vi_32/D26s4tMwZbQ4AeSz6QDpR3kib39dP3RnL6UIIVzHtQfx3ZWWbibUxr4zarcIHMM9dFyPDvfARYmAz3K42kiaOhzIA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (720, '', 6.00, 0, '', '(^(^)筱蕊', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLERLpErfNmoiblblGjgh5E8N0pfOice4oeoJR6VQmT4PiamRLbOaOppKF8XHbm0jFAK77jZlye6N59Q/132', '', '西宁', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (721, '', 0.00, 0, '', '一纸魚舟', 1, 'https://wx.qlogo.cn/mmopen/vi_32/NHYYOmot5ka5Yx4d4C85goHQso5u8WRSRx4x8vm4JuIGPy7qbicUY5DxmoMNjKfectias8zcnKIJZu9f0j3iaWmwA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (722, '15334399400', 0.00, 0, '', '虹山面粉厂新迎店15334399400', 0, 'https://wx.qlogo.cn/mmopen/vi_32/vFhAmp9beuRuZZL0GQibJqvJ7kGSsicrOH9P256WGZfkiaIHpr0p90dI6OAzw80ibc0tjgsv2UCJxa3Zne88WK9Xnw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (723, '', 0.00, 0, '', '找找世界（一品红香辣蟹）', 1, 'https://wx.qlogo.cn/mmopen/vi_32/mOFw06icwoIWeYqMibAtFvDYOsSywibWiaB0dMGvbbDx7DhpNQabWPlMOtrg93CqTw6m9oE7uMROkgVCKCOyodgztA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (724, '', 0.00, 0, '', '突突', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqGBufBl9HksH8RMHveNbibcZeuTwVWFUctafB4ZGS9XMpagTFhNDQNs2LOh2aHbTjG8vHYVCfbobg/132', '', '西城', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (725, '', 0.00, 0, '', '刷脸支付', 1, 'https://wx.qlogo.cn/mmopen/vi_32/W7z4uB2e2Z5iajy30iaIXxaPnru4icLZKJ58g5ubddhaIUN9HD3oTM3afOzgcecQWt4PHrLqkXp7FKYLXibcibN4XAw/132', '', '毕节', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (726, '', 0.00, 0, '', '绝味辣螃蟹15087181618', 1, 'https://wx.qlogo.cn/mmopen/vi_32/SaC50HiaRicPbKsT7XjSMFtAR3GJ09BoqBkM3gDJTq8g0u8OTAEwrMm2jcZlN3TaPL7b1x9T18Qcbj0wIuUDZwSg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (727, '', 0.00, 0, '', '欢乐佳园明朝秀', 1, 'https://wx.qlogo.cn/mmopen/vi_32/gO7sbCDzHh4IhMNRcAosfiaeu9edsvrEusAsk6ZEcRTNtcvwXeM3tfKCapeibRqnNiaRr4LBBzvxPpVClufwEKzOw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (728, '', 0.00, 0, '', 'hhh', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qkJGD8TVtkQFbUeBeyOun5XQzICsic614P7c597WZVdzwtjlClskTS924BoQmXGyaA9EGjVbIgiaYRebHiaWyvqgA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (729, '', 0.00, 0, '', '???', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIGDibVCFrQf8ib6G93aAuVbDsZudp2d7UT54crcZ9W1GJho1S20YFatKP1YGhfib9LibBHwuf8GickhUA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (730, '', 0.00, 0, '', '家有宝贝', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK8DAJChw2SehS19bKEPWppHWU80GTMF6iarB7mGYyedHBxFONl9Tffbm2bPr1JSgaky819ELrQnIQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (731, '', 10.00, 0, '', '………', 2, 'https://wx.qlogo.cn/mmopen/vi_32/87rAP06gwZTFJJ3MDKcsQE69ssnkHO6koFSgaPLCRg2yWKLia1LZXrm9yx9Qib0VQVqPvvQoeX6Nw8ASX60Kt8lQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (732, '15187415468', 2.00, 0, '', '微光(･ิϖ･ิ)っ星辰♛', 2, 'https://wx.qlogo.cn/mmopen/vi_32/5gOHxNia1OPHfYICXrvM96sX21VbFNOxaUxlKxEHA55vsicvyxyzxoDVcvQb2miagKcZiaKzykKwjg9O6Nia8FAWvtQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (733, '', 0.00, 0, '', 'Q_Q', 2, 'https://wx.qlogo.cn/mmopen/vi_32/icNM21AqdRLeY2438JJNVoe0vXL1JhxN6bsF5boJjic30FkcmEa8ia2OgsYQcKE4xAGpNFkicO8UiaIajNm2UEQXKBA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (734, '', 0.00, 0, '', 'zyong', 1, 'https://wx.qlogo.cn/mmopen/vi_32/2euu4bJGf18ich7Y0ITIfIPwlI4HdJ0VjoNvb1iceBWz5zAOiaZ5Kiaj9NWDz7ibjUdQuJZPsOruqe3LtVPv6via7Y2g/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (735, '', 0.00, 0, '', '编辑中。', 0, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqe8GoSmNwZkSrAa8AbxGfB5RicuWEcDAeTMicibHS63oQLrsEMS9nTsZicE6WaPYohPibSqUX6oPzaiaLA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (736, '13888656283', 0.00, 0, '', '杀仟陌', 1, 'https://wx.qlogo.cn/mmopen/vi_32/foJib1nNUdMRVE1KzoG6ovQODnHHHGB50vj76FftAJpmxdFLU9kJ9htxruKDekI3ssGhU6MUszYcO8FPEwcAdag/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (737, '', 10.00, 0, '', '雨点', 0, 'https://wx.qlogo.cn/mmopen/vi_32/WlLdPUVg9EBe3o5pGdVdPxwkEJ0vl5VJr0icN8FWZ7F0NZe1pwtXhjAI5gOngIBJNcW17JnvmcWVHknGsrcqgHA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (738, '', 0.00, 0, '', '木林森！', 1, 'https://wx.qlogo.cn/mmopen/vi_32/a1xgrjMdOp8kbBxKrSHKpmzqIkbULz8grbcjpp2eicuSqCSxVPreXlFuxbrGEiaENibbkfmic5lw5K4EjHiagU6FicCg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (739, '', 0.00, 0, '', '\'麦子\'', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epRpCynbtOTxicFcLGdE1lqRIp5PJCZko0X2LSf48iamSZdSUM8AEAHkSJyDkmDph9laXozMgXS79icg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (740, '', 0.00, 0, '', '吕江维', 1, 'https://wx.qlogo.cn/mmopen/vi_32/xJ7UUZzIJ2UNLicaOjs7ibF1HDHgicicSeH87zyvngsmhibZGkmrFBu8nrjpKedrCsPOCHSVkFe1YG1fuISctugdnvA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (741, '', 0.00, 0, '', '可轩.', 1, 'https://wx.qlogo.cn/mmopen/vi_32/P3f5CnOfibjfYFNaVbWGHGd6CK3JfPNhv2RBA03biaLMWp0Y1SF3ibZPUN2BeK7fibPfk34ApLibUzsBrzgBs2o8Z0A/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (742, '', 0.00, 0, '', '百行以德为首', 2, 'https://wx.qlogo.cn/mmopen/vi_32/86pkScSSYvKwVibUnBnKyGySSb1JI2j3x8dav9aPibKlK0113DmIuK0XHn8dssZdAiaaRiaAyibAz6hiaKYdz1VMmHPg/132', '', '忠县', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (743, '', 0.00, 0, '', '练就学院－万靖', 1, 'https://wx.qlogo.cn/mmopen/vi_32/UpkQhpyMtGs1IAsaOtibicAiam8JsGp5iakZ1S0wn5KygQSFcickUFogx5dDcG9uYuMc8InmCO4RiamsYIOdaHtB1mMA/132', '', '忠县', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (744, '13099931094', 0.00, 0, '', '꧁꫞꯭余生꫞꧂', 1, 'https://wx.qlogo.cn/mmopen/vi_32/wOzOetuHIjVWXDgtRMy869hY8X7GFFVciaRrx3cdTSFLficqfqpVC8N4JOCBDnBiazrmXCJl0Fz9jrb9cFQyMuFwg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (745, '', 0.00, 0, '', '！', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKib5EEL89P7MiaVQiadUnNvKMp1j2bwyqicSKsrNqVW7G0f9pSoyaAvUv3pfGUgw7Pic4CA6G6UaCzS7g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (746, '', 0.00, 0, '', '博', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIuhbM8udBShc2voricpficYAfVRQodEDtLmnM1icK0rVicnpIDpUfudVTiaNqFDicuMen6icocTufksBUOw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (747, '', 0.00, 0, '', '梦心美业', 1, 'https://wx.qlogo.cn/mmopen/vi_32/MHicHn48rsrOTJIdklM4ehQian1ia9WleQCy0LVrMT8Fhq6zaRlcm9Cpic1XzcE0JCg4GfmxeRicY0GrpJg12Qd6fxA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (748, '', 0.00, 0, '', '芭菲国际知名设计师阿龙', 1, 'https://wx.qlogo.cn/mmopen/vi_32/1LoPsB8ojmEAJ7G0fEXBnQU8NzibjZqSJk9JxafbeB00zDSekxqwTiay96xWnRDheaCic5DPAqNQHJ7ib74eoDxbCg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (749, '', 0.00, 0, '', '刘靖艺廊印象发艺13759109198', 1, 'https://wx.qlogo.cn/mmopen/vi_32/t5nP1ibbg0KYJF1wlmdPwiciaiaJMgUdfCibxibZ1N5hTvzjgSl7J3nd4vE95HaxWacPicm6DHpJcwLrUE4pBvBnmye3w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (750, '', 1.00, 0, '', '美好阳光，13888906427', 2, 'https://wx.qlogo.cn/mmopen/vi_32/dvnIlYasopwnsQiaicuDzNbSTZsfhy4AHe4WdhwXd47SYJmMrBvp0E5Lqjd608mLu5FqicgqNicagxwAjvpGqcB7ow/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (751, '', 0.00, 0, '', '虎哥海鲜（四川烧烤小吃）', 0, 'https://wx.qlogo.cn/mmopen/vi_32/EDl0sujGmoIC8Yluw1ZxDMYJiaIZRk8fXDIWSUQe5ia6ImeXGLTrgnY5FbL2pQMbLWYueD7Axy028RK68KnUEalw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (752, '', 0.00, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/LrTWoZffcP1Eb6HOVddABk2iaAOZgtS3anH9L8NxxmBNKS5GHfU9Z3F8UAt4Xjicnyj3wO2m7hvW4pls2cY7mE9Q/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (753, '', 1.00, 0, '', '齐哥', 1, 'https://wx.qlogo.cn/mmopen/vi_32/11tGZX8d1WibttdISYQYJaPdZ4b04PFaVUd0x8EiazpTPCs6mfiaNRDkmicV0xtaMffGbDzzHViaPXkXrrAcv5pgKxQ/132', '', '保山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (754, '', 1.00, 0, '', 'huihuixinxinrz', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoia9vVVR28kMbMYzfibONKeYBKyI9h58MdxHvHpUvv8sUANdXAoCevbnibSlZPlQ3UCJic9icXCQzLftg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (755, '', 10.00, 0, '', '徐国华', 1, 'https://wx.qlogo.cn/mmopen/vi_32/icMiaU1A2ZCic7xqGuWv0ibkLDwq16iaaMzzcFn0zw5pt8JqCdzeBEh1Q1zPyTqp8rpIbJu5LA43Gax3w211HW0sc8Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (756, '', 0.00, 0, '', '燕子', 2, 'https://wx.qlogo.cn/mmopen/vi_32/yaa5vOkqObSqNLLic31dTTp6Waf2LCibcMbZsznUzSZlxUoc18xxiccLwSth3MhbW7FuShdEqhoJx2SFIJIRtRGNg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (757, '', 0.00, 0, '', '[爱心]', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ibs3bZS6S6vGHxDwNREj86D8qYQiaIEyTIRWZuW4ViahmiaesP7aLr9iaicLkKm84Id5btkric3jTNm3SAjQLdtuxRdsw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (758, '', 0.00, 0, '', '：）', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hWibvR3QJc60icPpeoOMkj6kxAshqsRbr2Ymde2iaWH29lU829bIandxrSBUq5hria3aGe3Hzt4GjXfAib5BwvTyJOQ/132', '', '长治', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (759, '18687026811', 0.00, 0, '', '李丽娜是我的名字®', 2, 'https://wx.qlogo.cn/mmopen/vi_32/16ZDP2RdE8t9yyYyVMRJktZz47ougACbH1TUrJ4NPiawaERvDsKMK7UTMwHI5EvVzZGq0UOcpeGGJtu07icicfoKw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (760, '', 0.00, 0, '', '风', 1, 'https://wx.qlogo.cn/mmopen/vi_32/JJWK22c912qQ49uXRPzCHXEPxlV0bjhGSY2vQ9G7cgE0GqXSiamwhwyZibwlDymCEibIw72bMkjIHYIkMn11iaaU0g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (761, '', 0.00, 0, '', '艳阳高照', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DLcTlSKOQloqRIwVRPTPulN027HDhETq1IQ2f1Ed4N2gB0NhT9iaP2rIfTSSD6mpecgXb3CjVCND5cVONLF6POg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (762, '', 118.00, 0, '', '哥的人生你不懂', 1, 'https://wx.qlogo.cn/mmopen/vi_32/czYut7WNicFTDtFCS3nwH8biaLOib0yhaAFMGnFPFUbIIKmapjGSZJYsojpBQNuKhTYzDOJESN5oreB6FZxhUfbyg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (763, '', 0.00, 0, '', '二维码 HSR', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83er8MPD5H4d9D6etKJ93BSsAl8BhYy2xNcxtibYxpWAxqFX3ovWjUC29DCKxocDUONOrKgVrVY1mR7A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (764, '', 0.00, 0, '', 'A.非凡丨将军', 1, 'https://wx.qlogo.cn/mmopen/vi_32/SiaYUiagEbCTKplzBl2iaLRVjv7Un1Sydr3BFeP9ydwdCP2BVFXw5BHAzsSeJYAbLkYpic7Yo5Il0IZGc7PuwjGPCg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (765, '', 1.00, 0, '', 'Mr.clown', 1, 'https://wx.qlogo.cn/mmopen/vi_32/bVXrSiboKWgfwiaA3cDckvTo4vlicGQkub7FUibf8oicXAALG264JB5jSoMf8wYLSTgRX6LSsJJiaSMhWibExwguT0ibdw/132', '', '墨尔本', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (766, '', 1.00, 0, '', '小姐姐说小哥哥我喜欢你', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqURfZYQ4T7sK4jdSSmUKe0vhxd5HuKFBEkThBib11r8CoOg0P0hlu1JK565bSwhEsF7TBTIAD5rpw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (767, '', 0.00, 0, '', '时光', 2, 'https://wx.qlogo.cn/mmopen/vi_32/vJ2zleuGPkTqziboJM4Up3YNqGkFCjcZZNdKBCE8pgbWmOvjNbM8feQBD7Oibkm74uQfG4WDyIuSmRoWIQJRaI8w/132', '', '内江', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (768, '', 0.00, 0, '', '徐盛浙', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo2VVZG70rLVCt4ECEahjAhic20peiatg0utv2D5TJVqp9Lf4mjr3PT9hy5bicCFnG5EFh6vdN4P5Qyw/132', '', '温州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (769, '', 0.00, 0, '', '过客(大邦)', 1, 'https://wx.qlogo.cn/mmopen/vi_32/YbJ6JiaYIYTiaeY2u8LrRCh31HQ6KWt1AqficvEwvgomvMZCKxDzSZKNla1QC04cK0b4wgwibSbkjaRTs7ic2yUulJw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (770, '', 0.00, 0, '', '寒梅', 2, 'https://wx.qlogo.cn/mmopen/vi_32/1UlcyWYfYHJQ4AVib0ic0ZBtbg9kN0GzX61yu3EFNP3gJGSUKtWOtoickNxCgKTRTibM61DYesdiahzuYt1GBW9l9icA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (771, '', 10.00, 0, '', '周莲', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqicICH3xddlvl244jqh77yG8aDmrnaS2eyVZtuYGicjiaicAf2Wes4yLicqckAztTjQ2pVsTkI0APms7A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (772, '', 4.00, 0, '', '3000刺', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLpuXh4ibibw0eJFWz27pzaJ74uVAu5ibLdooLyOquOza8lnNibDdk5HOhXvMC11kwjCy6V20NAoIy6RQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (773, '', 0.00, 0, '', '=', 2, 'https://wx.qlogo.cn/mmopen/vi_32/c4r4qweDNIl4XKDao6vWt4XBh2s7B34jXD6t35g33GJicM2ec589tCfWdRRuxscSF6ysxYVocKnc7ib6q62he1Kg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (774, '', 0.00, 0, '', '莉，', 2, 'https://wx.qlogo.cn/mmopen/vi_32/9rH9pbAOiahd3fvvJ0us4qicrHBFsshnLW8ibnknN28lQL3MeKK7VvsZ9Q2hLgP369ichKcrFCNQnSFuJcJSzia58NA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (775, '', 0.00, 0, '', '美好的一天', 1, 'https://wx.qlogo.cn/mmopen/vi_32/9TyQk3pM68Mxlt2pphuI90KC20nZcWWklkhJDHLvTFDrz2S4oIAGAT99nttKFeUgzhsotiarTZLkdXiachbbtukw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (776, '', 0.00, 0, '', 'De.伟爷', 1, 'https://wx.qlogo.cn/mmopen/vi_32/W2N155ZMvrgiawACRF5HNHicrVU7yrYpS7kcibVibNItj91OTc303t9RKOXffpiabghWgKlhV3siaKpZ6FqAOvQUYMLQ/132', '', '深圳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (777, '', 410.00, 0, '', '牛牛哥', 1, 'https://wx.qlogo.cn/mmopen/vi_32/eScHMRqT2enWibU1xaolW5VSJfBWVCLmpOFIbKt0kI3TH9FL15NYJX2Nr9aUHdkOSLp6ed3xOHMpjsyjvPWQ7Ig/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (778, '', 1.00, 0, '', '雄霸天下', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIc9VqokTCzIaKmxUpvh5MamrXgEibibvjqibez5PnsgqM7ydrIIQFLAqecSkVkAmvNBvdhuRPflTiaibQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (779, '', 0.00, 0, '', '爱尚美业张龙', 1, 'https://wx.qlogo.cn/mmopen/vi_32/BslRsianAO6w7N96ibdg4RR6xhx3tNRE4gxv5fAW2aQubdeQF9sNuZpwjuGKibPpGXiaAowtibF5b9HnwWE5tBa7FyA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (780, '', 0.00, 0, '', '高旭峰', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTI5ycIX439499DeV7jcW3Q18wfjWV45FJSFiaFia8FWSAYG7FMRlYwiaFKb0V2oCq5MCC4z2lt8qwYhA/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (781, '', 0.00, 0, '', '赐哥~小区乐招募实体店入驻', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJKtEmgWGP9licLbpRWpsTRzVhIaNwYke59N8HAibibDhHbCwibPxnFpCwrn2sUibxMKkrmn0ET2cSbeGg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (782, '', 0.00, 0, '', '@༒ཻༀ 爱尚美业张虎จุ๊บ࿅࿆', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJtAG1sZt7iaxYtv9YAx6veapoibicicD7hzEjD52d3rb6iaVz2fCEc5fibllbun9VjslPzOx1QTHd1mrQQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (783, '', 0.00, 0, '', '周考', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJicoPJcetyJB53zTKksYVTLF1k5Em13esws5x96lcU9cKfibtib8n2PibEQlazz5cEvUnJUYcW3R8ibnw/132', '', '六盘水', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (784, '', 10.00, 0, '', '广迪床垫 一唐继', 1, 'https://wx.qlogo.cn/mmopen/vi_32/NyFOEueITjZxWrvHWM77oibibjvz6WFQXtpVaR4qrGPpzLmQZ9ibsfRwBvUPpnnbm2Rmo0BRaib4a8B1bdP5XWvic7g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (785, '', 0.00, 0, '', '醒 掌 天 下 ， 醉 卧 美 人 膝', 1, 'https://wx.qlogo.cn/mmopen/vi_32/jYqaHZRx6jc3gLNGZ4alEmfd5YpoLpSXxEqKvoBia9SaYcc1RdhHjSm6iaIHHQ7RF7zDpXAY5P9rutPKdMU0X4jQ/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (786, '', 5.00, 0, '', '随便', 2, 'https://wx.qlogo.cn/mmopen/vi_32/yvZwnuVYOB0xzibv9DlKNZ5KAWppNjbzAb4ic3jlffuicS4ic0NfwQFKXKgrl5xotwwOfwrwpvxk1ticfs6micNjzX2g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (787, '', 35.00, 0, '', '刘小佼', 2, 'https://wx.qlogo.cn/mmopen/vi_32/WD47dQiaGVXljmA822LpvVAFyeHGeBY3PpcRkWbjWwibPkDH2RtvazRL2MQZIGbft4MEtnTDlfsmY1VNR5sYkurg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (788, '', 0.00, 0, '', '腊梅', 2, 'https://wx.qlogo.cn/mmopen/vi_32/jE8ib7wgzUv0RbteDoQnicmouqp7icHw2fQ5IOK2KJ2iacnN3920lbh9uAoXbNJrnFQGzBtPczN8gJmfJyjBxAlgHQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (789, '', 0.00, 0, '', '你我都在等', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep3oSCWO8tVib2YdQvmCDXDdzHROjIibdjMum2gGMZ8m5KsAXcAwNiaYQazhiaichaJDibRkqpwVwjHvsZA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (790, '', 0.00, 0, '', '云南雄本集团（老司机顺风车）', 1, 'https://wx.qlogo.cn/mmopen/vi_32/p8zibw17429yyxmPes3RjnRIks3x5QDIP4trfoXFaZKiahJrjvcZ6rOQJPdsDrEHaICl1b15gbTSVbibsLwIjt9rw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (791, '', 0.00, 0, '', '怜音止梦', 2, 'https://wx.qlogo.cn/mmopen/vi_32/02zg2wo427MxId8icZDCZPSnIZz93E0Ou6P0ZZuCbnMyicxic22ssicIfTbH9f0YcS2hIYSGx4jAsbA5yFASib4qlew/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (792, '', 0.00, 0, '', '鄂A面馆', 0, '', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (793, '', 0.00, 0, '', '超哥', 1, 'https://wx.qlogo.cn/mmopen/vi_32/IlwEf2gv0eFqhw4E8Y7DSH2sJVVicIicbANMmuwIkuCZqjhRiaNZQZIfrwwc3ibGibZNveGMKbe0oXn7zvofhcXQBJw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (794, '', 0.00, 0, '', '位芳', 2, 'https://wx.qlogo.cn/mmopen/vi_32/rxdYBA6YcYReuGFPexcxxrcGMJn68xL1QJd8PtwBqz1Gpdgvvhm5X68Sr8vayaRdAPpYjue62BKDFEicBiab044A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (795, '', 0.00, 0, '', '史利红', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaELEHyib5ib5AAg3tLkwdiau4b7ro54SDXSNrpvB1mbZBR3InG4AtqeLvlUTdRGpHLiczNLQj7utVm0cnQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (796, '18386410809', 0.00, 0, '', 'Haha', 2, 'https://wx.qlogo.cn/mmopen/vi_32/gcOIudbznzTIlHuNrcPKr3HxmyPxtHJpgOSyISXvRoFKmdM8wSNFicnrkyxrhiczOfDfpgxo4sf1ENenrib0d1LicA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (797, '', 10.00, 0, '', '喜', 2, 'https://wx.qlogo.cn/mmopen/vi_32/GavHpicNvqYAka7r5tdRiakDzNrFSVZdO7FALmSpDh90bmrME96KciaIOAOyP5rjKEWEnRrzHsPzCWEH1libSXpHtg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (798, '', 0.00, 0, '', '涂凸', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erHVpYe1Mzicd53MavHV0uezxicNmia6J0k4XOgv4wYXXT12XianAVibFYM9enMzRpU06HNj6mpAABQMLA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (799, '', 7.00, 0, '', '马龙', 0, 'https://wx.qlogo.cn/mmopen/vi_32/lhoZpleQFz3Yw1UJz8u205qZwwzJbDZSGZAtaMNOxx4n3iaRSZ8GLWawRKGcREB3oVJ3BNBpC57iclF9MDJJQ9AQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (800, '', 0.00, 0, '', 'hi', 0, '', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (801, '', 5.00, 0, '', 'Sherry', 2, 'https://wx.qlogo.cn/mmopen/vi_32/rftSmUv20v0q3AMr1yrSL8rso1qIcEO78uwBYnFB5H8K03Mhstxnka3YBkicJlicUtgicwbzu2IR45kWvgTG98Ahw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (802, '', 0.00, 0, '', '往后余生18725148283', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoVFBzR3PgZGwZArDhRhTM5bnJVXfSmkHTnP5icIicAzdS802ibLLMHNyY7e1kZ82k1nicst2JfodND2Q/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (803, '', 0.10, 0, '', 'Mr.李', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epAdlVeNZWae6T0qXpyhe3ZtCsV9OZATYvdfia7ru3LBHLCnOibQFIaA89EGTGK0WpI0Bk3oQGl1j9g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (804, '', 5.00, 0, '', '海绵～～予予', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJ9Md7kkQhWIxZrOriayO53nrUqnK0SBQCWdHtfMdCxZ3pTpmbSMPiaNadic59gq3IQ3TxVZkNeZWziaQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (805, '', 5.00, 0, '', 'Karen木子小瑶', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erhIAYDKcgicGibebOARQ2jNicjNIuItibBKQ25J281qPfYK7TktTm4D33UiamYFK9VWpsicF9wPIO3icIJQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (806, '13888776733', 0.00, 0, '', '心愿', 2, 'https://wx.qlogo.cn/mmopen/vi_32/SC10b7zWbibOicD81wb5kVRgfv4IwyqQv7ElaB4z3gWDrf9nFHjOVZfzu1563ricwRH9dzNVUzw7mTsVKZGRPVfJA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (807, '', 0.00, 0, '', '无声告别', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLJukmDCK0sBKUPUpcUxo35vV1bHaHQaulzS61EicH6p21jmToJNZhBKekMWTGLOBy5eKQjic8XEeTw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (808, '', 0.00, 0, '', '展超', 1, 'https://wx.qlogo.cn/mmopen/vi_32/HrIZ9VjxGO1morx7PXy5h4ybqm53ibdkNGJJ5yfjrSluDKN3MRszQDkbEcOv42uWx13KzIOsAYTkTVpmTZwIalg/132', '', '金昌', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (809, '', 0.00, 0, '', 'sunxiyou', 2, 'https://wx.qlogo.cn/mmopen/vi_32/sz1t9CPeahZF6k4GicZibIwcT3COURDlPk4ia268vwmcRCibpeTauCPTklXXdG3fUBLgzCyFZtAYfVr4ibpshbd2LkA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (810, '', 0.00, 0, '', '牛哥', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hdGuqMTtQ5p1JJlnTo6xHsiaeVKCs3wckjR73xSmiaSuJxJdZYUfUo1pFu83DEI5gao2avvadAP9NmhHamIDKgPA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (811, '', 0.00, 0, '', '冲', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIWQHgibHmra6vEWW9Nq2CObVVGbQAaEgncNmibCcMMAm0fSLnyEjkA0M4SqpPVicrxTTbRn1swQnBGg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (812, '', 0.00, 0, '', '美好时光', 1, 'https://wx.qlogo.cn/mmopen/vi_32/lKwuzv6xxHMhmMYc9FanAc1bcwnmKBztb5MLJwW0XwBCfBoayI3hfWsRZo8oWPicsJFv6VibIibGYtjVtzXqLSJmQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (813, '18787135401', 2.00, 0, '', '梨膏糖', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEKp3Vz7oaJc8v6pDIHXhIfz8mLJiceqibotoh8XjfFNdopOYhXA2EApEfGtgC6vzrtdFldUCEKpibP9g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (814, '', 227.00, 0, '', '卐小拉丝牛逼很', 2, 'https://wx.qlogo.cn/mmopen/vi_32/LeI0E6YmlwgHM1jJ1qOHicYpnNbYiblKgOUL8PffwfL2BaNR8t041lvKRbkic1DJtpicwt5v1eupH1bZRg7jnmzKXg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (815, '', 0.00, 0, '', '徐川川', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo0sPBowju3s9bh3XbfBthE9AZZPbfPqjIfBFXKg6koBeAFZZTvftRtvJjyd2z6XZSl1czzjQTibHA/132', '', '济宁', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (816, '', 0.00, 0, '', '大云在发光，耶！', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKyaV1j1CksxLIgxQjKWRvcLnd4ezFPPDiahKRHas68p2T3OpTXnCvFH9Fhn0ZmrLhd0KJD7hhrlXQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (817, '', 0.00, 0, '', '八九.', 2, 'https://wx.qlogo.cn/mmopen/vi_32/U97Uz2DWMickribTBsuFS9TnfCYpUjXoWwgZluGKoDQLZHL5fwkUwOnskK5JxvZJzvaoibpw5CabvBj561v577IbQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (818, '', 0.00, 0, '', '旺', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqK7FhdXz1CFFGLrDw0PxKwtHcx3aCiblbY4fWzdfibcGfwqbmZ5axfaarutRFrY18guYib9mKyBW7dA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (819, '', 0.00, 0, '', '鬼影', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erAe2ryXafb7THR8xhSSTmFVgbIg8HWQ1Dz8YzuThZfCgl0zZ65OIM2cxibbwAHtH7C6h5Qia6kxJQQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (820, '', 0.00, 0, '', '月竹挽风', 2, 'https://wx.qlogo.cn/mmopen/vi_32/6W2kUx26elYPlgA1jrZpjN1icyQKHqKib4uOw0Ir0iaqwaMI54N2PWbRU500rU2AKgdGGgtqsLibygAx5EP2wnLbicg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (821, '', 0.00, 0, '', '张尧', 1, 'https://wx.qlogo.cn/mmopen/vi_32/23JHFrKkjhzktRTXx6ick6ZOj5hrSBich1bJ1Lo67SD9qDl9DBt32uCRgJGq3J4j6icpkIn7W1W3LMVIRjdlcN5KQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (822, '', 0.00, 0, '', '岁月无情', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqjx9dPouWAiblGElptibyYKmO4bvS54vU9cQhwWuKJTo5BuzyHuXBCXs5XJr2jEJHshx4Y3wknjvtA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (823, '', 0.00, 0, '', '忘记', 2, 'https://wx.qlogo.cn/mmopen/vi_32/AMLB8mt9vibS4fObH5G7YtFgSpXt0axCMoxyVoOMtfW1rmEc43sticcBn5F5Dth8zMFGn1d6J4Ud3grFB6epKiaKg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (824, '', 0.00, 0, '', '美燕', 2, 'https://wx.qlogo.cn/mmopen/vi_32/1UZhWgYjXXia501FFUibFt0dumwDII46f0js2ibkoJ8AHMUXgzGyzibLic6v35Uia8slbenykDg5dDYmAyNOu8Oia98kA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (825, '', 0.00, 0, '', '君君', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eo8cxQOnjZSAYfcWqrb9yAAjOfABwaIkJQxMCiaGQuXXlEichNF8tD4KcHiaDB4pq2Z6ynv1Ga5WtwIQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (826, '', 0.00, 0, '', '人人聚财王伶俐', 2, 'https://wx.qlogo.cn/mmopen/vi_32/tHpiaicHEicGowrgHKHiaYzPXWfrt4S4jspWInbxOu7FkcCWzagnerUHZEr7SfjT5CwtzNGajmuh5viaCPNMQjTtAxQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (827, '', 0.00, 0, '', '女人心', 2, 'https://wx.qlogo.cn/mmopen/vi_32/z6icVEE3NvYHLqibUwshicic2pmozE2yksLkC3ItLosCno3ur9cmsKRZ5GuPZus0cb1azwfL0DwRicfZtutYCBS2ncw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (828, '', 0.00, 0, '', '奋斗者', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epJ8wsplGRBsOwvK0tWaO39BaJTcWDpNm8bZ92q1ia5bhJ0ibhNl3QgY5JTMVPKw38FwMX37auPXTng/132', '', '临夏', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (829, '', 0.00, 0, '', 'life', 1, 'https://wx.qlogo.cn/mmopen/vi_32/9evWut6LiaTbfN1BasLGlbQiaAczaLGl926vnpgT3u1KPeKySv8g2RcSbd1SL65jBpZtfibib745RjmKCUKSYYbrfg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (830, '', 0.00, 0, '', '普天同庆', 0, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eq84OzgEUTZfG6cqlJdSiblMWcMcdiajojEQdTL4GGI7lTEy6zBzfpia5B57CNhV2ZwEArmqiauCgrx4w/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (831, '', 0.00, 0, '', '张鹏15912588381', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJOc0n02eNKfmOTPvg1mHyOpjiaI3dazTQJibUZuFc3c1ibRXC4BxWAOlE3NZTeRrCMvfPUiaoW3P5Aiag/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (832, '', 0.00, 0, '', '多年不后', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIwuxQFbyIarrEiam8M1vH8EEWhSCbmOkjIQlywLEz1fcFTL4CeEbzMXxFaJ0C5u744vUkoicNQwkrA/132', '', '维克托港', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (833, '', 0.00, 0, '', '顺其自然', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKXSzzSA9K2dTkyaR1WTEMXe1IcFmwKs8eSbuKG9qXYHp8OX5k1kt2Ew9QCUN2JrajhyC8Eia0w3pw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (834, '', 0.00, 0, '', '粗心', 1, 'https://wx.qlogo.cn/mmopen/vi_32/YNNnFPAwM2uhnSibvSarv4yu6pSe6OHic6VjbHGbHreSOWbib45YofOibk8Zds4tB68Mfuh6DgMHsJMoSctVwiasSwg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (835, '', 0.00, 0, '', '简单就好', 1, 'https://wx.qlogo.cn/mmopen/vi_32/7LeOtz6273aTRcjs97O4SnoIL6AnxKhSveG08sDl9bmBd0KrblbqNJrbS7jOL9ulBchyO2nW3ialDf7O7p0Or9w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (836, '', 0.00, 0, '', '欣遥', 0, 'https://wx.qlogo.cn/mmopen/vi_32/T2WIS5gJVKqypBJJpQVoUKuqPe3wktuwQibrV6f2BJR3A1P3uWvOicyX3JfbYzjmjwUOqRiaWppEkggKqFNjC25Fw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (837, '', 0.00, 0, '', '水夏炎冬', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoqNyVGPhBPB6qJuf3gDSZkUdCUjcJ9rO7uCsia0R0K18JeqDiaBmfMhI9I0VM3zCk8HlrkahNSo6yw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (838, '', 0.00, 0, '', '柠柚', 1, 'https://wx.qlogo.cn/mmopen/vi_32/4TSDPkgJSfXTUk04M4GZlsn1OjRT6xztkXuOqiaY1tovyMCOtx7l7rK5blc2dMarFeCAbYicHda5qQa7eaMYftQw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (839, '', 0.00, 0, '', '冯燕~梦心美业13577063921', 2, 'https://wx.qlogo.cn/mmopen/vi_32/GWhnZQXpLZHWkJU7zLCdarO8iboia229RAichQpVCtUuu6uxEQRnSibN2KGwxIdRrw7kxtiaLq6ULCRDO1XcLicNqSTQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (840, '', 0.00, 0, '', '炳哥', 2, 'https://wx.qlogo.cn/mmopen/vi_32/WPWRDeXmGJTVyo0CaceHQ0bMvXq7EJW7iaCiaq40Kibs7NFLfx1eqrP3ia5UpQn9N13w8iahgQIvtNGD1ZT9uaTpj5w/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (841, '', 0.00, 0, '', '妞妞', 2, 'https://wx.qlogo.cn/mmopen/vi_32/aTcqgoNdKHYlw3ht0YuopzsHkEhtaMRTtVicgHpkOwGMkGp1BYKqgMLxokmOK7OU7E5vSN4lVQJSvZHYRwRumWQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (842, '', 0.00, 0, '', '敏哥舒敏', 1, 'https://wx.qlogo.cn/mmopen/vi_32/vOZcibej70AFDXibJ5ghry3NmicqFu2Z3rSsAvAALdTfcTDwtF3mdHS8aFpb8eOLpn2icib9lD7c8borglO2iagO4oBQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (843, '', 0.00, 0, '', '中国青海海东伊凯', 1, 'https://wx.qlogo.cn/mmopen/vi_32/bWVia8ULo3ceZYZ49mR0hg6R2m2yVnib1NVYyWZziaBJNOvFPwDpYrbbzZNyNO4WnORQDib3wzWERedBYsWHOAEsoA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (844, '', 0.00, 0, '', '常来长往', 1, 'https://wx.qlogo.cn/mmopen/vi_32/HWIicyvOibMYQNlhicmnspicb5hE7kJNroojERW6J7J7iapwZ6MyXm874yJH7IcOKRfSUJOOQURLn4rEaogOT6GBcdA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (845, '', 0.00, 0, '', '吕大师15287123848', 1, 'https://wx.qlogo.cn/mmopen/vi_32/YTm36OkshsGHdfgll6ZNWtAclhaia5bicKKOAUgKk6hZSKia3ibuMxoCHKDZXTfbSBjlb31bLibzpAQl2ZLwRp7A7Bw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (846, '', 0.00, 0, '', 'A持久妆   封采彤', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erNOs5icCrxIAmtKj2eHuy8Ol3VQcktr5HlR3dSUNmr6EWIctA1OUCMsVaS3ic7lBhXEp6KfHuvmOrw/132', '', '深圳', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (847, '', 0.00, 0, '', '小时候ke拽了', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoOPxCOWD35icCPgNeXOh5H0bmmpic3OLnslibdiat2bQPvkNhNrmkbeeiattAkrYw1Wx1Kv25E2UDqdSQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (848, '', 0.00, 0, '', '微风细雨', 2, 'https://wx.qlogo.cn/mmopen/vi_32/kv8erPayyiaFyT95VicvLbyCO9FFV1CRIqCBG3ibadXFzbgL4iakgEo0a1W6JgVUc7kXTy88mGIiaCicTluV8aIbBx0A/132', '', '玉林', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (849, '', 0.00, 0, '', '昂贵的、背影', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qciaKsTjdpRQdoHdVsiaB5YIPblrK0riaGB8Puy5AAjKf4lTlZ3tM5o059F9jicshHCIVLUU4CrsFTGEZk6hXOC2Sw/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (850, '', 0.00, 0, '', '陶有忠', 1, 'https://wx.qlogo.cn/mmopen/vi_32/8EuHIUhKmsicARSkkYRTFfh2frCnWwgELgFLda8ITewT7Lc7Sth0H32cdqwuhEpiaXeUbKQFqC5HTjqFnib7YFmDQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (851, '', 0.00, 0, '', '弘道清霜', 1, 'https://wx.qlogo.cn/mmopen/vi_32/tVVPx5edvUmg4AAeqEnicDBUld1gpBvUt84TZOM27q45wVA5CibXJB6JWOTDvFHE7xsmdBMia3iaJqW27B3gSgjHKQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (852, '', 0.00, 0, '', '鲁伯特', 1, 'https://wx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEKfTsyWicGxY3YxrgVqIqqqwyiakcyh0hzLDKyz8nXZjicXs3WktjDh9CvjY0cJbONJ7BMkDVGzovthA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (853, '', 0.00, 0, '', '小勋家的鹿边摊', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ib3tfnjzhx4UG3Ttfk83RvE4fMjslDY1HYnicv4YIuiaicErnSDWcVd87BfNRicFdRQzwFxPZykgrCz9kBQJ2xJNjHA/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (854, '', 0.00, 0, '', '盐津特色燃面', 0, 'https://wx.qlogo.cn/mmopen/vi_32/ibpzuiczPETB0RA9POXGU0XGMcM9fZtias5NtEXTpcrHoeb1xjia78b6SWxmDDWBtJfBDC8c5sfzFjvE20aBhH2wbA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (855, '', 0.00, 0, '', '壞', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoXmogYD4jqLXIKic2T5X4DTVDL8cAs3ISWnkauMH1ZaG5QPNia9ucpPhxtu8E7x9Hgz5CVibbEg1l1A/132', '', '南昌', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (856, '', 0.00, 0, '', '格桑梅朵餐厅，高原明珠美食城', 1, 'https://wx.qlogo.cn/mmopen/vi_32/fibHgmW25Gba0dX3ALECSMuj1mXZ4xjoLiciaicItRXQ1L9fAhZgK4adcwfmSofARLUtZVq1ZUMc8icqgZRFhxwiaBhA/132', '', '迪庆', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (857, '', 0.00, 0, '', 'miss', 0, 'https://wx.qlogo.cn/mmopen/vi_32/ibLLb9OrOR1mKRxcd2PJKyg8PYD8A6OUeicbnpw3lszCjaULhgVHicsHnMPJqf0iaCcE4Q8l7PqXebG3KP2iaJJcueg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (858, '', 0.00, 0, '', '伟', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qDx9b2kITjrEL4SDZeNTIjMRRGxugxMfa9C6DXNWSgP2ovxXfpTibrTH59KhqpItsTruyaESTibnQogE6RzDfK0A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (859, '', 0.00, 0, '', '。', 2, 'https://wx.qlogo.cn/mmopen/vi_32/4F1P0u27Crzv3oBZLKicowNia2V2hAq2394B7c99g7cXmK3mmfichq1u2FhIAaWeqibKZ7icQiaELQD9uicqxljMdc5hQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (860, '', 0.00, 0, '', '十八閑客', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Ct8bt215tupgs1IWvcl1CEyYZc0p70Tpmibiad9v4Cs8RbacJsuD1gcDuIicnSj7wWt3MZFDe9KEV1iaKf1u7hNvEQ/132', '', 'Busan', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (861, '', 0.00, 0, '', 'yy', 2, 'https://wx.qlogo.cn/mmopen/vi_32/nMfepoCoHyF9XhmJTuuvxuljzC8uLEFu795pialfauyeHibdSpK9HgeblISc3IWJI04LFaXuDpSicn8ATsY7Slzeg/132', '', '大理', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (862, '', 0.00, 0, '', 'hey', 1, 'https://wx.qlogo.cn/mmopen/vi_32/xtB603UoeXQT3TWoeIfv25BjY8VlvEBa5EtCIYW0MwqsG4p8MmyWjraV9gVCAa2DPFYKjiaGZweaDPgcCzdY42g/132', '', '楚雄', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (863, '', 28.00, 0, '', '???', 2, 'https://wx.qlogo.cn/mmopen/vi_32/SVQeKXGWib2pDsN4ZsrLxQhYmTCZTdKp962oIFdenu3WzFYrSUvfoOSGPr0RicBMhNLr7cYDW8EXCczaqtfibb5fg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (864, '', 0.00, 0, '', '宋某某', 0, 'https://wx.qlogo.cn/mmopen/vi_32/MQXxcprTe9Wo7M79nWcSDiaS85jicvodqibdO14sMJhsUbvC7H8GvqtkGlIZwkQKxnqpqoWHJibE4rQl7keqQWsyTA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (865, '', 0.00, 0, '', '双', 2, 'https://wx.qlogo.cn/mmopen/vi_32/BzHqpcBduibPkPicIZUUm2CkkfvKMUYL4IRcKK5DMRSAcSdPsgMHNrvbwzWG9gq9FicXM2fqbkvnS09UXLUM21JuA/132', '', '金华', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (866, '', 0.00, 0, '', '房东的老妹儿', 2, 'https://wx.qlogo.cn/mmopen/vi_32/s3l1cvljHFqpo4vX2W5cOGELSgoHyXrXoBM6bzW6TdLZO2h51KoxURd244uHJ69sIkArnsP0SxFKeomBm3wKPQ/132', '', '安庆', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (867, '', 0.00, 0, '', 'rial', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKrvoHticYQpavUoaTjV4qgl4PTmx7MlKBof5xUwia5oBbfwkvZyNUVewVqdRUtKKE72uwVGhU6ic4aQ/132', '', '温州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (868, '', 0.00, 0, '', '脉搏々＆為你跳', 1, 'https://wx.qlogo.cn/mmopen/vi_32/sAYVwPWHfncqG5E3GwGn1ib9HktD5COGkxZukdLFHXpTa5aPkBS8IDlGnymc9oIiawG5MTwDvjl8Xicu2xiacNRdoQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (869, '', 0.00, 0, '', '追', 1, 'https://wx.qlogo.cn/mmopen/vi_32/FmjAcibbIH7DHTWJ6OhqBaicJtibcHUNlV2wSmytPaicASYZ3VJEMLfuWpWDyPP98MDC7UVKanWtMYRYSuyf8xLGHg/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (870, '', 0.00, 0, '', '勿喜勿念', 2, 'https://wx.qlogo.cn/mmopen/vi_32/w85PMBJwjYAM2EbwXT0eGg0oNiaMKSpKBJVBja5fJ5yjhr8mSFlVhEr8eyZNyYSrbqVexMf9wD1G5C4d9sZicWBw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (871, '', 0.00, 0, '', '粢犼', 1, 'https://wx.qlogo.cn/mmopen/vi_32/xPiaENfelgFdJ1EpfbFmycJmSib5CWBc4oib9P0NCkYgUyVSN3s8ic7bUD5t8kVYxJU0AFTR6XS53WFoWfdBEwL9oQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (872, '', 0.00, 0, '', '周炜翔13888224218', 1, 'https://wx.qlogo.cn/mmopen/vi_32/hgQtxmblnO66xZr08vgD5sdQ81rKUpTkfLmkvzZibKHTqrLAkaZQSUHgmlNUkOk8dvKeSLUFAR7FE3UUhHlftvg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (873, '', 0.00, 0, '', '飞腾留一手烤鱼', 1, 'https://wx.qlogo.cn/mmopen/vi_32/6OLZucUMRbjmD5r0p5BcicwBtTzPibrjYKN6uibty1KjL32QJGLQGdy6qXcdpHQwTevznueRzaY7H52npVONPw9Ag/132', '', '楚雄', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (874, '13759136471', 0.00, 0, '', '心里没点逼数', 2, 'https://wx.qlogo.cn/mmopen/vi_32/zuBUib5BL0khx4aWib8ibk9tS0sRlJUibPEUHJFiaNAIFZeV9yzhEOz4jIpnjexGC9DOiaQ6jxY1qVL9gGfjCT2sUtYg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (875, '', 0.00, 0, '', '杜昊宸', 1, 'https://wx.qlogo.cn/mmopen/vi_32/aoxUzQzd3YBJj1oWycwIDFpbWAhUpg1D0ojnwhsMpXIicibpeSq0yozOJQZPjLznNZ7vdiaFHyuZesY7lmuATzQxA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (876, '', 0.00, 0, '', '???', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJ5sXrTGCq7nt3LQJQZZXvXF2LkY3zMibRzQlaljY6BDO9Xibs33bkU3h9MmCR4d1xXLsRzhGN2Ckeg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (877, '', 0.00, 0, '', '℡精怪敏', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qSibw3VP7q0ZibUIMomxltI1FfcklaheyXbLRzibbnWYZFQwtUVulZTK21q6n3wb2b9XUpYGahHsV8uVBj8HFBbWw/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (878, '', 0.00, 0, '', '贵阳留一手烤鱼', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Ihbrwokogf36TMHiaSLxcWZFSSC6T1UptNb7X9JB5s33zbKBDfv1SgrYOGxUy4ic1aqUsvUdLcyfzjlWg9qn5KxA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (879, '', 0.00, 0, '', '浪里小白条', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLyYy9sS23MRcELYVkPQYoia4qapgBG9XKkic7ZnAHk1DlicP3RNqJMICVuBOsSrXKQDvtP9Q4nd827Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (880, '18208865574', 0.00, 0, '', '孙超', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIhzDQUfufkqysIGpcexnAFX7CmQpPdAk3GOsZSPsIoxwUp7bDcPBIQ2U5TzuoEq18ribvdaAvF7wQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (881, '', 0.00, 0, '', '稚恋', 2, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erwWtn7T1ATXF7sUEpv4tjhejnYzPLktKjPZsCpGgOXraiaEbcP5W1olMaB6bX7Oru7ABkh1nm3W3w/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (882, '', 0.00, 0, '', 'Aniki', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLpuXh4ibibw0eJG9RhDBDq6g5Ex6Ilz3zK9ObXchtKrl4b0KHCNTQOXO0ztJC1O5evSRKJbrQ08WPg/132', '', '红河', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (883, '', 0.00, 0, '', '总有刁民想害朕', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep2HyaAw2EXObjFAJMG15iays9nKibSxCd6hJCHLUaZHibEH7mIOFz43NThbqf62q01cB01ic9kxuGibzg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (884, '', 0.00, 0, '', '_南风知我意', 2, 'https://wx.qlogo.cn/mmopen/vi_32/TYVLmOuEB2xBdVZfE0WIycpicwY9NaFvpVzS3zMxwGDOmUYU9zj7FnXLRojbm4m2ibaz7TNjzicH9AvNRykXsibKKA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (885, '', 0.00, 0, '', '标妹', 2, 'https://wx.qlogo.cn/mmopen/vi_32/mDlrhAcIyKdVz02T8OJK0BicQDTqHhKXDd1pBBHMPxgpWTySSZsiaq6ibicwaZAJ8f4Yq1gjyZ89GELOcSJ2WicEo5g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (886, '', 0.00, 0, '', '独家', 1, 'https://wx.qlogo.cn/mmopen/vi_32/1W8mHTFW9iblicwrYOiau95iaYX31aMq2lzvl3OcFZQf61DA9jH60uGeYCnDpYSbAm9icdGoWdfpnarYIwJU5djibrqA/132', '', '赣州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (887, '', 0.00, 0, '', '小宝贝', 2, 'https://wx.qlogo.cn/mmopen/vi_32/GLfaKQqialvlj51SgTkgzTmt8h2N6fm2PgEooBQ2Q4NLWWywSCPGOVSLYaFvJibogP5Sibrs07ibttlibKoGCYATM0w/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (888, '', 0.00, 0, '', 'α柠檬酸西瓜', 1, 'https://wx.qlogo.cn/mmopen/vi_32/wrzlqfk3wkGicKUz6Ed9GHeS9fezfwVebgElR5wyaIULN14icgQqsniaNfD7nG3bsuTkTlibcDq3PPpft0VMonqUPg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (889, '', 0.00, 0, '', '君君', 2, 'https://wx.qlogo.cn/mmopen/vi_32/0SUWeW2ok1Q3bvVuicICIwPhb3Ib0t0AwaEVVCeqJMfQQ7rT9Ndh5XdtdpSgBIuoLLzxxab2pXib6cL0yfRibLgSQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (890, '', 0.00, 0, '', '简™㏒爱', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIxcfxDBibxMrkDVMH3uo35u7JBqYqeB9vRbpUSQpXARynS8ABZUBS0pavIcX9oC4LoasQYmSWZ72Q/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (891, '', 0.00, 0, '', '冯文全', 0, '', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (892, '', 0.00, 0, '', 'Bruce·辉', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ajGibWl8a5cReiamOgia48MekYNLGicsolClCxwZyrzPz14Lq3klNzsW09EBicxsCJMBstzexdmqr4uicWXC7qER74tw/132', '', '北帕默斯顿', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (893, '', 0.00, 0, '', 'Sunshine', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Btm2oKgtYQ84yHSYl6ibyjEP3lwEqFmGFKocwmRcSCFp9S8e6Me7iaPThldBLYxSGp15lmYJQZiaCKzHKlkmqN5qg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (894, '15287578439', 7.00, 0, '', '如初＠_＠', 2, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJpkf8KlXsVibw8cK1AQv9DjTcZVicy19IbQOQEnUU1j7UpUOvfiaZIZBtLPOcGf4PtDk4GHV5ksOFGA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (895, '', 0.00, 0, '', '陌颜&浮尘', 2, 'https://wx.qlogo.cn/mmopen/vi_32/qTlfVhIBVibbupRNribAZFGQuQic969TLA2yNQ4MJVc5rsUwEkhBzicQqjEtJnzpCVO24RBMIhia5FvJyMNUTjRvcdw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (896, '', 0.00, 0, '', '@', 1, 'https://wx.qlogo.cn/mmopen/vi_32/qaWaib5qPd0QbdUAUQI9u6zcp2jEibiciaZKcOdk9y0uoDwe5Oco4dZRAtlOSm29m60HH9rOHdiccvp6BNQFJlze9Bg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (897, '', 0.00, 0, '', '小小怪下士', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep0BlpZcObmANFUyvZfYVMOW0OoZQeY5Zg0qDa6oCn5tIrfxMRjlaWDic90MGdrcw8xnpoMHKK1SiaA/132', '', '昭通', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (898, '18208887573', 0.00, 0, '', 'Cynicism', 0, 'https://wx.qlogo.cn/mmopen/vi_32/9csJ0bK0RNKfMxVnTIJN87OsicGYGU0u02QoOSW6Fcicq9WbPC1caULQibxwAD5PzNbZy7auR9ltDPOKDOYzVXywg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (899, '', 0.00, 0, '', '素萦', 1, 'https://wx.qlogo.cn/mmopen/vi_32/OhoV7anx1OtrDNBUSwWVYL9oiajvcYGkFuIPG6I2r4DzibFUqpYT0IfhAlbppkIuKZ24bmrmGPbFv9UGFJPIWtIw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (900, '', 0.00, 0, '', '贺建平', 1, 'https://wx.qlogo.cn/mmopen/vi_32/l3zJgicDxibiaWxia8MRwXG75R5QXgyf960h5MIJibNm3YWL0ILRTpQx6xpQ8oS4zGCml7TiaCic1wSia0oXTRhZX2TmsA/132', '', '梁平', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (901, '', 0.00, 0, '', '龍魂', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ibiawv1M7Sib7TicpdFWH4jW19Hf090E7A7phuCXiboOGzZuIaOyHiaMeLCtoWu2xLa03wgRteLwmg3FIL7tOnia5WlKQ/132', '', '六盘水', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (902, '', 0.00, 0, '', '笑看人生', 0, 'https://wx.qlogo.cn/mmopen/vi_32/G8oPxV8geKW3ECbBlLbMf1Yb9Onpj0L4mUAl8xolBJYSdbzfaqHDC4y6MBhbv6icibQGAO4PARdLoRweuWtEgiapQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (903, '', 0.00, 0, '', '卡梵国际', 1, 'https://wx.qlogo.cn/mmopen/vi_32/dJCqrn6VYibtwIc4pBLU8PqHib1CvB3elVPriaMSBDVhiciaP9Z4iaLYe7Y6qiauGMHhA7OlsFWZYnAn9fcE8Ifa1X9Ew/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (904, '', 0.00, 0, '', '宠', 2, 'https://wx.qlogo.cn/mmopen/vi_32/nfYKnCpC9ibuQjd2wu0iaP5ibLbvZmEsSSUvdp4E1hJao2U4cmOIcSW7JlyRtbficHibk9qMu1iamJe9szwRNuSaFib1A/132', '', '楚雄', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (905, '', 0.00, 0, '', '李亚欧', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKK91g6SVMOlVibvHYkbLcM0txdaEYrdIb7phAFETQPzPq1UNh2xjribAicwH9wONalheQzunpm0beJw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (906, '', 0.00, 0, '', '天天开心', 0, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep3quGgvtthLnBCSsOQUHZUGMBwn3U5ro5tiaQPkvY2hFLEAzGTj8Dg3hdrsX8fbAX1KvhKuWrxhBg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (907, '', 0.00, 0, '', '馨*怡', 2, 'https://wx.qlogo.cn/mmopen/vi_32/pZCm5O6liaFAib0ch0Kb9WLlQy5Y3swMjPRmBzb7zalqfXVF2v8EUGysyI1pn6Ja7lFDK0oHUZx9nWRTVfT62W6A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (908, '', 0.00, 0, '', '李通连18760859783 ？18787021490', 1, 'https://wx.qlogo.cn/mmopen/vi_32/pVtQbJIsCNcknnh2bFhjB9HI7XdZX7kWIYErqVw7EnkJkq6yv0P2PibbeKto3qLpHT7oDpxJyc4bl0fnHDXF9AA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (909, '', 0.00, 0, '', '虎瘦雄心在', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ckBCaB3va7KBFHKFXkyb8luJPmSRwZ1z5C613bjAxDuLjqXbaiaGbqD2ialcewViaEaYibYnLvkZeB8ycHQCXUKSEQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (910, '', 0.00, 0, '', '个旧团山带皮小黄牛米线', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqtffZBQvHIJIunpOmNSA5sro3P4USs6D9n91libf15Ty8UncCicpCgv2NBicxRtVSUDIaZ2VSgHkic5A/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (911, '', 0.00, 0, '', '你了解我吗', 2, 'https://wx.qlogo.cn/mmopen/vi_32/qEbHIAvg4F4OUquvAaYMPznwm7JnV9KYIVoQHBlLEELeI3pyDS2JvPUOs8tHBdmmxiaatGh0NhTuxbxMsdakAicA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (912, '', 0.00, 0, '', 'べ等一个', 1, 'https://wx.qlogo.cn/mmopen/vi_32/7XSJPX4o5jAHMyxIAkARp0KocxuSf4lM6FrwW10Z0wCQpjyTcTDeUkoAm8HZPqD07h1VJCicErnq2LXTCVyWcCQ/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (913, '', 0.00, 0, '', '', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKdp8IeYplCola7PUEsicnFuGLBZERHN0HId5fZVqvqH2PIXMjGJRthXek84FrrLyu3NbwFhic5TwQA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (914, '', 0.00, 0, '', '乐书兰', 0, 'https://wx.qlogo.cn/mmopen/vi_32/wbeZbj30Dxb79FE0C3qDrlZiabQMrp4YrSvib2Hg3iaqG8jvW5XfZhld4Ghicg9eHHLsV1mPluOYmia8KZ1zQhzCRDQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (915, '', 0.00, 0, '', 'Mr_李先森', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoGmeqRq6vpHxO4vo5gQrnicc1ttibxH3EkJLmRf0xd9Lz3yOj87llnA0DpqoG5L7DIPpicU29kfposA/132', '', '唐山', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (916, '', 0.00, 0, '', '水电弱电综合布线安装18687507781', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epfQ0zburSYJql8zLheGHfF3HVpaOoABreBYe0koichHmG0iaxfHVXUQq0AG0XYsSY9b7jPJ6ibbb94g/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (917, '', 0.00, 0, '', '九年时光', 1, 'https://wx.qlogo.cn/mmopen/vi_32/FD1K6M9FGmvhEmYosWsYy1u34uMhT54BfcXYREb3sNzxg8ukZKCWSjDAwpTNjAx8wXDghSnluEiaWHicbyskKfsg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (918, '', 0.00, 0, '', '马永珍', 0, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLExia3jrv5ic26UIMMPwvW2QDOp2DWs5DPlqShsYQfF4Fbs7Mg5Zde8iaj0YXQ7CbT07ic83EhxfiaWnA/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (919, '', 0.00, 0, '', '白云', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqtMkWz92nRZLleNdlR58mEfBA9jxfBVGDKxEVhTTsYBS3jcFoRknjAGbRGyytGFSpDlhiaXpt3bGA/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (920, '', 0.00, 0, '', '•', 2, 'https://wx.qlogo.cn/mmopen/vi_32/icTWgfqauJWrl5F3Qt1fbswwn3AxBUO0tkU8MeiaU1s8yL9z2UdP3yxGecxHn9Mq39P0dia6grrvprCesd2AkXPng/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (921, '', 0.00, 0, '', '阿鸡米德', 1, 'https://wx.qlogo.cn/mmopen/vi_32/ajNVdqHZLLDzh8YAdVO6BpcXs2M6MsIPk5ntbCy20KPNiawx6gfes7pdG4Ma1PDaLPFVsEiaBEGy9gFRoN541X2g/132', '', '防城港', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (922, '', 0.00, 0, '', '湘满楼餐厅', 1, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqiacOwUneK04OPuHhia8vibsfTtZR67yQ1JpW3SkYDeFK77icy2RaoKicmL1s0CQksCIs4q2FuvJNicq1w/132', '', '永州', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (923, '', 0.00, 0, '', 'flask see', 2, 'https://wx.qlogo.cn/mmopen/vi_32/L829fZY63qsffjn1cocy2Dg5fWY9YCmU189LIMhOCpHZ5FibgicavmuInXLbuZImVVWszUapIlZnticKvRlPwkQmA/132', '', 'Meadow Lake', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (924, '', 0.00, 0, '', '自顾自走', 1, 'https://wx.qlogo.cn/mmopen/vi_32/jRKNzAnWliahkWOglhdGibT3LqCuheLG9XzaTnotzCGicTAWtbs25SmGjycEpkelNf1ZN2IQmaeLXgDqElYnwbIQw/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (925, '', 0.00, 0, '', '.CN', 1, 'https://wx.qlogo.cn/mmopen/vi_32/yHbOibpoMbCTFqvUTkOmN54HACia2ETF1DI1cMYBMicCzd6H0ECN4yLBZdSwWvA4nhmhbgcJxpu42XXUTXDEOAXmQ/132', '', '临沧', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (926, '', 0.00, 0, '', '蚊子闯天下', 1, 'https://wx.qlogo.cn/mmopen/vi_32/sQd3gvllJ62AeLTibX7ic73dypWO77RGEFENbhST7Zom8S8sbU1sKW7QqnuTicZc6axziaTFEfajB4MpqlIzskcynw/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (927, '', 0.00, 0, '', '假装不懂', 1, 'https://wx.qlogo.cn/mmopen/vi_32/csVT9tTQhsIrcN4HBR15wpRrpiagCxCk9Gu5MSJiabLicrYF9Zo8Ku58qbtGDbWiaLQXaWtdMbTJ2aofpv1ia0L5TCg/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (928, '', 0.00, 0, '', '振', 0, 'https://wx.qlogo.cn/mmopen/vi_32/4PLs10x1rSS6QKtav671PfCEribsz7W4pdGwwyiaXUMHnKTAIO0UibONLxMibpwofx1z1ibzFicHIH2fIfZlKLjnaa4w/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (929, '', 0.00, 0, '', '张壮壮18313758692～云南练就校园', 1, 'https://wx.qlogo.cn/mmopen/vi_32/WL4n2nnQK1iaGGzAz328aelMHlk0roFZXOFK07gOibpOFfQpNQIt4icCaGcGOurF1KkHJZD6YGoUkiaIabOCJLLC0w/132', '', '邯郸', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (930, '', 0.00, 0, '', 'A+大白', 1, 'https://wx.qlogo.cn/mmopen/vi_32/lrXGy4KxQ0OG5SX2jibmJmFVaT0icYX6G8ft2NVcaLVt9ZYGg2yOGqADLuL69aFsf2ib7HjrHa05dR8eu7T5FymSg/132', '', '张家界', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (931, '', 0.00, 0, '', '早', 1, 'https://wx.qlogo.cn/mmopen/vi_32/AZq6fh2gwBnQu6quYOiaLwvS3W2DT4RH4vyWj0EibwmvozDwMoLYLKC9neSgxboZEZRWojzHkoh25ppa5UC6PiagQ/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (932, '', 0.00, 0, '', '李应标', 0, 'https://wx.qlogo.cn/mmopen/vi_32/IBGUnHRcliaj6jZ5sWVuNRljs0DKSIqhhicxLe24MUXv1xIMwXPv7JCPfv1GXTHVibl4jiamjmaic3M2njJsw7AwQicQ/132', '', '', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (933, '', 0.00, 0, '', '好好先生', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIh35CvxVmuqcJbpJxfD799uWeTLSyvYZrhTc6LShaN99mxyLRdfrE7zmM34Cpq7KeZhWHJ1kgh2A/132', '', '海淀', '', '', '', 0.00000000, 0.00000000, 0, 0, '');

-- ----------------------------
-- Table structure for users_pay_log
-- ----------------------------
DROP TABLE IF EXISTS `users_pay_log`;
CREATE TABLE `users_pay_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pay_sn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值订单号',
  `transaction_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付返回订单号',
  `user_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '用户id',
  `price` decimal(11, 2) NOT NULL DEFAULT 0.00 COMMENT '充值金额',
  `add_time` int(11) NOT NULL DEFAULT 0 COMMENT '充值时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 244 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users_pay_log
-- ----------------------------
INSERT INTO `users_pay_log` VALUES (31, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (32, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (33, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (34, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (35, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (36, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (37, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (38, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (39, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (40, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (41, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (42, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (43, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (44, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (45, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (46, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (47, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (48, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (49, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (50, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (51, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (52, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (53, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (54, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (55, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (56, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (57, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (58, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (59, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (60, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (61, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (62, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (63, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (64, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (65, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (66, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (67, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (68, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (69, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (70, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (71, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (72, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (73, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (74, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (75, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (76, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (77, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (78, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (79, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (80, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (81, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (82, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (83, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (84, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (85, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (86, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (87, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (88, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (89, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (90, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (91, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (92, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (93, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (94, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (95, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (96, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (97, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (98, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (99, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (100, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (101, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (102, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (103, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (104, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (105, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (106, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (107, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (108, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (109, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (110, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (111, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (112, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (113, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (114, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (115, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (116, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (117, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (118, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (119, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (120, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (121, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (122, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (123, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (124, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (125, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (126, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (127, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (128, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (129, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (130, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (131, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (132, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (133, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (134, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (135, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (136, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (137, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (138, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (139, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (140, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (141, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (142, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (143, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (144, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (145, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (146, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (147, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (148, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (149, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (150, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (151, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (152, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (153, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (154, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (155, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (156, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (157, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (158, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (159, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (160, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (161, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (162, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (163, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (164, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (165, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (166, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (167, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (168, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (169, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (170, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (171, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (172, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (173, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (174, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (175, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (176, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (177, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (178, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (179, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (180, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (181, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (182, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (183, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (184, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (185, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (186, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (187, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (188, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (189, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (190, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (191, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (192, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (193, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (194, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (195, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (196, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (197, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (198, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (199, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (200, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (201, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (202, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (203, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (204, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (205, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (206, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (207, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (208, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (209, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (210, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (211, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (212, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (213, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (214, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (215, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (216, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (217, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (218, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (219, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (220, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (221, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (222, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (223, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (224, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (225, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (226, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (227, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (228, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (229, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (230, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (231, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (232, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (233, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (234, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (235, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (236, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (237, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (238, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (239, '98764631456', '13216546464566', 72, 40.00, 0);
INSERT INTO `users_pay_log` VALUES (240, '13456789792', '12345698741321', 29, 98.00, 0);
INSERT INTO `users_pay_log` VALUES (241, '12346788946', '45678456456454', 29, 140.00, 0);
INSERT INTO `users_pay_log` VALUES (242, '15416454644', '34654321314648', 71, 20.00, 0);
INSERT INTO `users_pay_log` VALUES (243, '98764631456', '13216546464566', 72, 40.00, 0);

SET FOREIGN_KEY_CHECKS = 1;
