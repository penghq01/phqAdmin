/*
 Navicat Premium Data Transfer

 Source Server         : 本地数据
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : phqadmin

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 04/12/2019 23:34:14
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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'root', '0b178dfde1b181b81d01ffb628f9c9bd', '', 1575275440, 'localhost:8181');
INSERT INTO `admin` VALUES (2, 'admin', '0b178dfde1b181b81d01ffb628f9c9bd', '5', 1575276511, 'localhost:8181');

-- ----------------------------
-- Table structure for admin_and_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_and_role`;
CREATE TABLE `admin_and_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL COMMENT '管理员表ID',
  `admin_role_id` int(11) NOT NULL COMMENT '角色表ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父id',
  `title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `crouter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端界面',
  `auth` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限',
  `visit` tinyint(1) NOT NULL DEFAULT 0 COMMENT '访问权限 0公开，1登录，2权限，3,系统管理员',
  `auth_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '路由类型 0菜单，1操作（按钮）',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否显示',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES (3, 0, '首页', 'fa fa-home', '/index', '{\"add\":{\"show\":false,\"router\":[]},\"delete\":{\"show\":false,\"router\":[]},\"edit\":{\"show\":false,\"router\":[]},\"select\":{\"show\":false,\"router\":[]}}', 1, 0, 1, 2);
INSERT INTO `auth` VALUES (4, 0, '系统与安全', 'fa fa-address-card', '', '{\"add\":{\"show\":false,\"router\":[]},\"delete\":{\"show\":false,\"router\":[]},\"edit\":{\"show\":false,\"router\":[]},\"select\":{\"show\":false,\"router\":[]}}', 2, 0, 1, 3);
INSERT INTO `auth` VALUES (5, 0, '附件管理', 'fa fa-folder-open', '', '{\"add\":{\"show\":false,\"router\":[]},\"delete\":{\"show\":false,\"router\":[]},\"edit\":{\"show\":false,\"router\":[]},\"select\":{\"show\":false,\"router\":[]}}', 2, 0, 1, 4);
INSERT INTO `auth` VALUES (6, 0, '用户管理', 'fa fa-user', '', '{\"add\":{\"show\":false,\"router\":[]},\"delete\":{\"show\":false,\"router\":[]},\"edit\":{\"show\":false,\"router\":[]},\"select\":{\"show\":false,\"router\":[]}}', 2, 0, 1, 5);
INSERT INTO `auth` VALUES (7, 4, '管理员管理', 'fa fa-user', '/admin', '{\"add\":{\"show\":true,\"router\":[\"/admin-api/admin/add\"]},\"delete\":{\"show\":true,\"router\":[\"/admin-api/admin/del\"]},\"edit\":{\"show\":true,\"router\":[\"/admin-api/admin/edit\"]},\"select\":{\"show\":true,\"router\":[\"/admin-api/admin/list\",\"/admin-api/role/list\"]}}', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (8, 4, '角色管理', 'fa fa-address-book', '/role', '{\"add\":{\"show\":true,\"router\":[\"/admin-api/role/add\"]},\"delete\":{\"show\":true,\"router\":[\"/admin-api/role/del\"]},\"edit\":{\"show\":true,\"router\":[\"/admin-api/role/edit\"]},\"select\":{\"show\":true,\"router\":[\"/admin-api/role/list\",\"/admin-api/role/auth-list\"]}}', 2, 0, 1, 1);
INSERT INTO `auth` VALUES (9, 4, '权限管理', 'fa fa-gears', '/auth', '{\"add\":{\"show\":true,\"router\":[\"/admin-api/auth/add\"]},\"delete\":{\"show\":true,\"router\":[\"/admin-api/auth/del\"]},\"edit\":{\"show\":true,\"router\":[\"/admin-api/auth/edit\"]},\"select\":{\"show\":true,\"router\":[\"/admin-api/auth/list\",\"/admin-api/auth/get/router-list\",\"/admin-api/icon/list/:pageszie/:page\"]}}', 3, 0, 1, 2);
INSERT INTO `auth` VALUES (10, 5, '图标管理', 'fa fa-info-circle', '/icon', '{\"add\":{\"show\":true,\"router\":[\"/admin-api/icon/add\"]},\"delete\":{\"show\":true,\"router\":[\"/admin-api/icon/del\"]},\"edit\":{\"show\":false,\"router\":[]},\"select\":{\"show\":true,\"router\":[\"/admin-api/icon/list/:page_size/:page\"]}}', 2, 0, 1, 1);
INSERT INTO `auth` VALUES (11, 6, '会员列表', 'fa fa-users', '/user', '{\"add\":{\"show\":false,\"router\":[]},\"delete\":{\"show\":false,\"router\":[]},\"edit\":{\"show\":false,\"router\":[]},\"select\":{\"show\":true,\"router\":[\"/admin-api/user/total/money-points\",\"/admin-api/user/pay/log/:page_size/:page\",\"/admin-api/user/list/:page_size/:page\"]}}', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (12, 6, '充值记录', 'fa fa-cc-visa', '/paylog', '{\"add\":{\"show\":false,\"router\":[]},\"delete\":{\"show\":false,\"router\":[]},\"edit\":{\"show\":false,\"router\":[]},\"select\":{\"show\":true,\"router\":[\"/admin-api/user/total/money-points\"]}}', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (13, 0, '基本权限', 'fa fa-hand-paper-o', '/', '{\"add\":{\"show\":false,\"router\":[]},\"delete\":{\"show\":false,\"router\":[]},\"edit\":{\"show\":true,\"router\":[\"/admin-api/admin/edit/pass\"]},\"select\":{\"show\":true,\"router\":[\"/admin-api/admin/info\",\"/admin-api/admin/auth\"]}}', 1, 1, 0, 1);
INSERT INTO `auth` VALUES (16, 0, '后台登录', 'fa fa-sign-in', '/login', '{\"add\":{\"show\":false,\"router\":[]},\"delete\":{\"show\":false,\"router\":[]},\"edit\":{\"show\":false,\"router\":[]},\"select\":{\"show\":true,\"router\":[\"/admin-api/login\"]}}', 0, 1, 0, 0);
INSERT INTO `auth` VALUES (17, 5, '图片管理', 'fa fa-file-image-o', '/images', '{\"add\":{\"show\":true,\"router\":[\"/admin-api/files/upload/img\",\"/admin-api/files/add/class\"]},\"delete\":{\"show\":true,\"router\":[\"/admin-api/files/del\",\"/admin-api/files/del/class\"]},\"edit\":{\"show\":true,\"router\":[\"/admin-api/files/edit/class\"]},\"select\":{\"show\":true,\"router\":[\"/admin-api/files/list/class\",\"/admin-api/files/list/:page_size/:page\"]}}', 2, 0, 1, 0);
INSERT INTO `auth` VALUES (18, 4, '数据备份恢复', 'fa fa-server', '/sql', '{\"add\":{\"show\":true,\"router\":[\"/admin-api/sql/exprot\"]},\"delete\":{\"show\":true,\"router\":[\"/admin-api/sql/del\"]},\"edit\":{\"show\":true,\"router\":[\"/admin-api/sql/improt\"]},\"select\":{\"show\":true,\"router\":[\"/admin-api/sql/list\"]}}', 2, 0, 1, 3);

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
) ENGINE = MyISAM AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for files_class
-- ----------------------------
DROP TABLE IF EXISTS `files_class`;
CREATE TABLE `files_class`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父ID',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of files_class
-- ----------------------------
INSERT INTO `files_class` VALUES (13, 0, '图片');

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
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (5, '超级管理员', '[{\"auth_id\":4,\"select\":true,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":7,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":8,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":5,\"select\":true,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":17,\"select\":true,\"add\":true,\"edit\":true,\"delete\":true},{\"auth_id\":10,\"select\":true,\"add\":true,\"edit\":false,\"delete\":true},{\"auth_id\":6,\"select\":true,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":11,\"select\":true,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":12,\"select\":true,\"add\":false,\"edit\":false,\"delete\":false}]', '拥有所有权限');
INSERT INTO `role` VALUES (7, '管理员', '[{\"auth_id\":4,\"select\":false,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":5,\"select\":false,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":6,\"select\":false,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":7,\"select\":true,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":17,\"select\":true,\"add\":false,\"edit\":false,\"delete\":false},{\"auth_id\":11,\"select\":true,\"add\":false,\"edit\":false,\"delete\":false}]', '管理员，拥有部分权限');

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
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (29, '18288411141', 0.00, 0, '', '微笑是坚强的表现', 1, 'https://wx.qlogo.cn/mmopen/vi_32/McNeTxFVPvDyFibiaXJEd8p2IRepg5DFib2m7rGiaLwfBmOg3ydnV1qTjiavjbcw4Olj2HE7kzZMlDrEQFcj0d4V4Yg/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (71, '', 0.00, 0, '', '小仕老师', 1, 'https://wx.qlogo.cn/mmopen/vi_32/icRPQLoicGwl2XtNEHkibpqC3CAhu4CibtgCIBicLPp9ibczrttVbxw0HhbqxcWiaqqVp1IgK8JAzpJEmItj4d1CHycWA/132', '', '曲靖', '', '', '', 0.00000000, 0.00000000, 0, 0, '');
INSERT INTO `users` VALUES (72, '', 0.00, 0, '', '箫沐言', 1, 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTK4RBEaUian1wxQe0UGGkmZ1Hj7fpiaZJCY7s3OicuulEqWzqXRI245elvTrDKM8a7ZoWGHGa9ajejSg/132', '', '昆明', '', '', '', 0.00000000, 0.00000000, 0, 0, '');

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
