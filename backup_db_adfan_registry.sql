/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.27-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: adfan_registry_db
-- ------------------------------------------------------
-- Server version	10.5.27-MariaDB-ubu2004

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add attendee',7,'add_attendee'),(26,'Can change attendee',7,'change_attendee'),(27,'Can delete attendee',7,'delete_attendee'),(28,'Can view attendee',7,'view_attendee'),(29,'Can add review',8,'add_review'),(30,'Can change review',8,'change_review'),(31,'Can delete review',8,'delete_review'),(32,'Can view review',8,'view_review'),(33,'Can add table',9,'add_table'),(34,'Can change table',9,'change_table'),(35,'Can delete table',9,'delete_table'),(36,'Can view table',9,'view_table'),(37,'Can add file download',10,'add_filedownload'),(38,'Can change file download',10,'change_filedownload'),(39,'Can delete file download',10,'delete_filedownload'),(40,'Can view file download',10,'view_filedownload');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$9U2I84ZaQVcbuPv9Le8N6E$x9VKVOcljRqT7HCOireAkDtGbogo3/igxusF2jNQ10Y=','2024-11-14 02:49:49.750435',1,'leomarrg','','','leomarrg@gmail.com',1,1,'2024-11-02 23:42:29.376862'),(2,'pbkdf2_sha256$600000$sHgTZ6Eanus5UU0hC8S6dP$Intqlzn1KBLTYQYEpwTeS604UtJ+wyjKWm1nXgWpYLk=','2024-11-14 00:40:07.310655',0,'fernando','','','',1,1,'2024-11-14 00:37:46.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (1,2,26),(2,2,28);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-11-09 06:52:14.673533','2','Satisfaction: sas, Usefulness: sasa, Date: 2024-11-09 06:52:14.672129+00:00',1,'[{\"added\": {}}]',8,1),(2,'2024-11-09 06:52:29.437369','2','Satisfaction: sas, Usefulness: sasa, Date: 2024-11-09 06:52:14.672129+00:00',3,'',8,1),(3,'2024-11-13 22:39:52.599910','22','Leomar Rodriguez Gonzalez',2,'[{\"changed\": {\"fields\": [\"Arrived\"]}}]',7,1),(4,'2024-11-13 22:40:27.571747','21','Leomar Rodriguez Gonzalez',2,'[{\"changed\": {\"fields\": [\"Arrived\"]}}]',7,1),(5,'2024-11-13 22:40:27.577854','20','Leomar Velez',2,'[{\"changed\": {\"fields\": [\"Arrived\"]}}]',7,1),(6,'2024-11-13 22:40:27.579913','19','Fernando Ortiz',2,'[{\"changed\": {\"fields\": [\"Arrived\"]}}]',7,1),(7,'2024-11-13 22:58:30.071884','1','Table 1',1,'[{\"added\": {}}]',9,1),(8,'2024-11-13 22:58:32.357162','2','Table 2',1,'[{\"added\": {}}]',9,1),(9,'2024-11-13 22:58:52.347073','3','Table 3',1,'[{\"added\": {}}]',9,1),(10,'2024-11-13 22:58:57.655392','4','Table 4',1,'[{\"added\": {}}]',9,1),(11,'2024-11-13 22:59:01.187296','5','Table 6',1,'[{\"added\": {}}]',9,1),(12,'2024-11-13 22:59:08.118274','6','Table 5',1,'[{\"added\": {}}]',9,1),(13,'2024-11-13 22:59:12.272565','7','Table 7',1,'[{\"added\": {}}]',9,1),(14,'2024-11-13 22:59:32.922930','8','Table 8',1,'[{\"added\": {}}]',9,1),(15,'2024-11-13 22:59:37.662925','9','Table 9',1,'[{\"added\": {}}]',9,1),(16,'2024-11-13 22:59:41.463026','10','Table 10',1,'[{\"added\": {}}]',9,1),(17,'2024-11-13 23:00:52.927088','11','Table 11',1,'[{\"added\": {}}]',9,1),(18,'2024-11-13 23:01:01.600426','12','Table 12',1,'[{\"added\": {}}]',9,1),(19,'2024-11-13 23:01:07.072742','13','Table 13',1,'[{\"added\": {}}]',9,1),(20,'2024-11-13 23:01:09.461449','14','Table 14',1,'[{\"added\": {}}]',9,1),(21,'2024-11-13 23:01:13.564144','15','Table 15',1,'[{\"added\": {}}]',9,1),(22,'2024-11-13 23:01:15.697819','16','Table 16',1,'[{\"added\": {}}]',9,1),(23,'2024-11-13 23:01:18.264948','17','Table 17',1,'[{\"added\": {}}]',9,1),(24,'2024-11-13 23:01:21.781533','18','Table 18',1,'[{\"added\": {}}]',9,1),(25,'2024-11-13 23:01:24.624113','19','Table 19',1,'[{\"added\": {}}]',9,1),(26,'2024-11-13 23:01:27.412788','20','Table 20',1,'[{\"added\": {}}]',9,1),(27,'2024-11-13 23:01:30.800155','21','Table 21',1,'[{\"added\": {}}]',9,1),(28,'2024-11-13 23:01:33.187353','22','Table 22',1,'[{\"added\": {}}]',9,1),(29,'2024-11-13 23:01:36.118035','23','Table 23',1,'[{\"added\": {}}]',9,1),(30,'2024-11-13 23:01:40.795218','24','Table 24',1,'[{\"added\": {}}]',9,1),(31,'2024-11-13 23:01:44.495406','25','Table 25',1,'[{\"added\": {}}]',9,1),(32,'2024-11-13 23:02:09.599871','2','Table 2',2,'[{\"changed\": {\"fields\": [\"Max seats\"]}}]',9,1),(33,'2024-11-13 23:02:21.845738','22','Leomar Rodriguez Gonzalez',2,'[{\"changed\": {\"fields\": [\"Arrived\"]}}]',7,1),(34,'2024-11-13 23:02:21.847063','21','Leomar Rodriguez Gonzalez',2,'[{\"changed\": {\"fields\": [\"Arrived\"]}}]',7,1),(35,'2024-11-13 23:02:21.847763','20','Leomar Velez',2,'[{\"changed\": {\"fields\": [\"Arrived\"]}}]',7,1),(36,'2024-11-13 23:02:21.848455','19','Fernando Ortiz',2,'[{\"changed\": {\"fields\": [\"Arrived\"]}}]',7,1),(37,'2024-11-14 00:37:46.431983','2','fernando',1,'[{\"added\": {}}]',4,1),(38,'2024-11-14 00:38:24.046859','2','fernando',2,'[{\"changed\": {\"fields\": [\"User permissions\"]}}]',4,1),(39,'2024-11-14 00:39:49.843557','2','fernando',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),(40,'2024-11-20 16:26:40.376492','5','7 Recurso Nayda Fernández EQUILIBRIO TOTAL 2024.pdf',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(41,'2024-11-20 16:26:40.377754','4','6_Recurso_Marta_Hernández_15_de_noviembre_de_2024_130_230_Vivo.pptx',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(42,'2024-11-20 16:26:40.378850','3','5_Recurso_Vicenty_Impacto_Legal_y_Social_de_la_Adopción_en_el_Bienestar.pptx',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(43,'2024-11-20 16:26:40.380084','2','4 Opusculo CODERI.pdf',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(44,'2024-11-20 16:26:40.381009','1','1_Recurso_Yolanda_Rodríguez_Presentacion_Adopcion_y_Discapacidad.pptx',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(45,'2024-11-20 16:37:01.458050','5','7 Recurso Nayda Fernández EQUILIBRIO TOTAL 2024.pdf',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(46,'2024-11-20 16:37:01.466869','4','6_Recurso_Marta_Hernández_15_de_noviembre_de_2024_130_230_Vivo.pptx',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(47,'2024-11-20 16:37:01.467934','3','5_Recurso_Vicenty_Impacto_Legal_y_Social_de_la_Adopción_en_el_Bienestar.pptx',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(48,'2024-11-20 16:37:01.468954','2','4 Opusculo CODERI.pdf',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(49,'2024-11-20 16:37:01.470073','1','1_Recurso_Yolanda_Rodríguez_Presentacion_Adopcion_y_Discapacidad.pptx',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(50,'2024-11-20 21:57:34.655242','8','Example Video',3,'',10,1),(51,'2024-11-20 21:57:43.164990','7','Video without Title',3,'',10,1),(52,'2024-11-20 21:57:43.166823','6','Video without Title',3,'',10,1),(53,'2024-11-20 23:11:40.238658','2','files/7_Recurso_Nayda_Fernandez_EQUILIBRIO_TOTAL_2024.pdf',1,'[{\"added\": {}}]',10,1),(54,'2024-11-20 23:12:34.056645','2','hola es una prueba',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1),(55,'2024-11-20 23:56:19.836584','3','files/7mo_Congreso_de_Adopción.mp4',1,'[{\"added\": {}}]',10,1),(56,'2024-11-21 00:05:38.875644','3','video congreso adopcion',2,'[{\"changed\": {\"fields\": [\"Display name\"]}}]',10,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'registry_app','attendee'),(10,'registry_app','filedownload'),(8,'registry_app','review'),(9,'registry_app','table'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-11-02 23:14:30.372177'),(2,'auth','0001_initial','2024-11-02 23:14:30.689459'),(3,'admin','0001_initial','2024-11-02 23:14:30.768467'),(4,'admin','0002_logentry_remove_auto_add','2024-11-02 23:14:30.773467'),(5,'admin','0003_logentry_add_action_flag_choices','2024-11-02 23:14:30.780101'),(6,'contenttypes','0002_remove_content_type_name','2024-11-02 23:14:30.819545'),(7,'auth','0002_alter_permission_name_max_length','2024-11-02 23:14:30.860633'),(8,'auth','0003_alter_user_email_max_length','2024-11-02 23:14:30.871679'),(9,'auth','0004_alter_user_username_opts','2024-11-02 23:14:30.876918'),(10,'auth','0005_alter_user_last_login_null','2024-11-02 23:14:30.903532'),(11,'auth','0006_require_contenttypes_0002','2024-11-02 23:14:30.905715'),(12,'auth','0007_alter_validators_add_error_messages','2024-11-02 23:14:30.911194'),(13,'auth','0008_alter_user_username_max_length','2024-11-02 23:14:30.921919'),(14,'auth','0009_alter_user_last_name_max_length','2024-11-02 23:14:30.933898'),(15,'auth','0010_alter_group_name_max_length','2024-11-02 23:14:30.945369'),(16,'auth','0011_update_proxy_permissions','2024-11-02 23:14:30.952249'),(17,'auth','0012_alter_user_first_name_max_length','2024-11-02 23:14:30.962461'),(22,'sessions','0001_initial','2024-11-02 23:14:31.129530');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('sg8kb5dc2231eu598dqujj0mhw010xas','.eJxVjDsOwyAQBe9CHSHAfFOm9xnQLqyDkwgkY1dR7h5bcpG0b2bem0XY1hK3TkucM7syyS6_G0J6Uj1AfkC9N55aXZcZ-aHwk3Y-tkyv2-n-HRToZa9JKeG1wmAzJm8lZAIS4JIJpLIBkKRRT86bAYJ3nnDaXTIkhkDWB_b5AvtjOHs:1tBPvZ:r4UHrf1d2AjiT7hrSGj8Dyeo_BLGV7WUSMQNVUbyrhI','2024-11-28 02:49:49.753806');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registry_app_attendee`
--

DROP TABLE IF EXISTS `registry_app_attendee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_app_attendee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `pre_registered` tinyint(1) NOT NULL,
  `registered_at_event` tinyint(1) NOT NULL,
  `registration_date` datetime(6) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `arrived` tinyint(1) NOT NULL,
  `seat_number` int(10) unsigned DEFAULT NULL CHECK (`seat_number` >= 0),
  `table_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `registry_app_attendee_table_id_306cd23b_fk_registry_app_table_id` (`table_id`),
  KEY `registry_app_attendee_last_name_0f7a4f7b` (`last_name`),
  KEY `registry_app_attendee_name_22cb515a` (`name`),
  CONSTRAINT `registry_app_attendee_table_id_306cd23b_fk_registry_app_table_id` FOREIGN KEY (`table_id`) REFERENCES `registry_app_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry_app_attendee`
--

LOCK TABLES `registry_app_attendee` WRITE;
/*!40000 ALTER TABLE `registry_app_attendee` DISABLE KEYS */;
INSERT INTO `registry_app_attendee` VALUES (1,'Leomar','Rodriguez','leomar@upr.edu','6768239812',1,0,'2024-11-02 23:43:36.411069','1957-01-23',1,10,2),(2,'Paola','Aviles','paola@gmail.com','5401980329',0,1,'2024-11-03 03:35:51.834818','1998-11-19',1,9,2),(3,'Angeliz','Trochez','angy@gmail.com','4561984209',1,0,'2024-11-03 05:41:55.833472','1987-08-19',1,8,2),(4,'Leomar-after-finishing','Rodriguez Gonzalez','leomar@gmail.com','9291830192',1,0,'2024-11-04 17:58:07.994136','1999-11-17',1,7,2),(5,'Fernando','Vera Nieves','fveragay@gmail.com','7873829013',1,0,'2024-11-04 18:02:16.026477','2024-11-06',1,6,2),(6,'Roman','Vazquez','leomarrg@gmail.com','2349023431',1,0,'2024-11-06 21:08:51.311212','2024-11-03',1,5,2),(7,'Leomar','Rodriguez','leomarrg12@gmail.com','9291830192',1,0,'2024-11-06 21:16:40.245753','2024-11-20',1,4,2),(8,'Leomar','Wilfredo','leomarrg123@gmail.com','8789878793',1,0,'2024-11-06 21:19:13.049922','2024-11-05',1,3,2),(9,'Fernando','Vera','leomarrg4@gmail.com','9291830192',1,0,'2024-11-06 21:23:02.301132','2024-11-06',1,1,2),(10,'Angeliz','Rodriguez Gonzalez','fvphotos@upra.edu','2349023431',1,0,'2024-11-06 21:24:01.940763','2024-11-06',1,2,2),(11,'Fernando','Wilfredo','leomarrg33@gmail.com','9291830192',1,0,'2024-11-06 21:25:32.041775','2024-12-03',1,12,1),(12,'Fernando','Vera','leomarrg600@gmail.com','8789878793',1,0,'2024-11-06 21:29:57.524994',NULL,1,11,1),(13,'Paola','Trochez','leomarrg87@gmail.com','7876787892',1,0,'2024-11-06 21:33:33.026530','2024-11-02',1,5,1),(14,'William Antonio','Ortiz','leo3marrg@gmail.com','7876787892',1,0,'2024-11-06 21:38:24.921171','2024-11-20',1,10,1),(15,'Fernando','Rodriguez','l3eomarrg@gmail.com','9291830192',1,0,'2024-11-06 21:42:07.659671',NULL,1,7,1),(16,'Angeliz','Ortiz','fdfdsfdfveragay@gmail.com','2347581029',1,0,'2024-11-06 21:43:42.104073',NULL,1,9,1),(17,'Fernando','Rodriguez','l66eomarrg@gmail.com','2347581029',1,0,'2024-11-06 21:53:33.862372',NULL,1,8,1),(18,'Leomar','Ortiz','fveragay1@gmail.com','2347581029',1,0,'2024-11-06 21:58:28.194038','2024-11-04',1,6,1),(19,'Fernando','Ortiz','leomarrg13@gmail.com','9291830192',1,0,'2024-11-06 22:16:47.164861','2024-11-11',1,4,1),(20,'Leomar','Velez','leomarrg64@gmail.com','9291830192',1,0,'2024-11-06 23:48:03.797913','2024-11-11',1,3,1),(21,'Leomar','Rodriguez Gonzalez','leomarg@gmail.com','9392570148',0,1,'2024-11-07 18:59:07.292226','2024-11-14',1,2,1),(22,'Leomar','Rodriguez Gonzalez','leo@gmail.com','5678901234',0,1,'2024-11-07 19:00:10.176850','2024-11-25',1,1,1);
/*!40000 ALTER TABLE `registry_app_attendee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registry_app_filedownload`
--

DROP TABLE IF EXISTS `registry_app_filedownload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_app_filedownload` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file` varchar(255) NOT NULL,
  `download_count` int(11) NOT NULL DEFAULT 0,
  `display_name` text DEFAULT NULL,
  `is_video` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry_app_filedownload`
--

LOCK TABLES `registry_app_filedownload` WRITE;
/*!40000 ALTER TABLE `registry_app_filedownload` DISABLE KEYS */;
INSERT INTO `registry_app_filedownload` VALUES (1,'videos/sample_video.mp4',0,'Sample Video',1),(2,'files/7_Recurso_Nayda_Fernandez_EQUILIBRIO_TOTAL_2024.pdf',0,'hola es una prueba',0),(3,'files/7mo_Congreso_de_Adopción.mp4',0,'video congreso adopcion',0);
/*!40000 ALTER TABLE `registry_app_filedownload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registry_app_review`
--

DROP TABLE IF EXISTS `registry_app_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_app_review` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comments` longtext NOT NULL,
  `review_date` datetime(6) NOT NULL,
  `satisfaction` varchar(50) NOT NULL,
  `usefulness` varchar(50) NOT NULL,
  `category` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry_app_review`
--

LOCK TABLES `registry_app_review` WRITE;
/*!40000 ALTER TABLE `registry_app_review` DISABLE KEYS */;
INSERT INTO `registry_app_review` VALUES (3,'ss','2024-11-11 05:37:55.621655','Muy satisfecho','Mucha utilidad','option1'),(4,'fffffff','2024-11-11 05:39:46.802167','Satisfecho','No es pertinente a la labor que realizo','option1'),(5,'sss','2024-11-11 06:06:47.506028','No satisfecho','No es pertinente a la labor que realizo','option1'),(6,'herrou','2024-11-11 06:06:58.262249','No satisfecho','De utilidad','option3');
/*!40000 ALTER TABLE `registry_app_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registry_app_table`
--

DROP TABLE IF EXISTS `registry_app_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_app_table` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `table_number` int(10) unsigned NOT NULL CHECK (`table_number` >= 0),
  `max_seats` int(10) unsigned NOT NULL CHECK (`max_seats` >= 0),
  PRIMARY KEY (`id`),
  UNIQUE KEY `table_number` (`table_number`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry_app_table`
--

LOCK TABLES `registry_app_table` WRITE;
/*!40000 ALTER TABLE `registry_app_table` DISABLE KEYS */;
INSERT INTO `registry_app_table` VALUES (1,1,12),(2,2,12),(3,3,12),(4,4,12),(5,6,12),(6,5,12),(7,7,12),(8,8,12),(9,9,12),(10,10,12),(11,11,12),(12,12,12),(13,13,12),(14,14,12),(15,15,12),(16,16,12),(17,17,12),(18,18,12),(19,19,12),(20,20,12),(21,21,12),(22,22,12),(23,23,12),(24,24,12),(25,25,12);
/*!40000 ALTER TABLE `registry_app_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-20 21:06:37
