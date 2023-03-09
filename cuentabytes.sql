-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 10, 2023 at 12:39 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cuentabytes`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCliente` (IN `_idCliente` INT(11), IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))  UPDATE `clientes` SET `idCliente`=_idCliente,`nombresCliente`=_nombresCliente,`apellidosCliente`=_apellidosCliente,`telefonoCliente`=_telefonoCliente,`cedulaCliente`=_cedulaCliente WHERE idCliente = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCostoProducto` (IN `_stockProducto` INT(7), IN `_costoProducto` INT(8), IN `_idProducto` INT)  UPDATE productos SET stockProducto = stockProducto + _stockProducto, costoProducto = _costoProducto WHERE idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarDetEgreso` (IN `_idDetEgreso` INT(11), IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100))  UPDATE `detalleegreso` SET `idDetEgreso`=_idDetEgreso,`valorEgreso`=_valorEgreso,`descripcion`=_descripcion WHERE idDetEgreso = _idDetEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEgreso` (IN `_idEgreso` INT(11), IN `_tituloEgreso` VARCHAR(80), IN `_vrTotalEgreso` INT(8), IN `_idTipoEgreso` INT(11))  UPDATE `encegreso` SET 
`idEgreso`=_idEgreso,`tituloEgreso`=_tituloEgreso,`vrTotalEgreso`=_vrTotalEgreso,`idTipoEgreso`=_idTipoEgreso WHERE idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEncVenta` (IN `titVenta` VARCHAR(35), IN `metodoPagoVenta_` VARCHAR(20), IN `descuentoVenta_` INT(11), IN `vrTotal` INT(11), IN `vrIva` INT(11), IN `idCliente_` INT(11), IN `idVenta_` INT)  BEGIN
UPDATE `encventas` SET `tituloVenta`=titVenta,`metodoPagoVenta`=metodoPagoVenta_,`descuentoVenta`=descuentoVenta_
,`vrTotalVta`=vrTotal,`vrTotalIva`=vrIva,`editado`= 1,`idCliente`=idCliente_ WHERE idVenta = idVenta_ ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarProducto` (IN `_idProducto` INT(11), IN `_nombreProducto` VARCHAR(30), IN `_descripcionProducto` VARCHAR(100), IN `_porcentajeIva` INT(5), IN `_costoProducto` INT(8), IN `_precioVenta` INT(8), IN `_stockProducto` INT(7), IN `_idImagen` INT(11))  UPDATE `productos` SET `nombreProducto`=_nombreProducto,`descripcionProducto`=_descripcionProducto,`porcentajeIva`=_porcentajeIva,`costoProducto`=_costoProducto,`precioVenta`=_precioVenta,
`stockProducto`=_stockProducto,`idImagen`=_idImagen WHERE idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarProveedor` (IN `_idProveedor` INT(11), IN `_nombreProveedor` VARCHAR(40), IN `_direccionProveedor` VARCHAR(30), IN `_telefonoProveedor` VARCHAR(15))  BEGIN
UPDATE `proveedor` SET `nombreProveedor`=_nombreProveedor,`direccionProveedor`=_direccionProveedor,`telefonoProveedor`=_telefonoProveedor WHERE idProveedor = _idProveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarStock` (IN `unidVend` INT(11), IN `_idProducto` INT(11))  BEGIN
UPDATE productos SET stockProducto = stockProducto - unidVend WHERE idProducto = _idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarCliente` (IN `_idCliente` INT(11))  DELETE FROM `clientes` WHERE idCliente = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarCompra` (IN `_idCompra` INT)  DELETE FROM `enccompraproducto` WHERE idCompra = _idCompra$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarEgreso` (IN `_idEgreso` INT(11))  DELETE FROM `encegreso` WHERE idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarProducto` (IN `_idProducto` INT(11))  BEGIN
DELETE FROM productos
WHERE idProducto = _idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarProvee` (IN `_idProveedor` INT(11))  BEGIN
	DELETE FROM proveedor WHERE proveedor.idProveedor = _idProveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarVta` (`idVenta_` INT)  BEGIN
	DELETE FROM encventas WHERE encventas.idVenta = idVenta_;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `idUltimaImg` ()  SELECT imagen.idImagen FROM `imagen` order by idImagen DESC LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarCliente` (IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))  INSERT INTO `clientes`(`nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES (_nombresCliente,_apellidosCliente,_telefonoCliente,_cedulaCliente)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetCompra` (IN `_cantidadCompra` INT(11), IN `_precioUnitario` INT(8), IN `_idCompra` INT(11), IN `_idProducto` INT(11))  INSERT INTO `detcompraproducto`(`cantidadCompra`, `precioUnitario`, `idCompra`, `idProducto`) 
VALUES (_cantidadCompra,_precioUnitario,_idCompra,_idProducto)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetEgreso` (IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100), IN `_idEgreso` INT(11))  INSERT INTO `detalleegreso`(`valorEgreso`, `descripcion`, `idEgreso`) VALUES (_valorEgreso,_descripcion,_idEgreso)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetVenta` (IN `_uniVendidas` INT(8), IN `precioUnit` INT(11), IN `_idVenta` INT(11), IN `idProducto` INT(11))  BEGIN
INSERT INTO `detalleventa` (`uniVendidas`, `precioUnitario`, `idVenta`, `idProducto`) VALUES (_uniVendidas, precioUnit, _idVenta, idProducto); END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncCompra` (IN `_idCompra` INT(11), IN `_conceptoCompra` VARCHAR(50), IN `_idProveedor` INT(11), IN `_vrTotalCompra` INT(11), IN `_vrTotalIva` INT(11))  INSERT INTO enccompraproducto(idCompra, conceptoCompra, fechaCompra, idProveedor, vrTotalCompra, vrTotalIva) 
VALUES (_idCompra,_conceptoCompra, now(),_idProveedor,_vrTotalCompra,_vrTotalIva)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncEgreso` (IN `_idEgreso` INT(11), IN `_tituloEgreso` VARCHAR(80), IN `_vrTotalEgreso` INT(8), IN `_idTipoEgreso` INT(11))  INSERT INTO `encegreso`(`idEgreso`, `fechaEgreso`, `tituloEgreso`, `vrTotalEgreso`, `idTipoEgreso`) VALUES (_idEgreso, now(),_tituloEgreso,_vrTotalEgreso,_idTipoEgreso)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncVenta` (IN `_idVenta` INT, IN `_tituloVta` VARCHAR(35), IN `_metPago` VARCHAR(20), IN `dto` INT(11), IN `vrTotal` INT(11), IN `vrIva` INT, IN `_idCliente` INT(11))  BEGIN
INSERT INTO `encventas`(`idVenta`, `tituloVenta`, `fechaVenta`, `metodoPagoVenta`, `descuentoVenta`, `vrTotalVta`, `vrtotalIva`, `editado`, `idCliente`) VALUES (_idVenta,_tituloVta, now(), _metPago, dto, vrTotal, vrIva, 0, _idCliente);                                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarProducto` (IN `_nombreProducto` VARCHAR(30), IN `_descripcionProducto` VARCHAR(100), IN `_porcentajeIva` INT(5), IN `_costoProducto` INT(8), IN `_precioVenta` INT(8), IN `_stockProducto` INT(7), IN `_idImagen` INT(11))  INSERT INTO `productos`(`nombreProducto`, `descripcionProducto`, `porcentajeIva`, `costoProducto`, `precioVenta`, `stockProducto`, `idImagen`) VALUES (_nombreProducto,_descripcionProducto,_porcentajeIva,_costoProducto,_precioVenta,_stockProducto,_idImagen)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarClientes` ()  BEGIN
SELECT nombresCliente, idCliente FROM clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarCompra` (IN `_idCompra` INT(11))  SELECT enccompraproducto.idCompra, enccompraproducto.conceptoCompra, enccompraproducto.fechaCompra, enccompraproducto.vrTotalCompra, enccompraproducto.vrTotalIva, 
proveedor.nombreProveedor, proveedor.idProveedor,
detcompraproducto.idDetCompra, detcompraproducto.cantidadCompra, detcompraproducto.precioUnitario, 
productos.nombreProducto, productos.idProducto
FROM enccompraproducto 
INNER JOIN proveedor ON proveedor.idProveedor = enccompraproducto.idProveedor
INNER JOIN detcompraproducto ON detcompraproducto.idCompra = enccompraproducto.idCompra
INNER JOIN productos ON productos.idProducto = detcompraproducto.idProducto
WHERE enccompraproducto.idCompra = _idCompra$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarCompras` ()  SELECT enccompraproducto.*, proveedor.nombreProveedor FROM enccompraproducto INNER JOIN proveedor on proveedor.idProveedor = enccompraproducto.idProveedor ORDER BY enccompraproducto.idCompra DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarEgreso` (IN `_idEgreso` INT(11))  SELECT encegreso.idEgreso, encegreso.fechaEgreso, encegreso.tituloEgreso, encegreso.vrTotalEgreso,
detalleegreso.idDetEgreso ,detalleegreso.valorEgreso, detalleegreso.descripcion, detalleegreso.idEgreso,
tipoegreso.idTipoEgreso, tipoegreso.nombreTipoEgreso FROM encegreso
INNER JOIN tipoegreso ON tipoegreso.idTipoEgreso = encegreso.idTipoEgreso
INNER JOIN detalleegreso ON detalleegreso.idEgreso = encegreso.idEgreso
WHERE encegreso.idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarEgresos` ()  SELECT encegreso.idEgreso, encegreso.fechaEgreso, encegreso.tituloEgreso, encegreso.vrTotalEgreso,
tipoegreso.idTipoEgreso, tipoegreso.nombreTipoEgreso 
FROM encegreso
INNER JOIN tipoegreso ON tipoegreso.idTipoEgreso = encegreso.idTipoEgreso ORDER BY encegreso.idEgreso DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProductos` ()  BEGIN
SELECT idProducto, nombreProducto, stockProducto, precioVenta, porcentajeIva, costoProducto FROM productos ORDER BY nombreProducto ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProveedores` ()  select * from proveedor order by idProveedor desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarTipoEgreso` ()  SELECT * FROM tipoegreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarVenta` (IN `idVenta_` INT(11))  BEGIN
SELECT encventas.idVenta, encventas.tituloVenta, encventas.fechaVenta, encventas.metodoPagoVenta, encventas.descuentoVenta, encventas.vrTotalVta, encventas.vrtotalIva, encventas.editado, clientes.idCliente, clientes.nombresCliente, detalleventa.idDetVenta, detalleventa.uniVendidas, detalleventa.precioUnitario, detalleventa.idProducto, productos.nombreProducto, productos.stockProducto, productos.porcentajeIva FROM encventas INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta INNER JOIN productos ON detalleventa.idProducto = productos.idProducto INNER JOIN clientes on clientes.idCliente = encventas.idCliente WHERE encventas.idVenta = idVenta_; 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarVentas` ()  BEGIN
SELECT idVenta, tituloVenta, fechaVenta, metodoPagoVenta, descuentoVenta, vrTotalVta, nombresCliente, apellidosCliente FROM encventas INNER JOIN clientes ON encventas.idCliente = clientes.idCliente order by idVenta DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mayorEgreso` ()  BEGIN
SELECT SUM(detalleegreso.valorEgreso)as mayorValor, detalleegreso.descripcion, encegreso.tituloEgreso FROM detalleegreso INNER JOIN encegreso ON encegreso.idEgreso = detalleegreso.idEgreso GROUP BY detalleegreso.idegreso ORDER BY mayorValor DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresClientes` ()  BEGIN
SELECT COUNT(encventas.idCliente) as nroFacturas, clientes.nombresCliente FROM encventas INNER
JOIN clientes on encventas.idCliente = clientes.idCliente GROUP BY encventas.idCliente ORDER BY nroFacturas desc limit 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menorEgreso` ()  BEGIN
SELECT SUM(detalleegreso.valorEgreso)as mayorValor, detalleegreso.descripcion, encegreso.tituloEgreso FROM detalleegreso INNER JOIN encegreso ON encegreso.idEgreso = detalleegreso.idEgreso GROUP BY detalleegreso.idegreso ORDER BY mayorValor ASC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarProductos` ()  BEGIN
SELECT * FROM productos ORDER BY nombreProducto ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarUnProducto` (IN `_idProducto` INT(11))  BEGIN
SELECT * FROM productos WHERE idProducto = _idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMasStock` ()  BEGIN
SELECT MAX(productos.stockProducto) AS stockMayor, productos.nombreProducto FROM productos GROUP BY idProducto ORDER BY stockMayor DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMasVend` ()  BEGIN
SELECT COUNT(detalleventa.idProducto) as nroFacturas, productos.idProducto, productos.nombreProducto FROM detalleventa INNER JOIN productos ON
productos.idProducto = detalleventa.idProducto group by detalleventa.idProducto ORDER by nroFacturas desc limit 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMenStock` ()  BEGIN
SELECT MIN(productos.stockProducto) AS stockMayor, productos.nombreProducto FROM productos GROUP BY idProducto ORDER BY stockMayor ASC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMenVend` ()  BEGIN
SELECT COUNT(detalleventa.idProducto) as nroFacturas, productos.idProducto, productos.nombreProducto FROM detalleventa INNER JOIN productos ON
productos.idProducto = detalleventa.idProducto group by detalleventa.idProducto ORDER by nroFacturas asc limit 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarEmpresa` (IN `nombreUsuario_` VARCHAR(40), IN `correoUsuario_` VARCHAR(40), IN `contrasenaUsuario_` VARCHAR(20))  INSERT INTO `usuarios`(`nombreUsuario`, `correoUsuario`, `contrasenaUsuario`) 
VALUES (nombreUsuario_,correoUsuario_,contrasenaUsuario_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarImagen` (IN `rutaImg_` VARCHAR(100), IN `nombreImg_` VARCHAR(30))  INSERT INTO `imagen`(`idImagen`, `rutaImagen`, `nombreImagen`) VALUES ('', rutaImg_, nombreImg_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rentabilidadProductos` ()  BEGIN
select productos.nombreProducto,max((productos.precioVenta- productos.costoProducto)/productos.costoProducto)as rentabilidad from productos group by productos.nombreProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenCompras` (IN `fecha1_` DATE, IN `fecha2_` DATE)  SELECT enccompraproducto.vrTotalCompra as total, enccompraproducto.conceptoCompra, enccompraproducto.fechaCompra FROM enccompraproducto WHERE
enccompraproducto.fechaCompra >= fecha1_ AND enccompraproducto.fechaCompra <= fecha2_ GROUP BY enccompraproducto.idCompra ORDER BY enccompraproducto.fechaCompra ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenEgreso` (IN `fecha1_` DATE, IN `fecha2_` DATE)  SELECT encegreso.vrTotalEgreso as total, encegreso.tituloEgreso, encegreso.fechaEgreso FROM encegreso WHERE
encegreso.fechaEgreso >= fecha1_ AND encegreso.fechaEgreso <= fecha2_ GROUP BY encegreso.idEgreso ORDER BY encegreso.fechaEgreso ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenVenta` (IN `fecha1_` DATE, IN `fecha2_` DATE)  SELECT encventas.vrTotalVta as total, encventas.tituloVenta, encventas.fechaVenta FROM encventas WHERE
encventas.fechaVenta >= fecha1_ AND encventas.fechaVenta <= fecha2_ GROUP BY encventas.idVenta ORDER BY encventas.fechaVenta ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_productoRentable` (OUT `_Rentabilidad` INT(11))  BEGIN
SELECT productos.nombreProducto, 
MAX((productos.precioVenta- productos.costoProducto)/productos.costoProducto)AS Rentabilidad
FROM productos INTO _Rentabilidad;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `nombresCliente` varchar(30) NOT NULL,
  `apellidosCliente` varchar(30) DEFAULT NULL,
  `telefonoCliente` varchar(15) DEFAULT NULL,
  `cedulaCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES
(4, 'Andrei', 'Peña', '31548792', 1111111111),
(6, 'Keanu', 'Reeves', '555693987', 101099853),
(7, 'Antonio', 'Alvarez', '78642211', 1010994788),
(8, 'Manuela', 'gomez orozco', '4789621', 1010998789),
(9, 'Denis Mariana ', 'Castaño Orozco', '3198752016', 1010998789),
(10, 'Rodolfo', 'Hernandez', '312498652', 1010998654),
(11, 'Pancho', 'Sansa', '0', 1010948769),
(13, 'gfdgfadga', 'fgfadag', '123213', 123123);

-- --------------------------------------------------------

--
-- Table structure for table `detalleegreso`
--

CREATE TABLE `detalleegreso` (
  `idDetEgreso` int(11) NOT NULL,
  `valorEgreso` int(8) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `idEgreso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detalleegreso`
--

INSERT INTO `detalleegreso` (`idDetEgreso`, `valorEgreso`, `descripcion`, `idEgreso`) VALUES
(1, 200000, 'Juan', 1),
(2, 120000, 'Maria', 1),
(3, 190000, 'Pablo', 1),
(4, 230000, 'Alcantarilla', 2),
(5, 12000, 'Viaje a la notaría', 2),
(6, 120000, 'vasos', 3),
(7, 80000, 'copas aguardiente', 3),
(8, 115000, 'Vasos cerveceros', 3),
(9, 15000, 'sacacorchos', 3),
(10, 12000, 'destapador de bebidas', 3),
(11, 2000000, 'Arriendo del Local', 4),
(12, 20000, 'Barniz', 5),
(13, 210000, 'Refacciones varias', 5),
(14, 150000, 'Carpintero', 5),
(15, 80500, 'Madera', 5),
(16, 100000, 'Juan', 6),
(17, 100000, 'Maria', 6),
(18, 100000, 'Pablo', 6),
(19, 240000, 'Juan', 7),
(20, 201400, 'Maria', 7),
(21, 120000, 'Pablo', 7),
(22, 240000, 'Curso manejo y conservación de vinos', 8);

-- --------------------------------------------------------

--
-- Table structure for table `detalleventa`
--

CREATE TABLE `detalleventa` (
  `idDetVenta` int(11) NOT NULL,
  `uniVendidas` int(8) NOT NULL,
  `precioUnitario` int(11) DEFAULT NULL,
  `idVenta` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detalleventa`
--

INSERT INTO `detalleventa` (`idDetVenta`, `uniVendidas`, `precioUnitario`, `idVenta`, `idProducto`) VALUES
(3, 3, 50000, 4, 9),
(4, 2, 42000, 4, 2),
(9, 1, 55000, 5, 10),
(10, 1, 5000, 5, 4),
(11, 3, 50000, 5, 1),
(12, 2, 42000, 5, 2),
(13, 4, 42000, 6, 2),
(14, 2, 3500, 7, 11),
(15, 1, 42000, 8, 2),
(17, 1, 36000, 9, 8),
(18, 10, 3500, 10, 11),
(19, 7, 6000, 10, 7),
(20, 2, 50000, 11, 6),
(21, 16, 3500, 12, 11);

-- --------------------------------------------------------

--
-- Table structure for table `detcompraproducto`
--

CREATE TABLE `detcompraproducto` (
  `idDetCompra` int(11) NOT NULL,
  `cantidadCompra` int(8) NOT NULL,
  `precioUnitario` int(11) NOT NULL,
  `idCompra` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detcompraproducto`
--

INSERT INTO `detcompraproducto` (`idDetCompra`, `cantidadCompra`, `precioUnitario`, `idCompra`, `idProducto`) VALUES
(58, 20, 2000, 1, 11),
(59, 14, 5000, 1, 7),
(60, 10, 40000, 2, 10),
(61, 10, 25000, 3, 5),
(62, 17, 42000, 4, 1),
(63, 11, 25000, 4, 8),
(64, 16, 2500, 5, 4),
(65, 12, 3000, 5, 3),
(66, 5, 5000, 5, 7),
(67, 5, 30000, 6, 9),
(68, 8, 30000, 7, 2),
(69, 9, 40000, 7, 6),
(70, 5, 30000, 8, 9);

-- --------------------------------------------------------

--
-- Table structure for table `enccompraproducto`
--

CREATE TABLE `enccompraproducto` (
  `idCompra` int(11) NOT NULL,
  `conceptoCompra` varchar(50) DEFAULT NULL,
  `fechaCompra` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `idProveedor` int(11) DEFAULT NULL,
  `vrTotalCompra` int(11) NOT NULL,
  `vrTotalIva` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `enccompraproducto`
--

INSERT INTO `enccompraproducto` (`idCompra`, `conceptoCompra`, `fechaCompra`, `idProveedor`, `vrTotalCompra`, `vrTotalIva`) VALUES
(1, 'Cervezas', '2023-03-08 17:26:14', 15, 110000, 18900),
(2, 'licor fuerte', '2023-03-08 17:27:17', 17, 400000, 84000),
(3, 'Guaro', '2023-03-08 17:28:20', 14, 250000, 52500),
(4, 'Vino', '2023-03-08 17:28:50', 11, 989000, 207690),
(5, 'Cerveza', '2023-03-08 17:29:38', 12, 101000, 10830),
(6, 'Champaña', '2023-03-08 17:30:07', 11, 150000, 31500),
(7, 'Trago fuerte', '2023-03-08 17:31:04', 11, 600000, 126000),
(8, 'Champaña', '2023-03-08 17:32:14', 15, 150000, 31500);

-- --------------------------------------------------------

--
-- Table structure for table `encegreso`
--

CREATE TABLE `encegreso` (
  `idEgreso` int(11) NOT NULL,
  `fechaEgreso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tituloEgreso` varchar(80) DEFAULT NULL,
  `vrTotalEgreso` int(8) NOT NULL,
  `idTipoEgreso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `encegreso`
--

INSERT INTO `encegreso` (`idEgreso`, `fechaEgreso`, `tituloEgreso`, `vrTotalEgreso`, `idTipoEgreso`) VALUES
(1, '2023-02-23 23:38:43', 'Pago a Personal', 510000, 3),
(2, '2023-02-23 23:40:41', 'Pago Alcantarillado', 242000, 0),
(3, '2023-02-23 23:44:44', 'Compra de utilería', 342000, 6),
(4, '2023-02-23 23:45:45', 'Arriendo Local', 2000000, 1),
(5, '2023-02-23 23:48:23', 'Barriles Vino', 460500, 5),
(6, '2023-02-23 23:49:14', 'Subsidio Transporte', 300000, 4),
(7, '2023-02-23 23:50:34', 'Nomina 2023', 561400, 2),
(8, '2023-02-23 23:52:22', 'Curso Empleados', 240000, 3);

-- --------------------------------------------------------

--
-- Table structure for table `encventas`
--

CREATE TABLE `encventas` (
  `idVenta` int(11) NOT NULL,
  `tituloVenta` varchar(35) DEFAULT NULL,
  `fechaVenta` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `metodoPagoVenta` varchar(20) DEFAULT NULL,
  `descuentoVenta` int(11) NOT NULL,
  `vrTotalVta` int(11) NOT NULL,
  `vrtotalIva` int(11) NOT NULL,
  `editado` int(10) NOT NULL,
  `idCliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `encventas`
--

INSERT INTO `encventas` (`idVenta`, `tituloVenta`, `fechaVenta`, `metodoPagoVenta`, `descuentoVenta`, `vrTotalVta`, `vrtotalIva`, `editado`, `idCliente`) VALUES
(4, '2 cremas de whiskey y 3 botellas de', '2023-02-23 12:30:33', 'Transferencia', 5000, 229000, 49140, 1, 4),
(5, '1 botella de gin,  un pilsenon 750,', '2023-02-23 12:36:38', 'Efectivo', 10000, 284000, 61440, 1, 9),
(6, '4 cremas de whiskey', '2023-02-23 12:37:47', 'Transferencia', 8000, 160000, 35280, 0, 7),
(7, 'Dos aguila lata', '2023-02-23 12:38:57', 'Efectivo', 0, 7000, 1470, 0, 4),
(8, '1 crema de whiskey', '2023-02-23 12:42:05', 'Efectivo', 0, 42000, 8820, 0, 8),
(9, 'Un vino vientos del sur', '2023-02-23 12:58:42', 'Tarjeta de crédito', 0, 36000, 7560, 0, 11),
(10, '10 aguila lata y 7 aguilones litro', '2023-02-23 13:01:54', 'Efectivo', 7000, 70000, 13650, 0, 10),
(11, '2 litros de ron caldas', '2023-02-23 13:04:53', 'Efectivo', 8500, 91500, 21000, 0, 6),
(12, '16 aguilas en lata', '2023-02-23 13:06:46', 'Transferencia', 0, 56000, 11760, 0, 7);

-- --------------------------------------------------------

--
-- Table structure for table `imagen`
--

CREATE TABLE `imagen` (
  `idImagen` int(11) NOT NULL,
  `rutaImagen` varchar(100) NOT NULL,
  `nombreImagen` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `imagen`
--

INSERT INTO `imagen` (`idImagen`, `rutaImagen`, `nombreImagen`) VALUES
(9, '/public/img/productos', 'bimbo.png');

-- --------------------------------------------------------

--
-- Table structure for table `notas`
--

CREATE TABLE `notas` (
  `idNota` int(11) NOT NULL,
  `tituloNota` varchar(20) DEFAULT NULL,
  `contenidoNota` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `productos`
--

CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL,
  `nombreProducto` varchar(30) NOT NULL,
  `descripcionProducto` varchar(100) DEFAULT NULL,
  `porcentajeIva` int(5) NOT NULL,
  `costoProducto` int(8) NOT NULL,
  `precioVenta` int(8) NOT NULL,
  `stockProducto` int(7) NOT NULL,
  `idImagen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`idProducto`, `nombreProducto`, `descripcionProducto`, `porcentajeIva`, `costoProducto`, `precioVenta`, `stockProducto`, `idImagen`) VALUES
(1, 'Vino gato negro', 'Vino Tinto merlot 2020', 21, 42000, 50000, 21, 9),
(2, 'Crema de whiskey', 'Crema dulce', 21, 30000, 42000, 8, 9),
(3, 'Pilsenon litro', 'Cerveza pilsen litro', 3, 3000, 5500, 44, 9),
(4, 'Pilsenon 750', 'Pilsenon 750ml\r\n', 15, 2500, 5000, 47, 9),
(5, 'Media de guaro', 'Media de guaro tapa roja', 21, 25000, 20000, 20, 9),
(6, 'litro de ron caldas', 'Litro de ron caldas', 21, 40000, 50000, 14, 9),
(7, 'Aguilon litro', 'Aguilon litro', 15, 5000, 6000, 42, 9),
(8, 'Vino Vientos del sur', 'Cavernet vientos del sur 750ml', 21, 25000, 36000, 18, 9),
(9, 'Botella de champaña', 'Botella de champaña blanca, espumosa ', 21, 30000, 50000, 17, 9),
(10, 'Botella de gin', 'Botella de ginebra ', 21, 40000, 55000, 13, 9),
(11, 'Aguila lata', 'Lata de aguila negra 330cm3', 21, 2000, 3500, 42, 9);

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `idProveedor` int(11) NOT NULL,
  `nombreProveedor` varchar(40) NOT NULL,
  `direccionProveedor` varchar(30) DEFAULT NULL,
  `telefonoProveedor` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `proveedor`
--

INSERT INTO `proveedor` (`idProveedor`, `nombreProveedor`, `direccionProveedor`, `telefonoProveedor`) VALUES
(9, 'Licores de cundinamarca S.A', 'calle 12', '124'),
(11, 'Variedades S.A', 'Cll Sa', '36588912'),
(12, 'FLA', 'Cll Santo tequila', '52424788'),
(14, 'Bavaria', 'Calle Elm', '555 666 4548'),
(15, 'Licores el gallo', 'avenida central', '3169874503'),
(16, 'Rones el pistolero', '...', '9561059878'),
(17, 'tqeuila es mescal', 'calle banano', '2225487');

-- --------------------------------------------------------

--
-- Table structure for table `tipoegreso`
--

CREATE TABLE `tipoegreso` (
  `idTipoEgreso` int(11) NOT NULL,
  `nombreTipoEgreso` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipoegreso`
--

INSERT INTO `tipoegreso` (`idTipoEgreso`, `nombreTipoEgreso`) VALUES
(0, 'Servicios públicos'),
(1, 'Arriendo'),
(2, 'Nómina'),
(3, 'Gastos Administrativos'),
(4, 'Transporte / Domicilios'),
(5, 'Mantenimiento / Reparaciones'),
(6, 'Muebles / Maquinaria');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nombreUsuario` varchar(40) NOT NULL,
  `correoUsuario` varchar(40) NOT NULL,
  `contrasenaUsuario` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombreUsuario`, `correoUsuario`, `contrasenaUsuario`) VALUES
(22, 'Los Pollos hermanos', 'yinifac660@crtsec.com', '1036251514'),
(24, 'Perros Juan', 'texeh42419@fsouda.com', '123456789'),
(25, 'Manueh', 'texeh42419@fsouda.com', '1036251514'),
(26, 'Pollos Hermanos', 'jasoyop726@ngopy.com', '1036251514'),
(27, 'Pollos Hermanos', 'jasoyop726@ngopy.com', '1036251514');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indexes for table `detalleegreso`
--
ALTER TABLE `detalleegreso`
  ADD PRIMARY KEY (`idDetEgreso`),
  ADD KEY `detalleEgreso` (`idEgreso`);

--
-- Indexes for table `detalleventa`
--
ALTER TABLE `detalleventa`
  ADD PRIMARY KEY (`idDetVenta`),
  ADD KEY `ventaProducto` (`idProducto`),
  ADD KEY `detEncVta` (`idVenta`);

--
-- Indexes for table `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
  ADD PRIMARY KEY (`idDetCompra`),
  ADD KEY `compraProducto` (`idCompra`),
  ADD KEY `detalleCompraProducto` (`idProducto`);

--
-- Indexes for table `enccompraproducto`
--
ALTER TABLE `enccompraproducto`
  ADD PRIMARY KEY (`idCompra`),
  ADD KEY `encCompraProductos` (`idProveedor`);

--
-- Indexes for table `encegreso`
--
ALTER TABLE `encegreso`
  ADD PRIMARY KEY (`idEgreso`),
  ADD KEY `egresosTipo` (`idTipoEgreso`);

--
-- Indexes for table `encventas`
--
ALTER TABLE `encventas`
  ADD PRIMARY KEY (`idVenta`),
  ADD KEY `clientesVentas` (`idCliente`);

--
-- Indexes for table `imagen`
--
ALTER TABLE `imagen`
  ADD PRIMARY KEY (`idImagen`);

--
-- Indexes for table `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`idNota`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `productoImagen` (`idImagen`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idProveedor`);

--
-- Indexes for table `tipoegreso`
--
ALTER TABLE `tipoegreso`
  ADD PRIMARY KEY (`idTipoEgreso`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `detalleegreso`
--
ALTER TABLE `detalleegreso`
  MODIFY `idDetEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `detalleventa`
--
ALTER TABLE `detalleventa`
  MODIFY `idDetVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
  MODIFY `idDetCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `imagen`
--
ALTER TABLE `imagen`
  MODIFY `idImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `notas`
--
ALTER TABLE `notas`
  MODIFY `idNota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tipoegreso`
--
ALTER TABLE `tipoegreso`
  MODIFY `idTipoEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detalleegreso`
--
ALTER TABLE `detalleegreso`
  ADD CONSTRAINT `detalleEgreso` FOREIGN KEY (`idEgreso`) REFERENCES `encegreso` (`idEgreso`) ON DELETE CASCADE;

--
-- Constraints for table `detalleventa`
--
ALTER TABLE `detalleventa`
  ADD CONSTRAINT `EncDetVta` FOREIGN KEY (`idVenta`) REFERENCES `encventas` (`idVenta`) ON DELETE CASCADE,
  ADD CONSTRAINT `ventaProducto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

--
-- Constraints for table `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
  ADD CONSTRAINT `compraProducto` FOREIGN KEY (`idCompra`) REFERENCES `enccompraproducto` (`idCompra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalleCompraProducto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

--
-- Constraints for table `enccompraproducto`
--
ALTER TABLE `enccompraproducto`
  ADD CONSTRAINT `encCompraProductos` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`) ON DELETE CASCADE;

--
-- Constraints for table `encegreso`
--
ALTER TABLE `encegreso`
  ADD CONSTRAINT `egresosTipo` FOREIGN KEY (`idTipoEgreso`) REFERENCES `tipoegreso` (`idTipoEgreso`) ON DELETE CASCADE;

--
-- Constraints for table `encventas`
--
ALTER TABLE `encventas`
  ADD CONSTRAINT `encClientes` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON DELETE CASCADE;

--
-- Constraints for table `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productoImagen` FOREIGN KEY (`idImagen`) REFERENCES `imagen` (`idImagen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
