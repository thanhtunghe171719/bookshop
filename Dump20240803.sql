-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bookshop
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category_id` int unsigned NOT NULL,
  `publishing_house` varchar(255) NOT NULL,
  `published_year` int NOT NULL,
  `size` varchar(255) NOT NULL,
  `weight` varchar(255) NOT NULL,
  `summary` text,
  `price` decimal(8,2) NOT NULL,
  `rating` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `format` varchar(255) NOT NULL,
  `pages` int NOT NULL,
  PRIMARY KEY (`book_id`),
  KEY `books_category_id_foreign` (`category_id`),
  CONSTRAINT `books_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Tìm điểm khác nhau','Hồ Viện Viện','https://i.ibb.co/Sv0nwP8/8935244876895.jpg',1,'NXB Kim Đồng',2022,'26 x 21 cm','80','Một trong những trò giải đố “kinh điển” của các bạn nhỏ chính là trò chơi tìm điểm khác nhau! Với cuốn sách này, các em sẽ tha hồ rèn luyện khả năng quan sát của mình, bên cạnh đó còn có thể thi tài cùng các bạn bè xem ai tìm điểm khác nhau nhanh hơn nữa đấy!',45.00,0,20,0,'2024-06-24 16:26:34','2024-07-26 17:22:27','Bìa Mềm',100),(2,'Kỹ Năng Sống Đầu Đời Cho Bé - Kỹ Năng Giao Tiếp Ngoài Xã Hội','Thẩm Viên, Khương Tĩnh Á','https://i.ibb.co/KzXnNZK/image-237178.jpg',1,'NXB Thanh Niên',2021,'22.5 x 20.5 x 0.3','100','Kỹ năng sống đầu đời cho bé là một bộ sách vô cùng bổ ích với nội dung được biên soạn công phu, tỉ mỉ, giúp các bạn bồi dưỡng thói quen tốt, biết cách ứng xử khi phải đối mặt với những tình huống khác nhau trong cuộc sống',25.00,0,20,29,'2024-06-24 16:26:34','2024-06-28 07:49:56','Bìa Mềm',100),(3,'Kỹ Năng Sống Đầu Đời Cho Bé - Kiến Thức Bảo Vệ Bản Thân','Thẩm Viên, Khương Tĩnh Á','https://i.ibb.co/PmzXq93/image-237180.jpg',1,'NXB Thanh Niên',2021,'22.5 x 20.5 x 0.3','100','Kỹ năng sống đầu đời cho bé là một bộ sách vô cùng bổ ích với nội dung được biên soạn công phu, tỉ mỉ, giúp các bạn bồi dưỡng thói quen tốt, biết cách ứng xử khi phải đối mặt với những tình huống khác nhau trong cuộc sống.',25.00,0,20,80,'2024-06-24 16:26:34','2024-06-25 09:17:55','Bìa Mềm',100),(6,'Cùng Con Nuôi Dưỡng Tính Cách Tốt - Con Muốn Nuôi Khỉ','Diêm Lị, Khổng Xảo Lệ','https://i.ibb.co/GMtskBX/8935212366182.jpg',1,'NXB Thanh Niên',2023,'25 x 18.5 x 0.2','100','Một hạt giống cần mảnh đất màu mỡ để có thể phát triển thành cái cây xanh tươi, tương tự vậy, trẻ em cũng cần một môi trường giáo dục lành mạnh để hình thành nên những phẩm chất tốt, từ đó gặt hái thành công trong tương lai. Vậy chúng ta nên làm gì để giúp trẻ bồi đắp những phẩm chất tốt ngay từ khi còn nhỏ?\r\nBộ sách Cùng con nuôi dưỡng tính cách tốt chính là một công cụ cực kỳ hữu ích giúp làm được điều này. Thông qua những tình huống quen thuộc thường gặp trong cuộc sống, bộ sách dạy trẻ cách ứng xử với bạn bè, biết lắng nghe ý kiến và tự tin bày tỏ quan điểm, biết nhường nhịn, chia sẻ và không ngừng sáng tạo. Với tranh minh họa đáng yêu cùng cách kể chuyện gần gũi, tin rằng bộ sách sẽ là người bạn đồng hành thú vị của các bạn nhỏ, đồng thời là những gợi ý bổ ích cho cha mẹ trong quá trình nuôi dạy con trưởng thành',45.00,0,20,99,'2024-06-24 16:26:34','2024-06-25 09:18:48','Bìa Mềm',100),(7,'365 Truyện Kể Trước Giờ Đi Ngủ - Những Câu Chuyện Phát Triển Chỉ Số Tình Cảm EQ','Ngọc Linh','https://i.ibb.co/8dzBdL8/8935212341134-1.jpg',1,'NXB Thế Giới',2018,'13 x 20.5','300','Bộ 365 chuyện kể trước giờ đi ngủ gồm hai tập: Những câu chuyện phát triển chỉ số thông minh IQ và Những câu chuyện phát triển chỉ số tình cảm EQ.\r\nMỗi buổi tối trước giờ đi ngủ, các bậc cha mẹ đừng quên đọc truyện cho con em mình. Những câu chuyện có nội dung hay, nhân vật lại vô cùng gần gũi, cuối mỗi truyện lại có mục. “Bài học nhỏ” - nhẹ nhàng mà sâu sắc chắc chắn sẽ giúp các em trở nên thông minh hơn, lương thiện hơn, biết quan tâm, yêu thương mọi người, yêu cuộc sống và có sức sáng tạo. Mỗi ngày cha mẹ cùng trẻ đọc một câu chuyện, những điều tiếp thu được sẽ là tài sản tinh thần to lớn giúp ích cho các em trong suốt cuộc đời.',78.00,0,30,0,'2024-06-24 16:26:34','2024-06-25 09:19:02','Bìa Mềm',100),(8,'168 Câu Chuyện Hay Nhất - Giúp Hình Thành Nhân Cách - Cậu Bé Và Cỏ Tâm An (2018)','Ngọc Linh','https://i.ibb.co/8P467x2/image-241699.jpg',1,'NXB Thế Giới',2018,'20.5 x 13','320','\"Một buổi sáng, khi cậu bước ra vườn học, thấy cây cối hoa cỏ ở đây đều héo úa ảm đạm... Tuy nhiên cậu thấy có một loài cỏ vẫn mọc lên xanh tốt, cậu bé ngạc nhiên hỏi nó vì sao...\"\r\nCâu chuyện sẽ tiếp diễn ra sao? Mời bạn cùng đón đọc 168 Câu Chuyện Kỹ Năng Sống Cho Học Sinh- Giúp hình thành nhân cách - Cậu bé và cỏ tâm an',50.00,0,20,90,'2024-06-24 16:26:34','2024-06-25 09:19:12','Bìa Mềm',100),(9,'10 Vạn Câu Hỏi Vì Sao - Khám Phá Thế Giới Động Vật - Chạy Trên Mặt Đất 1 (Tái Bản 2018)','Tôn Nguyên Vĩ','https://i.ibb.co/k43mY29/8935212340502.jpg',1,'NXB Thanh Niên',2018,'14.5 x 20.5','150','Tuổi thơ là khoảng thời gian đẹp nhất trong cuộc đời mỗi người. Ở lứa tuổi này luôn tràn đầy hy vọng, ước mơ, cùng những ngây thơ trong sáng buổi ban đầu. Đứng trước thế giới với bao điều kỳ diệu, mang trong mình sự tò mò, khát vọng tìm hiểu, câu nói thường thấy nhất ở trẻ là “Vì sao?”. Để có thể trả lời chính xác câu hỏi của trẻ, không phải là việc đơn giản. Các nghiên cứu cho thấy, sự phát triển của bộ não trẻ diễn ra nhanh nhất vào tuổi 13 trở về trước, là một phụ huynh, khi không mang lại cho trẻ cơ hội suy nghĩ, tìm hiểu, có thể bạn sẽ phải rất ân hận! Thế giới ngày nay phát triển nhanh chóng, kho tàng kiến thức là vô hạn, luôn được đổi mới với tốc độ chóng mặt.\r\nCũng xuất phát từ những suy nghĩ trên, bộ sách  Mười vạn câu hỏi vì sao mang lại những câu trả lời cho các em theo từng chủ đề mà các em ham tìm hiểu như: vũ trụ, trái đất, con người, thế giới tự nhiên, xã hội, khoa học… Sách sử dụng ngôn ngữ dễ hiểu, kết hợp những hình ảnh minh họa sinh động, sẽ đem đến cho các em những kiến thức cơ bản, chứa đựng nội dung phong phú, khái quát rộng rãi kiến thức xưa nay, giúp các em vui vẻ, thoải mái, tự tin tiến lên trên con đường thành công tương lai.',50.00,0,30,36,'2024-06-24 16:26:34','2024-06-25 09:19:29','Bìa Mềm',100),(10,'Giáo Dục Giới Tính Và Nhân Cách Dành Cho Bé Gái - Tớ Dũng Cảm Nói Không Với Kẻ Xấu!','	Trung tâm Sáng tạo Thiếu nhi Mộc Đầu Nhân','https://i.ibb.co/fXZBRyx/giao-duc-gioi-tinh-va-nhan-cach-danh-cho-be-gai-to-dung-cam-noi-khong-voi-ke-xau-3-2019-08-10-09-30.jpg',1,'NXB Hà Nội',2018,'20.5 x 25.5','80','Giáo dục giới tính và nhân cách dành cho bé gái là bộ sách rất bổ ích, giúp các bé gái có hành vi, ngôn ngữ, cử chỉ đúng mực, biết đoàn kết yêu thương chia sẻ với mọi người. Đặc biệt, thông qua bộ sách này, các bé gái còn học được cách bảo vệ cơ thể mình, chống lại các hành vi xâm hại cơ thể, bảo vệ bản thân khi gặp kẻ xấu.\r\nBộ sách là món quà nhỏ tuyệt vời mà các bố mẹ và thầy cô gửi tặng các con, giúp các con cư xử đúng mực, thông minh trong mọi tình huống, mọi hoàn cảnh.',32.00,0,20,99,'2024-06-24 16:26:34','2024-06-25 09:19:38','Bìa Mềm',100),(11,'Góc Nhỏ Có Nắng','Little Rainbow','https://i.ibb.co/c1RWV6S/b-a-in-g-c-nh-c-n-ng.jpg',2,'NXB Thanh Niên',2024,'26.5 x 19 x 0.3','100','- Với 30 chủ đề tô màu phong phú đa dạng, mỗi bức tranh như là một lời thủ thỉ tâm tình gửi đến bạn\r\n- Thư giãn và chữa lành: Với những hình ảnh đẹp mắt và đơn giản, tô màu sẽ là một phương pháp hiệu quả giúp bạn chữa lành và nuôi dưỡng tâm hồn\r\n- Khám phá sự sáng tạo: Bạn đừng ngại vẽ thêm, tô thêm màu sắc để thể hiện cảm xúc của riêng mình\r\n- Chất liệu giấy dày, mịn, đẹp sẽ đem đến cho bạn trải nghiệm tô màu thú vị.',50.00,0,20,100,'2024-06-24 16:26:34','2024-06-25 09:19:47','Bìa Mềm',100),(12,'999 Lá Thư Gửi Cho Chính Mình - Tô Màu Cuộc Sống','Miêu Công Tử, Hà Trang (Tahtag)','https://i.ibb.co/KbJVWH5/999-l-th-g-i-cho-ch-nh-m-nh-t-m-u-cu-c-s-ng.jpg',2,'NXB Thanh Niên',2023,'24 x 19 x 0.5','120','Chúng mình đều biết những sắc màu của cuộc sống đều bắt nguồn từ những điều bình dị và thường nhật nhất xung quanh mà ta vẫn thường tiếp xúc mỗi ngày: như bầu trời xanh ngát, như áng mây trắng tinh, như ánh nắng phủ vàng lên những đóa hoa hồng ngọt… Thế nhưng nhịp sống hàng ngày của chúng ta luôn trôi qua trong sự vội vã, những bộn bề hóa thành “bộ lọc” biến bức tranh cuộc sống muôn màu kia trở nên ảm đạm và phủ đầy âu lo, khiến ta dường như quên lãng việc phải khám phá ra những vẻ đẹp thuần khiết của vạn vật, quên mất rằng thế giới mà chúng ta đang sống cũng có những điều nhỏ nhặt đáng quý và đáng yêu biết nhường nào.\r\nHiểu thấu được điều đó, “999 lá thư gửi cho chính mình” – Phiên bản “Tô màu cuộc sống” chính thức ra đời với sứ mệnh mang đến cho cuộc sống của bạn thêm nhiều điều hạnh phúc ngọt ngào thông qua những lá thư đầy ý nghĩa kết hợp cùng những bức tranh sinh động nhất đợi bạn đặt bút tô điểm. Đến với cuốn sách này, chúng mình mong rằng bạn có thể tự tay vẽ nên những giấc mơ của riêng bạn, những giây phút thăng hoa trong cuộc sống, có thể tô điểm thêm cho những khoảnh khắc đời thường trở nên rực rỡ và muôn phần lộng lẫy hơn. Mong rằng những gam màu ấm áp và tươi vui do chính tay bạn tô vẽ có thể xoa dịu và chữa lành những bất an bên trong bạn, để thế giới xung quanh bạn trở nên muôn màu muôn vẻ, mang không khí tươi trẻ và nhiệt huyết ngập tràn, đón ánh ban mai và vui sống!',99.00,0,20,100,'2024-06-24 16:26:34','2024-06-25 09:20:00','Bìa Mềm',100),(13,'Tuổi Trẻ Đáng Giá Bao Nhiêu','Rosie Nguyễn','https://cdn0.fahasa.com/media/catalog/product/i/m/image_239651.jpg',6,'NXB Trẻ',2018,'13.5 x 20.5 cm','450g','Cuốn sách chia sẻ trải nghiệm, suy nghĩ và những bài học về cuộc sống và định hướng sự nghiệp của tác giả Rosie Nguyễn',90.00,0,10,50,'2024-06-24 16:26:34','2024-06-25 09:20:14','Bìa Mềm',100),(14,'Tôi Thấy Hoa Vàng Trên Cỏ Xanh','Nguyễn Nhật Ánh','https://cdn0.fahasa.com/media/catalog/product/n/n/nna-hvtcx.jpg',2,'NXB Trẻ',2006,'13 x 20.5 cm','350g','Tiểu thuyết phản ánh những nét văn hóa đặc trưng của vùng quê Nam Bộ, kể về cuộc sống của những đứa trẻ nghèo nhưng rất hồn nhiên và lạc quan',150.00,0,0,29,'2024-06-24 16:26:34','2024-06-25 09:21:23','Bìa Mềm',100),(15,'Đắc Nhân Tâm','Dale Carnegie','https://cdn0.fahasa.com/media/catalog/product/b/_/b_a-1---_c-nh_n-t_m.jpg',6,'NXB Tổng hợp TP.HCM',2019,'14 x 20.5 cm','500g','Cuốn sách hướng dẫn cách phát triển các mối quan hệ cá nhân và thành công trong cuộc sống',86.00,0,20,80,'2024-06-24 16:26:34','2024-06-25 09:21:36','Bìa Mềm',100),(16,'Lịch Sử Tư Tưởng Triết Học Phương Tây','Bertrand Russell','https://cdn0.fahasa.com/media/catalog/product/8/9/8935280501492.jpg',4,'NXB Tri Thức',2017,'16 x 24 cm','850g','Công trình nghiên cứu toàn diện về lịch sử triết học phương Tây từ thời Hy Lạp cổ đại đến thế kỷ XX',635.00,0,0,20,'2024-06-24 16:26:34','2024-06-25 09:21:48','Bìa Mềm',100),(17,'Tiếng Anh Giao Tiếp Cơ Bản','Mark Williams','https://cdn0.fahasa.com/media/catalog/product/9/7/9786045856697.jpg',5,'NXB Giáo Dục',2020,'14 x 20 cm','400g','Giáo trình tiếng Anh giao tiếp dành cho người mới bắt đầu, kèm theo các bài tập thực hành',90.00,0,15,100,'2024-06-24 16:26:34','2024-06-25 09:21:59','Bìa Mềm',100),(23,'ggghhh','ggghh','https://cdn0.fahasa.com/media/catalog/product/8/9/8935235224353_1.jpg',5,'NXB Thanh Niên',2016,'25x23','80','ddddd',20.00,0,20,200,'2024-07-09 02:38:34','2024-07-09 02:38:33','Bìa Cứng',200);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `promotion_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `note` varchar(255) NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `cart_user_id_foreign` (`user_id`),
  KEY `cart_promotion_id_foreign` (`promotion_id`),
  CONSTRAINT `cart_promotion_id_foreign` FOREIGN KEY (`promotion_id`) REFERENCES `promotions` (`promotion_id`),
  CONSTRAINT `cart_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,9,NULL,'2024-06-24 16:28:42','2024-06-24 16:28:42','Đã Insert.'),(2,10,NULL,'2024-06-24 18:25:32','2024-06-24 18:25:32','Đã Insert.'),(3,14,NULL,'2024-06-24 18:29:42','2024-06-24 18:29:42','Đã Insert.'),(4,18,NULL,'2024-06-24 18:54:58','2024-06-24 18:54:58','Đã Insert.'),(5,23,NULL,'2024-06-25 07:25:29','2024-06-25 07:25:29','Đã Insert.'),(6,24,NULL,'2024-06-25 07:27:00','2024-06-25 07:27:00','Đã Insert.'),(8,96,NULL,'2024-07-14 10:06:31','2024-07-14 10:06:31','Đã Insert.'),(9,98,NULL,'2024-07-14 10:09:07','2024-07-14 10:09:07','Đã Insert.'),(10,99,NULL,'2024-07-14 10:13:43','2024-07-14 10:13:43','Đã Insert.'),(11,1,NULL,'2024-07-21 14:41:34','2024-07-21 14:41:34','Please deliver before 5 PM.'),(12,2,NULL,'2024-07-21 14:41:34','2024-07-21 14:41:34','Need the items urgently.'),(13,3,NULL,'2024-07-21 14:41:34','2024-07-21 14:41:34','Standard delivery option selected.'),(14,1,NULL,'2024-07-21 14:42:03','2024-07-21 14:42:03','Please deliver before 5 PM.'),(15,2,NULL,'2024-07-21 14:42:03','2024-07-21 14:42:03','Need the items urgently.'),(16,3,NULL,'2024-07-21 14:42:03','2024-07-21 14:42:03','Standard delivery option selected.'),(17,1,NULL,'2024-07-21 14:44:27','2024-07-21 14:44:27','Please deliver before 5 PM.'),(18,2,NULL,'2024-07-21 14:44:27','2024-07-21 14:44:27','Need the items urgently.'),(19,3,NULL,'2024-07-21 14:44:27','2024-07-21 14:44:27','Standard delivery option selected.'),(20,4,NULL,'2024-07-21 14:44:27','2024-07-21 14:44:27','Successfull'),(21,1,NULL,'2024-07-21 14:45:42','2024-07-21 14:45:42','Please deliver before 5 PM.'),(22,2,NULL,'2024-07-21 14:45:42','2024-07-21 14:45:42','Need the items urgently.'),(23,3,NULL,'2024-07-21 14:45:42','2024-07-21 14:45:42','Standard delivery option selected.'),(24,4,NULL,'2024-07-21 14:45:42','2024-07-21 14:45:42','Successfull'),(25,102,NULL,'2024-07-26 16:56:17','2024-07-26 16:56:17','Đã Insert.'),(26,103,NULL,'2024-07-26 18:16:04','2024-07-26 18:16:04','Đã Insert.'),(27,104,NULL,'2024-07-26 18:19:49','2024-07-26 18:19:49','Đã Insert.'),(28,105,NULL,'2024-07-26 18:20:54','2024-07-26 18:20:54','Đã Insert.'),(29,106,NULL,'2024-07-27 08:23:50','2024-07-27 08:23:50','Đã Insert.'),(30,108,NULL,'2024-08-01 08:28:58','2024-08-01 08:28:58','Đã Insert.'),(31,112,NULL,'2024-08-01 21:15:15','2024-08-01 21:15:15','Đã Insert.'),(32,113,NULL,'2024-08-01 21:29:53','2024-08-01 21:29:53','Đã Insert.'),(33,115,NULL,'2024-08-01 21:54:23','2024-08-01 21:54:23','Đã Insert.'),(34,116,NULL,'2024-08-01 22:01:54','2024-08-01 22:01:54','Đã Insert.'),(35,117,NULL,'2024-08-01 22:02:30','2024-08-01 22:02:30','Đã Insert.'),(36,118,NULL,'2024-08-01 22:03:05','2024-08-01 22:03:05','Đã Insert.');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `cart_item_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL,
  `book_id` int unsigned DEFAULT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  KEY `cart_items_cart_id_foreign` (`cart_id`),
  KEY `cart_items_book_id_foreign` (`book_id`),
  CONSTRAINT `cart_items_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (18,5,9,2),(19,6,9,2),(20,6,1,2),(68,25,7,1),(69,25,9,2),(70,25,2,1),(147,29,3,1);
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Sách Thiếu Nhi','https://cdn0.fahasa.com/media/wysiwyg/Duy-VHDT/Danh-muc-san-pham/8935244874389.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34'),(2,'Sách Văn Học','https://cdn0.fahasa.com/media/catalog/product/i/m/image_195509_1_41170.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34'),(3,'Sách Kinh Tế','https://cdn0.fahasa.com/media/catalog/product/b/_/b_a-1_5_14.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34'),(4,'Sách Tiểu Sử-Hồi Ký','https://cdn0.fahasa.com/media/catalog/product/8/9/8935235241015.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34'),(5,'Sách Ngoại Ngữ','https://cdn0.fahasa.com/media/catalog/product/8/9/8935246917176.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34'),(6,'Sách Tâm Lý-Kỹ Năng Sống','https://cdn0.fahasa.com/media/catalog/product/9/7/9786043440287.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34'),(7,'Sách Giáo Khoa-Tham Khảo','https://cdn0.fahasa.com/media/catalog/product/z/3/z3543944350145_ec66f22a86880daac11b61bc47e36387_1_1.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34'),(8,'Truyện Tranh','https://cdn0.fahasa.com/media/catalog/product/b/a/bach-tuyet-toc-do_bia_tap-14.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34'),(9,'Nuôi dạy con','https://cdn0.fahasa.com/media/catalog/product/9/7/9780241439425.jpg','2024-06-24 16:26:34','2024-06-24 16:26:34');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_item_id` int unsigned NOT NULL,
  `rating` int DEFAULT NULL COMMENT 'CHECK (rating >= 1 AND rating <= 5)',
  `comment` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Show','Hide') NOT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `feedback_order_item_id_foreign` (`order_item_id`),
  CONSTRAINT `feedback_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,8,5,'ban dep trai nhu cut','2024-07-26 17:08:13','Show'),(2,139,5,'xịn','2024-08-01 22:10:28','Show');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int unsigned NOT NULL,
  `book_id` int unsigned NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,2,1,1),(2,6,9,2),(3,6,1,1),(4,6,5,1),(5,8,2,1),(6,9,1,98),(7,10,1,1),(8,11,2,1),(9,12,2,98),(10,13,2,1),(11,13,5,99),(13,14,5,1),(14,14,9,98),(16,15,9,2),(17,15,1,2),(18,17,1,51),(19,18,9,1),(20,19,2,1),(21,19,7,99),(22,20,9,1),(23,24,14,1),(45,36,7,1),(46,37,10,1),(47,38,2,2),(48,38,1,1),(50,39,2,1),(51,39,3,1),(53,40,7,0),(54,40,8,1),(55,40,6,1),(56,41,2,1),(57,41,3,1),(59,42,1,1),(60,43,2,1),(61,44,2,1),(62,45,1,5),(63,46,6,2),(64,46,8,1),(66,47,2,20),(67,48,2,10),(68,48,3,20),(70,49,2,5),(71,49,8,5),(72,50,3,1),(73,51,1,1),(74,52,2,1),(75,52,3,1),(77,53,1,1),(78,54,3,1),(79,55,7,0),(80,55,2,1),(82,56,2,5),(83,57,2,1),(84,58,2,1),(85,58,3,1),(87,62,3,1),(88,62,1,1),(90,63,8,1),(91,64,6,1),(92,65,2,1),(93,66,2,2),(94,67,3,2),(95,67,2,10),(97,68,8,2),(98,70,2,1),(99,70,3,1),(101,71,1,1),(102,71,6,1),(104,72,3,3),(105,72,8,1),(106,72,6,1),(107,73,3,1),(108,74,1,3),(109,75,1,3),(110,75,2,1),(111,75,8,98),(112,76,2,1),(113,77,3,1),(114,78,8,1),(115,79,6,1),(116,79,3,4),(118,80,8,4),(119,81,1,3),(120,82,1,3),(121,83,3,2),(122,84,6,1),(123,84,2,1),(125,85,3,2),(126,86,3,4),(127,87,8,3),(128,88,2,5),(129,89,2,5),(130,90,2,1),(131,90,3,1),(133,91,2,1),(134,91,3,1),(136,92,2,1),(137,92,3,1),(139,93,3,1),(140,94,6,1);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `order_status_id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_status` varchar(255) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'Pending','2024-06-24 16:26:34','2024-06-24 16:26:34'),(2,'Processing','2024-06-24 16:26:34','2024-06-24 16:26:34'),(3,'Shipped','2024-06-24 16:26:34','2024-06-24 16:26:34'),(4,'Delivered','2024-06-24 16:26:34','2024-06-24 16:26:34'),(5,'Canceled','2024-07-19 06:00:07','2024-07-19 06:00:07');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `order_status_id` int unsigned NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_cart_id_foreign` (`cart_id`),
  KEY `orders_order_status_id_foreign` (`order_status_id`),
  CONSTRAINT `orders_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  CONSTRAINT `orders_order_status_id_foreign` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`order_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (2,1,45.00,4,'2024-04-24 16:29:03','2024-06-24 16:29:03',NULL,NULL),(6,1,170.00,3,'2024-06-17 18:38:34','2024-07-26 18:30:05',NULL,NULL),(8,1,25.00,4,'2024-03-26 18:54:07','2024-06-26 18:54:07',NULL,NULL),(9,1,4410.00,1,'2024-06-12 05:34:37','2024-06-25 05:34:37',NULL,NULL),(10,1,4410.00,1,'2024-03-29 05:35:39','2024-07-26 18:30:15',NULL,NULL),(11,1,25.00,4,'2024-01-16 05:43:32','2024-06-25 05:43:32',NULL,NULL),(12,1,2450.00,3,'2024-06-24 05:43:56','2024-06-25 05:43:56',NULL,NULL),(13,1,2475.00,2,'2024-06-17 05:46:43','2024-06-25 05:46:43',NULL,NULL),(14,1,4900.00,1,'2024-07-18 05:48:38','2024-06-25 05:48:38',NULL,NULL),(15,1,142.00,4,'2024-05-11 10:19:59','2024-06-25 10:19:59',NULL,NULL),(16,1,142.00,4,'2024-02-26 10:19:59','2024-06-25 10:19:59',NULL,NULL),(17,1,1836.00,1,'2024-04-23 06:41:11','2024-06-28 06:41:11',NULL,NULL),(18,1,35.00,5,'2024-06-25 06:42:40','2024-06-28 06:42:40',NULL,NULL),(19,1,5425.40,5,'2024-07-13 05:59:23','2024-07-19 05:59:23',NULL,NULL),(20,1,35.00,1,'2024-07-21 09:09:26','2024-07-21 09:09:26',NULL,NULL),(21,1,35.00,1,'2024-07-21 09:09:48','2024-07-21 09:09:48',NULL,NULL),(22,1,35.00,1,'2024-07-21 09:09:54','2024-07-21 09:09:54',NULL,NULL),(24,1,150.00,1,'2024-07-21 09:45:38','2024-07-21 09:45:38',NULL,NULL),(25,1,150.00,1,'2024-07-21 09:45:48','2024-07-21 09:45:48',NULL,NULL),(26,1,150.00,4,'2024-07-21 14:44:27','2024-07-21 14:44:27',NULL,NULL),(27,2,200.50,1,'2024-07-21 14:44:27','2024-07-21 14:44:27',NULL,NULL),(28,3,75.25,4,'2024-07-21 14:44:27','2024-07-21 14:44:27',NULL,NULL),(29,2,120.75,1,'2024-07-21 14:44:27','2024-07-21 14:44:27',NULL,NULL),(30,3,90.00,1,'2024-07-21 14:44:27','2024-07-21 14:44:27',NULL,NULL),(31,1,150.00,1,'2024-07-21 14:45:42','2024-07-21 14:45:42',NULL,NULL),(32,2,200.50,1,'2024-07-21 14:45:42','2024-07-21 14:45:42',NULL,NULL),(33,3,75.25,4,'2024-07-21 14:45:42','2024-07-21 14:45:42',NULL,NULL),(34,2,120.75,1,'2024-07-21 14:45:42','2024-07-21 14:45:42',NULL,NULL),(35,3,90.00,4,'2024-07-21 14:45:42','2024-07-21 14:45:42',NULL,NULL),(36,1,54.60,5,'2024-07-26 17:54:26','2024-07-26 17:54:26','Hà Nội',NULL),(37,1,25.60,1,'2024-07-26 17:58:47','2024-07-26 17:58:47','Hà Giang',NULL),(38,1,76.00,5,'2024-07-27 02:10:43','2024-07-27 02:10:43','Hà Nội',NULL),(39,29,40.00,5,'2024-07-27 08:24:18','2024-07-27 08:24:18','Bắc Từ Liêm',NULL),(40,29,76.00,5,'2024-07-27 08:25:00','2024-07-27 08:25:00','Cầu Giấy',NULL),(41,29,40.00,5,'2024-07-27 08:54:21','2024-07-27 08:54:21','Bắc Từ Liêm',NULL),(42,29,36.00,5,'2024-07-27 09:36:01','2024-07-27 09:36:01','Bắc Từ Liêm',NULL),(43,29,20.00,5,'2024-07-27 09:48:57','2024-07-27 09:48:57','Bắc Từ Liêm',NULL),(44,29,20.00,5,'2024-07-27 12:34:42','2024-07-27 12:34:42','Bắc Từ Liêm',NULL),(45,29,180.00,5,'2024-07-27 13:20:43','2024-07-27 13:20:43','Bắc Từ Liêm',NULL),(46,29,112.00,5,'2024-07-27 13:29:01','2024-07-27 13:29:01','Bắc Từ Liêm',NULL),(47,29,400.00,5,'2024-07-27 13:36:28','2024-07-27 13:36:28','Bắc Từ Liêm',NULL),(48,29,600.00,5,'2024-07-27 13:37:07','2024-07-27 13:37:07','Bắc Từ Liêm',NULL),(49,29,300.00,5,'2024-07-27 14:22:43','2024-07-27 14:22:43','Bắc Từ Liêm',NULL),(50,29,20.00,5,'2024-07-28 07:48:03','2024-07-28 07:48:03','Bắc Từ Liêm',NULL),(51,29,36.00,5,'2024-07-28 07:48:46','2024-07-28 07:48:46','Bắc Từ Liêm',NULL),(52,29,40.00,5,'2024-07-28 11:53:17','2024-07-28 11:53:17','Bắc Từ Liêm',NULL),(53,29,36.00,5,'2024-07-28 11:53:41','2024-07-28 11:53:41','Bắc Từ Liêm',NULL),(54,29,20.00,5,'2024-07-28 11:53:57','2024-07-28 11:53:57','Bắc Từ Liêm',NULL),(55,29,20.00,1,'2024-07-28 13:10:59','2024-07-28 13:10:59','Bắc Từ Liêm',NULL),(56,29,100.00,5,'2024-07-28 14:36:50','2024-07-28 14:36:50','Bắc Từ Liêm',NULL),(57,29,20.00,1,'2024-07-28 14:47:49','2024-07-28 14:47:49','Bắc Từ Liêm',NULL),(58,29,40.00,5,'2024-07-28 15:52:23','2024-07-28 15:52:23','Bắc Từ Liêm',NULL),(59,1,60000.00,1,'2024-07-29 01:16:41','2024-07-29 01:16:41','Tây Hồ',NULL),(60,29,60.00,1,'2024-07-29 01:18:55','2024-07-29 01:18:55','Tây Hồ',NULL),(61,29,60.00,1,'2024-07-29 01:19:42','2024-07-29 01:19:42','Bắc Từ Liêm',NULL),(62,29,56.00,1,'2024-07-29 01:22:30','2024-07-29 01:22:30','Bắc Từ Liêm',NULL),(63,29,40.00,1,'2024-07-29 01:30:45','2024-07-29 01:30:45','Bắc Từ Liêm',NULL),(64,29,36.00,5,'2024-07-29 01:33:40','2024-07-29 01:33:40','Bắc Từ Liêm',NULL),(65,29,20.00,1,'2024-07-29 02:59:33','2024-07-29 02:59:33','Bắc Từ Liêm',NULL),(66,30,40.00,2,'2024-08-01 08:31:44','2024-08-01 08:39:42','Bạch Mai',NULL),(67,29,240.00,3,'2024-08-01 08:34:38','2024-08-01 08:48:20','Bắc Từ Liêm',NULL),(68,29,80.00,1,'2024-08-01 08:41:51','2024-08-01 08:41:51','Cầu Giấy',NULL),(69,29,200.00,1,'2024-08-01 09:26:26','2024-08-01 09:26:26','Minh Khai','0828734612'),(70,29,40.00,1,'2024-08-01 09:27:11','2024-08-01 09:27:11','Cầu Giấy','0827365482'),(71,29,72.00,1,'2024-08-01 09:47:15','2024-08-01 09:47:15','Cầu Giấy','0999999999'),(72,29,136.00,1,'2024-08-01 09:59:48','2024-08-01 09:59:48','Mai Dịch','0132465787'),(73,29,20.00,5,'2024-08-01 10:00:20','2024-08-01 10:00:20','Hoàng Mai','0827365482'),(74,29,108.00,5,'2024-08-01 10:01:05','2024-08-01 10:01:05','Cầu Giấy','0132465787'),(75,29,4048.00,5,'2024-08-01 10:27:21','2024-08-01 10:27:21','Hoàng Mai','0902347162'),(76,29,20.00,3,'2024-08-01 10:29:02','2024-08-01 10:43:37','Hoàng Mai','0902347162'),(77,29,20.00,1,'2024-08-01 15:49:52','2024-08-01 15:49:52','Bắc Từ Liêm','0328830583'),(78,29,40.00,1,'2024-08-01 15:51:06','2024-08-01 15:51:06','Bắc Từ Liêm','0328830583'),(79,29,116.00,1,'2024-08-01 19:16:47','2024-08-01 19:16:47','Cầu Giấy','0918634816'),(80,29,160.00,1,'2024-08-01 19:42:17','2024-08-01 19:42:17','Bắc Từ Liêm','0328830583'),(81,29,108.00,5,'2024-08-01 20:05:58','2024-08-01 20:05:58','Bắc Từ Liêm','0328830583'),(82,29,108.00,3,'2024-08-01 20:06:24','2024-08-01 20:09:06','Bắc Từ Liêm','0328830583'),(83,29,40.00,5,'2024-08-01 20:15:22','2024-08-01 22:00:57','Bắc Từ Liêm','0328830583'),(84,29,56.00,5,'2024-08-01 20:56:47','2024-08-01 20:59:02','Bắc Từ Liêm','0328830583'),(85,29,40.00,1,'2024-08-01 21:00:35','2024-08-01 21:00:35','Cầu Giấy','0918634816'),(86,29,80.00,1,'2024-08-01 21:09:07','2024-08-01 21:09:07','Cầu Giấy','0902347162'),(87,29,120.00,4,'2024-08-01 21:24:20','2024-08-01 21:28:17','Tây Hồ','0993231180'),(88,29,100.00,1,'2024-08-01 21:40:06','2024-08-01 21:40:06','Bắc Từ Liêm','0328830583'),(89,29,100.00,5,'2024-08-01 21:40:54','2024-08-01 21:40:54','Bắc Từ Liêm','0328830583'),(90,29,40.00,5,'2024-08-01 21:42:06','2024-08-01 21:42:06','Bắc Từ Liêm','0328830583'),(91,33,40.00,5,'2024-08-01 21:55:54','2024-08-01 21:55:54','Minh Khai','0398457237'),(92,33,40.00,4,'2024-08-01 21:56:53','2024-08-01 22:00:18','Cầu Giấy','0289475236'),(93,34,20.00,4,'2024-08-01 22:07:44','2024-08-01 22:10:07','Cầu Giấy','0237460926'),(94,34,36.00,5,'2024-08-01 22:11:03','2024-08-01 22:13:14','Cầu Giấy','0237460926');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_type` enum('review','event','hot_spot') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Show','Hide') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`),
  KEY `posts_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (47,'https://file.hstatic.net/200000343865/file/munoixanh_621886237e66473c8e52d51e1b32a5ff_grande.jpg','HÀNH TRÌNH \"GIEO HẠT HÒA BÌNH\" CỦA NGƯỜI LÍNH TRẺ MŨ NỒI XANH Ở NAM SUDAN',5,'Hành trình vì hòa bình của chiến sĩ mũ nồi xanh\n\nMũ nồi xanh - Người đi gieo hạt hòa bình do Nhà xuất bản Kim Đồng phát hành, là cuốn sách ảnh về người lính Việt Nam tham gia hoạt động gìn giữ hòa bình Liên Hợp Quốc. \n\nCuốn sách là lời kể của người lính mũ nồi xanh - Trung úy Nguyễn Sỹ Công, do nhà báo Nam Kha chấp bút. \n\nTác phẩm được chia thành nhiều chương, gồm lời kể và hình ảnh về cuộc sống, công việc, sinh hoạt của quân nhân Việt Nam làm nhiệm vụ tại Nam Sudan. \n\n\n\nBìa sách \"Mũ nồi xanh - Người đi gieo hạt hòa bình\" (Ảnh: Nhà xuất bản Kim Đồng).\n\nTrong đó, Trung úy Nguyễn Sỹ Công công tác tại khoa Khám bệnh, Bệnh viện dã chiến cấp 2 số 4 tại căn cứ quân sự Juba Compound Bentiu (Nam Sudan) - cách Việt Nam hơn 8.500km. Tại đây, nội chiến vẫn xảy ra hàng ngày. \n\nChọn lên đường và dấn thân, câu chuyện của Trung úy Nguyễn Sỹ Công đã truyền cảm hứng về hòa bình và hi vọng.\n\nTham gia thực hiện nhiệm vụ quốc tế, hành trình của anh không chỉ hoàn thành công việc chữa bệnh cứu người mà còn vẽ dáng hình đất nước, mang nụ cười đến trẻ em và người dân châu Phi.\n\nNhững câu chuyện của anh cũng là minh chứng sống động giúp độc giả hình dung rõ nét hơn về cuộc sống nơi chiến tuyến - mọi hiểm nguy luôn rình rập mỗi giờ. Ở đó, điều kiện khắc nghiệt về khí hậu, môi trường, đời sống và sinh hoạt đều thiếu thốn.\n\nNhững người lính không trực tiếp cầm súng, họ vẫn có một cách riêng để gìn giữ hòa bình.\n\nTrung úy Nguyễn Sỹ Công tâm niệm, để thể hiện lòng yêu nước và góp phần làm rạng danh tổ quốc trong lòng bạn bè quốc tế có rất nhiều cách khác nhau.\n\nNhưng cách đơn giản nhất, mỗi cá nhân phải luôn cố gắng chu toàn bổn phận, nhiệm vụ của mình một cách chuyên nghiệp nhất.\n\n\n\nTrung úy Nguyễn Sỹ Công (Ảnh: Nhà xuất bản Kim Đồng).\n\n\"Chỉ cần bấy nhiêu thôi cũng nhận được sự đánh giá cao từ mọi người xung quanh. Tôi tin đây cũng là cách quảng bá hình ảnh đất nước, con người Việt Nam một cách chân thực và thuyết phục hơn bất kỳ lời mời nào\", anh cho hay. \n\nTrong những trang sách, qua lời kể và hình ảnh, nụ cười luôn hiện diện trên khuôn mặt anh cùng đồng đội. Tất cả như liều thuốc diệu kỳ, xóa tan những nhọc nhằn và căng thẳng nơi chiến tuyến.\n\nVẽ dáng hình đất nước với bạn bè năm châu','review','Hide','2024-05-27 00:00:00','2024-07-29 15:39:52'),(49,'https://file.hstatic.net/200000343865/file/muabanthayao_0d0a0e4c7e3b488e88805fdc5bd18ac5_grande.jpg','“MÙA BAN THAY ÁO” - GIEO MỘT SẮC HOA BAN CÙNG KHÍ PHÁCH ĐIỆN BIÊN PHỦ',6,'“Sáu năm sinh sống và làm việc tại Điện Biên, tôi luôn ấp ủ dự định viết một cuốn sách về mảnh đất thiêng liêng này. Như thể nơi lồng ngực tôi, một hạt ban nhỏ đang thao thức cựa mình, thôi thúc tôi cầm bút. Khi sự trải nghiệm đủ chín, sự cảm nhận đủ chạm, tôi mang những điều tôi ấn tượng vào truyện dài \"Mùa ban thay áo\", thật tự nhiên, mộc mạc. Và tôi tự hỏi, cây ban có một trái tim hay trái tim tôi vừa mọc một cây ban?” (Phan Đức Lộc).<br><br>Một cây ban nở muộn, xòe bung cánh trắng trong nắng hè vàng đượm cùng tiếng reo vang của đứa trẻ mở cánh cửa đưa bạn đọc chậm rãi bước vào thế giới văn chương của “Mùa ban thay áo” (Phan Đức Lộc), trong bộ sách Kỷ niệm 70 năm Chiến thắng Điện Biên Phủ của NXB Kim Đồng, 2024. Ở đó có “những ngọn núi ngời sắc màu kì ảo, những câu chuyện lịch sử hào hùng bên ánh lửa bập bùng, những tình cảm nồng ấm của đồng bào các dân tộc anh em và những mùa hoa ban đẹp man mác như dải thổ cẩm được dệt bằng hoài niệm”.<br><br>Vẫn là Phan Đức Lộc quen thuộc với những trau chuốt trong ngôn ngữ; tinh tế trong từng chi tiết, hình ảnh; chặt chẽ trong bố cục và sâu sắc, nhân văn trong suy nghĩ. Với những độc giả đã yêu mến và thường xuyên dõi theo Phan Đức Lộc qua các tác phẩm hẳn sẽ không còn xa lạ với cảm giác man mác, trầm buồn, có khi buồn đến thê lương bao trùm trong các sáng tác của anh. Nhưng đến cuối cùng, điều đọng lại mãi trên những trang văn ấy là tình đời, tình người lấp lánh.<br><br>“Mùa ban thay áo” xoay quanh kí ức của Hạt về một thời thanh xuân nhiệt huyết trên con đường dân công hỏa tuyến. Thực tế khốc liệt của chiến tranh cùng những mất mát, hy sinh hiện hữu trong chính gia đình mình đã tác động mạnh mẽ vào ý chí của cô gái, ngày qua ngày thổi bừng lên niềm mong mỏi được tham gia kháng chiến.','hot_spot','Hide','2024-05-29 00:00:00','2024-07-27 01:53:23'),(50,'https://ddk.1cdn.vn/2024/05/27/moc-an.jpg','LÀM SAO BẮT KỊP SỰ ‘KHÁC’ CỦA ĐỘC GIẢ LÀ ĐIỀU RẤT KHÓ',7,'Trong số các tác giả ra sách cho thiếu nhi đều đặn trong vài ba năm trở lại đây, có tác giả Mộc An (tên thật là Nguyễn Nguyệt Trinh).\r\n<br>\r\n<br>Điều thú vị, tác giả 8x này hiện đang dạy học tại Bình Định. Vậy nhưng, những cuốn sách thiếu nhi “Đậu Đậu, Sâu Sâu & Be Bé”, “Nếu một ngày chúng tớ biến mất”, “Nhạc sĩ đường phố”, “Ở một nơi có rất nhiều Rồng”… cứ lần lượt ra đời, góp thêm một giọng điệu mới. Với bản thảo “Ở một nơi có rất nhiều Rồng”, năm 2023, Mộc An đã được trao giải Khát vọng Dế Mèn trong hệ thống Giải thưởng Thiếu nhi Dế Mèn.\r\n<br>\r\n<br>PV: Trong một thời gian không dài, Mộc An đã liên tiếp cho ra mắt nhiều cuốn sách viết cho thiếu nhi. Cuốn sau hấp dẫn hơn cuốn trước. Xin hỏi, chị đến với việc sáng tác văn học cho thiếu nhi như thế nào?\r\n<br>\r\n<br>\r\n<br>\r\n<br>Tác giả Mộc An. Ảnh: NVCC.\r\n<br>\r\n<br>MỘC AN: Tôi được đọc những tác phẩm văn học viết cho thiếu nhi từ khi rất nhỏ, đọc nhiều và rất say mê. Đó là thời của những cuốn sách được in bằng giấy rơm vàng, mở ra cho tôi một thế giới vô cùng rộng lớn.\r\n<br>\r\n<br>Lớn lên, tôi vẫn chưa bao giờ hết hứng thú với mảng tác phẩm này lẫn phim hoạt hình, thế giới trẻ thơ hồn nhiên khiến lòng mình trong trẻo lại, mà cũng học được từ đó rất nhiều điều.\r\n<br>\r\n<br>Khi trở thành một người mẹ, chọn sách và đọc sách cùng con, sự gần gũi với văn học thiếu nhi càng mạnh mẽ hơn, có lúc tôi nảy ra ý nghĩ, mình có thể tham dự vào mảng này. Cho đến khi được một người học trò, cũng là bạn viết của tôi, gợi hứng, tôi chính thức tham dự vào việc viết sách cho thiếu nhi, và thấy rất vui.\r\n<br>\r\n<br>Khi viết cho thiếu nhi, chị có gặp áp lực gì không? Vì mình là người đi sau chẳng hạn?\r\n<br>\r\n<br>- Khi viết cho thiếu nhi, tôi không thấy quá áp lực. Trong văn chương chúng ta luôn là người đến sau. (Cười). Nếu đặt ra một mục tiêu phải trở thành, sẽ tự tạo cho mình áp lực. Nhưng nếu xác định, mình dự vào mảng này, nếu có thể đóng góp được chút gì đó đã là vui, thì sẽ thấy vui.\r\n<br>\r\n<br>Viết cho thiếu nhi với tôi như một lời hồi đáp dịu dàng nhất dành cho cuộc sống, vì vậy trong quá trình viết, niềm vui đã sẵn, nhiều lúc vừa viết vừa cười một mình là thật.\r\n<br>\r\n<br>Thế còn tác phẩm của những tác giả viết cho thiếu nhi tên tuổi đi trước, như các nhà văn Tô Hoài, Võ Quảng, Phạm Hổ, Vũ Tú Nam, Vũ Hùng… Những tên tuổi ấy có khiến chị cảm thấy áp lực, hay giúp chị rút ra được những kinh nghiệm viết gì?\r\n<br>\r\n<br>- Thế hệ chúng tôi thừa hưởng rất nhiều thành quả từ những trang văn mình đọc được từ các tiền bối. Tôi còn nhớ đã từng say mê “Dế Mèn phiêu lưu ký”, đã thích những câu chuyện trong “Quê nội” như thế nào. Sự đẹp đẽ trong sáng của tiếng Việt, khả năng viết đến chặt chẽ hàm súc tinh tế… là những điều tôi luôn luôn ngưỡng mộ và hướng đến. Tuy nhiên, thời đại mới sẽ đòi hỏi những điều khác trước về cảm xúc, nội dung, bút pháp… đẩy dòng chảy văn học nối tiếp không ngừng.\r\n<br>\r\n<br>Mộc An vừa nói, thời đại mới sẽ đòi hỏi những điều khác trước cả về cảm xúc, nội dung, và bút pháp… Vậy khi viết cho thiếu nhi, nhất là thiếu nhi của thời 4.0, hẳn chị phải có một kinh nghiệm hay quan niệm gì để \"khác\"?\r\n<br>\r\n<br>- Đòi hỏi tác phẩm hoàn toàn khác với thời trước, tác giả trước là điều rất khó, vì dòng chảy văn chương luôn có sự kế thừa tiếp nối, nếu có, thì tôi mong tác phẩm của mình có một chút “khác”. Chút “khác” này có thể đến từ góc nhìn, suy nghiệm riêng của cá nhân. Điều tôi mong nhất là tác phẩm sau có chút khác so với chính tác phẩm trước của mình. Tuy nhiên, có một điều chắn chắn khác trước là tâm lý tiếp nhận của thiếu nhi đã thay đổi, làm thế nào để bắt kịp sự “khác” này của độc giả mới là thực sự khó.\r\n<br>\r\n<br>Chị thường khởi đầu một tác phẩm mới như thế nào?\r\n<br>\r\n<br>- Một tác phẩm mới đến với tôi có vẻ như khá tình cờ, một lúc nào đó bất chợt nảy ra ý tưởng. Tôi cũng nhận được rất nhiều gợi ý từ con trai mình, khi độc giả đầu tiên mà tôi hướng đến là bạn ấy, bạn ấy thích đọc gì, tôi sẽ thử viết. Nhưng sâu hơn, tác phẩm thường là kết quả của những quan sát, cảm nhận, suy tư về đời sống cả một quá trình dài. Chẳng hạn, “Nếu một ngày chúng tớ biến mất” được gợi hứng từ ngay trong mảnh vườn nhỏ của tôi, từ một bạn ốc sên nhỏ bò đến vườn nhà vào mùa thu và gặm chậu hoa cúc tôi mới mua về.\r\n<br>\r\n<br>Tuy nhiên phải mấy năm sau tôi mới viết được về bạn ấy. “Ở một nơi có rất nhiều Rồng” được viết ra là vì bạn nhỏ ở nhà thích Rồng, viết cho bạn ấy đọc, sau đó là cho cả những bạn nhỏ khác, kể cả những người lớn muốn trở lại với thế giới trẻ thơ.\r\n<br>\r\n<br>Với chị, tìm kiếm chủ đề cuốn sách là quan trọng, hay tìm giọng kể, cách kể câu chuyện; hay nuôi dưỡng cảm xúc để hoàn thành cuốn sách mới là điều quan trọng?\r\n<br>\r\n<br>- Có lẽ là cộng lại tất cả những yếu tố ấy (Cười). Chẳng hạn, tôi hay nghĩ, mình sẽ viết về cái gì, sau đó sẽ nghĩ ra giọng kể, cách kể phù hợp. Trước và trong quá trình viết, cảm xúc phải đủ mạnh mẽ, thôi thúc, sự dồi dào của cảm xúc sẽ khiến cho ngòi bút đi một hơi và có những lúc lóe lên mà ngay cả người viết cũng không lường trước, làm nên điểm sáng của tác phẩm.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Cuốn sách “Ở một nơi có rất nhiều Rồng” của Mộc An. Ảnh: Thư Hoàng.\r\n<br>\r\n<br>Một số người vẫn nói, sách văn học Việt cho thiếu nhi Việt ngày nay vẫn ít, không đủ đáp ứng độc giả. Mộc An có thể chia sẻ thêm về góc nhìn của mình?\r\n<br>\r\n<br>- So với mặt bằng rộng lớn của văn học dịch cho trẻ em, thậm chí là nguyên tác tiếng nước ngoài, thì tác phẩm văn học viết cho thiếu nhi trong nước dường như vẫn chưa theo kịp.\r\n<br>\r\n<br>Nhưng thật ra khi nói “ít”, thì đã có sự thúc đẩy và vận động tự thân rồi. Ngày càng đông đảo lực lượng sáng tác dự vào mảng văn học thiếu nhi, sự đa dạng về đề tài, nội dung, thể loại, phong cách, giọng điệu… cho thấy văn học thiếu nhi hiện nay đã có bước chuyển biến rất lớn để bắt kịp với nhu cầu tinh thần ngày càng mới mẻ phong phú của các em.\r\n<br>\r\n<br>Trong quan sát của mình, chị có nhận định gì về các tác giả trẻ viết cho thiếu nhi hiện nay?\r\n<br>\r\n<br>- Các tác giả trẻ hứa hẹn một diện mạo mới cho văn học thiếu nhi Việt. Lê Quang Trạng, Nguyễn Chí Ngoan, Trọng Khang, Lạc An… là những tên tuổi gợi nhiều cảm hứng, chưa kể một đội ngũ tác giả “nhí” có một bản lĩnh viết lách đáng kinh ngạc.\r\n<br>\r\n<br>Ở họ có sức trẻ, sự năng động, năng lực quan sát và tái hiện sinh động đời sống lẫn tâm lý trẻ em, hiểu biết sâu rộng tích hợp từ nhiều nền tảng văn hóa trong và ngoài nước, lẫn tài năng dung hợp giữa văn chương và hội họa…\r\n<br>\r\n<br>Chúng ta có quyền tin tưởng và hy vọng vào một nền văn học thiếu nhi Việt tiệm cận với văn học thiếu nhi thế giới trong tương lai.\r\n<br>\r\n<br>Xin cảm ơn chị!','review','Hide','2024-06-23 00:00:00','2024-07-27 01:53:23'),(51,'https://doanthanhnien.vn/Content/uploads/images/133605764359433958_VBAL6384.jpeg','ĐẢNG ỦY T.Ư ĐOÀN TUYÊN DƯƠNG 27 ĐIỂN HÌNH TIÊU BIỂU TRONG HỌC TẬP VÀ LÀM THEO BÁC',5,'Sáng 19.5, nhân dịp 134 năm Ngày sinh Chủ tịch Hồ Chí Minh, Đảng ủy T.Ư Đoàn tổ chức Hội nghị tuyên dương điển hình tiêu biểu trong học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh năm 2024.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Tham dự chương trình có đồng chí Nguyễn Quang Trường, Phó Bí thư Đảng ủy Khối các Cơ quan T.Ư; đồng chí Lê Giang Nam, Phó trưởng Ban Tổ chức Đảng ủy Khối các Cơ quan T.Ư.\r\n<br>\r\n<br>Về phía T.Ư Đoàn, có đồng chí Bùi Quang Huy, Ủy viên dự khuyết T.Ư Đảng, Bí thư thứ nhất T.Ư Đoàn, Bí thư Đảng ủy T.Ư Đoàn; đồng chí Ngô Văn Cương, Bí thư T.Ư Đoàn, Chủ nhiệm Ủy ban Kiểm tra T.Ư Đoàn; đồng chí Nguyễn Tường Lâm, Bí thư T.Ư Đoàn, Phó Chủ nhiệm thường trực Ủy ban Quốc gia về thanh niên Việt Nam; đồng chí Nguyễn Thanh Tùng, Phó Bí thư thường trực Đảng ủy Trung ương Đoàn.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Tại hội nghị Đảng ủy T.Ư Đoàn đã trao tặng giấy khen cho 27 cá nhân thuộc Đảng bộ T.Ư Đoàn là \"điển hình tiêu biểu trong học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh năm 2024”. \r\n<br>\r\n<br>\r\n<br>\r\n<br>\r\n<br>\r\n<br>3 cá nhân tiêu biểu đồng chí Lê Anh Quân, Phó bí thư chi bộ, Phó Trưởng Ban Công tác thiếu nhi TƯ Đoàn; đồng chí Châu Bùi Nữ Vương, đảng viên Đảng bộ Báo Thanh Niên; đồng chí Nguyễn Duy Thị Hiền Anh, Biên tập viên NXB Kim Đồng được tuyên dương đã giao lưu với các đại biểu với những chia sẻ truyền cảm hứng tới các đảng viên trong Đảng bộ T.Ư Đoàn\r\n<br>\r\n<br>\r\n<br>\r\n<br>Phát biểu tại hội nghị, đồng chí Bùi Quang Huy nhấn mạnh, Chủ tịch Hồ Chí Minh là biểu tượng cao đẹp nhất của chủ nghĩa yêu nước và chủ nghĩa anh hùng cách mạng Việt Nam; là người của đạo đức, trí tuệ, khí phách của dân tộc Việt Nam và của thời đại… Tư tưởng, đạo đức, phong cách của Chủ tịch Hồ Chí Minh là tài sản tinh thần vô giá, việc học tập và làm theo Người là nhiệm vụ quan trọng, không thể thiếu đối với tất cả tổ chức Đảng, đảng viên trong tu dưỡng, rèn luyện, cống hiến và phụng sự đất nước.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Đồng chí Bùi Quang Huy thay mặt Đảng ủy T.Ư Đoàn ghi nhận, đánh giá cao sự nghiêm túc, trách nhiệm, sáng tạo triển khai thực hiện Chỉ thị 05 của nhiều Đảng bộ, chi bộ trực thuộc và tuyên dương đóng góp thành tích, nỗ lực của nhiều đồng chí đảng viên trong Đảng bộ chúng ta, đặc biệt là 27 gương được tuyên dương.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Trong khuôn khổ chương trình tuyên dương, các đại biểu đã nghe chuyên đề \"Tăng cường tính tiên phong, gương mẫu của cán bộ, đảng viên, hoàn thành xuất sắc nhiệm vụ chính trị của các cơ quan T.Ư\" do PGS.TS Nguyễn Minh Tuấn, nguyên Viện trưởng Viện Xây dựng Đảng, Học viện Chính trị Quốc gia Hồ Chí Minh trình bày.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Trước lễ tuyên dương, các đại biểu đã vào Lăng viếng Chủ tịch Hồ Chí Minh, dâng hoa tưởng niệm Người.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Chương trình tuyên dương các điển hình tiêu biểu trong học tập và làm theo tư tưởng, đạo đức, phong cách Hồ Chí Minh được Đảng ủy T.Ư Đoàn thực hiện hằng năm vào dịp kỷ niệm Ngày sinh Chủ tịch Hồ Chí Minh là hoạt động vô cùng ý nghĩa, lan tỏa cảm hứng và động lực phấn đấu cho các đảng viên toàn Đảng bộ T.Ư Đoàn.','event','Hide','2024-06-23 00:00:00','2024-07-27 01:53:23'),(52,'https://media-cdn-v2.laodong.vn/storage/newsportal/2024/5/17/1341043/Phuong-Huyen.jpg?w=660','THÓI QUEN ĐỌC QUAN TRỌNG HƠN VIỆC LỰA CHỌN PHƯƠNG TIỆN ĐỌC',6,'Trong cuộc trò chuyện với Báo Lao Động, nhà báo, nhà văn Phương Huyền đã có những chia sẻ về về việc lan tỏa văn hóa đọc với đối tượng học sinh, sinh viên, đồng thời tiết lộ nguồn cảm hứng cho ra mắt nhiều tác phẩm văn học thiếu nhi ấn tượng.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Nhà văn Phương Huyền tích cực tổ chức nhiều buổi giao lưu, trò chuyện về tình yêu sách dành cho học sinh, sinh viên. Ảnh: Nhân vật cung cấp\r\n<br>\r\n<br>Từ góc nhìn của một nhà báo, một nhà văn thường xuyên theo sát hoạt động khuyến đọc, chị có cho rằng các giá trị văn hóa đọc truyền thống như sách giấy sẽ biến mất trước làn sóng công nghệ mạnh mẽ hiện nay?\r\n<br>\r\n<br>- Đối với tôi, văn hóa đọc không nằm ở phương tiện mà chính là thói quen đọc sách. Nhiều người thường biện minh rằng công việc bộn bề nên không có thời gian đọc sách. Không sao! bạn có thể chọn audiobook (sách nói) mà. Bản thân tôi cũng thường xuyên nghe audiobook trong lúc tập thể dục, chạy bộ hay làm việc nhà. Chỉ mất tầm 50 phút trong một lần thì sau một tuần có thể nghe xong cuốn sách. Dù rằng sách nói không thể tạo sự tập trung và ghi nhớ tốt, hay thậm chí chỉ nhận về 5 - 6 phần kiến thức so với sách giấy đi chăng nữa vẫn tốt hơn bạn không đọc gì.\r\n<br>\r\n<br>Nói như vậy để cho thấy việc hình thành thói quen đọc là quan trọng hơn, còn lựa chọn phương tiện đọc như thế nào còn tùy vào điều kiện và thói quen mỗi người. Bản thân tôi tin rằng sách giấy vẫn luôn là ưu tiên số 1 và sẽ không bao giờ biến mất bởi làn sóng công nghệ. Bởi lẽ, đối với độc giả, sách giấy vẫn có giá trị lưu trữ và hơn hết là giá trị tinh thần lớn hơn so với nhiều phương tiện đọc sách hiện đại.\r\n<br>\r\n<br>Nhiều người cho rằng mỗi phương tiện đọc đều có ưu thế riêng và là tiền đề để xây dựng thói quen đọc sách. Tuy nhiên, nhiều bậc phụ huynh bày tỏ lo ngại việc để con em tiếp xúc với các phương tiện điện tử quá sớm? Chị nghĩ sao về vấn đề này?\r\n<br>\r\n<br>- Chúng ta không thể sống tách biệt với công nghệ hay phủ nhận các lợi ích mà nó mang lại. Việc biến công nghệ thành công cụ tích cực hay tiêu cực đối với trẻ nằm ở chính cách quản lý của gia đình. Mỗi bậc cha mẹ cần xây dựng kế hoạch quản trị thời gian hiệu để cân bằng giữa việc học tập, sử dụng thiết bị công nghệ và các hoạt động vui chơi, giải trí bên ngoài của trẻ.\r\n<br>\r\n<br>Thực tế, nhiều bố mẹ hiện nay không quan tâm đến việc đọc sách cùng con, chỉ ôm khư khư điện thoại suốt ngày thì làm sao con trẻ tiếp cận được những cái hay, cái tốt mà công nghệ mang lại được.\r\n<br>\r\n<br>Vậy theo chị, làm sao để kéo trẻ em về lại với văn hóa đọc khi ngày càng nhiều phương tiện giải trí hiện đại luôn hiện hữu xung quanh?\r\n<br>\r\n<br>- Theo tôi, chúng ta phải làm sao để các bạn xem sách như một người bạn. Điều này xuất phát từ sự chủ động và kiên trì của mỗi gia đình. Trong nhiều buổi trò chuyện, tôi vẫn thường nhắc các em khi về nhà, hãy yêu cầu bố mẹ dành 15 - 20 phút mỗi tối đọc sách cùng con. Dần dần, con trẻ sẽ hình thành thói quen và tình yêu cho sách.\r\n<br>\r\n<br>Một điều nữa tôi nhận ra là những bạn nhỏ được bố mẹ khuyến khích đọc sách sẽ phát triển kỹ năng giao tiếp một cách lưu loát và tự tin hơn. Tôi còn nhớ rõ trong một buổi giao lưu với các học sinh THCS tại TPHCM, có một bạn nhỏ chia sẻ rằng: “Mẹ con luôn khuyến khích đọc sách, bởi vì việc đọc sách giúp con có nhiều từ ngữ để cải thiện khả năng viết lách và học tập, đặc biệt con sẽ biết cách giao tiếp để người khác tôn trọng mình”. Đó là một cái quan điểm tôi rất tâm đắc.\r\n<br>\r\n<br>Còn vai trò của nhà trường thì sao, thưa nhà văn?\r\n<br>\r\n<br>- Những năm gần đây, nhà trường cũng bắt đầu có nhiều sự quan tâm hơn cho hoạt động khuyến đọc nhưng chỉ mang tính phong trào theo từng thời điểm chứ chưa thực sự diễn ra một cách thường xuyên, liên tục.\r\n<br>\r\n<br>Để văn hóa đọc ở học đường thực sự có hiệu quả, tôi cho rằng cần sự nỗ lực nhiều hơn nữa từ Ban giám hiệu. Nhà trường cần chú trọng mô hình thư viện thân thiện, thường xuyên bổ sung đầu sách mới, đa dạng, chú trọng số hóa để tra cứu thông tin sách dễ dàng, tổ chức những tiết đọc sách hay cuộc thi nhằm giúp các em có sân chơi giao lưu, giới thiệu những đầu sách hay, qua đó lan tỏa tình yêu sách đến với bạn bè.\r\n<br>\r\n<br>Tôi từng đọc bài báo viết về một ngôi trường ở miền Tây, ở đó thư viện không chỉ là không gian đọc sách mà còn là nơi để các bạn tâm sự, giãi bày mọi thắc mắc trong học tập và cuộc sống. Chính nỗ lực của cô thủ thư khi đã trở thành một người bạn gần gũi, tin cậy của các bạn đã lôi kéo càng nhiều học sinh đến thư viện. Nói như vậy để thấy rằng, chính mỗi thầy cô cũng cần phải thay đổi thì mới lan tỏa văn hóa đọc đến các học sinh được.\r\n<br>\r\n<br>Những năm trở lại đây, chị đã tích cực tham gia nhiều buổi chia sẻ, tọa đàm về tình yêu sách và văn hóa đọc đến với học sinh, sinh viên. Liệu đó có phải là nguồn cảm hứng để chị cho ra đời các tác phẩm văn học thiếu nhi trong thời gian qua?\r\n<br>\r\n<br>- Hơn 20 năm kể từ khi bắt đầu viết, tôi đã sáng tác qua nhiều chủ đề khác nhau từ tuổi mới lớn, phụ nữ hay chấp bút cho các doanh nghiệp. Nói đúng ra thì bản thân không nghiêng hẳn về một thể loại cụ thể nào. Tuy nhiên, tôi rất yêu thích và mong muốn được trò chuyện nhiều hơn với các em nhỏ.\r\n<br>\r\n<br>Mặc khác, kể từ khi làm mẹ, tôi cũng muốn truyền tải thông điệp đến các bậc phụ huynh rằng hãy luôn đồng hành, đọc sách cùng con. Tôi cho rằng không chỉ trẻ em mới đọc sách thiếu nhi mà chính các bậc cha mẹ cũng cần phải đọc để biết cách làm bạn với con, đồng thời dạy trẻ những bài học về tình yêu thương qua các câu chuyện trong văn học thiếu nhi. Khi con trẻ thấu hiểu được tình yêu thương thì chắc chắn nó cũng sẽ biết yêu thương người khác.\r\n<br>\r\n<br>Chính bản thân tôi đã cùng con đọc sách, làm bạn suốt 15 năm qua, chia sẻ cho nhau nghe nhiều tâm sự. Đó là một điều cực kỳ tuyệt vời.\r\n<br>\r\n<br>Rất nhiều nhà văn cho rằng viết cho thiếu nhi không dễ. Chị có phải là trường hợp ngoại lệ?\r\n<br>\r\n<br>- Tôi cũng gặp nhiều khó khăn khi viết sách cho thiếu nhi. Cuốn sách thiếu nhi đầu tiên là “Cái tai và cuộc phiêu lưu kỳ thú” vốn được chấp bút từ những câu chuyện kể con nghe hàng ngày. Khi hoàn thành xong, tôi vẫn băn khoăn liệu đây có phải là ngôn ngữ của thiếu nhi và có được các con thích hay không. May mắn nhờ có sự khích lệ từ phía nhà xuất bản nên mới tự tin cho ra mắt, sau đó có động lực viết tiếp những cuốn khác.\r\n<br>\r\n<br>Quá trình làm làm báo đã cho chị kinh nghiệm gì để có những trang viết bắt đúng tâm lý độc giả?\r\n<br>\r\n<br>- Suốt hơn 18 năm làm báo, tôi may mắn được tiếp cận và trò chuyện gần gũi với thính giả qua vai trò phát thanh viên. Đặc biệt, khi còn làm chương trình \"Trò chuyện đêm khuya\" cùng tiến sĩ tâm lí Lý Thị Mai, tôi được lắng nghe nhiều câu chuyện rất thực tế, có cả những tâm sự \"rút ruột, rút gan\" của nhân vật. Đến bây giờ, tôi vẫn biết ơn nghề báo đã cho mình nhiều cơ hội gặp gỡ, tiếp xúc với nhiều con người, câu chuyện hay, từ đó có chất liệu quý giá trong con đường sáng tác văn chương.','event','Hide','2024-06-23 23:52:03','2024-07-27 01:53:23'),(53,'https://file.hstatic.net/200000343865/file/fb_post_1200x800_93c719890b124663872e4fe3eb7c1093_grande.jpg','NXB KIM ĐỒNG TỔ CHỨC CHUỖI SỰ KIỆN ĐỌC SÁCH CHÀO MỪNG TẾT THIẾU NHI VÀ THÁNG SÁCH KIM ĐỒNG',7,'Chào đón Tết Thiếu nhi 1/6, mở ra một mùa hè khám phá đầy lý thú, chào mừng kỉ niệm 67 năm ngày thành lập Nhà xuất bản Kim Đồng (17/6/1957-17/6/2024), trong khuôn khổ Tháng sách Kim Đồng, Nhà xuất bản Kim Đồng tổ chức nhiều hoạt động giao lưu giới thiệu sách mới dành cho độc giả tại Hà Nội và TP. Hồ Chí Minh. \r\n<br>\r\n<br>1. Góc đọc cuối tuần: Bước vào cuộc phiêu lưu của Dế Út cùng họa sĩ Linh Rab.\r\n<br>\r\n<br>\r\n<br>\r\n<br>\r\n<br>Thời gian: 10:00 sáng thứ Bảy, ngày 1/6/2024\r\n<br>Địa điểm: Hội trường tầng 2, Trụ sở NXB Kim Đồng, 55 Quang Trung, Q. Hai Bà Trưng, Hà Nội\r\n<br>Khách mời: Họa sĩ Linh Rab\r\n<br>\r\n<br>Bộ truyện tranh “Cuộc phiêu lưu của Dế Út” gồm 4 tập, được họa sĩ Linh Rab sáng tác lấy cảm hứng từ tác phẩm “Dế Mèn phiêu lưu ký” của nhà văn Tô Hoài. Bộ truyện tranh mang các độc giả nhí tới thế giới vô cùng thú vị của chú Dế Út sống độc lập, kiên cường nhưng cũng rất mộng mơ với giấc mơ lớn nhất là vượt qua bụi cỏ nhà mình đi khám phá thế giới. Đôi lúc mắc sai lầm, đôi khi gặp nghịch cảnh, nhưng Dế Út luôn được sát cánh cùng những “chiến hữu” thân thiết, và học được những bài học vô giá. Trên tất cả, tác phẩm đề cao tấm lòng hào hiệp, nhân hậu và những tình cảm gia đình, bạn bè đáng quý. \r\n<br>“Cuộc phiêu lưu của Dế Út” nhận được rất nhiều sự quan tâm và yêu thích của các bạn đọc nhỏ tuổi nhờ vào cốt truyện phiêu lưu hấp dẫn và cách kể chuyện bằng truyện tranh mới mẻ, hiện đại. Bộ sách đã giúp tác giả Linh Rab nhận được Giải thưởng Thiếu nhi Dế Mèn lần 5 - 2024. Mời các bạn nhỏ cùng tới giao lưu với họa sĩ Linh Rab và tham gia các hoạt động vui nhộn xung quanh bộ truyện tranh thú vị này nhé!\r\n<br>\r\n<br>***\r\n<br>\r\n<br>2. Giao lưu ra mắt loạt sách thiếu nhi của nhà văn Áo nổi tiếng - Mira Lobe\r\n<br>\r\n<br>\r\n<br>\r\n<br>Thời gian: 15:00 ngày 1/6/2024\r\n<br>Địa điểm: Hội trường tầng 3, NXB Kim Đồng, 55 Quang Trung, Q. Hai Bà Trưng, Hà Nội\r\n<br>Khách mời: Dịch giả Chu Thu Phương\r\n<br> Mira Lobe là một nhà văn nổi tiếng người Áo, bà là tác giả của hơn một trăm tác phẩm viết cho thiếu nhi. Bốn cuốn sách của bà mới được NXB Kim Đồng giới thiệu với độc giả Việt Nam gồm: truyện dài Bà ngoại trên cây táo và ba tác phẩm sách tranh: “Lại đây nào!” mèo bảo, Tôi là tôi bé nhỏ, Thành phố quanh vòng quanh. \r\n<br>Tại buổi ra mắt, các bạn nhỏ sẽ được giao lưu với dịch giả Chu Thu Phương, được xem kịch do Câu lạc bộ Tiếng Đức biểu diễn, và tham quan triển lãm tranh minh họa các tác phẩm của Mira Lobe của các họa sĩ Susi Weigel và Angelika Kaufmann.\r\n<br>\r\n<br>***\r\n<br>\r\n<br>3. Giao lưu: Quản lí tài chính cá nhân dành cho bạn trẻ: Khéo khôn với tiền – Tránh những ưu phiền\r\n<br>\r\n<br>\r\n<br>\r\n<br>Thời gian: 9 giờ 30 phút ngày Chủ nhật, 02/06/2024 \r\n<br>Địa điểm: Hội trường tầng 3, Nhà xuất bản Kim Đồng, 55 Quang Trung, Q. Hai Bà Trưng, Hà Nội.\r\n<br>\r\n<br>Trong bối cảnh các phương tiện truyền thông đại chúng thường xuyên cảnh báo về những câu chuyện buồn do thiếu kiến thức hiểu biết về tài chính, việc các bạn trẻ cần tự trang bị kiến thức cơ bản về tài chính ngày càng thể hiện rõ sự cần thiết hơn bao giờ hết. Chương trình giao lưu Quản lí tài chính cá nhân cho bạn trẻ: Khéo khôn với tiền – Tránh những ưu phiền, do NXB Kim Đồng phối hợp cùng Dự án Sách Nhà Mình thực hiện, được thiết kế dành riêng cho các bạn trẻ với nhiều hoạt động trò chơi, hỏi đáp, giao lưu tương tác, chia sẻ kiến thức về tài chính từ các chuyên gia.\r\n<br>\r\n<br>***\r\n<br>\r\n<br>4. Gặp gỡ và giao lưu cùng nhà văn Thủy Nguyên, chủ đề: \"Gặp gỡ nhà văn Thủy Nguyên - Từ giấc mơ cổ tích đến thế giới đồng thoại\".\r\n<br>\r\n<br>Thời gian: 9h, Chủ nhật, 2/6 \r\n<br>Địa điểm: Đường sách TP. Thủ Đức, Quận 9, TP. Hồ Chí Minh\r\n<br>Tác giả Thủy Nguyên có nhiều đầu sách được xuất bản tại NXB Kim Đồng như: Thiện và Ác và Cổ tích; Bộ ba Câu chuyện dòng sông: Người mẹ sông Hồng, Em gái sông Hương, Chàng trai Cửu Long; Sẻ Nâu mơ thành đại bàng.\r\n<br>Trong chương trình nhà văn Thủy Nguyên sẽ chia sẻ cùng độc giả nguồn cảm hứng để chị viết nên những tác phẩm này. \r\n<br>\r\n<br>***\r\n<br>\r\n<br>5. Góc đọc cuối tuần: Đọc sách “Mặt trời luôn bên tôi” và giao lưu với tác giả Lê Trung Cường\r\n<br>Thời gian: 10:00, Thứ Bảy, 8/6\r\n<br>Địa điểm: Phòng đọc tầng 2, NXB Kim Đồng, 55 Quang Trung, Hà Nội\r\n<br>Khách mời: Tác giả Lê Trung Cường\r\n<br>\r\n<br>Tác giả Lê Trung Cường là một người khiếm thị, anh luôn vươn lên trong cuộc sống và học tập để tự giúp chính mình và cống hiến cho xã hội. Anh đã phấn đấu trở thành thầy giáo dẫn dắt và truyền cảm hứng cho những người sống xung quanh. Những cuốn sách của thầy giáo Lê Trung Cường giúp người đọc tìm thấy ánh sáng, ý chí nghị lực vượt lên khó khăn. Đây là chương trình đặc biệt được Nhà xuất bản Kim Đồng phối hợp với câu lạc bộ Bookidoo tổ chức dành cho các bạn nhỏ có hoàn cảnh đặc biệt của Làng Hoa Phượng (Thành phố Hải Phòng). \r\n<br>\r\n<br>***\r\n<br>\r\n<br>6. Giao lưu ra mắt sách: Mũ nồi xanh – Người đi gieo hạt hòa bình. \r\n<br>\r\n<br>\r\n<br>\r\n<br>9:30, Sáng thứ Bảy, 8/6\r\n<br>Sân khấu A, đường sách TP HCM\r\n<br>Khách mời: Trung úy Nguyễn Sỹ Công, Nhà báo Nam Kha, Nhà thơ Lê Minh Quốc\r\n<br>“Mũ nồi xanh – Người đi gieo hạt hòa bình” là cuốn sách ảnh về những câu chuyện về người lính Việt Nam tham gia hoạt động giữ gìn hoà bình Liên hợp quốc, qua lời kể của người lính Mũ nồi xanh Nguyễn Sỹ Công do nhà báo Nam Kha chấp bút. \r\n<br>Cuốn sách được chia thành nhiều chương, gồm lời kể và hình ảnh về cuộc sống công việc, sinh hoạt của quân nhân Việt Nam đang làm nhiệm vụ tại Nam Sudan. Những câu chuyện của Nguyễn Sỹ Công giúp bạn hình dung rõ nét hơn về cuộc sống nơi mọi hiểm nguy luôn rình rập hằng giờ, điều kiện khắc nghiệt về khí hậu, đời sống và sinh hoạt đều thiếu thốn. Hành trình của Nguyễn Sỹ Công không chỉ hoàn thành công việc chữa bệnh cứu người mà còn vẽ dáng hình đất nước, mang nụ cười đến cho trẻ em và người dân Phi châu. Chọn lên đường và dấn thân, chàng quân nhân Việt Nam - Trung uý Nguyễn Sỹ Công đã truyền cảm hứng về hoà bình và hy vọng. \r\n<br>\r\n<br>***\r\n<br>\r\n<br>7. Góc đọc cuối tuần: Chuyện hay Sử Việt - Những câu chuyện hào hùng về ngàn năm dựng nước và giữ nước của dân tộc Việt Nam\r\n<br>Thời gian: 10:00, Thứ Bảy, 15/6\r\n<br>Địa điểm: Tầng 2, NXB Kim Đồng, 55 Quang Trung, Q. Hai Bà Trưng, Hà Nội.\r\n<br>Khách mời: Tác giả Nguyễn Huy Thắng.\r\n<br>\r\n<br>Lịch sử đất nước đã trải qua hàng nghìn năm với biết bao thời khắc huy hoàng và bi tráng. Góc đọc cuối tuần - Chuyện hay sử Việt sẽ dẫn dắt các bạn nhỏ đi ngược dòng thời gian, thông qua những sự kiện hào hùng, câu chuyện về những nhân vật được ghi trong chính sử và cả các huyền tích, giai thoại lưu truyền trong dân gian.\r\n<br>\r\n<br>***\r\n<br>\r\n<br>8. Góc đọc cuối tuần: Học cách trở thành những đứa trẻ hạnh phúc – Đọc sách “Những đứa trẻ hạnh phúc”.\r\n<br>Thời gian: 10:00, Thứ Bảy, 22/6 \r\n<br>Địa điểm: Tầng 2, NXB Kim Đồng, 55 Quang Trung, Q. Hai Bà Trưng, Hà Nội.\r\n<br>\r\n<br>Thế nào là hạnh phúc? Các em có muốn trở thành những đứa trẻ hạnh phúc và lan tỏa niềm hạnh phúc đó tới mọi người không? Hãy ghé thăm Góc đọc tuần này nhé! Bộ sách Những đứa trẻ hạnh phúc gồm 10 cuốn, tái hiện thế giới tuổi thơ muôn màu với những câu chuyện dung dị, đời thường nhưng cũng đầy bất ngờ và ý nghĩa của các bạn nhỏ thuộc các dân tộc Việt Nam. Đây là bộ sách tranh truyện đầu tiên có nhân vật chính là trẻ em của nhiều dân tộc trên đất nước ta chắc chắn sẽ mang đến cho các độc giả nhí nhiều trải nghiệm thú vị. Bộ sách vinh dự nhận giải thưởng Sách Quốc gia năm 2023.\r\n<br>\r\n<br>***\r\n<br>\r\n<br>9. Góc đọc cuối tuần: Cười bể bụng với Paul Jenning – Đọc sách “Chuyện bí ẩn thường ngày”\r\n<br>Thời gian: 10:00, Thứ Bảy, 29/6 \r\n<br>Địa điểm: Tầng 2, NXB Kim Đồng, 55 Quang Trung, Q. Hai Bà Trưng, Hà Nội.\r\n<br>Trẻ em khắp thế giới không thể cưỡng lại trước tài năng kể chuyện đặc biệt kì diệu của Paul Jennings, vị phù thủy của ngôn từ đã mê hoặc và mang lại thật nhiều niềm vui cho độc giả nhỏ tuổi.\r\n<br>\r\n<br>***\r\n<br>\r\n<br>GÓC ĐỌC CUỐI TUẦN được tổ chức vào 10h sáng thứ Bảy hàng tuần tại góc đọc tầng 2, trụ sở NXB Kim Đồng, 55 Quang Trung, Q. Hai Bà Trưng, Hà Nội. Các bạn nhỏ được tham dự hoàn toàn miễn phí.  Mời bố mẹ cùng theo dõi các thông tin cập nhật và đăng kí tham gia chương trình cho các con tại đây: https://gocdocsach.nxbkimdong.com.vn/','event','Hide','2024-06-24 17:32:28','2024-07-27 01:53:23'),(54,'https://file3.qdnd.vn/data/images/0/2024/05/27/upload_2049/sach.jpg?dpi=150&quality=100&w=870','KẾT NỐI VĂN HÓA ĐỌC: KHƠI MỞ NHỮNG CÂU CHUYỆN THÚ VỊ CHO TRẺ EM ',7,'Thế giới quanh ta vốn mang bao điều thú vị thu hút sự ham thích khám phá của con người, nhất là lứa tuổi thiếu nhi. Xoay quanh hành trình tìm mẹ của Chuồn Chuồn Ớt, nhà văn Nguyễn Hồng Chiến đã kể câu chuyện đồng thoại nơi sông núi Tây Nguyên diệu kỳ trong cuốn sách “Chuồn Chuồn Ớt tìm mẹ” (Nhà xuất bản Kim Đồng, 2022). Cuốn sách đã đoạt giải khuyến khích Giải thưởng Sách quốc gia lần thứ VI, năm 2023.\r\n<br>\r\n<br>“Chuồn Chuồn Ớt tìm mẹ” viết theo thể loại truyện đồng thoại với các nhân vật được nhân cách hóa một cách gần gũi, ngộ nghĩnh, đáng yêu. Truyện được chia làm 13 phần, mỗi phần là một câu chuyện hoàn chỉnh, độc lập gắn với hành trình tìm mẹ của Chuồn Chuồn Ớt. Trong cuốn sách, thế giới đa màu sắc được vun vén, đắp bồi và khơi mở từ những câu chuyện thú vị để bạn đọc nhỏ tuổi có thể dễ dàng tiếp cận.\r\n<br>\r\n<br>Mở đầu “Chuồn Chuồn Ớt tìm mẹ”, tác giả gợi ra câu chuyện nơi xóm Bùn của bé Bọ Ăn Mày. Cái xóm ở đáy ao chật chội, tách biệt và nhỏ bé ấy là nơi trú ngụ của biết bao loài vật. Từ bà Hến, bà Ngao, cô Ốc Nhồi, đám Cá Mương, cụ Cá Chép đến lão Cá Chuối, Cá Trê và anh em Bọ Ăn Mày. Cuộc sống trầm lặng nơi xóm Bùn sẽ diễn ra như vậy nếu không có sự phát hiện của cô Ốc Nhồi. Họ ồn ào, nháo nhác vì thông tin “Phía trên mặt nước còn có trời xanh cao và rộng lắm, có ông Mặt trời sưởi ấm muôn loài, mặt đất không có nước, trên ấy còn có cả mây bay không cần đuôi và vây”...\r\n<br>\r\n<br>\r\n<br>\r\n<br>Bìa cuốn sách. \r\n<br>\r\n<br>Câu chuyện tưởng như khó tin ấy dẫn dụ những ham thích của muôn loài nơi đây. Nhưng rồi, ngoại trừ Bọ Ăn Mày, chẳng ai dám vượt khỏi ranh giới an toàn của xóm Bùn khi ngoài kia có đầy rẫy hiểm nguy rình rập. Với hoàn cảnh là đứa trẻ mồ côi, lại khao khát tìm hiểu thế giới, Bọ Ăn Mày đã leo lên đỉnh cây tre, để cho nắng gió hong khô bộ áo thân đốt. Bộ áo vỡ ra, từ trong lốt một con Bọ Ăn Mày xấu xí bỗng hiện lên một thân hình hoàn toàn khác, trở thành Chuồn Chuồn Ớt màu đỏ tươi có đôi cánh mỏng tang.\r\n<br>\r\n<br>Cũng từ đây, hành trình tìm mẹ của Chuồn Chuồn Ớt chính thức bắt đầu. Những câu chuyện mới mẻ về thời tiết, thiên nhiên, tập tính muôn loài được khám phá. Nơi đầu tiên Chuồn Chuồn Ớt đến là trường học, nơi trú ngụ của bác Phượng Già, Ve Sầu, Sẻ Con, Hạt Sỏi... Ở đó, Chuồn Chuồn Ớt được nghe Hạt Sỏi lý giải vì sao Mặt Trời chính là người quyết định khi nào mùa hè đến: “Căn cứ theo đường đi của ông Mặt Trời mà người ta chia theo mùa. Khi ông ta đi qua đầu chúng ta, tạo ra cái bóng tròn dưới chân, đấy là mùa hè”. Tiếp nối là những câu chuyện gần gũi, dí dỏm, cuốn hút bạn đọc như: Gió ốm, Ve Sầu đâu rồi, vì sao bàng rụng lá...\r\n<br>\r\n<br>Không chỉ ở trường học, không gian trong “Chuồn Chuồn Ớt tìm mẹ” còn được mở rộng qua xóm Bằng Lăng, vùng núi cao... Nơi nào đi qua, Chuồn Chuồn Ớt cũng gặp những người bạn mới với bao câu chuyện đặc biệt. Đó là chú K’tia (chim Vẹt) với “cái mỏ rắn chắc như thép” rất lắm lời và giỏi ngoại ngữ; ông Đầu Bạc ồn ào, đi đến đâu cũng chuyện trò rôm rả như ngày hội; chị Hồng Tước ham chơi, không nghe lời bố mẹ, bị bắt nhốt trong lồng; Chuồn Chuồn Đá thân hình lực lưỡng như trực thăng; Chuồn Chuồn Kim nhỏ như chiếc kim khâu; lũ Chèo Bẻo mình đen thui, chuyên đi bắt chuồn chuồn... Những số phận, hiện thực cuộc sống hiển hiện trước mắt Chuồn Chuồn Ớt vừa thú vị, mới lạ vừa mạo hiểm, day dứt.\r\n<br>\r\n<br>Với “Chuồn Chuồn Ớt tìm mẹ”, tác giả Nguyễn Hồng Chiến đã khéo léo lồng ghép những bài học về giao tiếp, ứng xử, tinh thần khám phá, sẻ chia, giúp đỡ khi gặp khó khăn, hoạn nạn... Khép lại hành trình, dẫu không thể tìm được mẹ nhưng những bài học trên đường đời và được kết thân với những người bạn mới là giá trị tuyệt vời nhất mà Chuồn Chuồn Ớt có được. Đó cũng là điều mà tác giả muốn độc giả trẻ được trải nghiệm qua những trang văn giản dị, hồn nhiên.\r\n<br>\r\n<br>','review','Show','2024-06-24 23:30:11','2024-07-27 01:53:23'),(55,'https://img.daibieunhandan.vn/resize/800x800/Files/Images/2024/03/23/image-daidoanket-vn-images-uploa-1711205278052.jpg','THÁCH THỨC BẢO VỆ BẢN QUYỀN SÁCH TRÊN KHÔNG GIAN MẠNG',5,'Tình trạng xâm phạm quyền tác giả, quyền liên quan vẫn diễn ra ở lĩnh vực xuất bản và phát hành sách, đặc biệt là sách điện tử trên không gian mạng.\r\n<br>\r\n<br>Xâm phạm bản quyền sách diễn ra phổ biến và dễ dàng hơn\r\n<br>\r\n<br>\"Trong kỷ nguyên số, cũng như các lĩnh vực chuyên ngành khác của bảo vệ quyền tác giả, bản quyền sách hiện nay chịu ảnh hưởng to lớn của thời kỳ công nghệ 4.0, đặc biệt là trên không gian mạng\" - ThS. Phạm Thị Kim Oanh, Phó Cục trưởng Cục Bản quyền tác giả, Bộ Văn hóa, Thể thao và Du lịch cho biết tại Hội nghị triển khai công tác Xuất bản và Phát hành xuất bản phẩm năm 2024.\r\n<br>\r\n<br>Sự xuất hiện và phát triển của kỹ thuật số gắn với công nghệ kỹ thuật số như internet, điện toán đám mây, AI, máy ảnh kỹ thuật số, điện thoại thông minh, TV thông minh, phương tiện truyền thông xã hội, máy quét, sách điện tử... Điều này tạo thuận lợi cho việc sáng tạo, lưu giữ, sao chép và phổ biến tác phẩm ở định dạng kỹ thuật số, trong không gian kỹ thuật số, thay đổi phương thức cung cấp, truyền đạt sách đến công chúng, phương thức khai thác, sử dụng sách. Tuy nhiên, không gian mạng là môi trường trung gian tiếp tay cho các hành vi xâm phạm bản quyền sách diễn ra phổ biến và dễ dàng hơn, là thách thức không nhỏ trong việc bảo vệ bản quyền sách.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Vi phạm bản quyền sách trên không gian mạng diễn ra dễ dàng hơn. Nguồn: daidoanket.vn\r\n<br>\r\n<br>Vi phạm bản quyền sách trên không gian mạng xuất phát từ một số nguyên nhân. Trong đó, vẫn còn đối tượng chạy theo lợi nhuận, vì lợi ích cá nhân mà xâm hại quyền lợi hợp pháp của tác giả, chủ sở hữu quyền. Tổ chức, cá nhân khai thác, sử dụng và công chúng chưa ý thức được trách nhiệm, nghĩa vụ về quyền tác giả, quyền liên quan; mua sách rẻ mặc dù có thể biết hoặc không biết đó là sách lậu, sách giả, sách vi phạm bản quyền.\r\n<br>\r\n<br>Một số tác giả, chủ sở hữu quyền chưa nắm vững các quy định pháp luật, chưa chủ động áp dụng các biện pháp để bảo vệ quyền, lợi ích hợp pháp của mình. Đặc biệt là các chủ sở hữu quyền như nhà xuất bản, khi có tranh chấp, vẫn chưa cung cấp đủ bằng chứng/chứng cứ liên quan về quyền của mình và về hành vi vi phạm cho cơ quan có thẩm quyền. Mặt khác, xử lý hành vi xâm phạm về quyền tác giả, quyền liên quan còn hạn chế, chưa đủ sức răn đe, ngăn ngừa. Một số cơ quan có thẩm quyền xử lý vi phạm còn có biểu hiện né tránh trách nhiệm, chưa phối hợp đồng bộ nhịp nhàng...\r\n<br>\r\n<br>Hoàn thiện chính sách, cơ chế bảo vệ bản quyền\r\n<br>\r\n<br>Để thúc đẩy bảo hộ quyền tác giả thời gian tới, bà Phạm Thị Kim Oanh cho rằng, phải thực hiện đồng bộ nhiều giải pháp. Cụ thể, tiếp tục rà soát, bổ sung hoàn thiện thể chế, chính sách liên quan nhằm tạo dựng hành lang pháp lý khuyến khích hoạt động sáng tạo; bảo vệ bản quyền trên không gian mạng.\r\n<br>\r\n<br>Đẩy mạnh phối hợp giữa các cơ quan quản lý, thực thi trong quản lý và xử lý hành vi xâm phạm quyền, như ký kết bản ghi nhớ hợp tác, phối hợp trong công tác quản lý và thực thi bản quyền sách giữa Bộ Văn hóa, Thể thao và Du lịch, Bộ Thông tin và Truyền thông và các cơ quan liên quan; đẩy mạnh hoạt động của Ban chỉ đạo 389…; liên kết, chia sẻ dữ liệu, đẩy mạnh ứng dụng công nghệ thông tin trong quản lý, thực thi bảo hộ bản quyền.\r\n<br>\r\n<br>\r\n<br>\r\n<br>Hoàn thiện các chính sách, cơ chế để bảo vệ bản quyền trên không gian mạng. Nguồn: dangkybanquyen.net\r\n<br>\r\n<br>Đồng tình với ý kiến trên, đại diện Nhà xuất bản Trẻ kiến nghị cần hoàn thiện cơ chế, chính sách để bảo vệ bản quyền trên không gian mạng. Mạnh tay dẹp bỏ triệt để các hành vi chia sẻ lậu, bất hợp pháp ebook, audiobook trên mạng… Đặc biệt, xử lý nhanh chóng nhiều đơn vị vẫn đang ngang nhiên xuất bản, phát hành xuất bản phẩm điện tử mà chưa được cấp phép.\r\n<br>\r\n<br>Bên cạnh đó, nâng cao tính chủ động của các chủ thể quyền (tác giả, nhà xuất bản) trong bảo vệ quyền và lợi ích hợp pháp của mình. Đồng thời, đẩy mạnh hợp tác quốc tế trong khai thác và bảo vệ bản quyền sách trên không gian mạng. Tăng cường công tác truyền thông, nâng cao nhận thức và ý thức chấp hành pháp luật cho các chủ thể quyền, cá nhân, tổ chức khai thác, sử dụng và công chúng.\r\n<br>\r\n<br>Tôn trọng và thực thi nghiêm túc pháp luật bản quyền, đặc biệt là bản quyền sách trên không gian mạng, chung tay hành động quyết liệt bảo vệ bản quyền sách sẽ góp phần khuyến khích các hoạt động sáng tạo, đầu tư khai thác phát triển thị trường sách, thúc đẩy công nghiệp văn hóa của Việt Nam trong kỷ nguyên số.','hot_spot','Show','2024-06-24 23:33:59','2024-07-27 01:53:23'),(56,'https://file.hstatic.net/200000343865/file/1_cd0ef7f707d1421a970a0fa680b24bb5_grande.jpg','NXB KIM ĐỒNG TRƯNG BÀY VÀ GIỚI THIỆU CÁC ẤN PHẨM “TỰ HÀO TRANG SỬ ĐỘI” KỈ NIỆM 83 NĂM NGÀY THÀNH LẬP ĐỘI TNTP HỒ CHÍ MINH',6,'Tình trạng xâm phạm quyền tác giả, quyền liên quan vẫn diễn ra ở lĩnh vực xuất bản và phát hành sách, đặc biệt là sách điện tử trên không gian mạng.\r\n\r\nXâm phạm bản quyền sách diễn ra phổ biến và dễ dàng hơn\r\n\r\n\"Trong kỷ nguyên số, cũng như các lĩnh vực chuyên ngành khác của bảo vệ quyền tác giả, bản quyền sách hiện nay chịu ảnh hưởng to lớn của thời kỳ công nghệ 4.0, đặc biệt là trên không gian mạng\" - ThS. Phạm Thị Kim Oanh, Phó Cục trưởng Cục Bản quyền tác giả, Bộ Văn hóa, Thể thao và Du lịch cho biết tại Hội nghị triển khai công tác Xuất bản và Phát hành xuất bản phẩm năm 2024.\r\n\r\nSự xuất hiện và phát triển của kỹ thuật số gắn với công nghệ kỹ thuật số như internet, điện toán đám mây, AI, máy ảnh kỹ thuật số, điện thoại thông minh, TV thông minh, phương tiện truyền thông xã hội, máy quét, sách điện tử... Điều này tạo thuận lợi cho việc sáng tạo, lưu giữ, sao chép và phổ biến tác phẩm ở định dạng kỹ thuật số, trong không gian kỹ thuật số, thay đổi phương thức cung cấp, truyền đạt sách đến công chúng, phương thức khai thác, sử dụng sách. Tuy nhiên, không gian mạng là môi trường trung gian tiếp tay cho các hành vi xâm phạm bản quyền sách diễn ra phổ biến và dễ dàng hơn, là thách thức không nhỏ trong việc bảo vệ bản quyền sách.','event','Show','2024-06-25 00:48:42','2024-07-27 01:53:23'),(57,'https://file.hstatic.net/200000343865/file/3_c0056832abe3495d86b515908980e2d3_grande.jpg','NXB KIM ĐỒNG HỢP TÁC CÙNG VIỆN PHÁP TẠI VIỆT NAM XÂY DỰNG CỘNG ĐỒNG SÁNG TÁC TRUYỆN TRANH',6,'Sáng ngày 13.06.2024, tại trụ sở NXB Kim Đồng (55 Quang Trung, P. Nguyễn Du, Q. Hai Bà Trưng, Hà Nội) đã diễn ra lễ kí kết hợp tác về việc tổ chức các hoạt động: Cuộc thi sáng tác truyện tranh và Hội thảo kĩ năng sáng tác truyện tranh giữa NXB Kim Đồng và Viện Pháp tại Việt Nam.\r\n\r\nTruyện tranh là một trong những thể loại sách bán chạy nhất tại Pháp, đôi khi còn được gọi là \"nghệ thuật thứ chín\" với lịch sử lâu dài, đề tài phong phú, dành cho nhiều đối tượng độc giả khác nhau. Hiện nay, truyện tranh ngày càng phát triển tại Pháp nhờ lực lượng đông đảo các hoạ sĩ tài năng trẻ tuổi với các tác phẩm độc đáo. Pháp đã trở thành địa điểm tổ chức thường niên của Liên hoan Truyện tranh Angoulême - một trong ba liên hoan truyện tranh lớn nhất thế giới.\r\n\r\n\r\n\r\nÔng Bùi Tuấn Nghĩa – Giám đốc NXB Kim Đồng (trái) và ông Franck Bolgiani - Tùy viên Văn hóa, Giám đốc Viện Pháp tại Hà Nội (phải) tại buổi lễ kí kết.\r\n\r\nTại Việt Nam, truyện tranh cũng đã trở nên quen thuộc với đông đảo bạn đọc trẻ. Vào những năm 1990, các tác phẩm truyện tranh đến từ Nhật Bản như Doraemon, Dragon Ball và từ Pháp như Astérix… đã gây tiếng vang lớn tại Việt Nam, trở thành một phần tuổi thơ của nhiều thế hệ người Việt. Tất cả những tác phẩm đều đến từ Nhà xuất bản Kim Đồng – một trong những nhà xuất bản tiên phong đưa thể loại truyện tranh đến với bạn đọc Việt Nam.\r\n\r\nVới mục đích nối dài niềm say mê của độc giả Việt đối với thể loại sách hấp dẫn này, Viện Pháp tại Việt Nam và Nhà xuất bản Kim Đồng phối hợp tổ chức Cuộc thi Sáng tác truyện tranh. Sự kiện này không chỉ là cơ hội để các tác giả, họa sĩ truyện tranh thể hiện tài năng, mà còn đóng góp xây dựng cộng đồng sáng tác truyện tranh và phát triển của dòng sách nghệ thuật này tại Việt Nam.\r\n\r\n\r\n\r\nTác giả tham gia Cuộc thi Sáng tác truyện tranh có cơ hội đến Liên hoan truyện tranh Angoulême, Pháp vào tháng 1/2025.\r\n\r\nTham dự buổi lễ, về phía Nhà xuất bản Kim Đồng có ông Bùi Tuấn Nghĩa – Giám đốc Nhà xuất bản và bà Vũ Thị Quỳnh Liên - Phó Giám đốc, Tổng biên tập; đại diện Viện Pháp tại Việt Nam có ông Franck Bolgiani - Tùy viên Văn hóa, Giám đốc Viện Pháp tại Hà Nội, bà Đỗ Thị Minh Nguyệt, Trưởng phòng Sách và Hội thảo.\r\n\r\n\r\n\r\nĐại diện Viện Pháp tại Việt Nam và Nhà xuất bản Kim Đồng tại buổi kí kết.\r\n\r\nTại buổi kí kết, ông Franck Bolgiani - Giám đốc Viện Pháp tại Hà Nội chia sẻ, Dự án về truyện tranh là một trong những dự án lớn trong khuôn khổ hợp tác văn hóa giữa Pháp và Việt Nam nói chung và của Viện Pháp tại Việt Nam nói riêng. Viện Pháp cũng mong muốn truyện tranh Việt Nam phát triển mạnh mẽ hơn nữa thông qua các hoạt động như tổ chức workshop, hội thảo sáng tác, đào tạo dịch giả, hỗ trợ nhà xuất bản trong công tác chuyển nhượng bản quyền...\r\n\r\nÔng Bùi Tuấn Nghĩa – Giám đốc Nhà xuất bản Kim Đồng khẳng định sự gắn bó lâu dài giữa Viện Pháp tại Việt Nam và Nhà xuất bản Kim Đồng từ gần 30 năm nay. NXB Kim Đồng sẽ tiếp tục đồng hành với Viện Pháp trong lĩnh vực đào tạo và sáng tác truyện tranh, góp phần phát triển bộ môn nghệ thuật này tại Việt Nam.\r\n\r\n','event','Show','2024-06-25 01:01:19','2024-07-27 01:53:23'),(58,'https://file.hstatic.net/200000343865/file/asterix_cover_fb_event_1920_x_1005_px_3d4aabadd0f94f61aca4668df57b1c16_grande.jpg','CUỘC THI SÁNG TÁC TRANH ASTÉRIX CHƠI THỂ THAO CÙNG CÁC BẠN TRẺ VIỆT NAM',6,'Hướng đến Thế vận hội Mùa hè – Olympic Paris 2024 và chuẩn bị chào đón cuốn sách tiếp theo trong bộ sách Astérix – “Astérix ở Thế vận hội” ra mắt độc giả Việt Nam, Viện Pháp tại Hà Nội và NXB Kim Đồng trân trọng tổ chức cuộc thi sáng tác tranh Astérix chơi thể thao cùng các bạn trẻ Việt Nam.\r\n\r\nThời gian nhận bài: 15.5.2024 -> 10.6.2024\r\nThời gian chấm bài: 10.6.2024 -> 16.6.2024\r\nThời gian công bố tác phẩm đoạt giải: 7.2024\r\n\r\nGIỚI THIỆU CHUNG VỀ CUỘC THI\r\n\r\nCuộc thi “Astérix chơi thể thao cùng các bạn trẻ Việt Nam” là cuộc thi sáng tác bằng hình thức vẽ và tạo lời về nhân vật Astérix.\r\n\r\nTHỂ LỆ VỀ CUỘC THI\r\n\r\n1. Đối tượng dự thi\r\n- Cuộc thi dành cho tất cả những người yêu văn học Pháp trong lứa tuổi học sinh (5 – 18 tuổi). \r\n\r\n2. Ban Tổ chức\r\nViện Pháp tại Việt Nam và Nhà xuất bản Kim Đồng.\r\n\r\n3. Điều kiện tham dự\r\nNgười tham dự cần chấp thuận các điều khoản và quyết định được đề ra từ Ban Tổ chức. Các tác phẩm được gửi đến dự thi phải là các tác phẩm gốc, chưa từng được xuất bản hay gửi đến bất kỳ nhà xuất bản nào. Các tác phẩm được giải phải là các tác phẩm hợp lệ chiếu theo điều kiện này và các quy định đề ra trong bản Thể lệ cuộc thi.\r\n\r\n4. Thời gian diễn ra cuộc thi \r\nCuộc thi chính thức bắt đầu vào ngày 15/5/2024 và sẽ kết thúc vào ngày 10/6/2024. \r\n\r\n5. Cách thức tham dự \r\n- Không giới hạn số lượng bài dự thi đối với từng cá nhân. \r\n- Các bài dự thi phải được vẽ trên giấy A3 \r\n- Các tác phẩm đã nộp sẽ không được trả lại.\r\n- Mỗi tác phẩm nếu có phần nội dung thuyết minh thì không được quá 1/3 trang A4\r\n- Bản gốc các bài dự thi cần gửi đến địa chỉ sau : Phòng Sách, Viện Pháp tại Hà Nội, 8 Thiền Quang, Hà Nội\r\n- Người bảo hộ của thí sinh dự thi cần ký giấy chấp thuận cho thí sinh tham gia cuộc thi. \r\n[ Giấy chấp thuận của phụ huynh – Bản tiếng Việt ] \r\n [ Giấy chấp thuận của phụ huynh – Bản tiếng Pháp (Formulaire de consentement parental) ]\r\n\r\n6. Cách thức trao giải \r\nBan tổ chức sẽ chọn ra những thi xuất sắc được giải trong các bài dự thi hợp lệ được gửi đến. Những thí sinh được giải sẽ được thông báo qua email và điện thoại. Danh sách những thí sinh được giải sẽ được công bố trên Facebook fanpage của Viện Pháp tại Hà Nội. \r\n\r\n7. Giải thưởng \r\nBan tổ chức sẽ chọn ra 20 tác phẩm xuất sắc nhất. Các tác phẩm sẽ được triển lãm tại NXB Kim Đồng, 55 Quang Trung, Hà Nội.\r\nCác thí sinh đoạt giải sẽ được nhận quà và giấy chứng nhận từ ban tổ chức nhân Ngày hội Asterix sẽ được tổ chức trong tháng 7 hoặc tháng 9-2024.\r\n\r\n8. Tranh chấp và Trách nhiệm\r\nThí sinh tham gia cuộc thi phải đồng ý chấp hành toàn bộ các điều lệ. Bất kỳ hành vi gian lận nào cũng sẽ khiến thí sinh bị tước bỏ tư cách tham gia \r\n\r\n9. Quyền sở hữu văn học và nghệ thuật\r\nChiểu theo các luật hiện hành liên quan đến sở hữu văn học và nghệ thuật, mọi hành vi sao chụp hay đăng tải một phần hoặc toàn phần các tác phẩm tham gia cuộc thi này cũng đều không được phép. Bằng sự tham gia của mình, các thí sinh đảm bảo cho Ban Tổ chức và Ban Giám khảo không vấp phải bất kỳ sự can thiệp nào của một bên thứ ba đối với những gì liên quan đến tính nguyên bản của tác phẩm dự thi.','event','Hide','2024-06-25 01:16:03','2024-07-27 02:26:53');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `promotion_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `discount_percentage` decimal(8,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`promotion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  `status_id` int unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin',1,'2024-06-24 16:26:34','2024-06-24 16:26:34'),(2,'Marketing',1,'2024-06-24 16:26:34','2024-06-24 16:26:34'),(3,'Sale',1,'2024-06-24 16:26:34','2024-06-24 16:26:34'),(4,'Customer',1,'2024-06-24 16:26:34','2024-06-24 16:26:34'),(5,'Sale Manager',1,'2024-07-25 18:38:03','2024-07-25 18:38:03'),(6,'Shipper',1,'2024-08-01 02:16:47','2024-08-01 02:16:47');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_management`
--

DROP TABLE IF EXISTS `sale_management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_management` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `sale_management_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `sale_management_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_management`
--

LOCK TABLES `sale_management` WRITE;
/*!40000 ALTER TABLE `sale_management` DISABLE KEYS */;
INSERT INTO `sale_management` VALUES (2,4,'2024-07-26 17:25:17','2024-07-26 17:25:17'),(6,3,'2024-07-26 17:25:35','2024-07-26 17:25:35'),(10,3,'2024-07-26 17:25:39','2024-07-26 17:25:39'),(66,3,'2024-08-01 08:39:42','2024-08-01 08:39:42'),(67,3,'2024-08-01 08:37:35','2024-08-01 08:37:35'),(76,3,'2024-08-01 10:42:24','2024-08-01 10:42:24'),(82,3,'2024-08-01 20:08:12','2024-08-01 20:08:12'),(83,3,'2024-08-01 20:15:59','2024-08-01 20:15:59'),(84,3,'2024-08-01 20:57:33','2024-08-01 20:57:33'),(87,3,'2024-08-01 21:25:23','2024-08-01 21:25:23'),(92,3,'2024-08-01 21:57:58','2024-08-01 21:57:58'),(93,117,'2024-08-01 22:08:55','2024-08-01 22:08:55'),(94,117,'2024-08-01 22:12:09','2024-08-01 22:12:09');
/*!40000 ALTER TABLE `sale_management` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ship_management`
--

DROP TABLE IF EXISTS `ship_management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ship_management` (
  `ship_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`ship_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ship_management`
--

LOCK TABLES `ship_management` WRITE;
/*!40000 ALTER TABLE `ship_management` DISABLE KEYS */;
INSERT INTO `ship_management` VALUES (1,6,107,'2024-07-31 01:05:23','2024-07-31 01:05:23'),(2,10,109,'2024-07-31 01:12:43','2024-07-31 01:12:43'),(3,14,106,'2024-07-31 17:31:10','2024-07-31 17:31:10'),(4,67,107,'2024-08-01 15:48:20','2024-08-01 15:48:20'),(5,76,107,'2024-08-01 17:43:37','2024-08-01 17:43:37'),(6,82,107,'2024-08-02 03:09:06','2024-08-02 03:09:06'),(7,83,110,'2024-08-02 03:17:31','2024-08-02 03:17:31'),(8,84,107,'2024-08-02 03:58:16','2024-08-02 03:58:16'),(9,87,107,'2024-08-02 04:27:42','2024-08-02 04:27:42'),(10,92,110,'2024-08-02 04:58:32','2024-08-02 04:58:32'),(11,93,118,'2024-08-02 05:09:35','2024-08-02 05:09:35'),(12,94,118,'2024-08-02 05:12:32','2024-08-02 05:12:32');
/*!40000 ALTER TABLE `ship_management` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_info`
--

DROP TABLE IF EXISTS `shipping_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_info` (
  `shipping_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `action` int DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`shipping_id`),
  KEY `shipping_info_user_id_foreign` (`user_id`),
  CONSTRAINT `shipping_info_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_info`
--

LOCK TABLES `shipping_info` WRITE;
/*!40000 ALTER TABLE `shipping_info` DISABLE KEYS */;
INSERT INTO `shipping_info` VALUES (1,102,NULL,'Bắc Giang',0,'2024-07-26 17:00:28','2024-07-26 17:00:28'),(2,102,NULL,'Cà Mau',1,'2024-07-26 17:00:49','2024-07-26 17:00:49'),(3,9,NULL,'sss',1,'2024-07-26 17:58:31','2024-07-26 17:58:31'),(4,9,NULL,'Hà Giang',1,'2024-07-26 17:58:35','2024-07-26 17:58:35'),(5,106,NULL,'Cầu Giấy',0,'2024-07-27 08:24:57','2024-07-27 08:24:57'),(6,108,NULL,'Bạch Mai',1,'2024-08-01 08:31:00','2024-08-01 08:31:00'),(7,106,'0827365482',NULL,0,'2024-08-01 08:34:36','2024-08-01 08:34:36'),(8,106,'0999999999',NULL,0,'2024-08-01 09:46:11','2024-08-01 09:46:11'),(9,106,'0132465787',NULL,0,'2024-08-01 09:59:27','2024-08-01 09:59:27'),(10,106,NULL,'Mai Dịch',0,'2024-08-01 09:59:44','2024-08-01 09:59:44'),(11,106,NULL,'Hoàng Mai',0,'2024-08-01 10:00:10','2024-08-01 10:00:10'),(12,106,'0999999999',NULL,0,'2024-08-01 10:25:51','2024-08-01 10:25:51'),(13,106,NULL,'Hoàng Mai',0,'2024-08-01 10:25:58','2024-08-01 10:25:58'),(14,106,NULL,'Hoàng Mai',1,'2024-08-01 10:26:55','2024-08-01 10:26:55'),(15,106,'0902347162',NULL,1,'2024-08-01 10:27:18','2024-08-01 10:27:18'),(16,106,'0918634816',NULL,1,'2024-08-01 19:15:36','2024-08-01 19:15:36'),(17,106,NULL,'Cầu Giấy',1,'2024-08-01 19:15:56','2024-08-01 19:15:56'),(18,106,'0993231180',NULL,1,'2024-08-01 21:24:04','2024-08-01 21:24:04'),(19,106,NULL,'Tây Hồ',1,'2024-08-01 21:24:16','2024-08-01 21:24:16'),(20,115,'0398457237',NULL,1,'2024-08-01 21:55:02','2024-08-01 21:55:02'),(21,115,NULL,'Minh Khai',1,'2024-08-01 21:55:29','2024-08-01 21:55:29'),(22,116,'0297342389','Cầu Giấy',1,'2024-08-01 22:04:19','2024-08-01 22:04:19');
/*!40000 ALTER TABLE `shipping_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slider`
--

DROP TABLE IF EXISTS `slider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slider` (
  `slider_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `status` enum('Show','Hide') NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`slider_id`),
  KEY `slider_user_id_foreign` (`user_id`),
  CONSTRAINT `slider_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slider`
--

LOCK TABLES `slider` WRITE;
/*!40000 ALTER TABLE `slider` DISABLE KEYS */;
INSERT INTO `slider` VALUES (2,7,'Mua Sắm Không Tiền Mặt','https://i.ibb.co/gzKBYkr/Ko-Tien-Mat-T424-Slide-840x320-1.jpg','Show','Deal to không lo với ví & ngân hàng'),(3,5,'Queen Of Sale','https://i.ibb.co/F3KT8d2/MCBook-T524-banner-Slide-840x320.jpg','Show','Nhận ưu đãi \"như hoàng tộc\" trong hè này từ kho deal hấp dẫn của nhà cung cấp MCBooks!'),(4,6,'Ưu đãi to trong tháng','img/slider/summersale_resize_mainbanner_840x320.jpg','Hide','Nhận ưu đãi \"như hoàng tộc\" trong hè này');
/*!40000 ALTER TABLE `slider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userchangehistory`
--

DROP TABLE IF EXISTS `userchangehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userchangehistory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `field_name` varchar(255) NOT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  `updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `userchangehistory_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userchangehistory`
--

LOCK TABLES `userchangehistory` WRITE;
/*!40000 ALTER TABLE `userchangehistory` DISABLE KEYS */;
INSERT INTO `userchangehistory` VALUES (1,101,'fullname','hoa','Hoan','2024-07-25 19:20:51'),(2,101,'address','','null','2024-07-25 19:20:51');
/*!40000 ALTER TABLE `userchangehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int unsigned NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `deleted` enum('no','yes') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'no',
  `updated_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_phone_unique` (`phone`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@gmail.com','0987654321','ddfa08f04ffbedd937ce079026ead9826c0f4572feee5e45ff2a66d058c0c9d5',1,'Admin','Nam',NULL,'','2024-06-24 16:26:34','2024-07-21 10:28:56','active','no','2024-07-27 01:34:49'),(2,'sale123@gmail.com','5555555555','d4a5c2fe9b4dda1c7268203a542866647ded72c7ced27167b22e7e6740de6078',5,'Sale1','Nữ',NULL,'Hải Phòng','2024-06-24 16:26:34','2024-06-24 16:26:34','active','no','2024-07-27 01:35:29'),(3,'sale456@gmail.com','1111111111','2800113c82318256fc4f98d00675b2ba489bed388ceb70bccdbf176aa13e7b81',3,'Sale2','Nam',NULL,'','2024-06-24 16:26:34','2024-07-27 09:03:10','active','no','2024-07-27 09:03:10'),(4,'sale789@gmail.com','9999999999','sale7890@',3,'Sale3','Nữ',NULL,'','2024-06-24 16:26:34','2024-07-27 09:01:29','active','no','2024-07-27 09:01:28'),(5,'marketing123@gmail.com','0975219245','f13a65e0f956f028151b3eda0b2f969e81784ceb25e7406653d4d1c3db81dd17',2,'Marketing1','Male',NULL,'Hà Nội','2024-06-24 16:26:34','2024-06-25 09:48:14','active','no','2024-07-27 01:36:48'),(6,'marketing456@gmail.com','6544101778','marketing456@',2,'Marketing2','Nam',NULL,'Bắc Giang','2024-06-24 16:26:34','2024-06-24 16:26:34','active','no','2024-07-25 19:04:50'),(7,'marketing789@gmail.com','5438965441','marketing789@',2,'Marketing3','Nữ',NULL,'Hà Nam','2024-06-24 16:26:34','2024-06-24 16:26:34','active','no','2024-07-25 19:04:50'),(8,'vuhuuban04092003@gmail.com','0522916847','123456789Ban!',4,'Vũ Hữu Bản','Nam',NULL,'Hà Nội','2024-06-24 16:26:34','2024-06-24 16:26:34','active','no','2024-07-25 19:04:50'),(9,'thanhtung2733@gmail.com','0395450996','943f4a266a184ebe3ac80999852c671df2d9ca43afd7664b13f1a2cf6fe22a7c',4,'Nguyen Thanh Tung','Male','uploads/8935244876895.jpg','Hà Nội','2024-07-26 18:37:06','2024-07-27 02:49:55','active','no','2024-07-27 02:49:55'),(10,'tt273@gmail.com','0123456789','1233',4,'Nguyễn Thanh Tùng',NULL,NULL,'sss','2024-06-24 18:25:33','2024-06-24 18:25:33','active','no','2024-07-25 19:04:50'),(14,'wwww@gmail.com','5555','22222222222',4,'gtdrf','Nữ',NULL,'','2024-06-24 18:29:42','2024-07-19 08:14:21','active','no','2024-07-25 19:04:50'),(18,'tthanh@gmail.com','0357746598','2222',4,'Nguyễn Thanh Tùng',NULL,NULL,'Hà Nội','2024-06-24 18:54:59','2024-06-24 18:54:59','active','no','2024-07-25 19:04:50'),(23,'binhnt@gmail.com','0567895123','A12345678',4,'Nguyễn Thanh Bình',NULL,NULL,'Hải Phòng','2024-06-25 07:25:29','2024-06-25 07:25:29','active','no','2024-07-25 19:04:50'),(24,'dungnt@gmail.com','0547621589','Dung1234',4,'Nguyễn Tiến Dũng',NULL,NULL,'Lào Cai','2024-06-25 07:27:00','2024-06-25 07:27:00','active','no','2024-07-25 19:04:50'),(25,'','','',4,'',NULL,NULL,'','2024-06-28 06:32:20','2024-06-28 06:32:20','active','yes','2024-07-25 19:04:50'),(65,'nguyen.van.a@gmail.com','123456789','password1',4,'Nguyễn Văn A','Nữ','','','2024-05-14 17:00:00','2024-07-19 08:08:43','active','yes','2024-07-25 19:04:50'),(66,'tran.thi.b@gmail.com','0123456790','password2',4,'Trần Thị B','Nữ','','Hồ Chí Minh','2024-06-14 17:00:00','2024-06-14 17:00:00','active','no','2024-07-25 19:04:50'),(67,'le.van.c@gmail.com','0123456791','password3',4,'Lê Văn C','Nam','','Đà Nẵng','2024-06-15 17:00:00','2024-06-15 17:00:00','active','no','2024-07-25 19:04:50'),(68,'pham.thi.d@gmail.com','0123456792','password4',4,'Phạm Thị D','Nữ','','Hải Phòng','2024-06-16 17:00:00','2024-06-16 17:00:00','active','yes','2024-07-25 19:04:50'),(69,'hoang.van.e@gmail.com','0123456793','password5',4,'Hoàng Văn E','Nam','','Cần Thơ','2024-06-17 17:00:00','2024-06-17 17:00:00','active','no','2024-07-25 19:04:50'),(70,'ngo.thi.f@gmail.com','0123456794','password6',4,'Ngô Thị F','Nữ','','Nha Trang','2024-06-18 17:00:00','2024-06-18 17:00:00','active','no','2024-07-25 19:04:50'),(71,'vu.van.g@gmail.com','0123456795','password7',4,'Vũ Văn G','Female','','','2024-06-19 17:00:00','2024-07-19 07:53:09','active','no','2024-07-25 19:04:50'),(72,'nguyen.thi.h@gmail.com','0123456796','password8',4,'Nguyễn Thị H','Nữ','','Biên Hòa','2024-06-20 17:00:00','2024-06-20 17:00:00','active','no','2024-07-25 19:04:50'),(73,'pham.van.i@gmail.com','0123456797','password9',4,'Phạm Văn I','Nam','','Vũng Tàu','2024-06-21 17:00:00','2024-06-21 17:00:00','active','no','2024-07-25 19:04:50'),(74,'tran.thi.j@gmail.com','0123456798','password10',4,'Trần Thị J','Nữ','','Đà Lạt','2024-06-22 17:00:00','2024-06-22 17:00:00','active','no','2024-07-25 19:04:50'),(75,'le.van.k@gmail.com','0123456799','password11',4,'Lê Văn K','Nam','','Buôn Ma Thuột','2024-06-23 17:00:00','2024-06-23 17:00:00','active','no','2024-07-25 19:04:50'),(76,'ngo.thi.l@gmail.com','0123456800','password12',4,'Ngô Thị L','Nữ','','Long Xuyên','2024-06-24 17:00:00','2024-06-24 17:00:00','active','no','2024-07-25 19:04:50'),(77,'vu.van.m@gmail.com','0123456801','password13',4,'Vũ Văn M','Nam','','Rạch Giá','2024-06-25 17:00:00','2024-06-25 17:00:00','active','no','2024-07-25 19:04:50'),(78,'pham.thi.n@gmail.com','0123456802','password14',4,'Phạm Thị N','Nữ','','Thái Nguyên','2024-06-26 17:00:00','2024-06-26 17:00:00','active','yes','2024-07-25 19:04:50'),(79,'nguyen.van.o@gmail.com','0123456803','password15',4,'Nguyễn Văn O','Nam','','Quy Nhơn','2024-06-27 17:00:00','2024-06-27 17:00:00','active','no','2024-07-25 19:04:50'),(80,'tran.thi.p@gmail.com','0123456804','password16',4,'Trần Thị P','Nữ','','Pleiku','2024-06-28 17:00:00','2024-06-28 17:00:00','active','no','2024-07-25 19:04:50'),(81,'le.van.q@gmail.com','0123456805','password17',4,'Lê Văn Q','Nam','','Bảo Lộc','2024-06-29 17:00:00','2024-06-29 17:00:00','active','no','2024-07-25 19:04:50'),(82,'ngo.thi.r@gmail.com','0123456806','password18',4,'Ngô Thị R','Nữ','','Phan Thiết','2024-06-30 17:00:00','2024-06-30 17:00:00','active','no','2024-07-25 19:04:50'),(83,'vu.van.s@gmail.com','0123456807','password19',4,'Vũ Văn S','Nam','','Tuy Hòa','2024-07-01 17:00:00','2024-07-01 17:00:00','active','no','2024-07-25 19:04:50'),(84,'pham.thi.t@gmail.com','0123456808','password20',4,'Phạm Thị T','Nữ','','Cà Mau','2024-07-02 17:00:00','2024-07-02 17:00:00','active','yes','2024-07-25 19:04:50'),(85,'nguyen.van.u@gmail.com','0123456810','password21',4,'Nguyễn Văn U','Nam','','Hà Nội','2024-07-03 17:00:00','2024-07-03 17:00:00','active','no','2024-07-25 19:04:50'),(86,'tran.thi.v@gmail.com','0123456811','password22',4,'Trần Thị V','Nữ','','Hồ Chí Minh','2024-07-04 17:00:00','2024-07-04 17:00:00','active','no','2024-07-25 19:04:50'),(87,'le.van.w@gmail.com','0123456812','password23',4,'Lê Văn W','Nam','','Đà Nẵng','2024-07-05 17:00:00','2024-07-05 17:00:00','active','no','2024-07-25 19:04:50'),(88,'pham.thi.x@gmail.com','0123456813','password24',4,'Phạm Thị X','Nữ','','Hải Phòng','2024-07-06 17:00:00','2024-07-06 17:00:00','active','no','2024-07-25 19:04:50'),(89,'hoang.van.y@gmail.com','0123456814','password25',4,'Hoàng Văn Y','Nam','','Cần Thơ','2024-07-07 17:00:00','2024-07-07 17:00:00','active','no','2024-07-25 19:04:50'),(90,'ngo.thi.z@gmail.com','0123456815','password26',4,'Ngô Thị Z','Nữ','','Nha Trang','2024-07-08 17:00:00','2024-07-08 17:00:00','active','no','2024-07-25 19:04:50'),(91,'vu.van.anh@gmail.com','0123456816','password27',4,'Vũ Văn Ánh','Nam','','Huế','2024-07-09 17:00:00','2024-07-09 17:00:00','active','no','2024-07-25 19:04:50'),(92,'nguyen.thi.binh@gmail.com','0123456817','password28',4,'Nguyễn Thị Bình','Nữ','','Biên Hòa','2024-07-10 17:00:00','2024-07-10 17:00:00','active','no','2024-07-25 19:04:50'),(93,'pham.van.cuong@gmail.com','0123456818','password29',4,'Phạm Văn Cường','Nam','','Vũng Tàu','2024-07-11 17:00:00','2024-07-11 17:00:00','active','no','2024-07-25 19:04:50'),(94,'tran.thi.dieu@gmail.com','0123456819','password30',4,'Trần Thị Diệu','Nữ','','Đà Lạt','2024-07-12 17:00:00','2024-07-12 17:00:00','active','no','2024-07-25 19:04:50'),(95,'camau.1@gmail.com','0258741369','camau1!4',4,'Nguyễn Thanh Tùng','Nam',NULL,'Cà Mau','2024-07-14 10:01:14','2024-07-14 10:01:14','active','no','2024-07-25 19:04:50'),(96,'camau.2@gmail.com','0258147963','camau2thanhtung@',4,'Nguyễn Thanh Tùng','Nam',NULL,'Cà Mau','2024-07-14 10:06:32','2024-07-14 10:06:32','active','no','2024-07-25 19:04:50'),(98,'soctrang.1@gmail.com','0258714369','soctrang1thanhtung%',4,'Nguyễn Thanh Tùng','Nam',NULL,'Sóc Trăng','2024-07-14 10:09:08','2024-07-14 10:09:08','active','no','2024-07-25 19:04:50'),(99,'hagiang.1@gmail.com','0987654329','hagiang1111#',4,'Nguyễn Đình Đức','Nam',NULL,'Hà Giang','2024-07-14 10:13:44','2024-07-14 10:13:44','active','no','2024-07-25 19:04:50'),(101,'hoa@gmail.com','0329981983','thanhtung123@',2,'Hoan','Nữ','',NULL,'2024-07-19 08:11:22','2024-07-19 08:11:22','active','no','2024-07-25 19:20:51'),(102,'thanhtung3372@gmail.com','0555555555','13456789Tung!',4,'Nguyễn Thanh Tùng','Nam','','Hà Giang','2024-07-26 16:56:18','2024-07-26 16:56:18','active','no','2024-07-26 16:56:17'),(103,'thanhtung2734@gmail.com','0333333333','1eb499a58a4926425a0b36725fa39241cf07a8a69bf7bd35a0636e98cddca34b',4,'Nguyễn Thanh Tùng','Nam','','Hà Nội','2024-07-26 18:16:04','2024-07-26 18:16:04','active','no','2024-07-26 18:16:04'),(104,'thanhtung2735@gmail.com','0258741069','ae6ca0846a9f1d6c65220d6eff9540be57a7ddad747bd453d630af53ed44eb69',4,'Nguyễn Thanh Tùng','Nam','','Hà Nội','2024-07-26 18:19:50','2024-07-26 18:19:50','active','no','2024-07-26 18:19:49'),(105,'thanhtung2736@gmail.com','0258147964','a26ada0cd5a9b185cfa430fb38741af566a1f462a7b9437ea4419e64c5682a66',4,'Nguyễn Thanh Tùng','Nam','','Hà Nội','2024-07-26 18:20:55','2024-07-26 18:20:55','active','no','2024-07-26 18:20:54'),(106,'ng.dinhduc.2311@gmail.com','0328830583','4031a4498dc234b13d6debcb4b5a38490f7ca51ce2d6a3817e56ebe74df0611d',4,'Nguyễn Đình Đức','Male','uploads/9c30b7d33e098f701dbf84024065a6d0.jpeg','Bắc Từ Liêm','2024-07-27 09:09:24','2024-08-01 20:05:06','active','no','2024-08-01 20:05:06'),(107,'shipper@gmail.com','0178943283','223aa5b36b74f2d0e0d1b6ed6af7bdc6d0f23d9148e6713155eee9942bf92475',6,'Shipper1','Name',NULL,NULL,'2024-08-01 02:19:09','2024-08-01 02:19:09','active','no','2024-08-01 02:19:09'),(108,'ducndhe171600@fpt.edu.vn','0196473582','4031a4498dc234b13d6debcb4b5a38490f7ca51ce2d6a3817e56ebe74df0611d',4,'Nguyễn Đình Đức','Nam','','Cầu Giấy','2024-08-01 08:28:58','2024-08-01 08:28:58','active','no','2024-08-01 08:28:57'),(109,'quyet123@gmail.com','0913276472','8b619d5038c60d3efc645b202565c61032e2a291eded726a3892baa925de8f60',4,'Trịnh Văn Quyết','Nam',NULL,NULL,'2024-08-01 20:11:35','2024-08-01 20:11:35','active','no','2024-08-01 20:11:35'),(110,'shipper2@gmail.com','0827363482','223aa5b36b74f2d0e0d1b6ed6af7bdc6d0f23d9148e6713155eee9942bf92475',6,'Shipper','Nam',NULL,NULL,'2024-08-01 20:14:29','2024-08-01 20:14:29','active','no','2024-08-01 20:14:29'),(111,'hoang12345@gmail.com','0287396523','ad26acc4f9b48b79d479d09bca3e1bb468ba00a3adace907808f9db6aeef0a1b',4,'Hoàng ','Nam',NULL,NULL,'2024-08-01 20:23:54','2024-08-01 20:23:54','active','no','2024-08-01 20:23:54'),(112,'binh123@gmail.com','0294587926','9adcef854ace3b2fd79056967e7238118629efc638a33161a255c4caeb9d9592',4,'Trương Gia Bình','Nam','','Cầu Giấy','2024-08-01 21:15:16','2024-08-01 21:15:16','active','no','2024-08-01 21:15:15'),(113,'phamlong@gmail.com','0238947562','b3ec696ee22a7c0efa2c7388f2a7a4d2d6964658746f18d86e49caba9c875b83',4,'Phạm Long','Nam',NULL,NULL,'2024-08-01 21:29:53','2024-08-01 21:29:53','active','no','2024-08-01 21:29:53'),(114,'phong123@gmail.com','0297346801','bdee171fc038899f7a37c87af644326f8c3203f55ad200afd7abb687451fe52a',4,'Phong','Nam','','','2024-08-01 21:38:21','2024-08-01 21:38:21','active','no','2024-08-01 21:38:21'),(115,'nhi123@gmail.com','0289475236','4031a4498dc234b13d6debcb4b5a38490f7ca51ce2d6a3817e56ebe74df0611d',4,'Nguyễn Yến Nhi','Nữ','','Cầu Giấy','2024-08-01 21:54:24','2024-08-01 21:54:24','active','no','2024-08-01 21:54:23'),(116,'phanson123@gmail.com','0237460926','ade98243b5e51059436942c6917e2eab920decf07bfb953168363d0869b67cec',4,'Phan Sơn','Nam',NULL,NULL,'2024-08-01 22:01:54','2024-08-01 22:01:54','active','no','2024-08-01 22:01:54'),(117,'sale444@gmail.com','0729843563','3a214496254ef9b1a5f1334d8f1aafc5a7be7ef78b1cc400b776e93424daa1a6',3,'Sale','Nam',NULL,NULL,'2024-08-01 22:02:30','2024-08-01 22:02:30','active','no','2024-08-01 22:02:30'),(118,'shipper3@gmail.com','0298734523','223aa5b36b74f2d0e0d1b6ed6af7bdc6d0f23d9148e6713155eee9942bf92475',6,'Shipper','Nam',NULL,NULL,'2024-08-01 22:03:05','2024-08-01 22:03:05','active','no','2024-08-01 22:03:05');
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

-- Dump completed on 2024-08-03 12:17:41
