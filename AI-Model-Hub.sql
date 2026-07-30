CREATE DATABASE  IF NOT EXISTS `ai_model_hub` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ai_model_hub`;
-- MySQL dump 10.13  Distrib 8.0.46, for macos15 (arm64)
--
-- Host: localhost    Database: ai_model_hub
-- ------------------------------------------------------
-- Server version	9.7.1

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '214817b2-85e5-11f1-a45e-b235f21fc479:1-36';

--
-- Table structure for table `Benchmarks`
--

DROP TABLE IF EXISTS `Benchmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Benchmarks` (
  `benchmark_id` int NOT NULL AUTO_INCREMENT,
  `benchmark_name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`benchmark_id`),
  UNIQUE KEY `benchmark_name` (`benchmark_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Benchmarks`
--

LOCK TABLES `Benchmarks` WRITE;
/*!40000 ALTER TABLE `Benchmarks` DISABLE KEYS */;
INSERT INTO `Benchmarks` VALUES (1,'MMLU','Massive Multitask Language Understanding'),(2,'HumanEval','Code generation benchmark'),(3,'MATH','Mathematical reasoning benchmark'),(4,'GSM8K','Grade school math benchmark');
/*!40000 ALTER TABLE `Benchmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Companies`
--

DROP TABLE IF EXISTS `Companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Companies` (
  `company_id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `founded_year` year DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Companies`
--

LOCK TABLES `Companies` WRITE;
/*!40000 ALTER TABLE `Companies` DISABLE KEYS */;
INSERT INTO `Companies` VALUES (1,'OpenAI','USA',2015,NULL),(2,'Google','USA',1998,NULL),(3,'Anthropic','USA',2021,NULL),(4,'Meta','USA',2004,NULL),(5,'xAI','USA',2023,NULL),(6,'Mistral AI','France',2023,NULL);
/*!40000 ALTER TABLE `Companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Licenses`
--

DROP TABLE IF EXISTS `Licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Licenses` (
  `license_id` int NOT NULL AUTO_INCREMENT,
  `license_name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`license_id`),
  UNIQUE KEY `license_name` (`license_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Licenses`
--

LOCK TABLES `Licenses` WRITE;
/*!40000 ALTER TABLE `Licenses` DISABLE KEYS */;
INSERT INTO `Licenses` VALUES (1,'Closed Source','Proprietary model'),(2,'Open Source','Source code and weights are publicly available');
/*!40000 ALTER TABLE `Licenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Modalities`
--

DROP TABLE IF EXISTS `Modalities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Modalities` (
  `modality_id` int NOT NULL AUTO_INCREMENT,
  `modality_name` varchar(50) NOT NULL,
  PRIMARY KEY (`modality_id`),
  UNIQUE KEY `modality_name` (`modality_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Modalities`
--

LOCK TABLES `Modalities` WRITE;
/*!40000 ALTER TABLE `Modalities` DISABLE KEYS */;
INSERT INTO `Modalities` VALUES (3,'Audio'),(5,'Code'),(2,'Image'),(1,'Text'),(4,'Video');
/*!40000 ALTER TABLE `Modalities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Model_Benchmarks`
--

DROP TABLE IF EXISTS `Model_Benchmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Model_Benchmarks` (
  `model_id` int NOT NULL,
  `benchmark_id` int NOT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`model_id`,`benchmark_id`),
  KEY `benchmark_id` (`benchmark_id`),
  CONSTRAINT `model_benchmarks_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `Models` (`model_id`),
  CONSTRAINT `model_benchmarks_ibfk_2` FOREIGN KEY (`benchmark_id`) REFERENCES `Benchmarks` (`benchmark_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model_Benchmarks`
--

LOCK TABLES `Model_Benchmarks` WRITE;
/*!40000 ALTER TABLE `Model_Benchmarks` DISABLE KEYS */;
INSERT INTO `Model_Benchmarks` VALUES (1,1,88.70),(1,2,90.20),(1,3,76.50),(1,4,95.80),(2,1,90.00),(2,2,92.40),(2,3,82.00),(2,4,96.50),(3,1,92.50),(3,2,95.00),(3,3,90.00),(3,4,98.20),(4,1,91.80),(4,2,91.00),(4,3,88.30),(4,4,97.50),(5,1,91.20),(5,2,93.50),(5,3,89.00),(5,4,97.00),(6,1,85.40),(6,2,82.80),(6,3,73.50),(6,4,90.40),(7,1,90.50),(7,2,91.80),(7,3,87.50),(7,4,96.00),(8,1,84.70),(8,2,81.30),(8,3,72.00),(8,4,89.80);
/*!40000 ALTER TABLE `Model_Benchmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Model_Modalities`
--

DROP TABLE IF EXISTS `Model_Modalities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Model_Modalities` (
  `model_id` int NOT NULL,
  `modality_id` int NOT NULL,
  PRIMARY KEY (`model_id`,`modality_id`),
  KEY `modality_id` (`modality_id`),
  CONSTRAINT `model_modalities_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `Models` (`model_id`),
  CONSTRAINT `model_modalities_ibfk_2` FOREIGN KEY (`modality_id`) REFERENCES `Modalities` (`modality_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model_Modalities`
--

LOCK TABLES `Model_Modalities` WRITE;
/*!40000 ALTER TABLE `Model_Modalities` DISABLE KEYS */;
INSERT INTO `Model_Modalities` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(1,2),(3,2),(4,2),(7,2),(1,3),(3,3),(2,5),(4,5),(5,5);
/*!40000 ALTER TABLE `Model_Modalities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Model_Versions`
--

DROP TABLE IF EXISTS `Model_Versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Model_Versions` (
  `version_id` int NOT NULL AUTO_INCREMENT,
  `model_id` int NOT NULL,
  `version_name` varchar(100) NOT NULL,
  `release_date` date DEFAULT NULL,
  `context_window` int DEFAULT NULL,
  PRIMARY KEY (`version_id`),
  KEY `model_id` (`model_id`),
  CONSTRAINT `model_versions_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `Models` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model_Versions`
--

LOCK TABLES `Model_Versions` WRITE;
/*!40000 ALTER TABLE `Model_Versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Model_Versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Models`
--

DROP TABLE IF EXISTS `Models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Models` (
  `model_id` int NOT NULL AUTO_INCREMENT,
  `model_name` varchar(100) NOT NULL,
  `company_id` int NOT NULL,
  `release_date` date DEFAULT NULL,
  `open_source` tinyint(1) DEFAULT NULL,
  `context_window` int DEFAULT NULL,
  `description` text,
  `license_id` int DEFAULT NULL,
  PRIMARY KEY (`model_id`),
  KEY `company_id` (`company_id`),
  KEY `fk_license` (`license_id`),
  CONSTRAINT `fk_license` FOREIGN KEY (`license_id`) REFERENCES `Licenses` (`license_id`),
  CONSTRAINT `models_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `Companies` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Models`
--

LOCK TABLES `Models` WRITE;
/*!40000 ALTER TABLE `Models` DISABLE KEYS */;
INSERT INTO `Models` VALUES (1,'GPT-4o',1,'2024-05-13',0,128000,NULL,1),(2,'GPT-4.1',1,'2025-04-14',0,1000000,NULL,1),(3,'GPT-5',1,'2025-08-07',0,1000000,NULL,1),(4,'Gemini 2.5 Pro',2,'2025-03-25',0,1000000,NULL,1),(5,'Claude 4 Opus',3,'2025-05-22',0,200000,NULL,1),(6,'Llama 4 Maverick',4,'2025-04-05',1,1000000,NULL,2),(7,'Grok 4',5,'2025-07-09',0,256000,NULL,1),(8,'Mistral Large 2',6,'2024-07-24',1,128000,NULL,2);
/*!40000 ALTER TABLE `Models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pricing`
--

DROP TABLE IF EXISTS `Pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pricing` (
  `pricing_id` int NOT NULL AUTO_INCREMENT,
  `model_id` int NOT NULL,
  `input_price` decimal(10,4) DEFAULT NULL,
  `output_price` decimal(10,4) DEFAULT NULL,
  `currency` varchar(10) DEFAULT 'USD',
  PRIMARY KEY (`pricing_id`),
  KEY `model_id` (`model_id`),
  CONSTRAINT `pricing_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `Models` (`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pricing`
--

LOCK TABLES `Pricing` WRITE;
/*!40000 ALTER TABLE `Pricing` DISABLE KEYS */;
INSERT INTO `Pricing` VALUES (1,1,2.5000,10.0000,'USD'),(2,2,2.0000,8.0000,'USD'),(3,3,1.2500,10.0000,'USD'),(4,4,1.2500,10.0000,'USD'),(5,5,15.0000,75.0000,'USD'),(6,6,0.2000,0.6000,'USD'),(7,7,3.0000,15.0000,'USD'),(8,8,2.0000,6.0000,'USD');
/*!40000 ALTER TABLE `Pricing` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-30  3:16:33
