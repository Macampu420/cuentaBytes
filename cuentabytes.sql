-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2023 at 09:39 PM
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
<<<<<<< HEAD
-- Database: `cuentabytes`
=======
-- Base de datos: `cuentabytes`
>>>>>>> Jota
--

DELIMITER $$
--
<<<<<<< HEAD
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCliente` (IN `_idCliente` INT(11), IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))   UPDATE `clientes` SET `idCliente`=_idCliente,`nombresCliente`=_nombresCliente,`apellidosCliente`=_apellidosCliente,`telefonoCliente`=_telefonoCliente,`cedulaCliente`=_cedulaCliente WHERE idCliente = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCostoProducto` (IN `_stockProducto` INT(7), IN `_costoProducto` INT(8), IN `_idProducto` INT)   UPDATE productos SET stockProducto = stockProducto + _stockProducto, costoProducto = _costoProducto WHERE idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarDetEgreso` (IN `_idDetEgreso` INT(11), IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100))   UPDATE `detalleegreso` SET `idDetEgreso`=_idDetEgreso,`valorEgreso`=_valorEgreso,`descripcion`=_descripcion WHERE idDetEgreso = _idDetEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEgreso` (IN `_idEgreso` INT(11), IN `_tituloEgreso` VARCHAR(80), IN `_vrTotalEgreso` INT(8), IN `_idTipoEgreso` INT(11))   UPDATE `encegreso` SET 
`idEgreso`=_idEgreso,`tituloEgreso`=_tituloEgreso,`vrTotalEgreso`=_vrTotalEgreso,`idTipoEgreso`=_idTipoEgreso WHERE idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEncVenta` (IN `titVenta` VARCHAR(35), IN `metodoPagoVenta_` VARCHAR(20), IN `descuentoVenta_` INT(11), IN `vrTotal` INT(11), IN `vrIva` INT(11), IN `idCliente_` INT(11), IN `idVenta_` INT)   BEGIN
=======
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCliente` (IN `_idCliente` INT(11), IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))   UPDATE `clientes` SET `idCliente`=_idCliente,`nombresCliente`=_nombresCliente,`apellidosCliente`=_apellidosCliente,`telefonoCliente`=_telefonoCliente,`cedulaCliente`=_cedulaCliente WHERE idCliente = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCostoProducto` (IN `_stockProducto` INT(7), IN `_costoProducto` INT(8), IN `_idProducto` INT)   UPDATE productos SET stockProducto = stockProducto + _stockProducto, costoProducto = _costoProducto WHERE idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarDetEgreso` (IN `_idDetEgreso` INT(11), IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100))   UPDATE `detalleegreso` SET `idDetEgreso`=_idDetEgreso,`valorEgreso`=_valorEgreso,`descripcion`=_descripcion WHERE idDetEgreso = _idDetEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEgreso` (IN `_idEgreso` INT(11), IN `_tituloEgreso` VARCHAR(80), IN `_vrTotalEgreso` INT(8), IN `_idTipoEgreso` INT(11))   UPDATE `encegreso` SET 
`idEgreso`=_idEgreso,`tituloEgreso`=_tituloEgreso,`vrTotalEgreso`=_vrTotalEgreso,`idTipoEgreso`=_idTipoEgreso WHERE idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEncVenta` (IN `titVenta` VARCHAR(35), IN `metodoPagoVenta_` VARCHAR(20), IN `descuentoVenta_` INT(11), IN `vrTotal` INT(11), IN `vrIva` INT(11), IN `idCliente_` INT(11), IN `idVenta_` INT)   BEGIN
>>>>>>> Jota
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarProductos` ()  SELECT productos.idProducto, productos.nombreProducto,productos.descripcionProducto, productos.porcentajeIva, productos.costoProducto, productos.precioVenta, productos.stockProducto, imagen.nombreImagen
FROM productos INNER JOIN imagen
ON productos.idImagen = imagen.idImagen$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarUnProducto` (IN `_idProducto` INT(11))   SELECT productos.idProducto, productos.nombreProducto, productos.stockProducto, productos.precioVenta, productos.porcentajeIva, productos.costoProducto, imagen.nombreImagen
FROM productos INNER JOIN imagen
ON productos.idImagen = imagen.idImagen$$
=======
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarProductos` ()  BEGIN
SELECT * FROM productos ORDER BY nombreProducto ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarUnProducto` (IN `_idProducto` INT(11))  BEGIN
SELECT * FROM productos WHERE idProducto = _idProducto;
END$$
>>>>>>> sebas

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMasStock` ()   BEGIN
SELECT MAX(productos.stockProducto) AS stockMayor, productos.nombreProducto FROM productos GROUP BY idProducto ORDER BY stockMayor DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarUnProducto` (IN `_idProducto` INT(11))   BEGIN
SELECT * FROM productos WHERE idProducto = _idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMasStock` ()   SELECT MAX(productos.stockProducto) AS stockMayor, productos.nombreProducto, imagen.nombreImagen 
FROM productos 
INNER JOIN imagen ON productos.idImagen = imagen.idImagen
GROUP BY productos.idProducto, productos.nombreProducto, imagen.nombreImagen
ORDER BY stockMayor DESC 
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMasVend` ()   SELECT COUNT(detalleventa.idProducto) as nroFacturas, productos.idProducto, productos.nombreProducto, imagen.nombreImagen 
FROM detalleventa 
INNER JOIN productos ON productos.idProducto = detalleventa.idProducto 
INNER JOIN imagen ON productos.idImagen = imagen.idImagen
GROUP BY detalleventa.idProducto, productos.idProducto, productos.nombreProducto, imagen.nombreImagen
ORDER BY nroFacturas DESC 
LIMIT 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMenStock` ()   SELECT MIN(productos.stockProducto) AS stockMayor, productos.nombreProducto, imagen.nombreImagen 
FROM productos 
INNER JOIN imagen ON productos.idImagen = imagen.idImagen
GROUP BY productos.idProducto, productos.nombreProducto, imagen.nombreImagen
ORDER BY stockMayor ASC 
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMenVend` ()   SELECT COUNT(detalleventa.idProducto) as nroFacturas, productos.idProducto, productos.nombreProducto, imagen.nombreImagen 
FROM detalleventa 
INNER JOIN productos ON productos.idProducto = detalleventa.idProducto 
INNER JOIN imagen ON productos.idImagen = imagen.idImagen
GROUP BY detalleventa.idProducto, productos.idProducto, productos.nombreProducto, imagen.nombreImagen
ORDER BY nroFacturas ASC 
LIMIT 3$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarEmpresa` (IN `nombreUsuario_` VARCHAR(40), IN `correoUsuario_` VARCHAR(40), IN `contrasenaUsuario_` VARCHAR(20))   INSERT INTO `usuarios`(`nombreUsuario`, `correoUsuario`, `contrasenaUsuario`) 
VALUES (nombreUsuario_,correoUsuario_,contrasenaUsuario_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarImagen` (IN `rutaImg_` VARCHAR(100), IN `nombreImg_` VARCHAR(30))   INSERT INTO `imagen`(`idImagen`, `rutaImagen`, `nombreImagen`) VALUES ('', rutaImg_, nombreImg_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rentabilidadProductos` ()   SELECT productos.nombreProducto, imagen.nombreImagen, MAX((productos.precioVenta - productos.costoProducto) / productos.costoProducto) as rentabilidad 
FROM productos 
INNER JOIN imagen ON productos.idImagen = imagen.idImagen
GROUP BY productos.nombreProducto, imagen.nombreImagen 
ORDER BY rentabilidad DESC 
LIMIT 3$$

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
<<<<<<< HEAD
-- Table structure for table `clientes`
=======
-- Estructura de tabla para la tabla `clientes`
>>>>>>> Jota
--

CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `nombresCliente` varchar(30) NOT NULL,
  `apellidosCliente` varchar(30) DEFAULT NULL,
  `telefonoCliente` varchar(15) DEFAULT NULL,
  `cedulaCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
<<<<<<< HEAD
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES
<<<<<<< HEAD
(4, 'Andrei', 'Peña', '31548792', 1111111111),
(6, 'Keanu', 'Reeves', '555693987', 101099853),
(7, 'Antonio', 'Alvarez', '78642211', 1010994788),
(8, 'Manuela', 'gomez orozco', '4789621', 1),
(9, 'Juana', 'Peña', '3198752016', 1010998789),
(10, 'Rodolfo', 'Hernandez', '312498652', 1010998654),
(11, 'Pancho', 'Sansa', '0', 1010948769),
(13, 'gfdgfadga', 'fgfadag', '123213', 123123);
=======
(4, 'Andrei', 'Peña', '31548792', 1111111111);
>>>>>>> sebas
=======
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES
(5, 'Juan ', 'Alberto', 'uwu', 12345678),
(13, 'asas', 'asa', 'asas', 11212),
(14, '123', '123', '123', 123),
(15, '123', '1313', '123313', 12344),
(16, '2132144', '12412', '21421', 1223143255),
(17, 'ssafas', 'Dd', 'aD', 11212),
(18, 'ssafas', 'Dd', 'aD', 11212),
(19, 'ssafas', 'Dd', 'aD', 11212),
(20, 'ssafas', 'Dd', 'aD', 11212),
(21, 'ssafas', 'Dd', 'aD', 11212),
(22, 'ssafas', 'Dd', 'aD', 11212),
(23, 'ssafas', 'Dd', 'aD', 11212),
(24, 'ssafas', 'Dd', 'aD', 11212),
(25, 'ssafas', 'Dd', 'aD', 11212),
(26, 'ssafas', 'Dd', 'aD', 11212);
>>>>>>> Jota

-- --------------------------------------------------------

--
<<<<<<< HEAD
-- Table structure for table `detalleegreso`
=======
-- Estructura de tabla para la tabla `detalleegreso`
>>>>>>> Jota
--

CREATE TABLE `detalleegreso` (
  `idDetEgreso` int(11) NOT NULL,
  `valorEgreso` int(8) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `idEgreso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
<<<<<<< HEAD
-- Dumping data for table `detalleegreso`
--

INSERT INTO `detalleegreso` (`idDetEgreso`, `valorEgreso`, `descripcion`, `idEgreso`) VALUES
<<<<<<< HEAD
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
=======
(44, 5000, 'Juan', 2),
(45, 10000, 'Manuel', 2),
(46, 7900000, 'Pc', 3),
(63, 12345678, 'Uwu', 3),
(69, 500000, 'Juan', 5),
(70, 2222, ' asasd', 6),
(71, 24333, 'jjjj', 7);
>>>>>>> sebas
=======
-- Volcado de datos para la tabla `detalleegreso`
--

INSERT INTO `detalleegreso` (`idDetEgreso`, `valorEgreso`, `descripcion`, `idEgreso`) VALUES
(96, 200000, 'Juan', 1),
(97, 120000, 'Maria', 1),
(98, 190000, 'Pablo', 1),
(99, 230000, 'Alcantarilla', 2),
(100, 12000, 'Viaje a la notaría', 2),
(101, 120000, 'vasos', 3),
(102, 80000, 'copas aguardiente', 3),
(103, 115000, 'Vasos cerveceros', 3),
(104, 15000, 'sacacorchos', 3),
(105, 12000, 'destapador de bebidas', 3),
(106, 2000000, 'Arriendo del Local', 4),
(107, 20000, 'Barniz', 5),
(108, 210000, 'Refacciones varias', 5),
(109, 150000, 'Carpintero', 5),
(110, 80500, 'Madera', 5),
(111, 100000, 'Juan', 6),
(112, 100000, 'Maria', 6),
(113, 100000, 'Pablo', 6),
(114, 240000, 'Juan', 7),
(115, 201400, 'Maria', 7),
(116, 120000, 'Pablo', 7),
(117, 240000, 'Curso manejo y conservación de vinos', 8);
>>>>>>> Jota

-- --------------------------------------------------------

--
<<<<<<< HEAD
-- Table structure for table `detalleventa`
=======
-- Estructura de tabla para la tabla `detalleventa`
>>>>>>> Jota
--

CREATE TABLE `detalleventa` (
  `idDetVenta` int(11) NOT NULL,
  `uniVendidas` int(8) NOT NULL,
  `precioUnitario` int(11) DEFAULT NULL,
  `idVenta` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

<<<<<<< HEAD
--
-- Volcado de datos para la tabla `detalleventa`
--

INSERT INTO `detalleventa` (`idDetVenta`, `uniVendidas`, `precioUnitario`, `idVenta`, `idProducto`) VALUES
<<<<<<< HEAD
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
=======
(63, 5, 6000, 1, 7),
(64, 2, 55000, 1, 10),
(65, 2, 36000, 1, 8),
(66, 2, 50000, 2, 1),
(67, 1, 36000, 2, 8),
(69, 1, 20000, 3, 5),
(70, 5, 42000, 3, 2);
>>>>>>> sebas

-- --------------------------------------------------------

--
-- Table structure for table `detcompraproducto`
=======
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detcompraproducto`
>>>>>>> Jota
--

CREATE TABLE `detcompraproducto` (
  `idDetCompra` int(11) NOT NULL,
  `cantidadCompra` int(8) NOT NULL,
  `precioUnitario` int(11) NOT NULL,
  `idCompra` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

<<<<<<< HEAD
<<<<<<< HEAD
--
-- Volcado de datos para la tabla `detcompraproducto`
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

=======
>>>>>>> sebas
-- --------------------------------------------------------

--
-- Table structure for table `enccompraproducto`
=======
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enccompraproducto`
>>>>>>> Jota
--

CREATE TABLE `enccompraproducto` (
  `idCompra` int(11) NOT NULL,
  `conceptoCompra` varchar(50) DEFAULT NULL,
  `fechaCompra` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `idProveedor` int(11) DEFAULT NULL,
  `vrTotalCompra` int(11) NOT NULL,
  `vrTotalIva` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

<<<<<<< HEAD
<<<<<<< HEAD
--
-- Volcado de datos para la tabla `enccompraproducto`
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

=======
>>>>>>> sebas
-- --------------------------------------------------------

--
-- Table structure for table `encegreso`
=======
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encegreso`
>>>>>>> Jota
--

CREATE TABLE `encegreso` (
  `idEgreso` int(11) NOT NULL,
  `fechaEgreso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tituloEgreso` varchar(80) DEFAULT NULL,
  `vrTotalEgreso` int(8) NOT NULL,
  `idTipoEgreso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
<<<<<<< HEAD
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
<<<<<<< HEAD
-- Table structure for table `encventas`
=======
-- Estructura de tabla para la tabla `encventas`
>>>>>>> Jota
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

<<<<<<< HEAD
--
-- Volcado de datos para la tabla `encventas`
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
=======
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen`
>>>>>>> Jota
--

CREATE TABLE `imagen` (
  `idImagen` int(11) NOT NULL,
  `rutaImagen` varchar(100) NOT NULL,
  `nombreImagen` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
<<<<<<< HEAD
-- Dumping data for table `imagen`
--

INSERT INTO `imagen` (`idImagen`, `rutaImagen`, `nombreImagen`) VALUES
<<<<<<< HEAD
(9, '/public/img/productos', 'bimbo.png'),
(11, './../../../public/img/productos/', '20230310011457.jpg');
=======
(9, '/public/img/productos', 'bimbo.png');
>>>>>>> sebas
=======
-- Volcado de datos para la tabla `imagen`
--

INSERT INTO `imagen` (`idImagen`, `rutaImagen`, `nombreImagen`) VALUES
(9, '/public/img/productos', 'bimbo.png');
>>>>>>> Jota

-- --------------------------------------------------------

--
<<<<<<< HEAD
-- Table structure for table `notas`
=======
-- Estructura de tabla para la tabla `notas`
>>>>>>> Jota
--

CREATE TABLE `notas` (
  `idNota` int(11) NOT NULL,
  `tituloNota` varchar(20) DEFAULT NULL,
  `contenidoNota` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
<<<<<<< HEAD
-- Table structure for table `productos`
=======
-- Estructura de tabla para la tabla `productos`
>>>>>>> Jota
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
<<<<<<< HEAD
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`idProducto`, `nombreProducto`, `descripcionProducto`, `porcentajeIva`, `costoProducto`, `precioVenta`, `stockProducto`, `idImagen`) VALUES
<<<<<<< HEAD
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
(11, 'Aguila lata', 'Lata de aguila negra 330cm3', 21, 2000, 3500, 42, 9),
(12, 'Botella de vodka', 'botella de vodka smirnoff', 21, 40000, 50000, 10, 11);
=======
=======
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProducto`, `nombreProducto`, `descripcionProducto`, `porcentajeIva`, `costoProducto`, `precioVenta`, `stockProducto`, `idImagen`) VALUES
>>>>>>> Jota
(1, 'Vino gato negro', 'Vino Tinto merlot 2020', 21, 42000, 50000, 7, 9),
(2, 'Crema de whiskey', 'Crema dulce', 21, 30000, 42000, 9, 9),
(3, 'Pilsenon litro', 'Cerveza pilsen litro', 3, 3000, 5500, 32, 9),
(4, 'Pilsenon 750', 'Pilsenon 750ml\r\n', 15, 2500, 5000, 32, 9),
(5, 'Media de guaro', 'Media de guaro tapa roja', 21, 10000, 20000, 10, 9),
(6, 'litro de ron caldas', 'Litro de ron caldas', 21, 40000, 50000, 7, 9),
(7, 'Aguilon litro', 'Aguilon litro', 15, 4000, 6000, 31, 9),
(8, 'Vino Vientos del sur', 'Cavernet vientos del sur 750ml', 21, 25000, 36000, 8, 9),
(9, 'Botella de champaña', 'Botella de champaña blanca, espumosa ', 21, 30000, 50000, 10, 9),
<<<<<<< HEAD
(10, 'Botella de gin', 'Botella de ginebra ', 21, 40000, 55000, 4, 9),
(11, 'Aguila lata', 'Lata de aguila negra 330cm3', 21, 1800, 3500, 50, 9);
>>>>>>> sebas
=======
(10, 'Botella de gin', 'Botella de ginebra ', 21, 40000, 55000, 3, 9),
(11, 'Aguila lata', 'Lata de aguila negra 330cm3', 21, 1800, 3500, 50, 9);
>>>>>>> Jota

-- --------------------------------------------------------

--
<<<<<<< HEAD
-- Table structure for table `proveedor`
=======
-- Estructura de tabla para la tabla `proveedor`
>>>>>>> Jota
--

CREATE TABLE `proveedor` (
  `idProveedor` int(11) NOT NULL,
  `nombreProveedor` varchar(40) NOT NULL,
  `direccionProveedor` varchar(30) DEFAULT NULL,
  `telefonoProveedor` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
<<<<<<< HEAD
-- Dumping data for table `proveedor`
=======
-- Volcado de datos para la tabla `proveedor`
>>>>>>> Jota
--

INSERT INTO `proveedor` (`idProveedor`, `nombreProveedor`, `direccionProveedor`, `telefonoProveedor`) VALUES
(9, 'Licores de cundinamarca S.A', 'calle 12', '124'),
(11, 'Variedades S.A', 'Cll Sa', '36588912'),
(12, 'FLA', 'Cll Santo tequila', '52424788'),
(14, 'Bavaria', 'Calle Elm', '555 666 4548'),
(15, 'Licores el gallo', 'avenida central', '3169874503'),
<<<<<<< HEAD
<<<<<<< HEAD
(16, 'Rones el pistolero', '...', '9561059878'),
(17, 'tqeuila es mescal', 'calle banano', '2225487');
=======
(16, 'Rones el pistolero', '...', '9561059878');
>>>>>>> sebas
=======
(16, 'Rones el pistolero', '...', '9561059878');
>>>>>>> Jota

-- --------------------------------------------------------

--
<<<<<<< HEAD
-- Table structure for table `tipoegreso`
=======
-- Estructura de tabla para la tabla `tipoegreso`
>>>>>>> Jota
--

CREATE TABLE `tipoegreso` (
  `idTipoEgreso` int(11) NOT NULL,
  `nombreTipoEgreso` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
<<<<<<< HEAD
-- Dumping data for table `tipoegreso`
=======
-- Volcado de datos para la tabla `tipoegreso`
>>>>>>> Jota
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
<<<<<<< HEAD
-- Table structure for table `usuarios`
=======
-- Estructura de tabla para la tabla `usuarios`
>>>>>>> Jota
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nombreUsuario` varchar(40) NOT NULL,
  `correoUsuario` varchar(40) NOT NULL,
  `contrasenaUsuario` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
<<<<<<< HEAD
-- Dumping data for table `usuarios`
=======
-- Volcado de datos para la tabla `usuarios`
>>>>>>> Jota
--

INSERT INTO `usuarios` (`idUsuario`, `nombreUsuario`, `correoUsuario`, `contrasenaUsuario`) VALUES
(22, 'Los Pollos hermanos', 'yinifac660@crtsec.com', '1036251514'),
(24, 'Perros Juan', 'texeh42419@fsouda.com', '123456789'),
(25, 'Manueh', 'texeh42419@fsouda.com', '1036251514'),
(26, 'Pollos Hermanos', 'jasoyop726@ngopy.com', '1036251514'),
(27, 'Pollos Hermanos', 'jasoyop726@ngopy.com', '1036251514');

--
<<<<<<< HEAD
-- Indexes for dumped tables
--

--
-- Indexes for table `clientes`
=======
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
>>>>>>> Jota
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`);

--
<<<<<<< HEAD
-- Indexes for table `detalleegreso`
=======
-- Indices de la tabla `detalleegreso`
>>>>>>> Jota
--
ALTER TABLE `detalleegreso`
  ADD PRIMARY KEY (`idDetEgreso`),
  ADD KEY `detalleEgreso` (`idEgreso`);

--
<<<<<<< HEAD
-- Indexes for table `detalleventa`
=======
-- Indices de la tabla `detalleventa`
>>>>>>> Jota
--
ALTER TABLE `detalleventa`
  ADD PRIMARY KEY (`idDetVenta`),
  ADD KEY `ventaProducto` (`idProducto`),
  ADD KEY `detEncVta` (`idVenta`);

--
<<<<<<< HEAD
-- Indexes for table `detcompraproducto`
=======
-- Indices de la tabla `detcompraproducto`
>>>>>>> Jota
--
ALTER TABLE `detcompraproducto`
  ADD PRIMARY KEY (`idDetCompra`),
  ADD KEY `compraProducto` (`idCompra`),
  ADD KEY `detalleCompraProducto` (`idProducto`);

--
<<<<<<< HEAD
-- Indexes for table `enccompraproducto`
=======
-- Indices de la tabla `enccompraproducto`
>>>>>>> Jota
--
ALTER TABLE `enccompraproducto`
  ADD PRIMARY KEY (`idCompra`),
  ADD KEY `encCompraProductos` (`idProveedor`);

--
<<<<<<< HEAD
-- Indexes for table `encegreso`
=======
-- Indices de la tabla `encegreso`
>>>>>>> Jota
--
ALTER TABLE `encegreso`
  ADD PRIMARY KEY (`idEgreso`),
  ADD KEY `egresosTipo` (`idTipoEgreso`);

--
<<<<<<< HEAD
-- Indexes for table `encventas`
=======
-- Indices de la tabla `encventas`
>>>>>>> Jota
--
ALTER TABLE `encventas`
  ADD PRIMARY KEY (`idVenta`),
  ADD KEY `clientesVentas` (`idCliente`);

--
<<<<<<< HEAD
-- Indexes for table `imagen`
=======
-- Indices de la tabla `imagen`
>>>>>>> Jota
--
ALTER TABLE `imagen`
  ADD PRIMARY KEY (`idImagen`);

--
<<<<<<< HEAD
-- Indexes for table `notas`
=======
-- Indices de la tabla `notas`
>>>>>>> Jota
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`idNota`);

--
<<<<<<< HEAD
-- Indexes for table `productos`
=======
-- Indices de la tabla `productos`
>>>>>>> Jota
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `productoImagen` (`idImagen`);

--
<<<<<<< HEAD
-- Indexes for table `proveedor`
=======
-- Indices de la tabla `proveedor`
>>>>>>> Jota
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idProveedor`);

--
<<<<<<< HEAD
-- Indexes for table `tipoegreso`
=======
-- Indices de la tabla `tipoegreso`
>>>>>>> Jota
--
ALTER TABLE `tipoegreso`
  ADD PRIMARY KEY (`idTipoEgreso`);

--
<<<<<<< HEAD
-- Indexes for table `usuarios`
=======
-- Indices de la tabla `usuarios`
>>>>>>> Jota
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`);

--
<<<<<<< HEAD
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
<<<<<<< HEAD
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
=======
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
>>>>>>> sebas

--
-- AUTO_INCREMENT de la tabla `detalleegreso`
--
ALTER TABLE `detalleegreso`
<<<<<<< HEAD
  MODIFY `idDetEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
=======
  MODIFY `idDetEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;
>>>>>>> sebas

--
-- AUTO_INCREMENT de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
<<<<<<< HEAD
  MODIFY `idDetVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
=======
  MODIFY `idDetVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;
>>>>>>> sebas

--
-- AUTO_INCREMENT de la tabla `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
<<<<<<< HEAD
  MODIFY `idDetCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;
=======
  MODIFY `idDetCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
>>>>>>> sebas

--
-- AUTO_INCREMENT de la tabla `imagen`
--
ALTER TABLE `imagen`
<<<<<<< HEAD
  MODIFY `idImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
=======
  MODIFY `idImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
>>>>>>> sebas

--
-- AUTO_INCREMENT for table `notas`
=======
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `detalleegreso`
--
ALTER TABLE `detalleegreso`
  MODIFY `idDetEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  MODIFY `idDetVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT de la tabla `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
  MODIFY `idDetCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `imagen`
--
ALTER TABLE `imagen`
  MODIFY `idImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `notas`
>>>>>>> Jota
--
ALTER TABLE `notas`
  MODIFY `idNota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
<<<<<<< HEAD
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
<<<<<<< HEAD
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
=======
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
>>>>>>> sebas

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
<<<<<<< HEAD
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
=======
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
>>>>>>> sebas

--
-- AUTO_INCREMENT for table `tipoegreso`
=======
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `tipoegreso`
>>>>>>> Jota
--
ALTER TABLE `tipoegreso`
  MODIFY `idTipoEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
<<<<<<< HEAD
-- AUTO_INCREMENT for table `usuarios`
=======
-- AUTO_INCREMENT de la tabla `usuarios`
>>>>>>> Jota
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
<<<<<<< HEAD
-- Constraints for dumped tables
--

--
-- Constraints for table `detalleegreso`
=======
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalleegreso`
>>>>>>> Jota
--
ALTER TABLE `detalleegreso`
  ADD CONSTRAINT `detalleEgreso` FOREIGN KEY (`idEgreso`) REFERENCES `encegreso` (`idEgreso`) ON DELETE CASCADE;

--
<<<<<<< HEAD
-- Constraints for table `detalleventa`
=======
-- Filtros para la tabla `detalleventa`
>>>>>>> Jota
--
ALTER TABLE `detalleventa`
  ADD CONSTRAINT `EncDetVta` FOREIGN KEY (`idVenta`) REFERENCES `encventas` (`idVenta`) ON DELETE CASCADE,
  ADD CONSTRAINT `ventaProducto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

--
<<<<<<< HEAD
-- Constraints for table `detcompraproducto`
=======
-- Filtros para la tabla `detcompraproducto`
>>>>>>> Jota
--
ALTER TABLE `detcompraproducto`
  ADD CONSTRAINT `compraProducto` FOREIGN KEY (`idCompra`) REFERENCES `enccompraproducto` (`idCompra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalleCompraProducto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

--
<<<<<<< HEAD
-- Constraints for table `enccompraproducto`
=======
-- Filtros para la tabla `enccompraproducto`
>>>>>>> Jota
--
ALTER TABLE `enccompraproducto`
  ADD CONSTRAINT `encCompraProductos` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`) ON DELETE CASCADE;

--
<<<<<<< HEAD
-- Constraints for table `encegreso`
=======
-- Filtros para la tabla `encegreso`
>>>>>>> Jota
--
ALTER TABLE `encegreso`
  ADD CONSTRAINT `egresosTipo` FOREIGN KEY (`idTipoEgreso`) REFERENCES `tipoegreso` (`idTipoEgreso`) ON DELETE CASCADE;

--
<<<<<<< HEAD
-- Constraints for table `encventas`
=======
-- Filtros para la tabla `encventas`
>>>>>>> Jota
--
ALTER TABLE `encventas`
  ADD CONSTRAINT `encClientes` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON DELETE CASCADE;

--
<<<<<<< HEAD
-- Constraints for table `productos`
=======
-- Filtros para la tabla `productos`
>>>>>>> Jota
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productoImagen` FOREIGN KEY (`idImagen`) REFERENCES `imagen` (`idImagen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
