-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dan
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `bairro`
--

DROP TABLE IF EXISTS `bairro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bairro` (
  `Cd_Bairro` int NOT NULL,
  `Nm_Bairro` varchar(45) DEFAULT NULL,
  `Cd_Cidade` int DEFAULT NULL,
  PRIMARY KEY (`Cd_Bairro`),
  KEY `Cd_Cidade_idx` (`Cd_Cidade`),
  CONSTRAINT `Cd_Cidade` FOREIGN KEY (`Cd_Cidade`) REFERENCES `cidade` (`Cd_Cidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bairro`
--

LOCK TABLES `bairro` WRITE;
/*!40000 ALTER TABLE `bairro` DISABLE KEYS */;
INSERT INTO `bairro` VALUES (1,'Vila Mariana',1),(2,'Pinheiros',1),(3,'Cambuí',2),(4,'Copacabana',3),(5,'Savassi',4),(6,'Batel',5);
/*!40000 ALTER TABLE `bairro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cidade`
--

DROP TABLE IF EXISTS `cidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cidade` (
  `Cd_Cidade` int NOT NULL,
  `Nm_Cidade` varchar(45) NOT NULL,
  `Sigla_Cidade` varchar(45) NOT NULL,
  `Cd_Estado` int NOT NULL,
  PRIMARY KEY (`Cd_Cidade`),
  UNIQUE KEY `Cd_Cidade_UNIQUE` (`Cd_Cidade`),
  KEY `Cd_Estado_idx` (`Cd_Estado`),
  CONSTRAINT `Cd_Estado` FOREIGN KEY (`Cd_Estado`) REFERENCES `estado` (`Cd_Estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidade`
--

LOCK TABLES `cidade` WRITE;
/*!40000 ALTER TABLE `cidade` DISABLE KEYS */;
INSERT INTO `cidade` VALUES (1,'São Paulo','SPO',1),(2,'Campinas','CPS',1),(3,'Rio de Janeiro','RIO',2),(4,'Belo Horizonte','BHZ',3),(5,'Curitiba','CWB',4),(6,'Los Angeles','LAX',6);
/*!40000 ALTER TABLE `cidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `Cd_Cliente` int NOT NULL,
  `Doc_Cliente` varchar(45) NOT NULL,
  `DocI_Cliente` varchar(45) NOT NULL,
  `DocDFN_Cliente` varchar(45) NOT NULL,
  `Nm_Cliente` varchar(45) NOT NULL,
  PRIMARY KEY (`Cd_Cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'123.456.789-09','12.345.678-9','2018-05-10','Marina Albuquerque Souza'),(2,'987.654.321-00','98.765.432-1','2019-11-22','Carlos Eduardo Mendonça'),(3,'111.222.333-96','11.222.333-4','2020-02-15','Fernanda Ribeiro Lima'),(4,'444.555.666-81','44.555.666-7','2021-07-03','Ricardo Tavares Nogueira'),(5,'777.888.999-35','77.888.999-0','2022-09-30','Juliana Prado Cavalcante');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comodo`
--

DROP TABLE IF EXISTS `comodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comodo` (
  `Cd_Comodo` int NOT NULL,
  `Nm_Comodo` varchar(45) NOT NULL,
  `FK_Obra` int NOT NULL,
  PRIMARY KEY (`Cd_Comodo`),
  KEY `Cd_Imovel_idx` (`FK_Obra`),
  CONSTRAINT `FK_Obra` FOREIGN KEY (`FK_Obra`) REFERENCES `obra` (`Cd_Obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comodo`
--

LOCK TABLES `comodo` WRITE;
/*!40000 ALTER TABLE `comodo` DISABLE KEYS */;
INSERT INTO `comodo` VALUES (1,'Sala de Estar',1),(2,'Cozinha',1),(3,'Escritório',2),(4,'Banheiro Social',3),(5,'Quarto Principal',3),(6,'Varanda Gourmet',4),(7,'Área de Serviço',4),(8,'Recepção',5);
/*!40000 ALTER TABLE `comodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `continente`
--

DROP TABLE IF EXISTS `continente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `continente` (
  `Cd_Continente` int NOT NULL,
  `Nm_Continente` varchar(45) DEFAULT NULL,
  `Sigla_Continete` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Cd_Continente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continente`
--

LOCK TABLES `continente` WRITE;
/*!40000 ALTER TABLE `continente` DISABLE KEYS */;
INSERT INTO `continente` VALUES (1,'América do Sul','AMS'),(2,'América do Norte','AMN'),(3,'Europa','EUR'),(4,'Ásia','ASI'),(5,'África','AFR');
/*!40000 ALTER TABLE `continente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado` (
  `Cd_Estado` int NOT NULL,
  `Nm_Estado` varchar(45) NOT NULL,
  `Sigla_Estado` varchar(3) NOT NULL,
  `Cd_Pais` int NOT NULL,
  PRIMARY KEY (`Cd_Estado`),
  KEY `Cd_Pais_idx` (`Cd_Pais`),
  CONSTRAINT `Cd_Pais` FOREIGN KEY (`Cd_Pais`) REFERENCES `pais` (`Cd_Pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'São Paulo','SP',1),(2,'Rio de Janeiro','RJ',1),(3,'Minas Gerais','MG',1),(4,'Paraná','PR',1),(5,'Buenos Aires','BA',2),(6,'Califórnia','CA',3);
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local`
--

DROP TABLE IF EXISTS `local`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local` (
  `Cd_Local` int NOT NULL,
  `Nm_Local` varchar(45) NOT NULL,
  `CdTLocal` int NOT NULL,
  `Cd_Logradouro` int NOT NULL,
  PRIMARY KEY (`Cd_Local`),
  KEY `Cd_Logradouro_idx` (`Cd_Logradouro`),
  KEY `CdTLocal_idx` (`CdTLocal`),
  CONSTRAINT `Cd_Logradouro` FOREIGN KEY (`Cd_Logradouro`) REFERENCES `logradouro` (`Cd_Logradouro`),
  CONSTRAINT `fk_Local_TipoLocal` FOREIGN KEY (`CdTLocal`) REFERENCES `tipolocal` (`CdTLocal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local`
--

LOCK TABLES `local` WRITE;
/*!40000 ALTER TABLE `local` DISABLE KEYS */;
INSERT INTO `local` VALUES (1,'Apartamento 101 - Edifício Aurora',1,1),(2,'Sala Comercial 22 - Torre Faria Lima',2,2),(3,'Casa Residencial Cambuí',3,3),(4,'Cobertura Edifício Mar Azul',1,4),(5,'Loja Térrea Savassi',2,5),(6,'Apartamento 803 - Edifício Batel Prime',1,6);
/*!40000 ALTER TABLE `local` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logradouro`
--

DROP TABLE IF EXISTS `logradouro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logradouro` (
  `Cd_Logradouro` int NOT NULL,
  `Desc_Logradouro` varchar(45) NOT NULL,
  `Nm_Logradouro` int NOT NULL,
  `Cd_Bairro` int DEFAULT NULL,
  PRIMARY KEY (`Cd_Logradouro`),
  KEY `Cd_Bairro_idx` (`Cd_Bairro`),
  CONSTRAINT `Cd_Bairro` FOREIGN KEY (`Cd_Bairro`) REFERENCES `bairro` (`Cd_Bairro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logradouro`
--

LOCK TABLES `logradouro` WRITE;
/*!40000 ALTER TABLE `logradouro` DISABLE KEYS */;
INSERT INTO `logradouro` VALUES (1,'Rua Domingos de Morais',1200,1),(2,'Avenida Faria Lima',3500,2),(3,'Rua Coronel Quirino',450,3),(4,'Avenida Atlântica',2000,4),(5,'Rua Pernambuco',780,5),(6,'Avenida do Batel',1500,6);
/*!40000 ALTER TABLE `logradouro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obra`
--

DROP TABLE IF EXISTS `obra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obra` (
  `Cd_Obra` int NOT NULL,
  `Cd_Cliente` int NOT NULL,
  `Dt_InicioO` date NOT NULL,
  `Dt_TerminoRf` date NOT NULL,
  `VlCusto_Servico` float NOT NULL,
  `Status_Obraa` tinyint NOT NULL,
  `Cd_Local` int NOT NULL,
  `Nm_Obra` varchar(45) NOT NULL,
  PRIMARY KEY (`Cd_Obra`),
  KEY `Cd_Cliente_idx` (`Cd_Cliente`),
  KEY `Cd_Local_idx` (`Cd_Local`),
  CONSTRAINT `Cd_Cliente` FOREIGN KEY (`Cd_Cliente`) REFERENCES `cliente` (`Cd_Cliente`),
  CONSTRAINT `Cd_Local` FOREIGN KEY (`Cd_Local`) REFERENCES `local` (`Cd_Local`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obra`
--

LOCK TABLES `obra` WRITE;
/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
INSERT INTO `obra` VALUES (1,1,'2026-01-10','2026-04-10',45000,2,1,'Reforma Apartamento Aurora'),(2,2,'2026-02-01','2026-06-30',120000,2,2,'Retrofit Sala Comercial Faria Lima'),(3,3,'2026-05-15','2026-11-15',85000.8,1,3,'Reforma Casa Cambuí'),(4,4,'2026-08-01','2026-12-20',230000,1,4,'Reforma Cobertura Mar Azul'),(5,5,'2026-11-01','2027-02-28',60000,0,5,'Adequação Loja Savassi');
/*!40000 ALTER TABLE `obra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pais` (
  `Nm_Pais` varchar(45) NOT NULL,
  `Cd_Pais` int NOT NULL,
  `Sigla_Pais` varchar(45) DEFAULT NULL,
  `Cd_Continente` int NOT NULL,
  PRIMARY KEY (`Cd_Pais`),
  KEY `Cd_Continente_idx` (`Cd_Continente`),
  CONSTRAINT `Cd_Continente` FOREIGN KEY (`Cd_Continente`) REFERENCES `continente` (`Cd_Continente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES ('Brasil',1,'BR',1),('Argentina',2,'AR',1),('Estados Unidos',3,'US',2),('Portugal',4,'PT',3),('Japão',5,'JP',4),('África do Sul',6,'ZA',5);
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `Cd_Pedido` int NOT NULL,
  `Dt_Abertura` date NOT NULL,
  `Dt_Finalizacao` date NOT NULL,
  `Cd_Obra` int NOT NULL,
  PRIMARY KEY (`Cd_Pedido`),
  KEY `Cd_Obra_idx` (`Cd_Obra`),
  CONSTRAINT `Cd_Obra` FOREIGN KEY (`Cd_Obra`) REFERENCES `obra` (`Cd_Obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'2026-01-05','2026-01-09',1),(2,'2026-01-20','2026-01-28',2),(3,'2026-05-10','2026-05-14',3),(4,'2026-07-25','2026-07-31',4),(5,'2026-10-20','2026-10-30',5);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planta`
--

DROP TABLE IF EXISTS `planta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planta` (
  `Cd_Planta` int NOT NULL,
  `Cd_Obra` int NOT NULL,
  `Nm_Planta` varchar(45) NOT NULL,
  `Vl_Planta` decimal(10,0) NOT NULL,
  PRIMARY KEY (`Cd_Planta`),
  KEY `Cd_Reforma_idx` (`Cd_Obra`),
  CONSTRAINT `Cd_Reforma` FOREIGN KEY (`Cd_Obra`) REFERENCES `obra` (`Cd_Obra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planta`
--

LOCK TABLES `planta` WRITE;
/*!40000 ALTER TABLE `planta` DISABLE KEYS */;
INSERT INTO `planta` VALUES (1,1,'Planta Baixa - Apartamento 101',18000),(2,1,'Planta de Layout - Apartamento 101',27000),(3,2,'Planta Baixa - Sala Comercial 22',120001),(4,3,'Planta Baixa - Casa Cambuí',55001),(5,3,'Planta Hidráulica - Casa Cambuí',30000),(6,4,'Planta Baixa - Cobertura Mar Azul',230000),(7,5,'Planta de Layout - Loja Savassi',60000);
/*!40000 ALTER TABLE `planta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipolocal`
--

DROP TABLE IF EXISTS `tipolocal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipolocal` (
  `CdTLocal` int NOT NULL,
  `Nm_TLocal` varchar(45) NOT NULL,
  `Desc_TLocal` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CdTLocal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipolocal`
--

LOCK TABLES `tipolocal` WRITE;
/*!40000 ALTER TABLE `tipolocal` DISABLE KEYS */;
INSERT INTO `tipolocal` VALUES (1,'Apartamento','Unidade residencial em edifício'),(2,'Comercial','Sala, loja ou espaço de uso comercial'),(3,'Casa','Residência unifamiliar térrea ou sobrado'),(4,'Cobertura','Unidade no último pavimento do edifício'),(5,'Galpão','Espaço amplo de uso industrial ou de armazenagem');
/*!40000 ALTER TABLE `tipolocal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `valorobra`
--

DROP TABLE IF EXISTS `valorobra`;
/*!50001 DROP VIEW IF EXISTS `valorobra`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `valorobra` AS SELECT 
 1 AS `Cd_Obra`,
 1 AS `Nm_Obra`,
 1 AS `Nm_Cliente`,
 1 AS `Dt_InicioO`,
 1 AS `Dt_TerminoRf`,
 1 AS `Valor_Total_Obra`,
 1 AS `Status_Obra`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `valorobra`
--

/*!50001 DROP VIEW IF EXISTS `valorobra`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `valorobra` AS select `o`.`Cd_Obra` AS `Cd_Obra`,`o`.`Nm_Obra` AS `Nm_Obra`,`c`.`Nm_Cliente` AS `Nm_Cliente`,`o`.`Dt_InicioO` AS `Dt_InicioO`,`o`.`Dt_TerminoRf` AS `Dt_TerminoRf`,`o`.`VlCusto_Servico` AS `Valor_Total_Obra`,(case when (`o`.`Status_Obraa` = 0) then 'Planejada' when (`o`.`Status_Obraa` = 1) then 'Em andamento' when (`o`.`Status_Obraa` = 2) then 'Concluída' end) AS `Status_Obra` from (`obra` `o` join `cliente` `c` on((`o`.`Cd_Cliente` = `c`.`Cd_Cliente`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-26  8:45:06
