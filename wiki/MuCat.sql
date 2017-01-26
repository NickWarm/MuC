-- MySQL dump 10.13  Distrib 5.7.13, for osx10.11 (x86_64)
--
-- Host: localhost    Database: MuCat
-- ------------------------------------------------------
-- Server version	5.7.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'2017-01-20 13:54:46','2017-01-20 13:54:46','14100420_10205046630484045_8939255742065973940_n.jpg','image/jpeg',55280,'2017-01-20 13:54:45',1),(2,'2017-01-23 11:49:25','2017-01-23 11:49:25','12698714_920836658035699_932899906695284890_o.png','image/png',865910,'2017-01-23 11:49:25',1);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `managers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_managers_on_email` (`email`),
  UNIQUE KEY `index_managers_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `is_editable` tinyint(1) DEFAULT '0',
  `link_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link_site` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (1,'學習方法論','# Inner Game Plus\r\n\r\n各位學弟妹好，我是陳威齊，97學年就讀中原大學電子系，101學年就讀中原大學通訊碩。\r\n\r\n## 一些往事\r\n\r\n在你讀這篇文章之前，先讓我說幾則我朋友與我的真實故事。\r\n\r\n兩個都是我大學同班同學，我是97學年入學，電子丙班的學長\r\n>1. 一位同班同學，上課很認真，非常認真，但是他大學時被當太多延畢\r\n>2. 另一位是我室友，期考前才來跟我借筆記唸書，而且從來沒動過筆\r\n\r\n一個很努力卻屢次被當而延畢，另一個很混卻順利畢業，為何會這樣呢？\r\n\r\n那我自己又是什麼情況呢？\r\n\r\n我自己\r\n>1. 大二修訊號與系統時，從聽不懂翹課，到回到教室專心聽課，並 **學會如何學習數學**\r\n>2. 大二時，寫工數、訊號的筆記，**於期考週時迅速教會同班同學們**\r\n>3. 大三因個人因素導致無心課業\r\n>4. 大四重修電磁學時，**教降轉的學長電磁學，讓他能順利畢業**，那天是考電磁學期末考的前一晚，我教他到半夜四點\r\n>5. 碩班時自己讀了[Haykin](https://www.amazon.com/Signals-Systems-2nd-Simon-Haykin/dp/0471164747)與[Oppenheim](https://www.amazon.com/Signals-Systems-2nd-Alan-Oppenheim/dp/0138147574)他們各自寫的兩本原文書，**自己手寫編「訊號與系統」的TA講義** 教學弟妹\r\n>6. 碩一修課時，聽不懂授課老師講的，讀了指導教授推薦的原文書，然後 **寫了一套筆記教了一起修課的同學，與重修的學長姐**\r\n\r\n## 教書的體悟\r\n\r\n碩一教書時發現，很多人都不笨，但是他們恐懼英文、未曾真正思考原文書在寫什麼，於是我分享了自己[大學時的讀書方法](http://nickwarm.logdown.com/posts/966300)。\r\n\r\n碩二教書時發現，程度差異有點大，原本的教法行不通了，我與指導教授合作採取了另一套新的方法。\r\n\r\n>來TA的只有少數人，我不再詳細講理論的推導，而是每次都叫一個人上台，在台上我問他們問題，引導他們 **自行思索出答案** ，再讓他們自己去教其他參與TA的同學。\r\n\r\n最後，這些學生成為教學長，在老師的課堂上分組教其他同學，而我也隨堂跟老師一起協助教學。\r\n\r\n## 不擅長的事\r\n\r\n當然我也有不擅長的\r\n>1. 碩一時，我發現自己對「學寫程式」，學得並不是很有效率\r\n>2. 我覺得我不會寫程式\r\n>   - 儘管我修資工的[影像處理](http://comm.cycu.edu.tw/wSite/ct?xItem=22779&ctNode=9397&mp=16)時，有自己寫出[作業與期末專題](https://github.com/NickWarm/ImageProcessing_HW)\r\n>   - 碩班畢業題目從完全不會寫JavaScript，到用[three.js](https://threejs.org)寫出在網站上渲染3D模型的[WebGL機率遊戲](https://www.youtube.com/watch?v=ZzQ6ef6GZKw)\r\n\r\n但是我還是覺得自己不會寫程式，我的煩惱與困惑陪伴著我畢業後在澎湖服役生涯\r\n\r\n## 轉機\r\n\r\n由於打算學寫網站，開始關注[xdite的臉書](https://www.facebook.com/xdite?fref=ts)，促使我思考，如何改進自己的學習方法論。\r\n\r\n最後我在這兩個資源上獲得深度啟發\r\n\r\n- Coursera的「[Learning how to learn](https://www.coursera.org/learn/learning-how-to-learn)」課程\r\n- xdite分享的「[The Inner Game of Tennis](https://www.amazon.com/Inner-Game-Tennis-Classic-Performance/dp/0679778314)」這本書\r\n\r\n去蕪存菁後我寫了一套[學習方法論：Inner Game Plus](http://nickwarm.logdown.com/posts/966527)。\r\n\r\n寫完這套方法論並實踐後，我終於覺得自己懂得如何學寫程式，在數學的學習也有更好的效率。\r\n\r\n在中國，若想要學習「學習方法論」你要繳納的學費\r\n>1. 千古劉傳的[認知學習法](http://chuansong.me/n/520186151978)要價人民幣699，換算台幣約3238元\r\n>2. Xdite在中國的新生大學開的[元學習課](http://mp.weixin.qq.com/s?__biz=MzAwMDgyMTA3Mg%3D%3D&mid=2650057305&idx=1&sn=2c82314f52e86a5c65658c2acccdf57e&scene=0#wechat_redirect)，只有3次課，新生大學會員200人民幣，非會員1200人民幣，換算台幣約5560元。\r\n\r\n\r\n學習能力飛速成長的鑰匙我已經給你了，現在你是否願意開啟這扇門？\r\n',0,'Go to Inner Game Plus','http://nickwarm.logdown.com/posts/966527','2017-01-20 14:01:14','2017-01-20 14:01:14',1),(2,'「訊號與系統TA」舊版講義','碩一帶TA，為了教學弟妹這門課，我讀了[Haykin](https://www.amazon.com/Signals-Systems-2nd-Simon-Haykin/dp/0471164747)與[Oppenheim](https://www.amazon.com/Signals-Systems-2nd-Alan-Oppenheim/dp/0138147574)他們各自寫的兩本原文書，自己手寫編「訊號與系統」的TA講義\r\n\r\n',0,'','','2017-01-20 14:05:48','2017-01-20 14:05:48',1),(3,'「機率與統計」線上學習資源','以下兩個資源都是葉丙成老師的\r\n\r\n### 最初youtube版\r\n- [台大電機系 Prof. 葉丙成 機率與統計 線上課程 - YouTube](https://www.youtube.com/playlist?list=PLtvno3VRDR_jMAJcNY1n4pnP5kXtPOmVk)\r\n\r\n### Coursera版\r\n- youtube：[機率 (Probability) by Prof. 葉丙成 MOOC - YouTube](https://www.youtube.com/playlist?list=PLw9fh2FrjAqu1Gj_WznO-humCJT-OB2zF)\r\n- 官方課程：[機率 (Probability) - 國立台灣大學 | Coursera](https://www.coursera.org/learn/prob1)',1,'','','2017-01-20 14:06:39','2017-01-20 14:08:51',1),(4,'「訊號與系統」線上學習資源','以下兩個資源分別是 **交大 陳永平老師** 與 **台科大 黃騰毅老師** 所提供的教材\r\n\r\n### 交大訊號與系統課程\r\n- youtube：[NCTU OCW 訊號與系統 - YouTube](https://www.youtube.com/playlist?list=PLj6E8qlqmkFuHIK3xM0-OAlMF7N1ta-b7)\r\n- 官方影片：[國立交通大學開放式課程(OpenCourseWare, OCW)](http://ocw.nctu.edu.tw/course_detail_3.php?bgid=8&gid=0&nid=453#.WIHWRLE8Ufw)\r\n- 課程講義：[國立交通大學開放式課程(OpenCourseWare, OCW)](http://ocw.nctu.edu.tw/course_detail_4.php?bgid=8&gid=0&nid=453#.WIHWQbE8Ufw)\r\n\r\n### 台科大訊號與系統\r\n- [信號與系統 訊號與系統 Signals and Systems 基礎數位信號處理 傅立葉轉換 傅利葉轉換 - YouTube](https://www.youtube.com/playlist?list=PLX6FA3vfNTfChkbNQGxVPrIsvkC_DwNV6)',1,'','','2017-01-20 14:07:20','2017-01-20 14:08:31',1),(5,'「影像處理」線上學習資源','我是陳威齊學長，我不推薦學弟妹用C語言入門影像處理，如果想真的 **會寫影像處理**，你該花時間學數學與學習如何 **用程式實踐數學**\r\n\r\n至於實踐的語言，你不一定要像過去的學長姐一樣用C寫，也可以用影像處理這領域另一個多人使用的語言Python去寫\r\n\r\n## 教學網站\r\n- [昨日](http://yester-place.blogspot.tw/)\r\n  - 以前學長都叫我們讀這教學，不過老實說，這東西真的很舊很舊，甚至可說跟不上時代了\r\n  - 畢業後再看以前學影像處理的經驗，我的感想\r\n    - 往年學長姐包括我在內的實驗室成員，都會必修資工[張元翔](http://uip.cycu.edu.tw/UIPWeb/wSite/sp?xdUrl=cycu/ApBlock/TeacherData.jsp&idCode=11641&mp=4700&ctNode=13793&idPath=13774_13790_13793)老師的影像處理\r\n    - 但其實我不推薦學弟妹從C語言寫影像處理\r\n      - 印象中，中原電子系出來的，**C語言都寫得好不好，要看遇到哪位老師**\r\n      - 而且大學老師教的C語言應該跟業界用的C語言差很多，詳情請見良葛格的這篇文章：[你腦袋的C更新了嗎？](http://www.ithome.com.tw/voice/108806)\r\n    - 如果想真的 **會寫影像處理**，你該花時間學數學與學習如何 **用程式實踐數學**\r\n    - 請參考張逸中老師的這篇文章：[想做影像辨識該學甚麼？ - 鄉下老師](http://blog.udn.com/yccsonar/25354225)\r\n- [OpenCV教學 | 阿洲的程式教學](http://monkeycoding.com/?page_id=12)\r\n- [影像處理 教學網頁](http://www.cs.pu.edu.tw/~ychu/class103-2/IP.htm)  \r\n  - 很多Java與C的範例碼\r\n- [演算法筆記](http://www.csie.ntnu.edu.tw/~u91029/)\r\n\r\n## 推薦閱讀文章\r\n- [想做影像辨識該學甚麼？ - 鄉下老師](http://blog.udn.com/yccsonar/25354225)\r\n- [你腦袋的C更新了嗎？](http://www.ithome.com.tw/voice/108806)\r\n- [「影像處理」與「影像辨識」 - 鄉下老師](http://blog.udn.com/yccsonar/32011266)\r\n- [Lib裡面沒有神 - 鄉下老師](http://blog.udn.com/yccsonar/43706585)\r\n- [影像辨識也會用到微積分？ - 鄉下老師](http://blog.udn.com/yccsonar/43587873)\r\n\r\n\r\n## MOOC\r\n- [Introduction to Computer Vision | Udacity](https://www.udacity.com/course/introduction-to-computer-vision--ud810)\r\n- [Image and Video Processing: From Mars to Hollywood with a Stop at the Hospital - 杜克大学 | Coursera](https://www.coursera.org/learn/image-processing)\r\n- [數字圖像處理 - 好大學在線CNMOOC_中國頂尖的慕課平台](http://www.cnmooc.org/portal/course/12/2023.mooc)\r\n\r\n\r\n\r\n## Youtube\r\n- [\\[10410CS135701\\] python 影像處理 - YouTube](https://www.youtube.com/watch?v=jbuYBURnVZY)\r\n- [Images and Pixels - Processing Tutorial - YouTube](https://www.youtube.com/playlist?list=PLRqwX-V7Uu6YB9x6f23CBftiyx0u_5sO9)\r\n- [Computer Vision - YouTube](https://www.youtube.com/playlist?list=PLRqwX-V7Uu6aG2RJHErXKSWFDXU4qo_ro)\r\n- [Video - Processing Tutorial - YouTube](https://www.youtube.com/playlist?list=PLRqwX-V7Uu6bw0bVn4M63p8TMJf3OhGy8)\r\n- [Coding Math - YouTube](https://www.youtube.com/user/codingmath/playlists)',0,'','','2017-01-20 14:09:30','2017-01-20 14:14:52',1);
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_authorities`
--

