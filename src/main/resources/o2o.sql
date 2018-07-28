-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.5.28 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 o2odb 的数据库结构
CREATE DATABASE IF NOT EXISTS `o2odb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `o2odb`;


-- 导出  表 o2odb.tb_area 结构
CREATE TABLE IF NOT EXISTS `tb_area` (
  `area_id` int(5) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(200) NOT NULL,
  `area_desc` varchar(1000) DEFAULT NULL,
  `priority` int(2) NOT NULL DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`area_id`),
  UNIQUE KEY `UK_AREA` (`area_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  o2odb.tb_area 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `tb_area` DISABLE KEYS */;
REPLACE INTO `tb_area` (`area_id`, `area_name`, `area_desc`, `priority`, `create_time`, `last_edit_time`) VALUES
	(3, '东苑', '东苑', 12, '2017-06-04 19:12:58', '2017-06-04 19:12:58'),
	(4, '南苑', '南苑', 10, '2017-06-04 19:13:09', '2017-06-04 19:13:09'),
	(5, '西苑', '西苑', 9, '2017-06-04 19:13:18', '2017-06-04 19:13:18'),
	(6, '北苑', '北苑', 7, '2017-06-04 19:13:29', '2017-06-04 19:13:29');
/*!40000 ALTER TABLE `tb_area` ENABLE KEYS */;


