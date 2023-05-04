-- MariaDB dump 10.19  Distrib 10.4.27-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: cuentabytes
-- ------------------------------------------------------
-- Server version	10.4.27-MariaDB

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
-- Table structure for table `ajustes`
--

DROP TABLE IF EXISTS `ajustes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajustes` (
  `nombreEmpresa` varchar(250) NOT NULL,
  `horaApertura` time DEFAULT '08:00:00',
  `horaCierre` time DEFAULT '17:00:00',
  `tipoGrafico` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`nombreEmpresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajustes`
--

LOCK TABLES `ajustes` WRITE;
/*!40000 ALTER TABLE `ajustes` DISABLE KEYS */;
INSERT INTO `ajustes` VALUES ('Licorera Elite','08:00:00','22:00:00','line');
/*!40000 ALTER TABLE `ajustes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombresCliente` varchar(30) NOT NULL,
  `apellidosCliente` varchar(30) DEFAULT NULL,
  `telefonoCliente` varchar(15) DEFAULT NULL,
  `cedulaCliente` int(11) NOT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (4,'Andrei','Peña','31548792',1111111111),(6,'Keanu','Reeves','555693987',101099853),(7,'Antonio','Alvarez','78642211',1010994788),(8,'Manuela','gomez orozco','4789621',1010998789),(9,'Panfilos','Castaño ','3198752016',12315124),(10,'Rodolfo','Hernandez','312498652',1010998654),(11,'Pancho','Sansa','0',1010948769),(14,'Mallerli','Ramirez','1595020119',1036251514);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalleegreso`
--

DROP TABLE IF EXISTS `detalleegreso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalleegreso` (
  `idDetEgreso` int(11) NOT NULL AUTO_INCREMENT,
  `valorEgreso` int(8) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `idEgreso` int(11) NOT NULL,
  PRIMARY KEY (`idDetEgreso`),
  KEY `detalleEgreso` (`idEgreso`),
  CONSTRAINT `detalleEgreso` FOREIGN KEY (`idEgreso`) REFERENCES `encegreso` (`idEgreso`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleegreso`
--

LOCK TABLES `detalleegreso` WRITE;
/*!40000 ALTER TABLE `detalleegreso` DISABLE KEYS */;
INSERT INTO `detalleegreso` VALUES (4,230000,'Alcantarilla',2),(5,12000,'Viaje a la notaría',2),(6,120000,'vasos',3),(7,80000,'copas aguardiente',3),(8,115000,'Vasos cerveceros',3),(9,15000,'sacacorchos',3),(10,12000,'destapador de bebidas',3),(11,2000000,'Arriendo del Local',4),(12,20000,'Barniz',5),(13,210000,'Refacciones varias',5),(14,150000,'Carpintero',5),(15,80500,'Madera',5),(16,100000,'Juan',6),(17,100000,'Maria',6),(18,100000,'Pablo',6),(19,240000,'Juan',7),(20,201400,'Maria',7),(21,120000,'Pablo',7),(22,240000,'Curso manejo y conservación de vinos',8),(24,2000000,'Arriendo',9),(25,1000000,'Pago a juan',10),(26,1000000,'pago a maria',10),(27,150000,'mano de obra',11),(28,2000000,'...',12),(29,2000,'destornillador',13),(30,10000,'sacacorchos',14),(31,15000,'almuerzo',15);
/*!40000 ALTER TABLE `detalleegreso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalleventa`
--

DROP TABLE IF EXISTS `detalleventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalleventa` (
  `idDetVenta` int(11) NOT NULL AUTO_INCREMENT,
  `uniVendidas` int(8) NOT NULL,
  `precioUnitario` int(11) DEFAULT NULL,
  `idVenta` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  PRIMARY KEY (`idDetVenta`),
  KEY `ventaProducto` (`idProducto`),
  KEY `detEncVta` (`idVenta`),
  CONSTRAINT `EncDetVta` FOREIGN KEY (`idVenta`) REFERENCES `encventas` (`idVenta`) ON DELETE CASCADE,
  CONSTRAINT `ventaProducto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleventa`
--

LOCK TABLES `detalleventa` WRITE;
/*!40000 ALTER TABLE `detalleventa` DISABLE KEYS */;
INSERT INTO `detalleventa` VALUES (9,1,55000,5,10),(10,1,5000,5,4),(11,3,50000,5,1),(12,2,42000,5,2),(13,4,42000,6,2),(14,2,3500,7,11),(15,1,42000,8,2),(17,1,36000,9,8),(18,10,3500,10,11),(19,7,6000,10,7),(20,2,50000,11,6),(21,16,3500,12,11),(22,1,50000,14,1),(23,3,3500,14,11),(24,1,55000,15,10),(25,10,50000,16,12),(26,0,5000,17,4),(27,1,50000,18,12),(28,0,50000,1,12),(30,1,36000,20,8),(31,1,6000,21,7),(34,2,50000,22,1),(35,1,42000,22,2),(36,1,50000,23,1),(37,6,3500,24,11),(38,1,50000,24,6),(39,2,6000,25,7),(40,1,50000,26,6),(41,12,3500,27,11),(42,1,50000,27,12),(43,1,42000,28,2),(44,1,50000,28,12),(45,7,3500,28,11),(46,2,6000,28,7),(47,1,3500,29,11),(48,1,3500,30,11),(49,1,3500,31,11),(50,1,6000,32,7),(51,1,6000,33,7),(52,1,20000,34,5),(53,2,50000,34,9),(54,4,3500,34,11),(55,1,50000,50,12),(56,1,3500,50,11),(57,6,3500,51,11),(58,1,50000,51,12),(59,1,3500,52,11),(60,2,3500,53,11),(61,1,3500,54,11),(62,2,6000,54,7),(63,1,50000,54,9),(64,5,4500,55,11),(65,1,50000,55,6),(66,1,50000,56,9),(67,1,50000,56,1),(68,12,4500,57,11),(69,5,6500,58,3),(70,3,20000,58,5);
/*!40000 ALTER TABLE `detalleventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detcompraproducto`
--

DROP TABLE IF EXISTS `detcompraproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detcompraproducto` (
  `idDetCompra` int(11) NOT NULL AUTO_INCREMENT,
  `cantidadCompra` int(8) NOT NULL,
  `precioUnitario` int(11) NOT NULL,
  `idCompra` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  PRIMARY KEY (`idDetCompra`),
  KEY `compraProducto` (`idCompra`),
  KEY `detalleCompraProducto` (`idProducto`),
  CONSTRAINT `compraProducto` FOREIGN KEY (`idCompra`) REFERENCES `enccompraproducto` (`idCompra`) ON DELETE CASCADE,
  CONSTRAINT `detalleCompraProducto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detcompraproducto`
--

LOCK TABLES `detcompraproducto` WRITE;
/*!40000 ALTER TABLE `detcompraproducto` DISABLE KEYS */;
INSERT INTO `detcompraproducto` VALUES (58,20,2000,1,11),(59,14,5000,1,7),(60,10,40000,2,10),(61,10,25000,3,5),(62,17,42000,4,1),(63,11,25000,4,8),(64,16,2500,5,4),(65,12,3000,5,3),(66,5,5000,5,7),(67,5,30000,6,9),(68,8,30000,7,2),(69,9,40000,7,6),(70,5,30000,8,9),(71,5,25000,9,8),(72,10,2000,10,11),(73,20,40000,10,6),(74,10,5000,10,7),(75,20,40000,11,6),(76,20,5000,12,7),(77,20,2000,12,11),(78,15,30000,13,9),(79,5,30000,13,2),(80,10,5000,13,7),(81,15,25000,14,5),(82,32,2000,14,11),(83,12,40000,14,10),(84,12,25000,15,8),(85,13,40000,16,12),(86,10,2000,17,11),(87,12,5000,17,7),(88,12,40000,18,12),(89,12,25000,19,8),(90,12,40000,20,10),(91,11,3000,23,11),(92,6,40000,23,10),(93,6,4000,24,3),(94,16,12500,24,5);
/*!40000 ALTER TABLE `detcompraproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enccompraproducto`
--

DROP TABLE IF EXISTS `enccompraproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enccompraproducto` (
  `idCompra` int(11) NOT NULL,
  `fechaCompra` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `idProveedor` int(11) DEFAULT NULL,
  `vrTotalCompra` int(11) NOT NULL,
  PRIMARY KEY (`idCompra`),
  KEY `encCompraProductos` (`idProveedor`),
  CONSTRAINT `encCompraProductos` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enccompraproducto`
--

LOCK TABLES `enccompraproducto` WRITE;
/*!40000 ALTER TABLE `enccompraproducto` DISABLE KEYS */;
INSERT INTO `enccompraproducto` VALUES (1,'2023-04-15 17:26:14',15,110000),(2,'2023-04-04 17:27:17',17,400000),(3,'2023-03-20 17:28:20',14,250000),(4,'2023-04-15 17:28:50',11,989000),(5,'2023-03-21 17:29:38',12,101000),(6,'2023-03-31 17:30:07',11,150000),(7,'2023-03-17 17:31:04',11,600000),(8,'2023-04-08 17:32:14',15,150000),(9,'2023-04-27 17:24:36',17,125000),(10,'2023-04-30 16:01:43',17,870000),(11,'2023-04-30 16:03:27',16,800000),(12,'2023-04-30 16:03:45',12,140000),(13,'2023-04-30 21:09:15',17,650000),(14,'2023-04-30 19:09:15',16,919000),(15,'2023-04-30 17:09:15',14,300000),(16,'2023-04-30 15:09:15',11,520000),(17,'2023-05-01 16:55:55',17,80000),(18,'2023-05-01 15:55:55',16,480000),(19,'2023-05-01 14:55:55',12,300000),(20,'2023-05-01 13:55:55',12,480000),(21,'2023-05-04 13:30:29',12,8000),(22,'2023-05-04 13:31:35',12,5000),(23,'2023-05-04 13:35:22',12,273000),(24,'2023-05-04 20:02:19',12,224000);
/*!40000 ALTER TABLE `enccompraproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encegreso`
--

DROP TABLE IF EXISTS `encegreso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encegreso` (
  `idEgreso` int(11) NOT NULL,
  `fechaEgreso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tituloEgreso` varchar(80) DEFAULT NULL,
  `vrTotalEgreso` int(8) NOT NULL,
  `idTipoEgreso` int(11) NOT NULL,
  PRIMARY KEY (`idEgreso`),
  KEY `egresosTipo` (`idTipoEgreso`),
  CONSTRAINT `egresosTipo` FOREIGN KEY (`idTipoEgreso`) REFERENCES `tipoegreso` (`idTipoEgreso`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encegreso`
--

LOCK TABLES `encegreso` WRITE;
/*!40000 ALTER TABLE `encegreso` DISABLE KEYS */;
INSERT INTO `encegreso` VALUES (2,'2023-04-07 15:28:03','Pago Alcantarillado',242000,0),(3,'2023-04-18 15:28:03','Compra de utilería',342000,6),(4,'2023-04-30 15:59:23','Arriendo Local',2000000,1),(5,'2023-04-12 16:28:03','Barriles Vino',460500,5),(6,'2023-04-16 13:28:03','Subsidio Transporte',300000,4),(7,'2023-04-17 12:28:03','Nomina 2023',561400,2),(8,'2023-04-06 17:28:03','Curso Empleados',240000,3),(9,'2023-04-16 18:09:55','Arriendo',2000000,1),(10,'2023-04-30 16:59:11','Pago a empleados',2000000,2),(11,'2023-04-30 14:28:03','Reparacion nevera',150000,5),(12,'2023-04-13 19:28:03','...',2000000,3),(13,'2023-05-01 15:00:39','wya',2000,2),(14,'2023-05-01 15:00:54','ajua',10000,0),(15,'2023-05-01 15:01:09','xdxdxd',15000,0);
/*!40000 ALTER TABLE `encegreso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encventas`
--

DROP TABLE IF EXISTS `encventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encventas` (
  `idVenta` int(11) NOT NULL,
  `fechaVenta` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `descuentoVenta` int(11) NOT NULL,
  `idMetodoPago` int(11) DEFAULT NULL,
  `vrTotalVta` int(11) NOT NULL,
  `idCliente` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVenta`),
  KEY `clientesVentas` (`idCliente`),
  KEY `metodoPago` (`idMetodoPago`),
  CONSTRAINT `encClientes` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`),
  CONSTRAINT `metodoPago` FOREIGN KEY (`idMetodoPago`) REFERENCES `metodopago` (`idMetodoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encventas`
--

LOCK TABLES `encventas` WRITE;
/*!40000 ALTER TABLE `encventas` DISABLE KEYS */;
INSERT INTO `encventas` VALUES (1,'2023-04-26 15:40:23',0,1,0,14),(5,'2023-04-20 19:53:41',10000,1,284000,9),(6,'2023-04-20 19:53:41',8000,1,160000,7),(7,'2023-04-20 19:53:41',0,1,7000,4),(8,'2023-04-20 19:53:41',0,1,42000,8),(9,'2023-04-20 19:53:41',0,1,36000,11),(10,'2023-04-20 19:53:41',7000,1,70000,10),(11,'2023-04-20 19:53:41',8500,1,91500,6),(12,'2023-04-20 19:53:41',0,1,56000,7),(13,'2023-04-25 21:17:33',0,1,50000,14),(14,'2023-04-25 21:21:05',0,1,60500,14),(15,'2023-04-25 22:29:19',0,1,55000,14),(16,'2023-04-26 15:27:09',0,1,500000,9),(17,'2023-04-26 15:35:49',0,1,0,10),(18,'2023-04-26 15:39:00',0,1,50000,14),(20,'2023-04-27 12:17:29',1000,1,35000,7),(21,'2023-04-27 12:27:56',0,1,6000,7),(22,'2023-04-27 17:25:55',2000,1,140000,8),(23,'2023-04-28 13:05:32',2000,1,48000,8),(24,'2023-04-30 16:04:37',0,2,71000,11),(25,'2023-04-30 16:04:51',0,1,12000,4),(26,'2023-04-30 13:05:06',0,4,50000,8),(27,'2023-05-01 13:02:27',2000,1,90000,7),(28,'2023-05-01 16:41:43',500,1,128000,10),(29,'2023-05-01 16:43:51',500,1,3000,14),(30,'2023-05-01 16:46:48',500,1,3000,14),(31,'2023-05-01 17:10:49',0,1,3500,4),(32,'2023-05-02 12:41:09',0,1,6000,6),(33,'2023-05-02 13:03:29',0,1,6000,6),(34,'2023-05-02 14:55:14',0,1,134000,4),(35,'2023-05-02 15:01:41',0,1,50000,10),(36,'2023-05-02 15:01:41',0,1,50000,8),(37,'2023-05-02 15:01:41',0,1,50000,9),(38,'2023-05-02 15:01:41',0,1,50000,7),(39,'2023-05-02 15:01:41',0,1,50000,11),(41,'2023-05-02 15:01:41',0,1,50000,4),(42,'2023-05-02 15:01:41',0,1,50000,9),(43,'2023-05-02 15:01:41',0,1,50000,9),(44,'2023-05-02 15:01:41',0,1,50000,6),(45,'2023-05-02 15:01:41',0,1,50000,10),(47,'2023-05-02 15:01:41',0,1,50000,9),(48,'2023-05-02 15:01:41',0,1,50000,6),(49,'2023-05-02 15:01:41',0,1,50000,9),(50,'2023-05-02 16:30:28',0,1,53500,4),(51,'2023-05-02 16:31:06',1000,1,70000,4),(52,'2023-05-03 22:44:53',0,1,3500,11),(53,'2023-05-04 12:34:47',0,1,7000,4),(54,'2023-05-04 12:35:35',500,1,65000,7),(55,'2023-05-04 15:17:34',500,1,72000,4),(56,'2023-05-04 15:18:01',0,2,100000,6),(57,'2023-05-04 15:18:24',0,2,54000,8),(58,'2023-05-04 20:22:51',500,1,92000,4);
/*!40000 ALTER TABLE `encventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagen`
--

DROP TABLE IF EXISTS `imagen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagen` (
  `idImagen` int(11) NOT NULL AUTO_INCREMENT,
  `rutaImagen` varchar(100) NOT NULL,
  `nombreImagen` varchar(30) NOT NULL,
  PRIMARY KEY (`idImagen`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagen`
--

LOCK TABLES `imagen` WRITE;
/*!40000 ALTER TABLE `imagen` DISABLE KEYS */;
INSERT INTO `imagen` VALUES (9,'/public/img/productos','bimbo.png'),(11,'./../../../public/img/productos/','20230310011457.jpg'),(12,'./../../../public/img/productos/','aguilaLata.jpg'),(13,'./../../../public/img/productos/','botellaGin.png'),(14,'./../../../public/img/productos/','champagne.jpg'),(15,'./../../../public/img/productos/','vientosDelSur.png'),(16,'./../../../public/img/productos/','aguilon.jpg'),(17,'./../../../public/img/productos/','ronCaldas.jpg'),(18,'./../../../public/img/productos/','pilsenon750.jpg'),(19,'./../../../public/img/productos/','pilsenon.png'),(20,'./../../../public/img/productos/','crema.jpg'),(21,'./../../../public/img/productos/','gatoNegro.png'),(22,'./../../../public/img/productos/','20230427165000.png'),(23,'./../../../public/img/productos/','20230427165047.png'),(24,'./../../../public/img/productos/','20230427171202.png');
/*!40000 ALTER TABLE `imagen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodopago`
--

DROP TABLE IF EXISTS `metodopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metodopago` (
  `idMetodoPago` int(11) NOT NULL AUTO_INCREMENT,
  `metodoPago` varchar(40) NOT NULL,
  PRIMARY KEY (`idMetodoPago`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodopago`
--

LOCK TABLES `metodopago` WRITE;
/*!40000 ALTER TABLE `metodopago` DISABLE KEYS */;
INSERT INTO `metodopago` VALUES (1,'Efectivo'),(2,'Transferencia'),(3,'Cheque'),(4,'Tarjeta de Crédito');
/*!40000 ALTER TABLE `metodopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas` (
  `idNota` int(11) NOT NULL AUTO_INCREMENT,
  `tituloNota` varchar(20) DEFAULT NULL,
  `contenidoNota` varchar(100) NOT NULL,
  PRIMARY KEY (`idNota`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (6,'Pagar arriendo','El miércoles 19 de Abril a Humberto'),(7,'Keanu Reeves (Debe)','2 litros de ron'),(9,'Comprar pilsenones','Necesito 3 cajas');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL AUTO_INCREMENT,
  `nombreProducto` varchar(30) NOT NULL,
  `descripcionProducto` varchar(100) DEFAULT NULL,
  `costoProducto` int(8) NOT NULL,
  `precioVenta` int(8) NOT NULL,
  `existenciaProducto` int(7) NOT NULL,
  `idImagen` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `productoImagen` (`idImagen`),
  CONSTRAINT `productoImagen` FOREIGN KEY (`idImagen`) REFERENCES `imagen` (`idImagen`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Vino gato negro','Vino Tinto merlot 2020',42000,50000,6,21),(2,'Crema de whiskey','Crema dulce',30000,42000,11,20),(3,'Pilsenon litro','Cerveza pilsen litro',4000,6500,45,19),(4,'Pilsenon 750','Pilsenon 750ml\r\n',2500,5000,0,18),(5,'Media de guaro','Media de guaro tapa roja',12500,20000,47,9),(6,'litro de ron caldas','Litro de ron caldas',40000,50000,17,17),(7,'Aguilon litro','Aguilon litro',5000,6000,34,16),(8,'Vino Vientos del sur','Cavernet vientos del sur 750ml',25000,36000,24,15),(9,'Botella de champaña','Botella de champaña blanca, espumosa ',30000,50000,28,14),(10,'Botella de gin','Botella de ginebra ',40000,55000,30,13),(11,'Aguila lata','Lata de aguila negra 330cm3',3000,4500,13,12),(12,'Botella de vodka','botella de vodka smirnoff',40000,50000,21,11);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `idProveedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombreProveedor` varchar(40) NOT NULL,
  `direccionProveedor` varchar(30) DEFAULT NULL,
  `telefonoProveedor` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (9,'Licores de cundinamarca S.A','calle 12','124'),(11,'Variedades S.A','Cll Sa','36588912'),(12,'FLA','Cll Santo tequila','52424788'),(14,'Bavaria','Calle Elm','555 666 4548'),(15,'Licores el gallo','avenida central','3169874503'),(16,'Rones el pistolero','...','9561059878'),(17,'tequila es mescal','calle banano','2225487');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoegreso`
--

DROP TABLE IF EXISTS `tipoegreso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoegreso` (
  `idTipoEgreso` int(11) NOT NULL AUTO_INCREMENT,
  `nombreTipoEgreso` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`idTipoEgreso`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoegreso`
--

LOCK TABLES `tipoegreso` WRITE;
/*!40000 ALTER TABLE `tipoegreso` DISABLE KEYS */;
INSERT INTO `tipoegreso` VALUES (0,'Servicios públicos'),(1,'Arriendo'),(2,'Nómina'),(3,'Gastos Administrativos'),(4,'Transporte / Domicilios'),(5,'Mantenimiento / Reparaciones'),(6,'Muebles / Maquinaria');
/*!40000 ALTER TABLE `tipoegreso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombreUsuario` varchar(40) NOT NULL,
  `correoUsuario` varchar(40) NOT NULL,
  `contrasenaUsuario` varchar(255) NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'licorera elite','example@example.com','123'),(2,'Licores elite','campuzanomiguel2208@gmail.com','3f944f9c37e525fdc0e2f9935d5dac22f366d14364777ff8d9c5a0ea33b7b87b'),(3,'Los Pollos hermanos','bedoyi5849@in2reach.com','0177a5ce06c50e390c083b965e4160373829723f97c64cc60cbf03db7a554d99');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-04 15:52:11