DROP TABLE IF EXISTS `post_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_authorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_authorities`
--

LOCK TABLES `post_authorities` WRITE;
/*!40000 ALTER TABLE `post_authorities` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'榮獲91學年國科會補助計畫','繆紹綱老師指導 **吳倉志** 的「智慧型數位監視系統」榮獲91學年國科會補助計畫\r\n\r\n### 出處\r\n- [中原大學研究發展處-09-大專學生研究計畫-相關訊息](http://uip.cycu.edu.tw/UIPWeb/wSite/ct?xItem=41575&ctNode=15261&mp=2500)，請下載：【其他】01-科技部(原名國科會)補助本校大專學生研究計畫歷年統計(79~104)\r\n','2017-01-20 14:19:18','2017-01-20 14:19:18'),(2,1,'中華民國影像處理與圖形識別學會佳作論文獎','繆紹綱老師指導 **朱鏡宏、黃心和** 同學以「A JPEG-Based Region of Interest Coding for Lossless Compression of Capsule Endoscope Images」榮獲 95 學年度中華民國影像處理與圖形識別學會佳作論文獎。\r\n\r\n### 出處\r\n- [中原電子: 學生傑出表現](http://9926267lab07.blogspot.tw/2013/03/blog-post_3063.html)\r\n- [電子工程學系-學生傑出表現-93~98年學生傑出表現](http://uip.cycu.edu.tw/UIPWeb/wSite/ct?xItem=58830&ctNode=20175&mp=46002)','2017-01-20 14:20:01','2017-01-20 14:32:36'),(3,1,'100學年：專題競賽第一名','100學年，繆紹綱老師指導 **汪炯廷** 學生以「利用H.264視訊模擬平台研發改良式的錯誤遮隱技術」獲得100學年度專題實作「通訊組」第一名\r\n\r\n### 出處\r\n- [電子工程學系-專題公告-100學年度專題實作競賽得獎名單](http://uip.cycu.edu.tw/UIPWeb/wSite/ct?xItem=55910&ctNode=19352&mp=46002)\r\n','2017-01-20 14:20:46','2017-01-20 14:36:22'),(4,1,'繆紹綱老師榮升IEEE資深會員','100學年，**繆紹綱、黃世旭** 老師榮升國際電機電子工程師學會(IEEE)資深會員(senior member)！\r\n\r\n### 出處\r\n- [電子工程學系-教師傑出表現-教師傑出表現](http://www.el.cycu.edu.tw/wSite/ct?xItem=58588&ctNode=20063&mp=46002#02)','2017-01-20 14:21:35','2017-01-20 14:32:14'),(5,1,'102學年：專題競賽第一名','102學年，繆紹綱老師指導 **蔡東昇、吳逸庭** 以「用於柑橘病蟲害防治的影像監測系統」榮獲102學年專題實作競賽：通訊組第一名。\r\n\r\n### 出處\r\n- [電子工程學系-專題公告-102-1專題展示會複賽口頭報告入選各組注意事項，請下載附檔詳閱內容。](http://uip.cycu.edu.tw/UIPWeb/wSite/ct?xItem=55886&ctNode=19352&mp=46002)\r\n- [電子工程學系-專題公告-102-1學期專題實作競賽意見回饋座談會及頒獎典禮訊息，請詳閱內容及附件。](http://uip.cycu.edu.tw/UIPWeb/wSite/ct?xItem=55883&ctNode=19352&mp=46002)','2017-01-20 14:22:10','2017-01-20 14:36:50'),(6,1,'入圍經濟部『搶鮮大賽』決賽','102學年，繆紹綱老師指導學生 **陳威齊、林建男** 的「[繆管家](https://www.youtube.com/watch?v=XelprFAymw4)」與 **蕭為允、林映丞、林政憲** 的「ipet」 這兩組隊伍入圍經濟部『搶鮮大賽-系統整合實作類』決賽\r\n\r\n### 出處\r\n- [中原大學公告系統：!!!賀!!!本校電子工程系與通訊工程學程學生團隊入圍經濟部搶鮮大賽決賽](http://ann.cycu.edu.tw/aa/frontend/AnnItem.jsp?sn=24589)\r\n','2017-01-20 14:22:56','2017-01-20 14:31:16'),(7,1,'103年 專題競賽','103學年，繆紹綱老師指導「以電腦視覺和機械手臂為基礎的象棋佈局輔助系統」、「空氣手槍打靶自動計分系統」這兩組隊伍，份別榮獲103學年專題實作競賽通訊組 **第三名** 與 **佳作**\r\n\r\n### 出處\r\n- [電子工程學系-專題公告-103-1學期專題實作展示會初複賽成績](http://uip.cycu.edu.tw/UIPWeb/wSite/ct?xItem=65850&ctNode=19352&mp=46002)','2017-01-20 14:24:39','2017-01-20 14:38:38'),(8,1,'跨領域科技部整合型計畫','104學年，**繆紹綱、張耀仁** 兩位老師帶領中原大學電子系、室內設計系與特殊教育系以服務學習內涵所撰寫的科技部整合型計畫，獲兩年經費合計 2,367,000元！\r\n\r\n### 出處\r\n- [電子工程學系-教師傑出表現-教師傑出表現](http://www.el.cycu.edu.tw/wSite/ct?xItem=58588&ctNode=20063&mp=46002#02)','2017-01-20 14:25:13','2017-01-20 14:29:27');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20161108114733'),('20161109115408'),('20161121085918'),('20161121101139'),('20161203140645'),('20161203144945'),('20161205115725'),('20170104125905'),('20170105132042'),('20170105132500'),('20170106073056'),('20170107112636'),('20170108125932'),('20170108132424');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `fb_uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fb_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fb_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fb_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `taiwan_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `english_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile` text COLLATE utf8_unicode_ci,
  `paper` text COLLATE utf8_unicode_ci,
  `has_graduated` tinyint(1) DEFAULT '0',
  `academic_degree` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'college',
  `joined_CYCU_at_which_year` int(11) DEFAULT NULL,
  `has_spent_how_much_time_at_CYCU` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  KEY `index_users_on_fb_uid` (`fb_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'dawarmwisdom@gmail.com','$2a$11$Z34yZLNDFvHfowjgchuMNuE5LglvvhtJ2FAIFPXtqbq7RuCVgYGwa',NULL,NULL,NULL,2,'2017-01-23 11:51:09','2017-01-20 13:54:28','::1','::1','2017-01-20 13:54:28','2017-01-23 11:52:29','10205663398902870','EAARnJZAC1QeoBAImoFFFdF01FBew4exbI0q18cMJKcgelMyzIWELDyPINX4EgrAWuIHhUFPqffxQdIFWiXaJDn6qTZBZAmFEq1CTucMhlpRdg9DyTEssiAMJO13i6g3x3pdU8gF6ZBe8SifQUJgOTHP7QavpMiIZD','http://graph.facebook.com/v2.6/10205663398902870/picture','陳威齊',NULL,'陳威齊','Nicholas','我是陳威齊，中原大學通訊工程碩士畢業。\r\n\r\n我喜歡數學，喜歡分享所學。嚴格來說，工程師並不是我的終生職志，我的天職應該是老師。\r\n\r\n碩班帶TA後發現自己喜歡教書。\r\n\r\n由於當初接觸到的學弟妹不懂學習方法、不擅長思考，於是開始去研究學習方法論與如何有效地教學。\r\n\r\n我不喜歡中華民國的教育體系，於是我開始學習Web技術，希望最終能透過Web技術創造一個數位學習系統，能有效率學習工程相關科目需要的數學，以及如何透過程式實踐數學。\r\n\r\n## 經歷與得獎項目\r\n- 103學年上(碩三)：[網頁的WebGL機率遊戲](https://www.youtube.com/watch?v=ZzQ6ef6GZKw)\r\n- 101學年下(碩一)：訊號與系統TA 自行編寫教學講義\r\n\r\n\r\n[歷年獎狀連結](https://photos.google.com/share/AF1QipMk0I1yut23hdUpA83uuepyVmYsIwf7funYLW95fj1TiYKGU0O8ylB9kmIaz3ziUg?key=NWwtWXo1S0o4UlJIa0x0U1JLQmlpcnp2b1JSYVJB)\r\n- 101學年上(碩一)：TANET 2012 論文發表 最佳論文：體感式肢體障礙者智慧型復健輔具\r\n- 100學年下(大四)： 全人關懷獎 服務尬科技迸出新滋味 第二名\r\n- 100學年下(大四)： 全人關懷獎 翻新舊電腦歡喜做公益 第三名\r\n- 100學年上(大四)： 2011資訊創新服務競賽 參賽\r\n- 100學年上(大四)：專題實作 複賽 佳作\r\n- 99學年下(大三)： 中原大學 創新創意實作競賽 第一名\r\n- 99學年下(大三)：中原大學 全人關懷獎 第一名\r\n','- [以ARCS動機模型與認知負荷理論 探討遊戲式學習-以機率與統計課程為例](http://ethesis.lib.cycu.edu.tw/etdservice/searching?query_word1=陳威齊&query_field1=all)',0,'master',101,NULL),(2,'wer@wer.wer','$2a$11$P6Nxg..nVEEFYzhuJw7F7.7bajPGhcAuOtgTQdTkHVqQcZ179nbzy',NULL,NULL,NULL,1,'2017-01-23 11:50:00','2017-01-23 11:50:00','::1','::1','2017-01-23 11:50:00','2017-01-23 11:50:24',NULL,NULL,NULL,NULL,NULL,'wer','wer','wer','wer',0,'college',111,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-26 17:25:44
