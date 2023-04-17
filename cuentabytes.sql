-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2023 at 12:32 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCliente` (IN `_idCliente` INT(11), IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))   UPDATE `clientes` SET `idCliente`=_idCliente,`nombresCliente`=_nombresCliente,`apellidosCliente`=_apellidosCliente,`telefonoCliente`=_telefonoCliente,`cedulaCliente`=_cedulaCliente WHERE idCliente = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCostoProducto` (IN `_stockProducto` INT(7), IN `_costoProducto` INT(8), IN `_idProducto` INT)   UPDATE productos SET stockProducto = stockProducto + _stockProducto, costoProducto = _costoProducto WHERE idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarDetEgreso` (IN `_idDetEgreso` INT(11), IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100))   UPDATE `detalleegreso` SET `idDetEgreso`=_idDetEgreso,`valorEgreso`=_valorEgreso,`descripcion`=_descripcion WHERE idDetEgreso = _idDetEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEgreso` (IN `_idEgreso` INT(11), IN `_tituloEgreso` VARCHAR(80), IN `_vrTotalEgreso` INT(8), IN `_idTipoEgreso` INT(11))   UPDATE `encegreso` SET 
`idEgreso`=_idEgreso,`tituloEgreso`=_tituloEgreso,`vrTotalEgreso`=_vrTotalEgreso,`idTipoEgreso`=_idTipoEgreso WHERE idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEncVenta` (IN `titVenta` VARCHAR(35), IN `metodoPagoVenta_` VARCHAR(20), IN `descuentoVenta_` INT(11), IN `vrTotal` INT(11), IN `vrIva` INT(11), IN `idCliente_` INT(11), IN `idVenta_` INT)   BEGIN
UPDATE `encventas` SET `tituloVenta`=titVenta,`metodoPagoVenta`=metodoPagoVenta_,`descuentoVenta`=descuentoVenta_
,`vrTotalVta`=vrTotal,`vrTotalIva`=vrIva,`editado`= 1,`idCliente`=idCliente_ WHERE idVenta = idVenta_ ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarProducto` (IN `_idProducto` INT(11), IN `_nombreProducto` VARCHAR(30), IN `_descripcionProducto` VARCHAR(100), IN `_porcentajeIva` INT(5), IN `_costoProducto` INT(8), IN `_precioVenta` INT(8), IN `_stockProducto` INT(7), IN `_idImagen` INT(11))   UPDATE `productos` SET `nombreProducto`=_nombreProducto,`descripcionProducto`=_descripcionProducto,`porcentajeIva`=_porcentajeIva,`costoProducto`=_costoProducto,`precioVenta`=_precioVenta,
`stockProducto`=_stockProducto,`idImagen`=_idImagen WHERE idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarProveedor` (IN `_idProveedor` INT(11), IN `_nombreProveedor` VARCHAR(40), IN `_direccionProveedor` VARCHAR(30), IN `_telefonoProveedor` VARCHAR(15))   BEGIN
UPDATE `proveedor` SET `nombreProveedor`=_nombreProveedor,`direccionProveedor`=_direccionProveedor,`telefonoProveedor`=_telefonoProveedor WHERE idProveedor = _idProveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarStock` (IN `unidVend` INT(11), IN `_idProducto` INT(11))   BEGIN
UPDATE productos SET stockProducto = stockProducto - unidVend WHERE idProducto = _idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `comprasPorDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
    SELECT DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d') AS Dia, SUM(enccompraproducto.vrTotalCompra) AS VrTotalDia
    FROM enccompraproducto
    WHERE enccompraproducto.fechaCompra >= inicio AND enccompraproducto.fechaCompra <= fin
    GROUP BY Dia;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `comprasPorHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT HOUR(DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d %H:%i:%s')) as hora, SUM(enccompraproducto.vrTotalCompra) as vrTotalHora FROM enccompraproducto WHERE enccompraproducto.fechaCompra >= inicio AND enccompraproducto.fechaCompra <= fin GROUP BY HOUR(DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d %H:%i:%s'))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `egresosPorDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
    SELECT DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d') AS Dia, SUM(encegreso.vrTotalEgreso) AS VrTotalDia
    FROM encegreso
    WHERE encegreso.fechaEgreso >= inicio AND encegreso.fechaEgreso <= fin
    GROUP BY Dia;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `egresosPorHora` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
SELECT HOUR(DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d %H:%i:%s')) as hora, SUM(encegreso.vrTotalEgreso) as vrTotalHora FROM encegreso WHERE encegreso.fechaEgreso >= inicio AND encegreso.fechaEgreso <= fin GROUP BY HOUR(DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d %H:%i:%s'));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarCliente` (IN `_idCliente` INT(11))   DELETE FROM `clientes` WHERE idCliente = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarCompra` (IN `_idCompra` INT)   DELETE FROM `enccompraproducto` WHERE idCompra = _idCompra$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarEgreso` (IN `_idEgreso` INT(11))   DELETE FROM `encegreso` WHERE idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarProducto` (IN `_idProducto` INT(11))   BEGIN
DELETE FROM productos
WHERE idProducto = _idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarProvee` (IN `_idProveedor` INT(11))   BEGIN
	DELETE FROM proveedor WHERE proveedor.idProveedor = _idProveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarVta` (`idVenta_` INT)   BEGIN
	DELETE FROM encventas WHERE encventas.idVenta = idVenta_;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `idUltimaImg` ()   SELECT imagen.idImagen FROM `imagen` order by idImagen DESC LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarCliente` (IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))   INSERT INTO `clientes`(`nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES (_nombresCliente,_apellidosCliente,_telefonoCliente,_cedulaCliente)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetCompra` (IN `_cantidadCompra` INT(11), IN `_precioUnitario` INT(8), IN `_idCompra` INT(11), IN `_idProducto` INT(11))   INSERT INTO `detcompraproducto`(`cantidadCompra`, `precioUnitario`, `idCompra`, `idProducto`) 
VALUES (_cantidadCompra,_precioUnitario,_idCompra,_idProducto)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetEgreso` (IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100), IN `_idEgreso` INT(11))   INSERT INTO `detalleegreso`(`valorEgreso`, `descripcion`, `idEgreso`) VALUES (_valorEgreso,_descripcion,_idEgreso)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetVenta` (IN `_uniVendidas` INT(8), IN `precioUnit` INT(11), IN `_idVenta` INT(11), IN `idProducto` INT(11))   BEGIN
INSERT INTO `detalleventa` (`uniVendidas`, `precioUnitario`, `idVenta`, `idProducto`) VALUES (_uniVendidas, precioUnit, _idVenta, idProducto); END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncCompra` (IN `_idCompra` INT(11), IN `_conceptoCompra` VARCHAR(50), IN `_idProveedor` INT(11), IN `_vrTotalCompra` INT(11), IN `_vrTotalIva` INT(11))   INSERT INTO enccompraproducto(idCompra, conceptoCompra, fechaCompra, idProveedor, vrTotalCompra, vrTotalIva) 
VALUES (_idCompra,_conceptoCompra, now(),_idProveedor,_vrTotalCompra,_vrTotalIva)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncEgreso` (IN `_idEgreso` INT(11), IN `_tituloEgreso` VARCHAR(80), IN `_vrTotalEgreso` INT(8), IN `_idTipoEgreso` INT(11))   INSERT INTO `encegreso`(`idEgreso`, `fechaEgreso`, `tituloEgreso`, `vrTotalEgreso`, `idTipoEgreso`) VALUES (_idEgreso, now(),_tituloEgreso,_vrTotalEgreso,_idTipoEgreso)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncVenta` (IN `_idVenta` INT, IN `_tituloVta` VARCHAR(35), IN `_metPago` VARCHAR(20), IN `dto` INT(11), IN `vrTotal` INT(11), IN `vrIva` INT, IN `_idCliente` INT(11))   BEGIN
INSERT INTO `encventas`(`idVenta`, `tituloVenta`, `fechaVenta`, `metodoPagoVenta`, `descuentoVenta`, `vrTotalVta`, `vrtotalIva`, `editado`, `idCliente`) VALUES (_idVenta,_tituloVta, now(), _metPago, dto, vrTotal, vrIva, 0, _idCliente);                                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarProducto` (IN `_nombreProducto` VARCHAR(30), IN `_descripcionProducto` VARCHAR(100), IN `_porcentajeIva` INT(5), IN `_costoProducto` INT(8), IN `_precioVenta` INT(8), IN `_stockProducto` INT(7), IN `_idImagen` INT(11))   INSERT INTO `productos`(`nombreProducto`, `descripcionProducto`, `porcentajeIva`, `costoProducto`, `precioVenta`, `stockProducto`, `idImagen`) VALUES (_nombreProducto,_descripcionProducto,_porcentajeIva,_costoProducto,_precioVenta,_stockProducto,_idImagen)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarClientes` ()   BEGIN
SELECT nombresCliente, idCliente FROM clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarCompra` (IN `_idCompra` INT(11))   SELECT enccompraproducto.idCompra, enccompraproducto.conceptoCompra, enccompraproducto.fechaCompra, enccompraproducto.vrTotalCompra, enccompraproducto.vrTotalIva, 
proveedor.nombreProveedor, proveedor.idProveedor,
detcompraproducto.idDetCompra, detcompraproducto.cantidadCompra, detcompraproducto.precioUnitario, 
productos.nombreProducto, productos.idProducto
FROM enccompraproducto 
INNER JOIN proveedor ON proveedor.idProveedor = enccompraproducto.idProveedor
INNER JOIN detcompraproducto ON detcompraproducto.idCompra = enccompraproducto.idCompra
INNER JOIN productos ON productos.idProducto = detcompraproducto.idProducto
WHERE enccompraproducto.idCompra = _idCompra$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarCompras` ()   SELECT enccompraproducto.*, proveedor.nombreProveedor FROM enccompraproducto INNER JOIN proveedor on proveedor.idProveedor = enccompraproducto.idProveedor ORDER BY enccompraproducto.idCompra DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarEgreso` (IN `_idEgreso` INT(11))   SELECT encegreso.idEgreso, encegreso.fechaEgreso, encegreso.tituloEgreso, encegreso.vrTotalEgreso,
detalleegreso.idDetEgreso ,detalleegreso.valorEgreso, detalleegreso.descripcion, detalleegreso.idEgreso,
tipoegreso.idTipoEgreso, tipoegreso.nombreTipoEgreso FROM encegreso
INNER JOIN tipoegreso ON tipoegreso.idTipoEgreso = encegreso.idTipoEgreso
INNER JOIN detalleegreso ON detalleegreso.idEgreso = encegreso.idEgreso
WHERE encegreso.idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarEgresos` ()   SELECT encegreso.idEgreso, encegreso.fechaEgreso, encegreso.tituloEgreso, encegreso.vrTotalEgreso,
tipoegreso.idTipoEgreso, tipoegreso.nombreTipoEgreso 
FROM encegreso
INNER JOIN tipoegreso ON tipoegreso.idTipoEgreso = encegreso.idTipoEgreso ORDER BY encegreso.idEgreso DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProductos` ()   BEGIN
SELECT idProducto, nombreProducto, stockProducto, precioVenta, porcentajeIva, costoProducto FROM productos ORDER BY nombreProducto ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProveedores` ()   select * from proveedor order by idProveedor desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarTipoEgreso` ()   SELECT * FROM tipoegreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarVenta` (IN `idVenta_` INT(11))   BEGIN
SELECT encventas.idVenta, encventas.tituloVenta, encventas.fechaVenta, encventas.metodoPagoVenta, encventas.descuentoVenta, encventas.vrTotalVta, encventas.vrtotalIva, encventas.editado, clientes.idCliente, clientes.nombresCliente, detalleventa.idDetVenta, detalleventa.uniVendidas, detalleventa.precioUnitario, detalleventa.idProducto, productos.nombreProducto, productos.stockProducto, productos.porcentajeIva FROM encventas INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta INNER JOIN productos ON detalleventa.idProducto = productos.idProducto INNER JOIN clientes on clientes.idCliente = encventas.idCliente WHERE encventas.idVenta = idVenta_; 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarVentas` ()   BEGIN
SELECT idVenta, tituloVenta, fechaVenta, metodoPagoVenta, descuentoVenta, vrTotalVta, nombresCliente, apellidosCliente FROM encventas INNER JOIN clientes ON encventas.idCliente = clientes.idCliente order by idVenta DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mayorEgreso` ()   BEGIN
SELECT SUM(detalleegreso.valorEgreso)as mayorValor, detalleegreso.descripcion, encegreso.tituloEgreso FROM detalleegreso INNER JOIN encegreso ON encegreso.idEgreso = detalleegreso.idEgreso GROUP BY detalleegreso.idegreso ORDER BY mayorValor DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresClientes` ()   BEGIN
SELECT COUNT(encventas.idCliente) as nroFacturas, clientes.nombresCliente FROM encventas INNER
JOIN clientes on encventas.idCliente = clientes.idCliente GROUP BY encventas.idCliente ORDER BY nroFacturas desc limit 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menorEgreso` ()   BEGIN
SELECT SUM(detalleegreso.valorEgreso)as mayorValor, detalleegreso.descripcion, encegreso.tituloEgreso FROM detalleegreso INNER JOIN encegreso ON encegreso.idEgreso = detalleegreso.idEgreso GROUP BY detalleegreso.idegreso ORDER BY mayorValor ASC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarProductos` ()   SELECT productos.idProducto, productos.nombreProducto,productos.descripcionProducto, productos.porcentajeIva, productos.costoProducto, productos.precioVenta, productos.stockProducto, imagen.nombreImagen
FROM productos INNER JOIN imagen
ON productos.idImagen = imagen.idImagen$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarUnProducto` (IN `_idProducto` INT(11))   SELECT productos.idProducto, productos.nombreProducto, productos.stockProducto, productos.precioVenta, productos.porcentajeIva, productos.costoProducto, imagen.nombreImagen
FROM productos INNER JOIN imagen
ON productos.idImagen = imagen.idImagen$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMasStock` ()   BEGIN
SELECT MAX(productos.stockProducto) AS stockMayor, productos.nombreProducto FROM productos GROUP BY idProducto ORDER BY stockMayor DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMasVend` ()   BEGIN
SELECT COUNT(detalleventa.idProducto) as nroFacturas, productos.idProducto, productos.nombreProducto FROM detalleventa INNER JOIN productos ON
productos.idProducto = detalleventa.idProducto group by detalleventa.idProducto ORDER by nroFacturas desc limit 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMenStock` ()   BEGIN
SELECT MIN(productos.stockProducto) AS stockMayor, productos.nombreProducto FROM productos GROUP BY idProducto ORDER BY stockMayor ASC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMenVend` ()   BEGIN
SELECT COUNT(detalleventa.idProducto) as nroFacturas, productos.idProducto, productos.nombreProducto FROM detalleventa INNER JOIN productos ON
productos.idProducto = detalleventa.idProducto group by detalleventa.idProducto ORDER by nroFacturas asc limit 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarEmpresa` (IN `nombreUsuario_` VARCHAR(40), IN `correoUsuario_` VARCHAR(40), IN `contrasenaUsuario_` VARCHAR(20))   INSERT INTO `usuarios`(`nombreUsuario`, `correoUsuario`, `contrasenaUsuario`) 
VALUES (nombreUsuario_,correoUsuario_,contrasenaUsuario_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarImagen` (IN `rutaImg_` VARCHAR(100), IN `nombreImg_` VARCHAR(30))   INSERT INTO `imagen`(`idImagen`, `rutaImagen`, `nombreImagen`) VALUES ('', rutaImg_, nombreImg_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rentabilidadProductos` ()   BEGIN
select productos.nombreProducto,max((productos.precioVenta- productos.costoProducto)/productos.costoProducto)as rentabilidad from productos group by productos.nombreProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenCompras` (IN `fecha1_` DATE, IN `fecha2_` DATE)   SELECT enccompraproducto.vrTotalCompra as total, enccompraproducto.conceptoCompra, enccompraproducto.fechaCompra FROM enccompraproducto WHERE
enccompraproducto.fechaCompra >= fecha1_ AND enccompraproducto.fechaCompra <= fecha2_ GROUP BY enccompraproducto.idCompra ORDER BY enccompraproducto.fechaCompra ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenEgreso` (IN `fecha1_` DATE, IN `fecha2_` DATE)   SELECT encegreso.vrTotalEgreso as total, encegreso.tituloEgreso, encegreso.fechaEgreso FROM encegreso WHERE
encegreso.fechaEgreso >= fecha1_ AND encegreso.fechaEgreso <= fecha2_ GROUP BY encegreso.idEgreso ORDER BY encegreso.fechaEgreso ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenVenta` (IN `fecha1_` DATE, IN `fecha2_` DATE)   SELECT encventas.vrTotalVta as total, encventas.tituloVenta, encventas.fechaVenta FROM encventas WHERE
encventas.fechaVenta >= fecha1_ AND encventas.fechaVenta <= fecha2_ GROUP BY encventas.idVenta ORDER BY encventas.fechaVenta ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_productoRentable` (OUT `_Rentabilidad` INT(11))   BEGIN
SELECT productos.nombreProducto, 
MAX((productos.precioVenta- productos.costoProducto)/productos.costoProducto)AS Rentabilidad
FROM productos INTO _Rentabilidad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ventasPorDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
    SELECT DATE_FORMAT(fechaVenta, '%Y-%m-%d') AS Dia, SUM(vrTotalVta) AS VrTotalDia
    FROM encVentas
    WHERE fechaVenta >= inicio AND fechaVenta <= fin
    GROUP BY Dia;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ventasPorHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
SELECT HOUR(DATE_FORMAT(fechaVenta, '%Y-%m-%d %H:%i:%s')) as hora, SUM(encventas.vrTotalVta) as vrTotalHora FROM encventas WHERE fechaVenta >= inicio AND fechaVenta <= fin GROUP BY HOUR(DATE_FORMAT(fechaVenta, '%Y-%m-%d %H:%i:%s'));
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES
(4, 'Andrei', 'Peña', '31548792', 1111111111),
(6, 'Keanu', 'Reeves', '555693987', 101099853),
(7, 'Antonio', 'Alvarez', '78642211', 1010994788),
(8, 'Manuela', 'gomez orozco', '4789621', 1),
(9, 'Juana', 'Peña', '3198752016', 1010998789),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enccompraproducto`
--

INSERT INTO `enccompraproducto` (`idCompra`, `conceptoCompra`, `fechaCompra`, `idProveedor`, `vrTotalCompra`, `vrTotalIva`) VALUES
(1, 'Tdpbwut', '2023-04-02 19:33:32', 14, 223899, 92719),
(2, 'Yktqjgl', '2023-03-31 10:37:11', 14, 333974, 389478),
(3, 'Wttoilp', '2023-04-01 05:24:21', 14, 406166, 480382),
(4, 'Ijsrnph', '2023-04-03 07:58:23', 14, 68746, 414252),
(5, 'Cvgqccd', '2023-04-01 07:42:47', 14, 85600, 394120),
(6, 'Jbmirhd', '2023-04-04 03:11:09', 14, 76944, 279133),
(7, 'Pbrzouy', '2023-04-01 22:45:22', 14, 65608, 401685),
(8, 'Zyitcad', '2023-04-04 02:04:50', 14, 425371, 263495),
(9, 'Plyffhk', '2023-04-06 19:11:35', 14, 227616, 377965),
(10, 'Srjhtsv', '2023-04-04 05:50:46', 14, 174738, 191677),
(11, 'Hzhjzpn', '2023-03-31 16:48:22', 14, 61599, 254842),
(12, 'Lmajiny', '2023-04-01 16:01:12', 14, 311275, 123146),
(13, 'Jfnkhxv', '2023-04-04 19:54:36', 14, 42370, 351050),
(14, 'Ctjboza', '2023-04-02 03:40:36', 14, 468165, 239130),
(15, 'Fzncxai', '2023-04-04 17:55:51', 14, 280575, 456666),
(16, 'Wleeosm', '2023-04-04 11:25:19', 14, 217266, 29241),
(17, 'Uvsphqa', '2023-04-03 00:47:39', 14, 165461, 307514),
(18, 'Qklziex', '2023-04-01 01:03:49', 14, 21727, 11854),
(19, 'Yiefkmv', '2023-04-02 15:27:58', 14, 238430, 50670),
(20, 'Lbhttgr', '2023-04-03 07:31:35', 14, 115632, 192470),
(21, 'Kzjnlov', '2023-04-06 01:43:14', 14, 198656, 88752),
(22, 'Pnsghfp', '2023-04-05 03:51:06', 14, 172944, 216206),
(23, 'Zbtqjai', '2023-04-03 07:13:03', 14, 469034, 258059),
(24, 'Eqjslai', '2023-04-01 14:41:21', 14, 86145, 95195),
(25, 'Raiiouz', '2023-04-01 23:40:59', 14, 432132, 367682),
(26, 'Lrbsinn', '2023-04-01 09:48:18', 14, 245905, 96381),
(27, 'Uqowxix', '2023-04-07 03:34:23', 14, 214166, 66533),
(28, 'Sinseij', '2023-04-04 02:09:31', 14, 468921, 312049),
(29, 'Izgchlr', '2023-04-03 03:49:57', 14, 454851, 92780),
(30, 'Mduftjp', '2023-03-31 17:13:29', 14, 460936, 223018),
(31, 'Hykotha', '2023-04-03 05:42:24', 14, 444628, 218313),
(32, 'Kkzwwvp', '2023-04-05 19:59:17', 14, 185090, 263750),
(33, 'Delsvxi', '2023-04-04 08:50:48', 14, 445902, 110215),
(34, 'Jwxqgxf', '2023-04-02 06:02:56', 14, 431857, 321604),
(35, 'Bvpuvej', '2023-04-03 17:18:22', 14, 148562, 89666),
(36, 'Duntlqe', '2023-04-03 18:08:00', 14, 297244, 436480),
(37, 'Wjqerhe', '2023-04-06 02:35:40', 14, 460241, 152763),
(38, 'Bjaccej', '2023-04-06 12:18:05', 14, 264515, 172143),
(39, 'Zlpyqga', '2023-04-07 00:50:26', 14, 230368, 50418),
(40, 'Rijzebl', '2023-04-01 11:53:00', 14, 176858, 148853),
(41, 'Banwjrl', '2023-04-03 04:42:49', 14, 158117, 298398),
(42, 'Ninecep', '2023-04-03 10:43:56', 14, 361483, 123071),
(43, 'Rjivngy', '2023-04-04 10:21:58', 14, 83850, 273539),
(44, 'Nqkolfp', '2023-04-03 11:27:27', 14, 297669, 464614),
(45, 'Cpweboe', '2023-04-04 17:04:28', 14, 51923, 223634),
(46, 'Mphhkxb', '2023-04-04 23:04:40', 14, 440024, 119792),
(47, 'Ptyhfej', '2023-04-02 05:36:39', 14, 153541, 240467),
(48, 'Ppwbjyr', '2023-04-04 13:20:20', 14, 230327, 42552),
(49, 'Ocewhtc', '2023-04-04 13:23:25', 14, 428156, 302228),
(50, 'Ukgzdgg', '2023-04-03 07:44:42', 14, 375279, 188375),
(51, 'Yqiswvt', '2023-04-05 21:43:03', 14, 220245, 96477),
(52, 'Gunsray', '2023-04-03 15:39:16', 14, 310578, 145017),
(53, 'Wynwwzk', '2023-04-02 20:16:32', 14, 332045, 99107),
(54, 'Iojilyg', '2023-04-02 10:21:17', 14, 273816, 72968),
(55, 'Tikqilh', '2023-04-03 09:08:49', 14, 335105, 330444),
(56, 'Qjpdbyq', '2023-04-06 19:04:44', 14, 356826, 496702),
(57, 'Icxppqw', '2023-04-04 00:29:17', 14, 143885, 111380),
(58, 'Opuxacf', '2023-04-06 05:31:59', 14, 243197, 60493),
(59, 'Bpaylce', '2023-03-31 10:49:34', 14, 142387, 220878),
(60, 'Kkwvxej', '2023-04-05 07:37:02', 14, 402885, 227114),
(61, 'Tndoovw', '2023-04-06 17:51:36', 14, 136567, 212627),
(62, 'Jjbwbkx', '2023-04-04 16:23:00', 14, 101486, 332679),
(63, 'Ugivpxw', '2023-04-06 16:27:01', 14, 432460, 221084),
(64, 'Wxhceiu', '2023-04-02 03:50:09', 14, 460575, 244070),
(65, 'Mdborqj', '2023-04-02 02:31:59', 14, 172766, 412252),
(66, 'Wgmqysb', '2023-04-05 15:42:56', 14, 333451, 247441),
(67, 'Elhcehk', '2023-03-31 17:12:53', 14, 230344, 136480),
(68, 'Obcpnat', '2023-04-02 00:28:06', 14, 191282, 318540),
(69, 'Shkrkmu', '2023-04-03 12:12:07', 14, 217707, 457443),
(70, 'Rwlephy', '2023-03-31 17:05:02', 14, 270916, 182263),
(71, 'Qhvhiso', '2023-04-01 11:02:06', 14, 218143, 483321),
(72, 'Pxqhvsp', '2023-04-04 19:45:07', 14, 52991, 269458),
(73, 'Jlxintw', '2023-04-01 21:54:02', 14, 58419, 307430),
(74, 'Vbmcagj', '2023-04-04 18:24:14', 14, 486808, 437595),
(75, 'Lkmxjsb', '2023-04-06 14:39:24', 14, 234435, 421498),
(76, 'Zcdmyxk', '2023-04-04 19:19:01', 14, 198571, 374409),
(77, 'Rzlahoy', '2023-04-02 23:28:25', 14, 444571, 323527),
(78, 'Sygtudq', '2023-04-03 19:31:58', 14, 230221, 388127),
(79, 'Vluycky', '2023-04-04 14:00:07', 14, 329916, 270267),
(80, 'Nigalgg', '2023-04-03 23:27:01', 14, 324764, 314700),
(81, 'Riorfwm', '2023-04-06 06:30:28', 14, 486164, 421591),
(82, 'Gkzqfro', '2023-03-31 08:32:39', 14, 50292, 352652),
(83, 'Zfsmjpp', '2023-04-06 11:40:34', 14, 17446, 347190),
(84, 'Mgcowac', '2023-03-31 14:52:50', 14, 154232, 67669),
(85, 'Kgjtpgf', '2023-04-04 01:04:04', 14, 445033, 410392),
(86, 'Yywjtvn', '2023-04-01 21:32:12', 14, 85127, 223358),
(87, 'Sjlpphk', '2023-04-06 12:38:12', 14, 106507, 331710),
(88, 'Epohtpu', '2023-04-06 03:57:13', 14, 392197, 298920),
(89, 'Xvzigma', '2023-04-02 19:18:14', 14, 275723, 82721),
(90, 'Arcxxih', '2023-04-05 18:25:01', 14, 322914, 146969),
(91, 'Njeutcr', '2023-04-03 04:21:28', 14, 18142, 403366),
(92, 'Mmvazew', '2023-04-03 02:48:42', 14, 241143, 207319),
(93, 'Paeoyvs', '2023-03-31 06:16:23', 14, 386529, 367763),
(94, 'Jqabmpq', '2023-04-03 16:48:11', 14, 180619, 371245),
(95, 'Lclozsf', '2023-04-05 09:34:11', 14, 407149, 349444),
(96, 'Zwonank', '2023-04-05 15:48:47', 14, 339473, 69897),
(97, 'Chfiwgc', '2023-04-03 19:30:51', 14, 372647, 290138),
(98, 'Woufkdl', '2023-04-02 06:31:32', 14, 260458, 298438),
(99, 'Hzbikuy', '2023-04-02 11:47:58', 14, 480485, 288734),
(100, 'Qwaakfj', '2023-04-05 14:17:23', 14, 169648, 366906);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `encegreso`
--

INSERT INTO `encegreso` (`idEgreso`, `fechaEgreso`, `tituloEgreso`, `vrTotalEgreso`, `idTipoEgreso`) VALUES
(1, '2023-04-03 00:08:19', 'pkiqtys', 580046, 5),
(2, '2023-04-01 23:02:48', 'nslzune', 631431, 4),
(3, '2023-04-07 01:52:15', 'awpeamz', 1693309, 1),
(4, '2023-04-07 00:53:30', 'vzowjbu', 117300, 2),
(5, '2023-04-01 22:50:01', 'fpvzqna', 823927, 6),
(6, '2023-04-06 19:36:38', 'tvwmokc', 983028, 5),
(7, '2023-04-06 05:30:04', 'hdhstjh', 938149, 3),
(8, '2023-04-06 14:32:42', 'vahanmr', 538951, 0),
(9, '2023-04-01 14:57:03', 'quugxgj', 697856, 6),
(10, '2023-04-05 13:24:51', 'dfnmaoi', 727910, 3),
(11, '2023-04-02 07:53:39', 'lybnppu', 1094360, 1),
(12, '2023-04-05 17:44:43', 'hgcusud', 804912, 6),
(13, '2023-04-02 17:16:45', 'bhusrmx', 75589, 3),
(14, '2023-04-02 08:57:13', 'rncjjse', 316166, 6),
(15, '2023-04-03 13:01:51', 'sqwesqs', 801677, 6),
(16, '2023-04-01 18:32:41', 'aseatsb', 1684828, 4),
(17, '2023-04-02 12:41:58', 'pvxxhnn', 1631968, 0),
(18, '2023-04-05 16:31:49', 'bhreont', 715942, 0),
(19, '2023-04-05 16:17:43', 'okzlmep', 804380, 1),
(20, '2023-04-01 05:30:00', 'xwebppj', 153638, 6),
(21, '2023-04-03 04:37:47', 'atmlrom', 1537563, 5),
(22, '2023-04-06 21:48:55', 'rxszhro', 713802, 1),
(23, '2023-04-05 22:11:17', 'kvwrjhc', 963656, 2),
(24, '2023-04-04 01:20:42', 'ocieids', 387701, 2),
(25, '2023-04-04 01:52:33', 'iwlebpd', 408658, 4),
(26, '2023-04-05 16:22:25', 'wfoxnia', 1323045, 2),
(27, '2023-04-02 10:36:04', 'hiyrwpp', 746047, 2),
(28, '2023-04-03 14:54:58', 'qgzrkgy', 770788, 1),
(29, '2023-04-02 16:49:53', 'oxcfspa', 201144, 3),
(30, '2023-04-02 20:21:06', 'siwpayl', 1786215, 5),
(31, '2023-04-04 03:27:09', 'wzyirrs', 1410503, 6),
(32, '2023-04-06 08:38:36', 'xfgwybs', 326965, 3),
(33, '2023-04-02 08:26:57', 'oygsitv', 1031165, 3),
(34, '2023-04-04 19:50:22', 'sjqitdo', 1278860, 6),
(35, '2023-04-01 14:14:03', 'qskhhzl', 1056899, 3),
(36, '2023-04-02 10:31:30', 'qnriufo', 264875, 0),
(37, '2023-04-03 20:05:44', 'qlcfrez', 1212022, 3),
(38, '2023-04-04 17:43:38', 'hqrjamm', 1883935, 3),
(39, '2023-04-02 04:14:40', 'adqnutl', 1491021, 1),
(40, '2023-04-04 09:16:08', 'fcuceek', 19832, 5),
(41, '2023-04-06 14:31:57', 'hqaaiow', 1215022, 0),
(42, '2023-04-06 07:01:46', 'uoewjfg', 1503835, 3),
(43, '2023-04-06 22:12:54', 'slhssgm', 417218, 0),
(44, '2023-04-01 13:06:22', 'lpviqzo', 884445, 2),
(45, '2023-04-04 00:40:52', 'mtsuvec', 647511, 6),
(46, '2023-04-05 04:47:28', 'swhukhj', 1833444, 4),
(47, '2023-04-03 21:52:35', 'hisaqfr', 1116560, 0),
(48, '2023-04-04 02:58:56', 'jmeqsnk', 479956, 2),
(49, '2023-04-06 06:05:53', 'pnavluy', 1383303, 4),
(50, '2023-04-06 20:44:53', 'oeatsif', 322969, 2),
(51, '2023-04-02 20:14:24', 'blkwhyb', 995016, 4),
(52, '2023-04-01 15:22:30', 'nsaevbe', 1569536, 4),
(53, '2023-04-05 09:39:36', 'movyyqm', 1001082, 2),
(54, '2023-04-02 02:28:12', 'fnorqhu', 1731700, 0),
(55, '2023-04-07 00:40:47', 'xlpaluu', 1329652, 0),
(56, '2023-04-03 09:34:45', 'ocuznsk', 1352916, 2),
(57, '2023-04-02 22:21:11', 'vktifyk', 854452, 4),
(58, '2023-04-03 23:00:15', 'qddlmik', 1503056, 5),
(59, '2023-04-04 09:19:08', 'rxxtpuy', 968509, 0),
(60, '2023-04-04 19:28:22', 'hcsiiit', 1787747, 1),
(61, '2023-04-05 14:15:51', 'igxjutn', 352381, 1),
(62, '2023-04-06 10:12:57', 'rnlcizo', 613909, 2),
(63, '2023-04-06 19:07:25', 'klyasia', 151993, 6),
(64, '2023-04-06 00:53:22', 'uhutqib', 16139, 1),
(65, '2023-04-06 15:27:08', 'afhzreu', 486427, 3),
(66, '2023-04-06 02:15:39', 'abcyxtu', 1388577, 3),
(67, '2023-04-02 16:00:16', 'guexbhl', 1532958, 2),
(68, '2023-04-03 00:58:06', 'zhopfhw', 1623138, 4),
(69, '2023-04-03 16:40:32', 'fauuwgv', 404364, 1),
(70, '2023-04-06 07:12:59', 'pbvnbup', 1404593, 4),
(71, '2023-04-02 10:38:56', 'jmhnhuu', 101233, 0),
(72, '2023-04-02 13:01:11', 'ufvpgil', 288567, 6),
(73, '2023-04-04 15:23:18', 'xtxncsw', 1183999, 2),
(74, '2023-04-04 13:26:34', 'wdwmbje', 399615, 1),
(75, '2023-04-03 02:38:12', 'wjbjwfw', 1097031, 4),
(76, '2023-04-04 09:34:29', 'vxpjgka', 237856, 0),
(77, '2023-04-06 14:52:43', 'orbhcro', 1230895, 3),
(78, '2023-04-03 23:46:00', 'hklicua', 227677, 2),
(79, '2023-04-02 22:14:30', 'ydfqndh', 1228025, 3),
(80, '2023-04-05 11:07:42', 'viiwalu', 731186, 3),
(81, '2023-04-02 17:02:12', 'hodybyo', 1959476, 4),
(82, '2023-04-07 02:51:34', 'fjjacas', 705261, 2),
(83, '2023-04-04 11:52:30', 'nafxpzu', 1200515, 0),
(84, '2023-04-03 19:35:54', 'dioiyeq', 145420, 1),
(85, '2023-04-06 05:17:39', 'vgptkys', 848190, 1),
(86, '2023-04-04 01:04:30', 'occsdje', 1374683, 1),
(87, '2023-04-06 11:15:37', 'vwfhqry', 255248, 3),
(88, '2023-04-05 17:09:23', 'qtamirv', 173963, 3),
(89, '2023-04-05 15:56:39', 'jcfjcbo', 317062, 6),
(90, '2023-04-05 20:37:36', 'siwomoo', 1487272, 3),
(91, '2023-04-05 19:20:36', 'aanlgvw', 1520525, 6),
(92, '2023-04-02 05:09:10', 'ebyxavg', 210554, 4),
(93, '2023-04-06 03:23:31', 'fibtkat', 1511829, 3),
(94, '2023-04-02 06:01:12', 'tzyqkzj', 478639, 4),
(95, '2023-04-06 05:50:27', 'lpmwuaj', 678660, 4),
(96, '2023-04-03 12:34:58', 'swszlqn', 112738, 3),
(97, '2023-04-06 17:10:20', 'drepglq', 878184, 5),
(98, '2023-04-04 17:33:32', 'deyxpmg', 542691, 6),
(99, '2023-04-04 08:38:27', 'wvkufga', 465554, 6),
(100, '2023-04-03 23:26:09', 'aissxkv', 1162717, 0);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `encventas`
--

INSERT INTO `encventas` (`idVenta`, `tituloVenta`, `fechaVenta`, `metodoPagoVenta`, `descuentoVenta`, `vrTotalVta`, `vrtotalIva`, `editado`, `idCliente`) VALUES
(1, 'aulcd', '2023-04-06 19:31:53', 'liluy', 203546, 554138, 687251, 0, 4),
(2, 'eljcn', '2023-04-05 07:16:49', 'xellb', 234156, 315387, 815208, 0, 4),
(3, 'qlfmr', '2023-04-05 21:32:35', 'mapxz', 609861, 869978, 684571, 1, 4),
(4, 'yrnzo', '2023-04-06 16:23:54', 'dquye', 677953, 574905, 560635, 0, 4),
(5, 'sykxw', '2023-04-04 03:58:31', 'posue', 362274, 575589, 650371, 0, 4),
(6, 'hggcw', '2023-04-04 18:21:09', 'lweiv', 190917, 989785, 902553, 1, 4),
(7, 'rcuxh', '2023-04-06 08:03:12', 'doaxu', 130950, 849675, 285523, 1, 4),
(8, 'gailn', '2023-04-03 23:15:53', 'nsvbu', 30256, 981115, 591235, 1, 4),
(9, 'ptgqr', '2023-04-01 10:03:09', 'gawvx', 299267, 365324, 392137, 1, 4),
(10, 'bmder', '2023-04-05 04:18:21', 'btbay', 463594, 997894, 169461, 0, 4),
(11, 'nuavv', '2023-04-05 05:06:42', 'rpxgr', 726777, 939470, 513205, 1, 4),
(12, 'jqvtq', '2023-04-04 00:14:33', 'nvegj', 595536, 787938, 355487, 1, 4),
(13, 'lhnxy', '2023-04-06 01:01:45', 'phzvf', 127381, 840654, 205411, 1, 4),
(14, 'lvboq', '2023-04-02 13:12:26', 'bdsqs', 268724, 324692, 37023, 1, 4),
(15, 'mcqei', '2023-04-01 09:21:09', 'prnkz', 974724, 597015, 644345, 0, 4),
(16, 'mowto', '2023-04-04 01:06:12', 'sklwf', 435531, 888387, 260730, 1, 4),
(17, 'blzcm', '2023-04-02 06:40:00', 'psqbo', 575458, 943779, 488341, 0, 4),
(18, 'hqcfd', '2023-04-03 01:10:05', 'hkrvv', 347220, 825429, 424995, 0, 4),
(19, 'evwrz', '2023-04-06 21:00:26', 'otuio', 738607, 116097, 997896, 0, 4),
(20, 'zerss', '2023-04-02 20:24:14', 'lboqp', 563220, 392335, 334163, 0, 4),
(21, 'cdqsd', '2023-04-04 07:41:48', 'godwa', 368431, 977033, 601241, 1, 4),
(22, 'bdvgh', '2023-04-05 08:34:53', 'avwsx', 27126, 484799, 38186, 0, 4),
(23, 'cbiwl', '2023-04-06 00:40:55', 'aqykf', 618774, 177316, 503091, 0, 4),
(24, 'ukagt', '2023-04-02 20:54:42', 'wvylj', 822887, 492562, 952896, 0, 4),
(25, 'osaar', '2023-04-03 23:08:48', 'rzdam', 20350, 313357, 207707, 0, 4),
(26, 'jrtll', '2023-04-04 12:39:55', 'wwicp', 36232, 235096, 930632, 1, 4),
(27, 'oylea', '2023-04-02 16:56:43', 'mulyh', 385504, 184900, 190897, 1, 4),
(28, 'jdbue', '2023-04-02 20:37:01', 'iqxba', 657972, 740902, 535782, 0, 4),
(29, 'zzwhe', '2023-04-02 03:21:14', 'sczib', 754625, 908627, 229352, 0, 4),
(30, 'jqozx', '2023-04-07 01:18:18', 'hokcb', 273431, 793087, 122099, 1, 4),
(31, 'yqbhs', '2023-04-01 09:29:42', 'nvsjt', 350304, 689531, 873796, 0, 4),
(32, 'fqbsk', '2023-04-06 07:40:24', 'wufzl', 145055, 450814, 623860, 0, 4),
(33, 'dorwb', '2023-04-05 10:50:52', 'pclsh', 624172, 415106, 497809, 1, 4),
(34, 'wbmmq', '2023-04-04 06:28:37', 'frrjb', 368545, 503953, 640102, 0, 4),
(35, 'yhdxh', '2023-04-04 05:23:09', 'lvsyw', 747851, 552212, 319245, 1, 4),
(36, 'orffl', '2023-04-05 02:14:43', 'wlxpf', 644160, 946829, 13333, 0, 4),
(37, 'nvwzu', '2023-04-06 06:00:24', 'ojtol', 168495, 965717, 796976, 1, 4),
(38, 'xpudm', '2023-04-06 00:24:49', 'ulazi', 806179, 532819, 643239, 1, 4),
(39, 'fyaku', '2023-04-03 05:36:19', 'tiohu', 394269, 549970, 885753, 1, 4),
(40, 'katji', '2023-04-04 05:05:08', 'fduha', 167836, 299930, 660741, 1, 4),
(41, 'agaso', '2023-04-05 02:27:21', 'kppqq', 30058, 733470, 954537, 0, 4),
(42, 'xsczw', '2023-04-04 00:58:21', 'mgwfd', 472659, 389823, 166664, 0, 4),
(43, 'kjgub', '2023-04-05 06:06:33', 'nhjbf', 536702, 937746, 245631, 0, 4),
(44, 'rqavt', '2023-04-04 22:31:43', 'sbzyn', 182238, 464260, 879749, 1, 4),
(45, 'agtvm', '2023-04-06 14:48:42', 'dcmqu', 277520, 801302, 188374, 1, 4),
(46, 'pzdwz', '2023-04-03 15:31:12', 'nwaiv', 592293, 887492, 253524, 0, 4),
(47, 'ijhbt', '2023-04-02 13:25:23', 'gcsid', 692953, 739027, 172131, 1, 4),
(48, 'jtbqf', '2023-04-05 02:50:40', 'bblcr', 937362, 24880, 317617, 1, 4),
(49, 'ksicv', '2023-04-05 09:41:25', 'clcvo', 196476, 261703, 684548, 0, 4),
(50, 'jmkcl', '2023-04-02 02:05:47', 'rphyh', 68814, 27957, 123502, 0, 4),
(51, 'dqgfr', '2023-04-01 12:18:33', 'xgdbu', 986979, 616702, 723617, 1, 4),
(52, 'qgfca', '2023-04-01 14:50:26', 'oyphb', 489203, 624188, 137774, 1, 4),
(53, 'apomv', '2023-04-06 15:26:39', 'tgbok', 55664, 873911, 449220, 0, 4),
(54, 'pgbjb', '2023-04-05 03:32:49', 'zifcx', 718640, 249249, 168303, 1, 4),
(55, 'gjyfu', '2023-04-01 14:25:23', 'brrkb', 715774, 948678, 717278, 0, 4),
(56, 'btwfs', '2023-04-05 06:00:07', 'xdbro', 538277, 412150, 815120, 0, 4),
(57, 'ylyty', '2023-04-02 06:18:46', 'irjro', 111873, 476443, 617251, 0, 4),
(58, 'wjgcx', '2023-04-06 01:13:47', 'zsseg', 972640, 232551, 391294, 1, 4),
(59, 'uoegq', '2023-04-05 02:12:21', 'xkysp', 857593, 158506, 140833, 1, 4),
(60, 'igjgl', '2023-04-02 05:51:16', 'wpyqd', 728785, 729190, 704145, 1, 4),
(61, 'zvswh', '2023-04-03 07:19:04', 'eagpm', 226550, 967032, 419713, 1, 4),
(62, 'tbppw', '2023-04-01 07:06:03', 'asjqs', 996028, 342708, 798489, 0, 4),
(63, 'qsapu', '2023-04-04 18:33:24', 'osogj', 451870, 403808, 233382, 0, 4),
(64, 'efsjh', '2023-04-04 13:03:28', 'zyuan', 654897, 417754, 80969, 0, 4),
(65, 'heicx', '2023-04-02 04:45:38', 'xkvwf', 47210, 932127, 696184, 1, 4),
(66, 'rpkvs', '2023-04-03 21:14:19', 'furfw', 199441, 442324, 425559, 0, 4),
(67, 'fuonq', '2023-04-03 13:36:56', 'guvov', 24840, 92790, 377149, 0, 4),
(68, 'gmirn', '2023-04-04 17:14:53', 'yusgs', 76951, 281622, 637960, 1, 4),
(69, 'bhnym', '2023-04-03 03:03:43', 'srgit', 329153, 957320, 777079, 1, 4),
(70, 'gkwfr', '2023-04-05 23:15:07', 'owpuk', 140162, 152111, 93243, 1, 4),
(71, 'hpuxo', '2023-04-04 20:15:39', 'vbirf', 98574, 594253, 882660, 1, 4),
(72, 'jlwmw', '2023-04-02 08:25:22', 'byyuo', 481254, 770969, 435408, 0, 4),
(73, 'kexfh', '2023-04-05 16:26:24', 'pdywx', 122577, 835977, 144701, 0, 4),
(74, 'qiwpf', '2023-04-01 14:15:57', 'zdoyy', 241124, 654982, 398882, 0, 4),
(75, 'upkga', '2023-04-05 00:41:14', 'vegqy', 223203, 617402, 469654, 0, 4),
(76, 'ghjrq', '2023-04-04 15:28:45', 'qsjzi', 31867, 21304, 482162, 0, 4),
(77, 'wmgvf', '2023-04-05 06:38:36', 'utjhx', 69418, 719241, 461025, 0, 4),
(78, 'biesm', '2023-04-05 16:43:28', 'tphus', 84810, 79509, 751405, 0, 4),
(79, 'qyjkb', '2023-04-03 13:02:14', 'iknyy', 509999, 28653, 994551, 1, 4),
(80, 'icifs', '2023-04-04 22:26:21', 'zxlrh', 347197, 340981, 180543, 0, 4),
(81, 'vlsxz', '2023-04-04 17:44:58', 'aqedi', 571166, 321383, 370997, 0, 4),
(82, 'wuwjl', '2023-04-04 06:32:24', 'idakl', 852637, 53128, 815588, 1, 4),
(83, 'oweqp', '2023-04-02 23:03:24', 'xwpjv', 553247, 328756, 255898, 1, 4),
(84, 'hmgtx', '2023-04-05 06:29:40', 'rvitu', 322966, 851044, 158035, 0, 4),
(85, 'mrfio', '2023-04-01 22:25:26', 'cjave', 467658, 58716, 116349, 0, 4),
(86, 'etyie', '2023-04-03 07:11:08', 'dzsfl', 353533, 320654, 271022, 1, 4),
(87, 'ytsel', '2023-04-05 01:55:54', 'tuosy', 564087, 185364, 91150, 0, 4),
(88, 'erjze', '2023-04-06 09:09:57', 'giqle', 558777, 864634, 692569, 1, 4),
(89, 'cokag', '2023-04-03 05:31:27', 'eqwjz', 529266, 800748, 547565, 0, 4),
(90, 'ndxws', '2023-04-05 04:39:04', 'fopag', 785058, 524186, 662712, 0, 4),
(91, 'lsilh', '2023-04-05 12:21:25', 'romss', 19035, 923352, 146171, 0, 4),
(92, 'ipvas', '2023-04-02 14:17:49', 'hgewd', 977055, 827503, 651213, 0, 4),
(93, 'wkiia', '2023-04-06 11:45:58', 'etirx', 501999, 53933, 806414, 0, 4),
(94, 'quqjp', '2023-04-06 20:07:57', 'wxacd', 645460, 635898, 515253, 1, 4),
(95, 'dhhxv', '2023-04-02 01:28:36', 'ybsdl', 772993, 746289, 94054, 1, 4),
(96, 'sdydy', '2023-04-04 12:34:59', 'vcbqx', 35431, 174771, 189668, 1, 4),
(97, 'uvqkh', '2023-04-04 22:50:51', 'xntdn', 947059, 673210, 950595, 0, 4),
(98, 'meimk', '2023-04-05 01:22:42', 'yzarb', 755641, 380922, 749204, 0, 4),
(99, 'mavlx', '2023-04-05 01:17:31', 'ifnre', 539350, 367632, 541373, 1, 4),
(100, 'lfkfh', '2023-04-05 07:43:10', 'arcja', 378798, 65490, 391483, 1, 4),
(101, 'sdbzt', '2023-03-12 04:51:04', 'ntmek', 875825, 326175, 504151, 1, 4),
(102, 'whlbr', '2023-01-30 06:07:08', 'stcqy', 727402, 185706, 297166, 1, 4),
(103, 'loowj', '2023-01-05 10:40:39', 'lbrar', 821801, 49478, 871759, 1, 4),
(104, 'tyfyk', '2023-03-07 13:21:21', 'hqaoz', 25741, 971261, 748861, 0, 4),
(105, 'diqvw', '2023-02-04 05:09:42', 'xlwpe', 804063, 492638, 535290, 0, 4),
(106, 'reiwf', '2023-01-10 15:12:48', 'biilt', 166237, 294591, 705342, 1, 4),
(107, 'sqocn', '2023-02-01 17:55:45', 'kdeat', 270439, 335070, 822266, 0, 4),
(108, 'mbwfa', '2023-02-20 17:17:29', 'mcgsc', 769184, 338851, 971844, 0, 4),
(109, 'sswvb', '2023-01-09 14:16:21', 'dnreh', 70851, 610966, 195406, 0, 4),
(110, 'sjlml', '2023-02-24 14:51:16', 'hbqtj', 950119, 877160, 739897, 1, 4),
(111, 'ucwaa', '2023-01-05 04:15:51', 'kevdy', 62389, 337077, 298237, 1, 4),
(112, 'lslsu', '2023-02-23 09:01:43', 'lphal', 369191, 522927, 180710, 1, 4),
(113, 'ipgnp', '2023-02-11 07:46:06', 'jjydq', 93336, 10680, 39851, 0, 4),
(114, 'taywy', '2023-01-22 16:08:31', 'nmmyk', 772407, 802578, 775558, 1, 4),
(115, 'inalk', '2023-03-12 19:20:38', 'pxfji', 704689, 672093, 283108, 1, 4),
(116, 'qhhih', '2023-03-17 17:21:01', 'zeynz', 54038, 255560, 992247, 1, 4),
(117, 'btehl', '2023-02-24 16:48:34', 'rvbta', 484825, 772088, 572341, 0, 4),
(118, 'hlzdi', '2023-01-23 15:22:42', 'ipvjf', 857200, 474586, 894242, 1, 4),
(119, 'pwwot', '2023-03-18 00:48:41', 'azbgr', 517132, 453167, 915831, 0, 4),
(120, 'wcugz', '2023-04-03 15:39:25', 'mnufw', 596853, 740964, 450525, 0, 4),
(121, 'xktyn', '2023-03-23 21:26:41', 'kzniv', 634560, 728727, 744696, 0, 4),
(122, 'ziuwn', '2023-02-18 22:50:43', 'jydep', 650465, 962582, 902731, 1, 4),
(123, 'jqiwo', '2023-01-27 13:59:23', 'gmbme', 359842, 14142, 132970, 0, 4),
(124, 'jkcwj', '2023-04-02 16:55:16', 'cpybh', 727957, 793227, 472184, 1, 4),
(125, 'eiupt', '2023-02-22 12:00:23', 'iqfmn', 597805, 497923, 291304, 0, 4),
(126, 'jhylo', '2023-01-11 02:57:58', 'msbpn', 825527, 979603, 35388, 0, 4),
(127, 'ryuml', '2023-02-18 01:11:45', 'srdfj', 672675, 907325, 479919, 0, 4),
(128, 'zqfop', '2023-02-01 19:10:29', 'duzpc', 343722, 30451, 86268, 0, 4),
(129, 'ofjjr', '2023-02-08 15:04:20', 'vsqjt', 267046, 758087, 272492, 0, 4),
(130, 'ivyyh', '2023-02-20 14:26:11', 'oqohw', 219039, 931239, 529726, 0, 4),
(131, 'dyxak', '2023-01-04 17:08:01', 'jokjv', 771442, 685241, 408373, 1, 4),
(132, 'dpuyb', '2023-02-07 11:59:14', 'wjzfi', 532415, 645202, 706779, 0, 4),
(133, 'ydujx', '2023-02-10 21:17:02', 'mslpt', 252354, 851407, 961114, 1, 4),
(134, 'vclnr', '2023-01-16 22:57:29', 'oqlti', 802964, 644985, 735881, 1, 4),
(135, 'grlwt', '2023-03-18 19:51:15', 'ahbjc', 132446, 517049, 711610, 1, 4),
(136, 'nvasx', '2023-02-10 07:21:02', 'qosbk', 649385, 436078, 429409, 1, 4),
(137, 'dlzor', '2023-01-21 10:41:53', 'oeozo', 587060, 705329, 442251, 1, 4),
(138, 'hpcsu', '2023-01-18 01:16:26', 'jmyts', 392473, 115483, 565866, 0, 4),
(139, 'vmgvv', '2023-02-15 15:52:41', 'locmn', 18992, 652985, 38663, 0, 4),
(140, 'rptnx', '2023-03-08 17:53:43', 'ignue', 58314, 661251, 693504, 0, 4),
(141, 'crhqo', '2023-02-27 17:05:50', 'qsaec', 78422, 128435, 250936, 1, 4),
(142, 'kptzn', '2023-01-01 06:46:14', 'lrghc', 314531, 141039, 56130, 1, 4),
(143, 'ckwwu', '2023-01-23 04:16:46', 'uncsy', 138379, 240839, 326226, 0, 4),
(144, 'ognfp', '2023-01-24 10:00:44', 'ebjnl', 466637, 972085, 351969, 1, 4),
(145, 'ysyiz', '2023-02-24 16:41:51', 'wqzqs', 930871, 397890, 682753, 0, 4),
(146, 'mkdux', '2023-01-23 02:37:47', 'zlnbl', 132143, 827474, 219306, 0, 4),
(147, 'gieit', '2023-03-04 14:41:06', 'tubus', 966048, 537150, 626254, 0, 4),
(148, 'scfzg', '2023-03-27 16:03:09', 'kpiqj', 826106, 153101, 985012, 1, 4),
(149, 'crnob', '2023-02-24 14:01:02', 'yudma', 524129, 861153, 80926, 0, 4),
(150, 'cggnt', '2023-03-27 22:10:51', 'hjpjp', 925559, 37638, 442795, 1, 4),
(151, 'jqesv', '2023-02-05 16:45:40', 'tgcby', 776138, 690702, 254603, 1, 4),
(152, 'isyhk', '2023-04-01 16:01:36', 'apyqk', 603135, 82330, 459238, 1, 4),
(153, 'jslvx', '2023-01-21 03:56:31', 'lknna', 332735, 510335, 431761, 1, 4),
(154, 'yowhq', '2023-03-26 12:42:54', 'qagwl', 705081, 617860, 130220, 0, 4),
(155, 'qlpkn', '2023-01-12 22:06:34', 'zhbqa', 445433, 671214, 835726, 1, 4),
(156, 'hbtys', '2023-01-04 19:25:24', 'ugrmi', 355760, 75578, 984923, 1, 4),
(157, 'dfkyw', '2023-01-27 14:37:00', 'fjwwb', 630304, 30450, 923796, 0, 4),
(158, 'fjvhb', '2023-04-03 08:13:16', 'wfgch', 510716, 508627, 157782, 0, 4),
(159, 'ezikz', '2023-01-24 04:55:12', 'hbrty', 357401, 629904, 534437, 1, 4),
(160, 'ulpwe', '2023-02-18 15:48:03', 'dtzbi', 812013, 808506, 488640, 1, 4),
(161, 'gmcre', '2023-01-12 17:32:32', 'odcqf', 988774, 395087, 593908, 1, 4),
(162, 'djpdy', '2023-02-09 09:15:21', 'oqltg', 365595, 253832, 376168, 1, 4),
(163, 'ewiuz', '2023-01-28 06:47:49', 'yuwuv', 24443, 651235, 264663, 0, 4),
(164, 'pdrou', '2023-03-20 18:21:41', 'wcxnw', 680971, 353921, 593517, 1, 4),
(165, 'yjonf', '2023-03-28 23:19:11', 'shyrm', 572196, 224111, 508302, 0, 4),
(166, 'pekwe', '2023-03-23 19:29:27', 'esxpp', 111779, 510851, 712532, 1, 4),
(167, 'cnfid', '2023-02-24 18:07:12', 'ybtdx', 187896, 150418, 498110, 1, 4),
(168, 'lisfa', '2023-01-15 08:47:22', 'xpsoe', 627705, 335819, 53046, 1, 4),
(169, 'fnceb', '2023-01-28 08:55:17', 'acvhb', 530948, 31749, 455142, 0, 4),
(170, 'pkibi', '2023-03-25 13:15:05', 'spihf', 939677, 623561, 525511, 1, 4),
(171, 'kzqam', '2023-02-07 13:13:49', 'qgoec', 203265, 62353, 529234, 1, 4),
(172, 'qnyrf', '2023-04-04 22:20:19', 'hibst', 685545, 972566, 686195, 0, 4),
(173, 'qdfhy', '2023-03-23 18:33:40', 'ymard', 849332, 207266, 361583, 0, 4),
(174, 'oiaxw', '2023-01-13 12:35:54', 'mwfip', 29069, 775414, 296989, 0, 4),
(175, 'bgkeu', '2023-03-28 12:09:42', 'vvhzu', 760780, 591532, 203127, 0, 4),
(176, 'ljtdu', '2023-01-29 23:47:01', 'myjrj', 992976, 704864, 675632, 0, 4),
(177, 'ujmwv', '2023-03-03 16:38:28', 'azwmw', 998876, 790578, 47251, 0, 4),
(178, 'vvlgs', '2023-03-24 02:54:48', 'lqwza', 628005, 828827, 811178, 1, 4),
(179, 'qpgqd', '2023-02-09 18:53:29', 'hypbu', 515002, 621038, 974580, 1, 4),
(180, 'lnpch', '2023-03-14 05:14:49', 'dmnks', 64942, 275687, 490248, 1, 4),
(181, 'xpvis', '2023-02-02 02:31:57', 'jcdbf', 380407, 800812, 386095, 1, 4),
(182, 'nzrdw', '2023-02-19 06:33:37', 'cbxzl', 880922, 882242, 672462, 1, 4),
(183, 'unsbe', '2023-03-21 22:33:09', 'iivmz', 998514, 206412, 879391, 0, 4),
(184, 'ifqyt', '2023-02-03 13:06:53', 'kyxii', 988520, 907052, 436271, 0, 4),
(185, 'zobhb', '2023-01-16 07:25:45', 'pjvbq', 831697, 648563, 89944, 0, 4),
(186, 'drdaz', '2023-01-01 16:52:09', 'nytcq', 54065, 821450, 941715, 0, 4),
(187, 'kjtiw', '2023-01-22 22:45:04', 'erqul', 837024, 828935, 279295, 1, 4),
(188, 'evtyt', '2023-03-07 01:31:27', 'thfbm', 405049, 213299, 555946, 0, 4),
(189, 'jpigl', '2023-01-21 09:24:13', 'jsqjl', 480258, 860464, 713305, 1, 4),
(190, 'bumuo', '2023-01-24 14:47:00', 'vkkdr', 508644, 526821, 591598, 0, 4),
(191, 'nwwsc', '2023-04-02 00:44:12', 'jpizx', 748275, 991739, 331591, 1, 4),
(192, 'vxlpq', '2023-01-13 18:45:38', 'fihdr', 404550, 930195, 835578, 1, 4),
(193, 'ygama', '2023-02-16 01:00:29', 'zjrut', 900968, 630291, 808878, 1, 4),
(194, 'ymtdt', '2023-03-26 18:48:51', 'wcxdi', 467794, 280320, 20060, 1, 4),
(195, 'txecl', '2023-01-04 17:24:50', 'dlyoa', 885940, 183577, 211590, 0, 4),
(196, 'cxrhg', '2023-03-04 13:08:18', 'joyaa', 840694, 870682, 758023, 1, 4),
(197, 'maqdv', '2023-01-20 08:36:56', 'rvgzp', 610279, 528216, 72150, 0, 4),
(198, 'ycuuc', '2023-02-19 01:03:10', 'btdfd', 301518, 256749, 982033, 0, 4),
(199, 'obmdc', '2023-03-08 14:52:25', 'jyesc', 416845, 88462, 296654, 1, 4),
(200, 'lnwbz', '2023-01-04 01:13:43', 'hvpdj', 648947, 859893, 977474, 0, 4),
(201, 'wadua', '2023-03-06 05:50:01', 'yauby', 11075, 841148, 43636, 0, 4),
(202, 'crqht', '2023-03-13 11:19:29', 'ymkpr', 564677, 456223, 331302, 1, 4),
(203, 'fourz', '2023-01-31 15:43:51', 'dumjg', 380495, 79496, 297855, 1, 4),
(204, 'leujf', '2023-03-13 16:17:00', 'qrayi', 999334, 443992, 348102, 1, 4),
(205, 'iahza', '2023-03-20 10:19:37', 'igefz', 676784, 202963, 230072, 0, 4),
(206, 'aipae', '2023-01-25 21:55:34', 'hvjts', 660158, 398388, 701155, 1, 4),
(207, 'zryjg', '2023-01-09 05:59:13', 'meplx', 749193, 817877, 473299, 0, 4),
(208, 'ryrnx', '2023-02-03 05:50:25', 'ivyjh', 83218, 781600, 484019, 1, 4),
(209, 'cfhkd', '2023-03-05 21:30:34', 'hfnpj', 673183, 639667, 442408, 1, 4),
(210, 'ctmlv', '2023-01-15 01:46:34', 'mmjry', 715948, 445240, 408262, 1, 4),
(211, 'zeshg', '2023-02-04 08:39:00', 'wmegq', 210863, 906731, 275527, 1, 4),
(212, 'xqbsj', '2023-01-02 22:20:05', 'iyoqx', 956029, 285472, 393010, 1, 4),
(213, 'akdtf', '2023-01-05 14:50:48', 'weqnp', 369252, 58048, 470201, 1, 4),
(214, 'wswdm', '2023-04-04 17:05:01', 'xutth', 94529, 265484, 796048, 1, 4),
(215, 'qvoqm', '2023-02-10 16:08:26', 'nbeza', 507105, 531989, 527950, 0, 4),
(216, 'wmnjz', '2023-01-18 06:17:56', 'agdfe', 949945, 677454, 223400, 0, 4),
(217, 'ofywz', '2023-02-02 11:54:21', 'admdh', 116486, 569769, 451338, 1, 4),
(218, 'gfisl', '2023-01-02 00:08:36', 'wlbtq', 768437, 359005, 759535, 1, 4),
(219, 'nvkrp', '2023-02-08 11:56:05', 'oglpb', 419551, 49319, 342572, 1, 4),
(220, 'ignir', '2023-02-25 06:30:40', 'nelrd', 506198, 481872, 160065, 0, 4),
(221, 'ubmkh', '2023-02-07 23:52:12', 'baqqi', 675092, 77949, 360058, 1, 4),
(222, 'xelxd', '2023-03-31 08:58:02', 'qxfze', 728656, 829093, 119815, 0, 4),
(223, 'rkwim', '2023-01-02 11:56:33', 'irfhb', 376114, 237424, 350059, 0, 4),
(224, 'uoxea', '2023-01-03 06:25:48', 'myzsa', 699210, 207242, 991133, 0, 4),
(225, 'joexb', '2023-01-18 18:29:52', 'jgzns', 117114, 988867, 660976, 0, 4),
(226, 'undze', '2023-01-17 02:34:54', 'cckww', 904925, 911969, 383726, 0, 4),
(227, 'wrjzz', '2023-01-13 20:04:35', 'oanoo', 203593, 91477, 630329, 1, 4),
(228, 'ymvpo', '2023-01-03 19:31:23', 'qspsh', 586983, 834996, 390937, 0, 4),
(229, 'cvush', '2023-01-28 18:58:23', 'rxayl', 219777, 327413, 883826, 0, 4),
(230, 'eelcw', '2023-02-02 05:42:56', 'lvwzp', 878711, 660779, 756996, 0, 4),
(231, 'occml', '2023-02-05 01:11:48', 'vfjym', 732535, 335577, 734533, 0, 4),
(232, 'kyngf', '2023-02-02 16:08:38', 'eqaqj', 452837, 321471, 159557, 0, 4),
(233, 'dxvci', '2023-02-12 21:35:01', 'lpciu', 360223, 220539, 408157, 1, 4),
(234, 'lkqub', '2023-03-24 13:22:40', 'tbdyb', 359583, 366156, 943698, 1, 4),
(235, 'lcnrf', '2023-03-10 15:42:06', 'qjyhg', 517563, 139605, 166033, 0, 4),
(236, 'jclif', '2023-03-15 21:39:52', 'frbpk', 361776, 419933, 264193, 0, 4),
(237, 'otxxv', '2023-01-15 21:57:13', 'qfvcs', 864318, 192141, 55743, 1, 4),
(238, 'utcsl', '2023-02-06 02:44:02', 'frhbx', 233275, 964655, 843879, 1, 4),
(239, 'wfynj', '2023-02-13 20:03:05', 'rcfka', 114200, 678929, 812642, 0, 4),
(240, 'agdvi', '2023-01-29 09:42:52', 'tycej', 854771, 932751, 256474, 0, 4),
(241, 'uedch', '2023-01-27 21:27:15', 'dfgup', 964156, 438938, 166326, 0, 4),
(242, 'lptqc', '2023-03-06 19:04:56', 'pmbrs', 874779, 934195, 376745, 1, 4),
(243, 'bobwd', '2023-01-28 17:32:49', 'xvsdt', 982253, 821699, 788404, 1, 4),
(244, 'zxrlc', '2023-01-05 17:09:46', 'skgki', 274289, 431584, 541693, 0, 4),
(245, 'zfrxw', '2023-01-28 17:32:43', 'qksya', 322552, 791204, 555828, 0, 4),
(246, 'xzhpw', '2023-01-16 00:13:32', 'amfsn', 319488, 876489, 485398, 1, 4),
(247, 'jxlxw', '2023-02-04 16:15:16', 'olrvl', 94105, 91554, 177849, 0, 4),
(248, 'uutly', '2023-03-26 05:16:37', 'ifate', 245258, 634782, 82819, 0, 4),
(249, 'sgxxz', '2023-01-23 17:23:55', 'lawxh', 977911, 189916, 712570, 0, 4),
(250, 'ybflm', '2023-02-23 05:19:07', 'utfpg', 979721, 490626, 705226, 1, 4),
(251, 'hfcie', '2023-01-14 09:10:59', 'aqvsh', 362115, 292967, 951423, 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `imagen`
--

CREATE TABLE `imagen` (
  `idImagen` int(11) NOT NULL,
  `rutaImagen` varchar(100) NOT NULL,
  `nombreImagen` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `imagen`
--

INSERT INTO `imagen` (`idImagen`, `rutaImagen`, `nombreImagen`) VALUES
(9, '/public/img/productos', 'bimbo.png'),
(11, './../../../public/img/productos/', '20230310011457.jpg'),
(12, './../../../public/img/productos/', 'aguilaLata.jpg'),
(13, './../../../public/img/productos/', 'botellaGin.png'),
(14, './../../../public/img/productos/', 'champagne.jpg'),
(15, './../../../public/img/productos/', 'vientosDelSur.png'),
(16, './../../../public/img/productos/', 'aguilon.jpg'),
(17, './../../../public/img/productos/', 'ronCaldas.jpg'),
(18, './../../../public/img/productos/', 'pilsenon750.jpg'),
(19, './../../../public/img/productos/', 'pilsenon.png'),
(20, './../../../public/img/productos/', 'crema.jpg'),
(21, './../../../public/img/productos/', 'gatoNegro.png');

-- --------------------------------------------------------

--
-- Table structure for table `notas`
--

CREATE TABLE `notas` (
  `idNota` int(11) NOT NULL,
  `tituloNota` varchar(20) DEFAULT NULL,
  `contenidoNota` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`idProducto`, `nombreProducto`, `descripcionProducto`, `porcentajeIva`, `costoProducto`, `precioVenta`, `stockProducto`, `idImagen`) VALUES
(1, 'Vino gato negro', 'Vino Tinto merlot 2020', 21, 42000, 50000, 21, 21),
(2, 'Crema de whiskey', 'Crema dulce', 21, 30000, 42000, 8, 20),
(3, 'Pilsenon litro', 'Cerveza pilsen litro', 3, 3000, 5500, 44, 19),
(4, 'Pilsenon 750', 'Pilsenon 750ml\r\n', 15, 2500, 5000, 47, 18),
(5, 'Media de guaro', 'Media de guaro tapa roja', 21, 25000, 20000, 20, 9),
(6, 'litro de ron caldas', 'Litro de ron caldas', 21, 40000, 50000, 14, 17),
(7, 'Aguilon litro', 'Aguilon litro', 15, 5000, 6000, 42, 16),
(8, 'Vino Vientos del sur', 'Cavernet vientos del sur 750ml', 21, 25000, 36000, 18, 15),
(9, 'Botella de champaña', 'Botella de champaña blanca, espumosa ', 21, 30000, 50000, 17, 14),
(10, 'Botella de gin', 'Botella de ginebra ', 21, 40000, 55000, 13, 13),
(11, 'Aguila lata', 'Lata de aguila negra 330cm3', 21, 2000, 3500, 42, 12),
(12, 'Botella de vodka', 'botella de vodka smirnoff', 21, 40000, 50000, 10, 11);

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `idProveedor` int(11) NOT NULL,
  `nombreProveedor` varchar(40) NOT NULL,
  `direccionProveedor` varchar(30) DEFAULT NULL,
  `telefonoProveedor` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `idImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `notas`
--
ALTER TABLE `notas`
  MODIFY `idNota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
