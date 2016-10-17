-- MySQL dump 10.13  Distrib 5.1.73, for debian-linux-gnu (i486)
--
-- Host: localhost    Database: mu_cat
-- ------------------------------------------------------
-- Server version	5.1.73-0ubuntu0.10.04.1

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
-- Table structure for table `china`
--

DROP TABLE IF EXISTS `china`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `china` (
  `year` int(11) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET big5 NOT NULL,
  `pic` text,
  `study` text CHARACTER SET big5
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `china`
--

LOCK TABLES `china` WRITE;
/*!40000 ALTER TABLE `china` DISABLE KEYS */;
INSERT INTO `china` VALUES (99,'潘衛國','pic/comm.jpg','針對國畫分割的影像技術'),(100,'田仙仙','pic/comm.jpg','AR');
/*!40000 ALTER TABLE `china` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data` (
  `year` char(30) DEFAULT NULL,
  `　name` char(70) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
INSERT INTO `data` VALUES ('tad',NULL);
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `year` int(11) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET big5 NOT NULL,
  `pic` text,
  `id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (2011,'老闆50大壽','pic/boss/DSC_0171.jpg',1),(2011,'老闆50大壽','pic/boss/DSC_0172.jpg',1),(2011,'老闆50大壽','pic/boss/DSC_0173.jpg',1),(2011,'老闆50大壽','pic/boss/DSC_0181.jpg',1),(2011,'老闆50大壽','pic/boss/DSC_0256.jpg',1),(2011,'老闆50大壽','pic/boss/IMG_9411.jpg',1),(2011,'老闆50大壽','pic/boss/IMG_9412.jpg',1),(2011,'老闆50大壽','pic/boss/IMG_9413.jpg',1),(2011,'老闆50大壽','pic/boss/IMG_9414.jpg',1),(2011,'老闆50大壽','pic/boss/IMG_9417.jpg',1),(2011,'老闆50大壽','pic/boss/IMG_9444.jpg',1),(2011,'老闆50大壽','pic/boss/IMG_9504.jpg',1),(2011,'花博出遊','pic/flower/IMG_2339.jpg',2),(2011,'花博出遊','pic/flower/IMG_2345.jpg',2),(2011,'花博出遊','pic/flower/IMG_2349.jpg',2),(2011,'花博出遊','pic/flower/IMG_2358.jpg',2),(2011,'花博出遊','pic/flower/IMG_2365.jpg',2),(2011,'花博出遊','pic/flower/IMG_2412.jpg',2),(2011,'花博出遊','pic/flower/IMG_2416.jpg',2),(2011,'花博出遊','pic/flower/IMG_2420.jpg',2),(2011,'花博出遊','pic/flower/IMG_2422.jpg',2),(2011,'花博出遊','pic/flower/IMG_2423.jpg',2),(2011,'花博出遊','pic/flower/IMG_2434.jpg',2),(2011,'花博出遊','pic/flower/IMG_2440.jpg',2),(2011,'花博出遊','pic/flower/IMG_2441.jpg',2),(2011,'花博出遊','pic/flower/IMG_2446.jpg',2),(2011,'花博出遊','pic/flower/IMG_2470.jpg',2),(2011,'花博出遊','pic/flower/IMG_2524.jpg',2),(2011,'花博出遊','pic/flower/IMG_2579.jpg',2),(2011,'花博出遊','pic/flower/IMG_2596.jpg',2),(2011,'花博出遊','pic/flower/IMG_2602.jpg',2),(2011,'花博出遊','pic/flower/IMG_2604.jpg',2),(2011,'花博出遊','pic/flower/IMG_2607.jpg',2),(2009,'屏東出遊','pic/Pinggtung/03400005.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400006.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400007.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400013.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400019.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400021.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400022.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400030.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400031.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03400034.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430001.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430005.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430007.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430008.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430009.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430011.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430017.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430021.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430024.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430029.jpg',6),(2009,'屏東出遊','pic/Pinggtung/03430036.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06635.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06666.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06672.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06673.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06695.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06706.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06714.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06734.jpg',6),(2009,'屏東出遊','pic/Pinggtung/DSC06748.jpg',6),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0600.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0601.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0602.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0603.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0606.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0611.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0613.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0615.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0621.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0629.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0631.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0632.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0639.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0648.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0652.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0663.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0664.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0665.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0666.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0673.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0675.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0677.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0692.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0697.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0703.jpg',7),(2009,'實驗室烤肉','pic/lab-BBQ/IMG_0704.jpg',7),(2009,'bowling_ball','pic/bowling_ball/03970002.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970003.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970004.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970005.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970006.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970007.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970008.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970009.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970010.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970011.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970012.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970013.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970014.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970015.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970016.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970017.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970018.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970019.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970020.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970022.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970023.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970024.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970025.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970026.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970027.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970028.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970029.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970030.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970031.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970032.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970033.jpg',8),(2009,'bowling_ball','pic/bowling_ball/03970034.jpg',8),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0512.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0513.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0515.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0517.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0518.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0525.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0530.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0532.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0545.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0556.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0564.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0570.jpg',4),(2010,'La-Fa聚餐','pic/La-Fa/IMG_0571.jpg',4),(2010,'饗','pic/eat/IMG_1053.jpg',5),(2010,'饗','pic/eat/IMG_1055.jpg',5),(2010,'饗','pic/eat/IMG_1056.jpg',5),(2010,'饗','pic/eat/IMG_1058.jpg',5),(2010,'饗','pic/eat/IMG_1059.jpg',5),(2010,'饗','pic/eat/IMG_1061.jpg',5),(2010,'饗','pic/eat/IMG_1062.jpg',5),(2010,'饗','pic/eat/IMG_1064.jpg',5),(2010,'饗','pic/eat/IMG_1065.jpg',5),(2010,'饗','pic/eat/IMG_1069.jpg',5),(2010,'饗','pic/eat/IMG_1071.jpg',5),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2211.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2215.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2227.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2263.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2270.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2301.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2559.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2628.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2629.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2644.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2701.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2704.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2710.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2714.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2728.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2778.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2820.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2825.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2925.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2965.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2966.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2968.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_2971.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_3003.jpg',3),(2010,'小琉球出遊','pic/Kaohsiung/IMG_3044.jpg',3),(2011,'綠島之旅','pic/green_island/DSC_0005.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0009.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0037.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0061.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0067.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0073.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0088.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0096.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0211.jpg',9),(2011,'綠島之旅','pic/green_island/DSC_0637.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1143.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1144.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1147.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1164.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1166.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1184.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1205.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1320.jpg',9),(2011,'綠島之旅','pic/green_island/IMG_1407.jpg',9);
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member0`
--

DROP TABLE IF EXISTS `member0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member0` (
  `year` int(11) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET big5 NOT NULL,
  `pic` text,
  `paper` text CHARACTER SET big5,
  `epaper` text CHARACTER SET big5,
  `study` text CHARACTER SET big5
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member0`
--

LOCK TABLES `member0` WRITE;
/*!40000 ALTER TABLE `member0` DISABLE KEYS */;
INSERT INTO `member0` VALUES (87,'黃嘉淵','pic/87_1.jpg','3G行動遠距醫療平台應用於生醫訊號傳輸之研究','A Telemedicine Platform for Biomedical Signal Transmission Based on 3G Mobile System','3G及B3G無線通訊系統、智慧型天線、無線多\r\n媒體通訊、藍芽及視訊、影像或生醫訊號處理壓縮及傳輸等'),(88,'顏恆麟','pic/88_1.jpg',' 基於小波變換的心電圖壓縮使用動態矢量量化：演算法與 FPGA實現','Wavelet-Based ECG Compression Using Dynamic Vector Quantization:Algorithms and FPGA Implementation','一、數位信號演算法開發方面\r\n\r\n　　1.視訊/影像/語音/生醫信號壓縮演算法開發 \r\n　　2.語音/影像辨識演算法及系統開發 \r\n　　3.數位電視系統中之MPEG2資料傳輸加密演算法開發 \r\n　　4.數位信號處理 \r\n　　5.多媒體無線通訊\r\n\r\n二、數位IC設計方面\r\n\r\n1.視訊/影像/語音/生醫信號壓縮之IC設計\r\n2.語音辨識演算法之IC設計'),(92,'陳世澤','pic/comm.jpg','以區域式隨選品質的編碼進行長序列醫學影像的壓縮','Region-Based Quality-on-Demand Coding for the Compression of Long Medical Image Sequences\r\n','影像、視訊及生醫訊號之辨識、驗證、加密、壓縮與傳輸演算法開發與實現'),(99,'尤里斯(外籍生)','pic/99_1.jpg','未定',' ',' '),(101,'陳瑞奇(外籍生)','pic/101_1.jpg','未定','','圖像處理，視頻編碼，3D視頻信號處理，視頻流，眼動追?或人的視覺注意和對等（P2P）計算機網絡的感知質量。');
/*!40000 ALTER TABLE `member0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member1`
--

DROP TABLE IF EXISTS `member1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member1` (
  `year` int(11) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET big5 NOT NULL,
  `pic` text,
  `study` text CHARACTER SET big5
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member1`
--

LOCK TABLES `member1` WRITE;
/*!40000 ALTER TABLE `member1` DISABLE KEYS */;
INSERT INTO `member1` VALUES (82,'沈保明','pic/82_1.gif','向量量化影像的通道錯誤保護'),(82,'黃煥旗','pic/comm.jpg','簡化的新認知機及其改良式二對一縮減架構'),(82,'劉國峰','pic/comm.jpg ','以TMS320C40實現快速影像漸進傳輸之平行演算法'),(83,'蔡東杰','pic/comm.jpg ','以小波轉換實現古典吉他樂曲音符之辨識'),(83,'林學毅','pic/83_1.gif ','交錯RS2錯誤更正碼及其在生醫訊號傳輸之應用'),(83,'曾裕仁','pic/83_2.gif ','結合小波轉換與多層級向量量化作醫學影像壓縮之漸進式傳輸'),(83,'蕭正恩','pic/83_3.jpg ','小波轉換與向量量化作心電圖資料壓縮'),(84,'黃基峰','pic/84_1.gif ','以VHDL實現離散小波轉換之FPGA設計'),(84,'呂瑞勝','pic/84_2.gif ','以VHDL實現交錯RS2錯誤更正碼之FPGA設計'),(85,'李正男','pic/comm.jpg ','以LMS自適性濾波器與小波分析抑制展頻通訊中的窄頻干擾'),(85,'簡明成','pic/85_1.gif','以小波轉換為基礎之多導程心電圖資料壓縮與辨識'),(85,'陳永昌','pic/85_2.gif','結合LUM濾波器與類神經網路之加強式邊緣檢測'),(85,'鐘文松','pic/85_3.gif','Gold-Washing自適性向量量化器之超大型積體電路架構'),(86,'黃嘉淵','pic/86_1.jpg','3G及B3G無線通訊系統、智慧型天線、無線多媒體通訊、藍芽及視訊、影像或生醫訊號處理壓縮及傳輸等。'),(86,'顏恆麟','pic/86_2.jpg','以碼簿擴增架構為基礎的自適性向量量化做影像壓縮'),(86,'藍仁宏','pic/86_3.jpg','以一維碼簿架構為基礎的自適性向量量化做近似週期信號的資料壓縮'),(87,'林家陽','pic/comm.jpg ','以模糊類神經網路做多導程心電圖病症分類辨識'),(87,'朱峰毅','pic/comm.jpg ','數位影像處理在監視系統上之應用'),(87,'陳光泰','pic/87_1.gif','向量量化器中碼簿冗餘性的探討及其應用'),(87,'莊瑞誠','pic/comm.jpg ','MPEG視訊之錯誤遮隱'),(88,'陳至明','pic/88_1.gif','一個以小波轉換與人體視覺系統為基礎的強健影像浮水印法'),(88,'易志達','pic/88_2.gif','先進體積型醫學影像壓縮系統之研究'),(88,'曾銘崧','pic/88_3.gif','熱感式指紋成像及其自動辨識法之研究'),(88,'林昶竹','pic/88_4.gif','熱感式指紋影像之特徵擷取'),(89,'李宗憲','pic/89_1.jpg','整合時間域與空間域之錯誤遮隱法在視訊傳輸上的應用'),(89,'林志龍','pic/89_2.jpg','生醫訊號小波壓縮之品質控制與加密演算法'),(89,'侯匡叡','pic/89_3.jpg','以非協調性機制解決藍芽傳輸遭受無線區域干擾的問題'),(89,'涂銘洲','pic/89_4.jpg','在藍芽環境中傳送Ｈ.263視訊資料之錯誤偵測'),(90,'高羽平','pic/90_1.jpg','無線通訊系統中生醫訊號傳輸之研究與實現(未完成)'),(90,'吳佳玲','pic/90_2.jpg','MIMO-OFDM系統應用於WLANs的效能分析(未完成)'),(90,'葉桂弘','pic/90_3.jpg','整合語音編碼與辨識之模組化設計及其FPGA實現FPGA實現'),(90,'徐祥豐','pic/90_4.jpg','一個用於MPEG-4視訊壓縮編碼之視訊物件分割法的評估準則'),(90,'張勝仁','pic/90_5.jpg','一個可增強車牌字元辨識效能的多重辨識器設計'),(91,'陳世澤','pic/91_1.jpg','影像、視訊及生醫訊號之辨識、驗證、加密、壓縮與傳輸演算法開發與實現'),(91,'馬鳴駿','pic/91_2.jpg','一個有地理資訊輔助的智慧型天線系統及其在無線用戶迴路中之應用'),(91,'黃泰祥','pic/91_3.jpg','具備人臉追蹤與辨識功能的一個智慧型數位監視系統'),(91,'許捷皓','pic/91_4.jpg','運用校正板與鏡頭光學參數的內視鏡影像校正法'),(91,'林宗翰','pic/91_5.jpg','一個整合心電圖壓縮與錯誤保護之機制及其在居家照護系統中藍芽傳輸之應用'),(91,'趙樹年','pic/91_6.jpg','以小波轉換以及統一的向量量化架構進行失真到無失真的心電圖壓縮'),(92,'李勝隆','pic/92_1.jpg','運用動態資訊與多重辨識器於道路行進車輛之車牌辨識系統'),(92,'吳倉志','pic/92_2.bmp','以二維轉換以及連續近似值編碼進行失真到無失真的多導程心電圖壓縮'),(92,'林書聖','pic/92_3.jpg','以一個隱藏式馬可夫模型羽模糊理論用於手寫筆跡心理學的文件處理與分析'),(92,'姚皓勻','pic/92_4.jpg','以SPIHT為基礎實現膠囊內試鏡影像無失真壓縮'),(93,'宋佩栩','pic/93_1.jpg',' 智慧型數位多攝影機監視系統'),(93,'李建國','pic/93_2.jpg','運用環場與PTZ攝影機在DSP板上實現移動物體之即時追蹤'),(93,'柯福生','pic/93_3.jpg','移動估測與JPEG-LS編碼進行無失真醫學影像壓縮'),(93,'蕭智弘','pic/93_4.bmp','在一個無線平台上傳送經壓縮之膠囊內視鏡影像的效能評估'),(93,'張鳳玲','pic/93_5.gif','一個可偵測多種異常膠囊內視鏡影像之 整合辨識系統'),(94,'黃漢強','pic/94_1.jpg','具備多重辨識器並以PDA為平台之車牌辨識系統'),(94,'石福僑','pic/94_2.jpg','ㄧ個使用環場攝影機及多重辨識器的跌倒偵測系統'),(94,'陳舒菁','pic/94_3.bmp','可復原感興趣區域之醫學影像浮水印技術'),(95,'黃逸昌','pic/95_1.jpg','一個使用環場攝影機在真實環境下的跌倒偵測系統'),(95,'簡呈羽','pic/95_2.jpg','以環場與PTZ攝影機進行移動物件即時追蹤之監控系統'),(95,'陳貞君','pic/95_3.jpg','一個使用移動歷史環場影像為基礎的跌倒行為偵測系統'),(95,'張中南','pic/95_4.jpg','一個在室內環境下使用環場攝影機與模型比較的多人追蹤系統'),(95,'陳英哲','pic/95_5.jpg','一個用於消化道中膠囊內視鏡定位的訊號處理技術'),(95,'丁安娜(外籍生)','pic/95_6.jpg','使用支持向量機偵測異常膠囊內視鏡影像'),(96,'鄭宇宏','pic/96_1.jpg','一個使用移動歷史紅外線影像為基礎的睡眠動作偵測系統'),(96,'廖宗彥','pic/96_2.jpg','一個使用單一攝影機進行走路姿勢分析的系統'),(96,'莊曜陽','pic/96_3.jpg','應用於醫學影像感興趣區域之可偵測竄改與復原的浮水印技術'),(96,'朱建興','pic/96_4.jpg','運用H.264預測模式做畫面內的錯誤隱藏'),(96,'葉紹康','pic/96_5.jpg','利用可復原浮水印技術於醫學影像竄改之偵測與修補'),(96,'魏世滿(外籍生)','pic/96_6.jpg','以SURF的方法為基礎使用多視角影像實現超解析度'),(96,'游華英(外籍生)','pic/96_7.jpg','用於偵測糖尿病的監督式學習法和特徵選取'),(97,'歐季祐','pic/97_1.jpg','以熱影像為基礎的睡眠品質分析系統'),(97,'李育仁','pic/97_2.jpg','使用兩台方向上垂直的攝影機進行步態分析的系統'),(97,'方恩霖(外籍生)','pic/97_3.jpg','使用局部二元圖樣和支持向量機進行膠囊內視鏡影像分類'),(98,'洪嘉澤','pic/98_1.jpg','智慧型數位多攝影機監視系統'),(98,'黃任宏','pic/98_2.jpg','環場攝影機應用'),(98,'陳瑞奇(外籍生)','pic/98_3.jpg','圖形識別'),(99,'洪明富','pic/comm.jpg','利用彩色影像邊緣與深度影像邊緣進行雙邊緣限制的3D深度圖修補'),(99,'葉昱慶','pic/99_11.jpg','以3D影像進行人體重量估測'),(99,'呂榮庭','pic/comm.jpg','（稍後更新）'),(100,'蕭為允','pic/100_1.jpg','機器人視覺'),(100,'林彥佑','pic/100_2.jpg','運用配戴式感應器所得到的數據做資料分析'),(100,'張倩瑜','pic/100_3.jpg','未定'),(100,'蔡文軒','pic/100_4.jpg','未定'),(101,'江知遠','pic/101_11.jpg','未定'),(101,'林哲?','pic/101_2.jpg','未定'),(101,'林源琦','pic/101_3.jpg','未定'),(103,'汪嘉偉',NULL,'未定'),(103,'顏義哲',NULL,'未定'),(103,'蔡東昇',NULL,'未定'),(104,'藍昱淳',NULL,'未定'),(104,'吳岱衛',NULL,'未定'),(104,'楊晨',NULL,'未定'),(104,'楊晨',NULL,'未定'),(102,'',NULL,NULL);
/*!40000 ALTER TABLE `member1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member2`
--

DROP TABLE IF EXISTS `member2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member2` (
  `year` int(11) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET big5 NOT NULL,
  `pic` text,
  `study` text CHARACTER SET big5
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member2`
--

LOCK TABLES `member2` WRITE;
/*!40000 ALTER TABLE `member2` DISABLE KEYS */;
INSERT INTO `member2` VALUES (92,'韋政宏','pic/comm.jpg','運用紅外線影像設計次世代遊戲主機中之光線槍系統'),(92,'葉本源','pic/comm.jpg','適用於台灣各種車輛之車牌辨識系統'),(93,'朱鏡宏','pic/comm.jpg','以JPEG-LS為基礎的感興趣區域編碼法實現膠囊內視鏡影像的無失真壓縮'),(93,'黃心和','pic/comm.jpg','針對H.264視訊編碼環境之自適性時間域錯誤遮隱處理順序的方法'),(94,'洪孟揚','pic/comm.jpg','汽車防撞系統'),(95,'余怡璇','pic/comm.jpg','未定'),(99,'陳建榮','pic/comm.jpg','未定');
/*!40000 ALTER TABLE `member2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member3`
--

DROP TABLE IF EXISTS `member3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member3` (
  `year` int(11) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET big5 NOT NULL,
  `pic` text,
  `man` text CHARACTER SET big5,
  `study` text CHARACTER SET big5
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member3`
--

LOCK TABLES `member3` WRITE;
/*!40000 ALTER TABLE `member3` DISABLE KEYS */;
INSERT INTO `member3` VALUES (94,'簡呈羽  陳貞君','','陳世澤','智慧型數位視訊儲存系統'),(94,'張香治','','張鳳玲 吳倉志','智慧型無線膠囊內試鏡影像自動辨識系統'),(94,'黃逸昌 連家良 許家榮','','李勝隆 黃漢強','運用邊緣及彩色資訊實現車牌定位及使用多重切割法進行字元切割'),(94,'李杰修 羅文偉','','林書聖 宋佩栩','以環場攝影機所擷取之影像進行人類跌倒之行為分析與偵測'),(95,'陳昱佑 莊曜陽','','陳舒菁','內嵌浮水印的影像編碼系統'),(95,'張博勇 洪于婷','','宋佩栩 石福僑','跌倒偵測系統 (軟體組)'),(95,'李宗翰','','李建國 石福僑 簡呈羽','跌倒偵測系統 (硬體組)'),(95,'顏允廷 廖宗彥','','黃漢強','一個可攜式智慧型PDA即時車牌辨識系統'),(96,'彭治平 林昶耀','','黃逸昌','一個具有錯誤回授控制之三維奈米加工系統'),(96,'余幸娟 蔡宏修','','簡呈羽','一個利用環場影像定位並搭載PTZ攝影機進行影像追蹤之可移動載具系統'),(96,'歐季祐 葉友綸','','陳貞君','以紅外線攝影機實現睡眠翻身監控'),(96,'蕭丞軒 林俊璋','','張中南','一個以RFID為基礎之資料庫管理系統'),(96,'邱博葳','','陳英哲','膠囊內視鏡定位之系統'),(97,'林世傑、黃璽祐','','鄭宇宏','眼部追蹤系統'),(98,'吳姿函、王婉珺','','洪嘉澤','即時視訊監控系統'),(98,'邱紹庭、邱少甫、許維倫','','黃任宏','校園緣化-智慧型模擬系統-數位影像評估系統'),(99,'汪炯廷',' ','洪明富 朱建興','利用H.264視訊模擬平台研發改良的錯誤攝影技術');
/*!40000 ALTER TABLE `member3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member4`
--

DROP TABLE IF EXISTS `member4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member4` (
  `year` int(11) unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET big5 NOT NULL,
  `now` text CHARACTER SET big5,
  `pic` text,
  `from` text CHARACTER SET big5,
  `habit` text CHARACTER SET big5
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member4`
--

LOCK TABLES `member4` WRITE;
/*!40000 ALTER TABLE `member4` DISABLE KEYS */;
INSERT INTO `member4` VALUES (1,'余嵐茵','已卸任','pic/comm.jpg','中原大學 企業管理學系','興趣：多的數不清\r\n專長：文書處理\r\n\r\n後記：偶爾陣陣撲鼻而來的咖啡香，最能表達出Mu-Cat融洽溫馨的味道，在這裡沒有嚴肅的研究氣氛，取而代之的是熱烈的討論和幽默的談笑。覺得很開心有機會來到這裡認識大家，也感謝老師和學長姐對我的照顧，讓我深深地感受到這裡的溫暖，留下了一段難忘的回憶....^__^'),(2,'楊如譽','已卸任','pic/2_1.jpg','中原大學 資訊管理學系','興趣：游泳、打羽球、看電影、聽音樂及閱讀\r\n\r\n專長：網頁視覺藝術設計、多媒體設計、系統分析'),(3,'盧郁雯','已卸任','pic/3_1.jpg','中原大學 企業管理學系','興趣：看電影   畫畫   勞作   品嚐美食  短期旅行\r\n　\r\n專長：文書資料處理'),(4,'宋佩栩','已卸任','pic/4_1.jpg','中原大學 電子系','興趣：上網，聽音樂，運動，旅行'),(5,'郭采瑋','已卸任','pic/5_1.jpg','中原大學 會計系','興趣：運動，逛街，聽音樂'),(6,'張香治','已卸任','pic/6_1.jpg','中原大學 電子系','興趣：玩電動、看電視、聽音樂'),(7,'洪晏儒','已卸任','pic/7_1.jpg','中原大學 會計系','興趣：'),(8,'黃逸昌','已卸任','pic/8_1.jpg','中原大學 電子系','興趣：打電動 看書 聽音樂'),(9,'方婉竹','已卸任','pic/9_1.jpg','中原大學 國貿系','興趣：看電影、睡覺'),(10,'黎念慈','已卸任','pic/10_1.jpg','中原大學 國貿系','興趣：打棒球、睡覺'),(11,'洪嘉澤','已卸任','pic/11_1.jpg','中原大學 電子系','興趣：游泳、玩電腦'),(12,'張倩瑜','現任','pic/12_1.jpg','中原大學 通訊學程','興趣:看日劇');
/*!40000 ALTER TABLE `member4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `year` char(30) DEFAULT NULL,
  `name` char(70) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES ('tad','kjhjio');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-26 13:08:57