-- 导出  表 o2odb.tb_award 结构
CREATE TABLE IF NOT EXISTS `tb_award` (
  `award_id` int(10) NOT NULL AUTO_INCREMENT,
  `award_name` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `award_desc` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `award_img` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `point` int(10) NOT NULL DEFAULT '0',
  `priority` int(2) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `enable_status` int(2) NOT NULL DEFAULT '0',
  `shop_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`award_id`),
  KEY `fk_award_shop_idx` (`shop_id`),
  CONSTRAINT `fk_award_shop` FOREIGN KEY (`shop_id`) REFERENCES `tb_shop` (`shop_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  o2odb.tb_award 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tb_award` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_award` ENABLE KEYS */;


-- 导出  表 o2odb.tb_head_line 结构
CREATE TABLE IF NOT EXISTS `tb_head_line` (
  `line_id` int(100) NOT NULL AUTO_INCREMENT,
  `line_name` varchar(1000) DEFAULT NULL,
  `line_link` varchar(2000) NOT NULL,
  `line_img` varchar(2000) NOT NULL,
  `priority` int(2) DEFAULT NULL,
  `enable_status` int(2) NOT NULL DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`line_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- 正在导出表  o2odb.tb_head_line 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `tb_head_line` DISABLE KEYS */;
REPLACE INTO `tb_head_line` (`line_id`, `line_name`, `line_link`, `line_img`, `priority`, `enable_status`, `create_time`, `last_edit_time`) VALUES
	(11, '1', '1', '/upload/images/item/headtitle/2017061320315746624.jpg', 1, 1, '2017-06-13 20:31:57', '2017-06-13 20:31:57'),
	(12, '2', '2', '/upload/images/item/headtitle/2017061320371786788.jpg', 2, 1, '2017-06-13 20:37:17', '2017-06-13 20:37:17'),
	(14, '3', '3', '/upload/images/item/headtitle/2017061320393452772.jpg', 3, 1, '2017-06-13 20:39:34', '2017-06-13 20:39:34'),
	(15, '4', '4', '/upload/images/item/headtitle/2017061320400198256.jpg', 4, 1, '2017-06-13 20:40:01', '2017-06-13 20:40:01');
/*!40000 ALTER TABLE `tb_head_line` ENABLE KEYS */;


-- 导出  表 o2odb.tb_local_auth 结构
CREATE TABLE IF NOT EXISTS `tb_local_auth` (
  `local_auth_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `user_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`local_auth_id`),
  UNIQUE KEY `uk_local_profile` (`user_name`),
  KEY `fk_local_profile` (`user_id`),
  CONSTRAINT `fk_local_profile` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  o2odb.tb_local_auth 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `tb_local_auth` DISABLE KEYS */;
REPLACE INTO `tb_local_auth` (`local_auth_id`, `user_id`, `user_name`, `password`, `create_time`, `last_edit_time`) VALUES
	(6, 8, 'xiangze', 's05bse6q2qlb9qblls96s592y55y556s', '2017-06-04 19:09:51', '2017-06-04 19:09:51'),
	(7, 9, 'test', 's05bse6q2qlb9qblls96s592y55y556s', '2017-06-05 22:05:13', '2017-06-05 22:05:13');
/*!40000 ALTER TABLE `tb_local_auth` ENABLE KEYS */;


-- 导出  表 o2odb.tb_person_info 结构
CREATE TABLE IF NOT EXISTS `tb_person_info` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `gender` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_img` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_flag` int(2) NOT NULL DEFAULT '0',
  `shop_owner_flag` int(2) NOT NULL DEFAULT '0',
  `admin_flag` int(2) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `enable_status` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  o2odb.tb_person_info 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `tb_person_info` DISABLE KEYS */;
REPLACE INTO `tb_person_info` (`user_id`, `name`, `birthday`, `gender`, `phone`, `email`, `profile_img`, `customer_flag`, `shop_owner_flag`, `admin_flag`, `create_time`, `last_edit_time`, `enable_status`) VALUES
	(8, '李翔', NULL, '1', NULL, NULL, 'http://wx.qlogo.cn/mmopen/XZumId0qMA815ApfWI2zibDnRMahic6SU0wHib2HgGJj5narL2ymRaI4Kn2Tx2Q8UfkicibvjVicu3De6fDYRMfo0uGW0SGicibxVnJ9/0', 1, 1, 1, '2017-06-04 19:01:09', '2017-06-04 19:01:09', 1),
	(9, '龙州一条街客服', NULL, '1', NULL, NULL, 'http://wx.qlogo.cn/mmopen/icF4iau8Sj7b0FiakC6ibBoTPmkvLpIX9YhWkNyEIGYfzYyqBiag2M3q2rnxSlXAh95UDHdWgywvEW5bN5FBzFPFazxBzqHTRqNwn/0', 1, 1, 0, '2017-06-04 21:20:43', '2017-06-04 21:20:43', 1),
	(10, 'king', NULL, '2', NULL, NULL, 'http://wx.qlogo.cn/mmopen/XZumId0qMA815ApfWI2zibDLckaAaV6QgcBJP0saJSDTuicZBd35HzPXUebLPSlexCIPJsLs3w6lG0xmwn3EZNicj04dJh4We7C/0', 1, 1, 0, '2017-06-07 01:36:16', '2017-06-07 01:36:16', 1),
	(11, '音策', NULL, '2', NULL, NULL, 'http://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKCWfIBicEwS3U0legxxQd5XFpZibBXVPyz0wphvvtaXqiblzQF2GqE28c7j8FGpuYqBCg1QRJThEzuw/0', 1, 1, 0, '2017-09-18 23:39:38', '2017-09-18 23:39:38', 1);
/*!40000 ALTER TABLE `tb_person_info` ENABLE KEYS */;


-- 导出  表 o2odb.tb_phone_auth 结构
CREATE TABLE IF NOT EXISTS `tb_phone_auth` (
  `phone_auth_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `phone` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `auth_number` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`phone_auth_id`),
  KEY `fk_phoneauth_profile` (`user_id`),
  CONSTRAINT `fk_phoneauth_profile` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  o2odb.tb_phone_auth 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tb_phone_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_phone_auth` ENABLE KEYS */;


-- 导出  表 o2odb.tb_product 结构
CREATE TABLE IF NOT EXISTS `tb_product` (
  `product_id` int(100) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `product_desc` varchar(2000) DEFAULT NULL,
  `img_addr` varchar(2000) DEFAULT '',
  `normal_price` varchar(100) DEFAULT NULL,
  `promotion_price` varchar(100) DEFAULT NULL,
  `priority` int(2) NOT NULL DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `enable_status` int(2) NOT NULL DEFAULT '0',
  `point` int(10) DEFAULT NULL,
  `product_category_id` int(11) DEFAULT NULL,
  `shop_id` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`),
  KEY `fk_product_shop` (`shop_id`),
  KEY `fk_product_procate` (`product_category_id`),
  CONSTRAINT `fk_product_procate` FOREIGN KEY (`product_category_id`) REFERENCES `tb_product_category` (`product_category_id`),
  CONSTRAINT `fk_product_shop` FOREIGN KEY (`shop_id`) REFERENCES `tb_shop` (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- 正在导出表  o2odb.tb_product 的数据：~18 rows (大约)
/*!40000 ALTER TABLE `tb_product` DISABLE KEYS */;
REPLACE INTO `tb_product` (`product_id`, `product_name`, `product_desc`, `img_addr`, `normal_price`, `promotion_price`, `priority`, `create_time`, `last_edit_time`, `enable_status`, `point`, `product_category_id`, `shop_id`) VALUES
	(4, '美式咖啡', '一丝醇香，流连忘返', '/upload/images/item/shop/15/2017060523302118864.jpg', '12', '11', 12, '2017-06-05 23:30:21', '2017-06-05 23:49:34', 1, 3, NULL, 15),
	(5, '转让八成新XX牌小车', '诚心转让八成新XX牌小车，有意者请连续8866666', '/upload/images/item/shop/15/2017060523485289817.jpg', '100000', '60000', 100, '2017-06-05 23:48:52', '2018-07-28 11:51:57', 1, 0, NULL, 15),
	(6, '转让电瓶车一辆', '转让电瓶车一辆，可当面看车，电话：1111222', '/upload/images/item/shop/15/2017060608490188656.jpg', '3000', '1200', 99, '2017-06-06 08:49:01', '2017-06-06 08:50:57', 1, 0, NULL, 15),
	(7, '转让半新旧男装摩托车一辆', '转让半新旧男装摩托车一辆，当面验车，电话：3333666', '/upload/images/item/shop/15/2017060608502085437.jpg', '8000', '3000', 98, '2017-06-06 08:50:20', '2017-06-06 08:51:19', 1, 0, NULL, 15),
	(8, '大量二手书籍转让', '大量二手书籍转让，电话详谈，或上门看书。联系电话：5556666   地址：东苑XX楼', '/upload/images/item/shop/16/2017060608574074561.jpg', '0', '0', 100, '2017-06-06 08:57:40', '2017-06-06 08:57:40', 1, 0, 10, 16),
	(9, '<十万个为什么>', '出手一本《十万个为什么》，8成新，想要的可以联系：9998886', '/upload/images/item/shop/16/2017060609025850665.png', '25', '10', 98, '2017-06-06 09:02:58', '2017-06-06 09:02:58', 1, 0, 10, 16),
	(10, '珍珠奶茶', '珍珠奶茶，弹性十足，香甜美味。', '\\upload\\images\\item\\shop\\20\\2018072717402794803.png', '10', '8', 100, '2017-06-06 20:11:41', '2018-07-27 18:15:17', 0, 0, 11, 20),
	(11, '红豆奶茶', '红豆和奶茶的完美结合，夏天不错的选择。', '/upload/images/item/shop/20/2017060620363014331.jpg', '10', '8', 99, '2017-06-06 20:36:30', '2017-06-06 20:36:30', 1, 1, 11, 20),
	(12, '绿豆冰', '清热解毒。', '/upload/images/item/shop/20/2017060620384620536.jpg', '8', '7', 98, '2017-06-06 20:38:46', '2017-06-06 20:38:46', 1, 0, 11, 20),
	(13, '芒果冰沙', '新鲜芒果制作。', '/upload/images/item/shop/20/2017060620472125629.jpg', '15', '13', 95, '2017-06-06 20:47:21', '2017-06-06 20:47:21', 1, 2, 11, 20),
	(14, '鲜榨芒果汁', '新鲜芒果新鲜榨，香甜可口，解暑降温。', '/upload/images/item/shop/20/2017060620492297296.jpg', '8', '8', 93, '2017-06-06 20:49:22', '2017-06-06 20:49:22', 1, 0, 11, 20),
	(15, '鲜榨西瓜汁', '每一杯都是鲜榨的，现榨现卖。', '/upload/images/item/shop/20/2017060621052824735.jpg', '8', '8', 90, '2017-06-06 21:05:28', '2017-06-06 21:05:28', 1, 0, 11, 20),
	(18, '测试', '123456', '\\upload\\images\\item\\shop\\20\\2018072714544914453.png', '12', '8', 100, '2018-07-27 14:54:49', '2018-07-28 15:11:29', 0, NULL, 11, 20),
	(19, 'ceshi888', '123456', '\\upload\\images\\item\\shop\\20\\2018072716272857697.jpg', '10', '8', 100, '2018-07-27 15:08:46', '2018-07-28 15:11:50', 0, NULL, 11, 20),
	(20, '张三二手车老店', '九成新二手车便宜出售', '\\upload\\images\\item\\shop\\15\\2018072811455834155.jpg', '600', '500', 10, '2018-07-28 11:45:58', '2018-07-28 11:45:58', 1, NULL, 23, 15),
	(21, '二手车', '123456', '\\upload\\images\\item\\shop\\15\\2018072811512035519.jpg', '100', '20', 10, '2018-07-28 11:51:20', '2018-07-28 11:52:00', 0, NULL, 23, 15),
	(22, '天天奶茶', '特别好喝', '\\upload\\images\\item\\shop\\27\\2018072815080730455.jpg', '15', '10', 10, '2018-07-28 15:08:07', '2018-07-28 15:08:07', 1, NULL, 24, 27),
	(23, '美丽奶茶', '123特别好', '\\upload\\images\\item\\shop\\27\\2018072815084791757.jpg', '16', '12', 15, '2018-07-28 15:08:47', '2018-07-28 15:08:47', 1, NULL, 25, 27);
/*!40000 ALTER TABLE `tb_product` ENABLE KEYS */;


-- 导出  表 o2odb.tb_product_category 结构
CREATE TABLE IF NOT EXISTS `tb_product_category` (
  `product_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_category_name` varchar(100) NOT NULL,
  `product_category_desc` varchar(500) DEFAULT NULL,
  `priority` int(2) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `shop_id` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_category_id`),
  KEY `fk_procate_shop` (`shop_id`),
  CONSTRAINT `fk_procate_shop` FOREIGN KEY (`shop_id`) REFERENCES `tb_shop` (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- 正在导出表  o2odb.tb_product_category 的数据：~11 rows (大约)
/*!40000 ALTER TABLE `tb_product_category` DISABLE KEYS */;
REPLACE INTO `tb_product_category` (`product_category_id`, `product_category_name`, `product_category_desc`, `priority`, `create_time`, `last_edit_time`, `shop_id`) VALUES
	(10, '二手书籍', NULL, 100, NULL, NULL, 16),
	(11, '奶茶', NULL, 100, NULL, NULL, 20),
	(12, '咖啡', NULL, 50, NULL, NULL, 20),
	(13, '甜品', NULL, 30, NULL, NULL, 20),
	(14, '小吃', NULL, 20, NULL, NULL, 20),
	(20, '测试', NULL, 10, NULL, NULL, 17),
	(21, 'test', NULL, 10, NULL, NULL, 26),
	(22, 'aaa', NULL, 10, NULL, NULL, 15),
	(23, '二手车', NULL, 1, NULL, NULL, 15),
	(24, '香飘飘', NULL, 10, NULL, NULL, 27),
	(25, '优乐美', NULL, 20, NULL, NULL, 27);
/*!40000 ALTER TABLE `tb_product_category` ENABLE KEYS */;


-- 导出  表 o2odb.tb_product_img 结构
CREATE TABLE IF NOT EXISTS `tb_product_img` (
  `product_img_id` int(20) NOT NULL AUTO_INCREMENT,
  `img_addr` varchar(2000) NOT NULL,
  `img_desc` varchar(2000) DEFAULT NULL,
  `priority` int(2) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `product_id` int(20) DEFAULT NULL,
  PRIMARY KEY (`product_img_id`),
  KEY `fk_proimg_product` (`product_id`),
  CONSTRAINT `fk_proimg_product` FOREIGN KEY (`product_id`) REFERENCES `tb_product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- 正在导出表  o2odb.tb_product_img 的数据：~27 rows (大约)
/*!40000 ALTER TABLE `tb_product_img` DISABLE KEYS */;
REPLACE INTO `tb_product_img` (`product_img_id`, `img_addr`, `img_desc`, `priority`, `create_time`, `product_id`) VALUES
	(19, '/upload/images/item/shop/15/20170605233021865310.jpg', NULL, NULL, '2017-06-05 23:30:22', 4),
	(20, '/upload/images/item/shop/15/20170605233022618071.jpg', NULL, NULL, '2017-06-05 23:30:22', 4),
	(21, '/upload/images/item/shop/15/20170605233022246642.jpg', NULL, NULL, '2017-06-05 23:30:22', 4),
	(22, '/upload/images/item/shop/15/20170605234852321010.jpg', NULL, NULL, '2017-06-05 23:48:52', 5),
	(23, '/upload/images/item/shop/15/20170606084902162950.jpg', NULL, NULL, '2017-06-06 08:49:02', 6),
	(24, '/upload/images/item/shop/15/20170606085020558290.jpg', NULL, NULL, '2017-06-06 08:50:20', 7),
	(25, '/upload/images/item/shop/16/20170606085740956160.jpg', NULL, NULL, '2017-06-06 08:57:40', 8),
	(26, '/upload/images/item/shop/16/20170606090259397060.png', NULL, NULL, '2017-06-06 09:02:59', 9),
	(30, '/upload/images/item/shop/20/20170606203630923430.jpg', NULL, NULL, '2017-06-06 20:36:31', 11),
	(31, '/upload/images/item/shop/20/20170606203631552081.png', NULL, NULL, '2017-06-06 20:36:31', 11),
	(32, '/upload/images/item/shop/20/20170606203631972862.jpg', NULL, NULL, '2017-06-06 20:36:31', 11),
	(33, '/upload/images/item/shop/20/20170606203846623120.jpg', NULL, NULL, '2017-06-06 20:38:47', 12),
	(34, '/upload/images/item/shop/20/20170606204721744860.jpg', NULL, NULL, '2017-06-06 20:47:21', 13),
	(35, '/upload/images/item/shop/20/20170606204922968580.jpg', NULL, NULL, '2017-06-06 20:49:23', 14),
	(36, '/upload/images/item/shop/20/20170606210528529220.jpg', NULL, NULL, '2017-06-06 21:05:28', 15),
	(37, '/upload/images/item/shop/20/20170606210528132921.jpg', NULL, NULL, '2017-06-06 21:05:28', 15),
	(38, '\\upload\\images\\item\\shop\\20\\20180727145449990060.jpg', NULL, NULL, '2018-07-27 14:54:49', NULL),
	(39, '\\upload\\images\\item\\shop\\20\\20180727150846767620.png', NULL, NULL, '2018-07-27 15:08:46', NULL),
	(40, '\\upload\\images\\item\\shop\\20\\20180727150846579611.jpg', NULL, NULL, '2018-07-27 15:08:46', NULL),
	(41, '\\upload\\images\\item\\shop\\20\\20180727162728236110.png', NULL, NULL, '2018-07-27 16:27:28', 19),
	(42, '\\upload\\images\\item\\shop\\20\\20180727174027494760.jpg', NULL, NULL, '2018-07-27 17:40:28', 10),
	(43, '\\upload\\images\\item\\shop\\15\\20180728114600948420.jpg', NULL, NULL, '2018-07-28 11:46:00', NULL),
	(44, '\\upload\\images\\item\\shop\\15\\20180728114600295121.jpg', NULL, NULL, '2018-07-28 11:46:00', NULL),
	(45, '\\upload\\images\\item\\shop\\15\\20180728115120507130.jpg', NULL, NULL, '2018-07-28 11:51:21', NULL),
	(46, '\\upload\\images\\item\\shop\\15\\20180728115120973051.jpg', NULL, NULL, '2018-07-28 11:51:21', NULL),
	(47, '\\upload\\images\\item\\shop\\27\\20180728150808900740.jpg', NULL, NULL, '2018-07-28 15:08:08', NULL),
	(48, '\\upload\\images\\item\\shop\\27\\20180728150847666960.jpg', NULL, NULL, '2018-07-28 15:08:47', NULL);
/*!40000 ALTER TABLE `tb_product_img` ENABLE KEYS */;


-- 导出  表 o2odb.tb_shop 结构
CREATE TABLE IF NOT EXISTS `tb_shop` (
  `shop_id` int(10) NOT NULL AUTO_INCREMENT,
  `owner_id` int(10) NOT NULL COMMENT '店铺创建人',
  `area_id` int(5) DEFAULT NULL,
  `shop_category_id` int(11) DEFAULT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  `shop_name` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `shop_desc` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shop_addr` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shop_img` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `longitude` double(16,12) DEFAULT NULL,
  `latitude` double(16,12) DEFAULT NULL,
  `priority` int(3) DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `enable_status` int(2) NOT NULL DEFAULT '0',
  `advice` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`shop_id`),
  KEY `fk_shop_profile` (`owner_id`),
  KEY `fk_shop_area` (`area_id`),
  KEY `fk_shop_shopcate` (`shop_category_id`),
  KEY `fk_shop_parentcate` (`parent_category_id`),
  CONSTRAINT `fk_shop_area` FOREIGN KEY (`area_id`) REFERENCES `tb_area` (`area_id`),
  CONSTRAINT `fk_shop_parentcate` FOREIGN KEY (`parent_category_id`) REFERENCES `tb_shop_category` (`shop_category_id`),
  CONSTRAINT `fk_shop_profile` FOREIGN KEY (`owner_id`) REFERENCES `tb_person_info` (`user_id`),
  CONSTRAINT `fk_shop_shopcate` FOREIGN KEY (`shop_category_id`) REFERENCES `tb_shop_category` (`shop_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  o2odb.tb_shop 的数据：~21 rows (大约)
/*!40000 ALTER TABLE `tb_shop` DISABLE KEYS */;
REPLACE INTO `tb_shop` (`shop_id`, `owner_id`, `area_id`, `shop_category_id`, `parent_category_id`, `shop_name`, `shop_desc`, `shop_addr`, `phone`, `shop_img`, `longitude`, `latitude`, `priority`, `create_time`, `last_edit_time`, `enable_status`, `advice`) VALUES
	(15, 9, 3, 14, 10, '二手车辆', '二手汽车、摩托车、电车等交通工具交易信息。', '面向全市', '0123456', '/upload/images/item/shop/15/2017060522042982266.png', NULL, NULL, 100, '2017-06-05 22:04:29', '2018-07-27 09:29:38', 1, NULL),
	(16, 9, 3, 15, 10, '旧书籍交易', '旧书籍交易信息', '旧书籍交易板块', '0000000', '/upload/images/item/shop/16/2017060608534289617.png', NULL, NULL, 99, '2017-06-06 08:53:42', '2018-07-27 09:30:59', 1, NULL),
	(17, 8, 3, 20, 11, '靓仔靓妹美容护理中心', '二十年手艺，专业护理秀发受损头发。美容美发首选。', '东苑北面二号门', '4445556', '/upload/images/item/shop/17/2017060609084595067.jpg', NULL, NULL, 0, '2017-06-06 09:08:45', '2017-06-06 09:45:32', 1, NULL),
	(18, 8, 3, 18, 11, '一剪没理发中心', '专业洗剪吹，又好又便宜。', '东苑北面3号门面', '9998887', '/upload/images/item/shop/18/2017060609110899956.jpg', NULL, NULL, 0, '2017-06-06 09:11:08', '2017-06-06 09:45:38', 1, NULL),
	(20, 8, 4, 22, 12, '香喷喷奶茶店', '鲜榨果汁、奶茶等饮品。', '南苑东面5号门面', '77788444', '/upload/images/item/shop/20/2017060609163395401.jpg', NULL, NULL, 30, '2017-06-06 09:16:33', '2017-06-07 16:24:07', 1, '""'),
	(21, 8, 5, 25, 13, '海陆空量贩KTV', '订包厢电话：8889997。节假日请预约。', '西苑1号门面', '8889997', '/upload/images/item/shop/21/2017060609194286080.jpg', NULL, NULL, 0, '2017-06-06 09:19:42', '2017-06-06 09:45:59', 1, NULL),
	(22, 8, 5, 24, 13, '幽城室逃生娱乐城', '考验你的智商，和小伙伴们一起来挑战吧。', '西苑3号楼第二层', '6666333', '/upload/images/item/shop/22/2017060609223853062.jpg', NULL, NULL, 0, '2017-06-06 09:22:38', '2017-06-06 09:46:04', 1, NULL),
	(23, 8, 6, 29, 27, '威水程序设计培训教育', '保教抱会，前途无量。', '北苑2栋5楼', '66633111', '/upload/images/item/shop/23/2017060609275777519.png', NULL, NULL, 0, '2017-06-06 09:27:57', '2017-06-06 09:46:09', 1, NULL),
	(24, 8, 6, 30, 27, '武林风舞蹈培训', '专业培训舞蹈，声乐。', '北苑9懂10楼', '5555555', '/upload/images/item/shop/24/2017060609354459045.png', NULL, NULL, 0, '2017-06-06 09:35:44', '2017-06-06 09:46:13', 1, NULL),
	(25, 8, 6, 14, 28, '易行交通工具租赁服务中心', '本店租赁各种汽车，摩托车等。详情请拨打电话咨询。电话：2222222', '1栋3号4号门面', '2222222', '/upload/images/item/shop/25/2017060609381150709.png', NULL, NULL, 40, '2017-06-06 09:38:11', '2017-06-06 19:58:32', 1, NULL),
	(26, 8, 6, 31, 28, '有声有色', '出租各种演出道具，乐器，服装等。', '北苑15号门面', '7777777', '/upload/images/item/shop/26/2017060609431259039.png', NULL, NULL, 41, '2017-06-06 09:43:12', '2017-06-06 19:58:45', 1, NULL),
	(27, 8, 3, 22, 12, '冰冻夏天奶茶店', '本店出售各种冷饮，奶茶，冰花，鲜榨果汁。', '东苑7懂2号门面', '8889999', '/upload/images/item/shop/27/2017060715512185473.jpg', NULL, NULL, 10, '2017-06-07 15:51:21', '2017-06-07 16:22:28', 1, '""'),
	(28, 9, 3, 14, 10, 'test', 'dfafaf', 'sdafafafa', '3424242', '/upload/images/item/shop/28/2017082500103690946.png', NULL, NULL, 0, '2017-08-25 00:10:36', '2017-08-25 00:10:36', 0, NULL),
	(30, 8, NULL, NULL, NULL, 'mytest2', 'mytest2', '2222222222222222222', '13810524526', 'test1', 1.000000000000, 1.000000000000, 0, '2018-07-25 13:54:45', '2018-07-25 13:54:45', 0, '审核中'),
	(51, 9, 3, 14, NULL, '萨达', '萨达', '萨达', '1234156489', 'upload\\item\\shop\\2018072615295693043.jpg', NULL, NULL, 0, '2018-07-26 15:29:56', '2018-07-26 15:29:56', 0, NULL),
	(52, 9, 3, 14, NULL, 'qqq', '萨达', '萨达', '1234156489', '\\upload\\item\\shop\\2018072615425899847.png', NULL, NULL, 0, '2018-07-26 15:32:04', '2018-07-26 15:32:04', 0, NULL),
	(53, 9, 3, 14, NULL, 'qqq', '萨达', '萨达', '1234156489', '\\upload\\item\\shop\\2018072615425899847.png', NULL, NULL, 0, '2018-07-26 15:37:07', '2018-07-26 15:37:07', 0, NULL),
	(54, 9, 3, 14, NULL, 'qqq', '萨达', '萨达', '1234156489', '\\upload\\item\\shop\\2018072615425899847.png', NULL, NULL, 0, '2018-07-26 15:38:35', '2018-07-26 15:38:35', 0, NULL),
	(55, 9, 3, 14, NULL, 'qqq', '萨达', '萨达', '1234156489', '\\upload\\item\\shop\\2018072615425899847.png', NULL, NULL, 0, '2018-07-26 15:38:38', '2018-07-26 15:38:38', 0, NULL),
	(56, 9, 3, 14, NULL, 'qqq', '萨达', '萨达', '1234156489', '\\upload\\item\\shop\\2018072615425899847.png', NULL, NULL, 0, '2018-07-26 15:42:58', '2018-07-26 15:42:58', 0, NULL),
	(61, 8, 4, 15, NULL, '最后一家店1', '阿萨德萨达', '阿萨德', '123456789', '\\upload\\item\\shop\\2018072622000679654.png', NULL, NULL, 0, '2018-07-26 22:00:06', '2018-07-26 22:00:06', 0, NULL);
/*!40000 ALTER TABLE `tb_shop` ENABLE KEYS */;


-- 导出  表 o2odb.tb_shop_auth_map 结构
CREATE TABLE IF NOT EXISTS `tb_shop_auth_map` (
  `shop_auth_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `shop_id` int(10) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '冗余是为了让shop在查找员工的时候，不需要去连tb_shop表，直接连tb_shop_auth_map就okay',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title_flag` int(2) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `enable_status` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shop_auth_id`),
  KEY `fk_shop_auth_map_shop` (`shop_id`),
  KEY `uk_shop_auth_map` (`employee_id`,`shop_id`),
  CONSTRAINT `fk_shop_auth_map_employee` FOREIGN KEY (`employee_id`) REFERENCES `tb_person_info` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  o2odb.tb_shop_auth_map 的数据：~14 rows (大约)
/*!40000 ALTER TABLE `tb_shop_auth_map` DISABLE KEYS */;
REPLACE INTO `tb_shop_auth_map` (`shop_auth_id`, `employee_id`, `shop_id`, `name`, `title`, `title_flag`, `create_time`, `last_edit_time`, `enable_status`) VALUES
	(13, 8, 15, '', '店家本人', 1, '2017-06-05 22:04:30', '2017-06-05 22:04:30', 1),
	(14, 8, 16, '', '店家本人', 1, '2017-06-06 08:53:42', '2017-06-06 08:53:42', 1),
	(15, 8, 17, '', '店家本人', 1, '2017-06-06 09:08:45', '2017-06-06 09:08:45', 1),
	(16, 8, 18, '', '店家本人', 1, '2017-06-06 09:11:09', '2017-06-06 09:11:09', 1),
	(17, 8, 19, '', '店家本人', 1, '2017-06-06 09:14:06', '2017-06-06 09:14:06', 1),
	(18, 8, 20, '', '店家本人', 1, '2017-06-06 09:16:33', '2017-06-06 09:16:33', 1),
	(19, 8, 21, '', '店家本人', 1, '2017-06-06 09:19:42', '2017-06-06 09:19:42', 1),
	(20, 8, 22, '', '店家本人', 1, '2017-06-06 09:22:38', '2017-06-06 09:22:38', 1),
	(21, 8, 23, '', '店家本人', 1, '2017-06-06 09:27:57', '2017-06-06 09:27:57', 1),
	(22, 8, 24, '', '店家本人', 1, '2017-06-06 09:35:44', '2017-06-06 09:35:44', 1),
	(23, 8, 25, '', '店家本人', 1, '2017-06-06 09:38:11', '2017-06-06 09:38:11', 1),
	(24, 8, 26, '', '店家本人', 1, '2017-06-06 09:43:13', '2017-06-06 09:43:13', 1),
	(25, 8, 27, '', '店家本人', 1, '2017-06-07 15:51:21', '2017-06-07 15:51:21', 1),
	(26, 9, 28, '', '店家本人', 1, '2017-08-25 00:10:36', '2017-08-25 00:10:36', 1);
/*!40000 ALTER TABLE `tb_shop_auth_map` ENABLE KEYS */;


-- 导出  表 o2odb.tb_shop_category 结构
CREATE TABLE IF NOT EXISTS `tb_shop_category` (
  `shop_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_category_name` varchar(100) NOT NULL DEFAULT '',
  `shop_category_desc` varchar(1000) DEFAULT '',
  `shop_category_img` varchar(2000) DEFAULT NULL,
  `priority` int(2) NOT NULL DEFAULT '0',
  `create_time` datetime DEFAULT NULL,
  `last_edit_time` datetime DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`shop_category_id`),
  KEY `fk_shop_category_self` (`parent_id`),
  CONSTRAINT `fk_shop_category_self` FOREIGN KEY (`parent_id`) REFERENCES `tb_shop_category` (`shop_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- 正在导出表  o2odb.tb_shop_category 的数据：~18 rows (大约)
/*!40000 ALTER TABLE `tb_shop_category` DISABLE KEYS */;
REPLACE INTO `tb_shop_category` (`shop_category_id`, `shop_category_name`, `shop_category_desc`, `shop_category_img`, `priority`, `create_time`, `last_edit_time`, `parent_id`) VALUES
	(10, '二手市场', '二手商品交易', '/upload/images/item/shopcategory/2017061223272255687.png', 100, '2017-06-04 20:10:58', '2017-06-12 23:27:22', NULL),
	(11, '美容美发', '美容美发', '/upload/images/item/shopcategory/2017061223273314635.png', 99, '2017-06-04 20:12:57', '2017-06-12 23:27:33', NULL),
	(12, '美食饮品', '美食饮品', '/upload/images/item/shopcategory/2017061223274213433.png', 98, '2017-06-04 20:15:21', '2017-06-12 23:27:42', NULL),
	(13, '休闲娱乐', '休闲娱乐', '/upload/images/item/shopcategory/2017061223275121460.png', 97, '2017-06-04 20:19:29', '2017-06-12 23:27:51', NULL),
	(14, '旧车', '旧车', '/upload/images/item/shopcategory/2017060420315183203.png', 80, '2017-06-04 20:31:51', '2017-06-04 20:31:51', 10),
	(15, '二手书籍', '二手书籍', '/upload/images/item/shopcategory/2017060420322333745.png', 79, '2017-06-04 20:32:23', '2017-06-04 20:32:23', 10),
	(17, '护理', '护理', '/upload/images/item/shopcategory/2017060420372391702.png', 76, '2017-06-04 20:37:23', '2017-06-04 20:37:23', 11),
	(18, '理发', '理发', '/upload/images/item/shopcategory/2017060420374775350.png', 74, '2017-06-04 20:37:47', '2017-06-04 20:37:47', 11),
	(20, '大排档', '大排档', '/upload/images/item/shopcategory/2017060420460491494.png', 59, '2017-06-04 20:46:04', '2017-06-04 20:46:04', 12),
	(22, '奶茶店', '奶茶店', '/upload/images/item/shopcategory/2017060420464594520.png', 58, '2017-06-04 20:46:45', '2017-06-04 20:46:45', 12),
	(24, '密室逃生', '密室逃生', '/upload/images/item/shopcategory/2017060420500783376.png', 56, '2017-06-04 20:50:07', '2017-06-04 21:45:53', 13),
	(25, 'KTV', 'KTV', '/upload/images/item/shopcategory/2017060420505834244.png', 57, '2017-06-04 20:50:58', '2017-06-04 20:51:14', 13),
	(27, '培训教育', '培训教育', '/upload/images/item/shopcategory/2017061223280082147.png', 96, '2017-06-04 21:51:36', '2017-06-12 23:28:00', NULL),
	(28, '租赁市场', '租赁市场', '/upload/images/item/shopcategory/2017061223281361578.png', 95, '2017-06-04 21:53:52', '2017-06-12 23:28:13', NULL),
	(29, '程序设计', '程序设计', '/upload/images/item/shopcategory/2017060421593496807.png', 50, '2017-06-04 21:59:34', '2017-06-04 21:59:34', 27),
	(30, '声乐舞蹈', '声乐舞蹈', '/upload/images/item/shopcategory/2017060421595843693.png', 49, '2017-06-04 21:59:58', '2017-06-04 21:59:58', 27),
	(31, '演出道具', '演出道具', '/upload/images/item/shopcategory/2017060422114076152.png', 45, '2017-06-04 22:11:40', '2017-06-04 22:11:40', 28),
	(32, '交通工具', '交通工具', '/upload/images/item/shopcategory/2017060422121144586.png', 44, '2017-06-04 22:12:11', '2017-06-04 22:12:11', 28);
/*!40000 ALTER TABLE `tb_shop_category` ENABLE KEYS */;


-- 导出  表 o2odb.tb_user_award_map 结构
CREATE TABLE IF NOT EXISTS `tb_user_award_map` (
  `user_award_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `award_id` int(10) NOT NULL,
  `shop_id` int(10) NOT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `award_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `used_status` int(2) NOT NULL DEFAULT '0',
  `point` int(10) DEFAULT NULL,
  PRIMARY KEY (`user_award_id`),
  KEY `fk_user_award_map_profile` (`user_id`),
  KEY `fk_user_award_map_award` (`award_id`),
  KEY `fk_user_award_map_shop` (`shop_id`),
  CONSTRAINT `fk_user_award_map_award` FOREIGN KEY (`award_id`) REFERENCES `tb_award` (`award_id`),
  CONSTRAINT `fk_user_award_map_profile` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`),
  CONSTRAINT `fk_user_award_map_shop` FOREIGN KEY (`shop_id`) REFERENCES `tb_shop` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  o2odb.tb_user_award_map 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tb_user_award_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_user_award_map` ENABLE KEYS */;


-- 导出  表 o2odb.tb_user_product_map 结构
CREATE TABLE IF NOT EXISTS `tb_user_product_map` (
  `user_product_id` int(30) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) DEFAULT NULL,
  `product_id` int(100) DEFAULT NULL,
  `shop_id` int(10) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `point` int(10) DEFAULT '0',
  PRIMARY KEY (`user_product_id`),
  KEY `fk_user_product_map_profile` (`user_id`),
  KEY `fk_user_product_map_product` (`product_id`),
  KEY `fk_user_product_map_shop` (`shop_id`),
  CONSTRAINT `fk_user_product_map_product` FOREIGN KEY (`product_id`) REFERENCES `tb_product` (`product_id`),
  CONSTRAINT `fk_user_product_map_profile` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`),
  CONSTRAINT `fk_user_product_map_shop` FOREIGN KEY (`shop_id`) REFERENCES `tb_shop` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  o2odb.tb_user_product_map 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tb_user_product_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_user_product_map` ENABLE KEYS */;


-- 导出  表 o2odb.tb_user_shop_map 结构
CREATE TABLE IF NOT EXISTS `tb_user_shop_map` (
  `user_shop_id` int(30) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `shop_id` int(10) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `shop_name` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `point` int(10) DEFAULT NULL,
  PRIMARY KEY (`user_shop_id`),
  UNIQUE KEY `uq_user_shop` (`user_id`,`shop_id`),
  KEY `fk_user_shop_shop` (`shop_id`),
  CONSTRAINT `fk_user_shop_shop` FOREIGN KEY (`shop_id`) REFERENCES `tb_shop` (`shop_id`),
  CONSTRAINT `fk_user_shop_user` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  o2odb.tb_user_shop_map 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tb_user_shop_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_user_shop_map` ENABLE KEYS */;


-- 导出  表 o2odb.tb_wechat_auth 结构
CREATE TABLE IF NOT EXISTS `tb_wechat_auth` (
  `wechat_auth_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `open_id` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`wechat_auth_id`),
  KEY `fk_oauth_profile` (`user_id`),
  KEY `uk_oauth` (`open_id`(255)),
  CONSTRAINT `fk_oauth_profile` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- 正在导出表  o2odb.tb_wechat_auth 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `tb_wechat_auth` DISABLE KEYS */;
REPLACE INTO `tb_wechat_auth` (`wechat_auth_id`, `user_id`, `open_id`, `create_time`) VALUES
	(4, 8, 'ovLbns-gxJHqC-UTPQKvgEuENl-E', '2017-06-04 19:01:09'),
	(5, 9, 'ovLbns9oD5K4g712TW63dgSHxC3o', '2017-06-04 21:20:43'),
	(6, 10, 'ovLbnsz16NtYSt2bCoJktXOGlzyg', '2017-06-07 01:36:16'),
	(7, 11, 'ovLbns4Z7ueIBJNmgVfpDTQQLCRA', '2017-09-18 23:39:38');
/*!40000 ALTER TABLE `tb_wechat_auth` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
