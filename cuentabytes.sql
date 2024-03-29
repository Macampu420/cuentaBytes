-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-05-2023 a las 02:09:18
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cuentabytes`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarAjustes` (IN `nombre_` VARCHAR(40), IN `horaApertura_` TIME, IN `horaCierre_` TIME)   UPDATE ajustes SET nombreEmpresa= nombre_, horaApertura = horaApertura_ , horaCierre = horaCierre_$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCliente` (IN `_idCliente` INT(11), IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))   UPDATE `clientes` SET `idCliente`=_idCliente,`nombresCliente`=_nombresCliente,`apellidosCliente`=_apellidosCliente,`telefonoCliente`=_telefonoCliente,`cedulaCliente`=_cedulaCliente WHERE idCliente = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCostoProducto` (IN `_stockProducto` INT(7), IN `_costoProducto` INT(8), IN `_precioVenta` INT, IN `_idProducto` INT)   UPDATE productos SET existenciaProducto = existenciaProducto + _stockProducto, costoProducto = _costoProducto, precioVenta = _precioVenta WHERE idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarDetEgreso` (IN `_idDetEgreso` INT(11), IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100))   UPDATE `detalleegreso` SET `idDetEgreso`=_idDetEgreso,`valorEgreso`=_valorEgreso,`descripcion`=_descripcion WHERE idDetEgreso = _idDetEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEgreso` (IN `_idEgreso` INT(11), IN `_tituloEgreso` VARCHAR(80), IN `_vrTotalEgreso` INT(8), IN `_idTipoEgreso` INT(11))   UPDATE `encegreso` SET 
`idEgreso`=_idEgreso,`tituloEgreso`=_tituloEgreso,`vrTotalEgreso`=_vrTotalEgreso,`idTipoEgreso`=_idTipoEgreso WHERE idEgreso = _idEgreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarEncVenta` (IN `titVenta` VARCHAR(35), IN `metodoPagoVenta_` VARCHAR(20), IN `descuentoVenta_` INT(11), IN `vrTotal` INT(11), IN `vrIva` INT(11), IN `idCliente_` INT(11), IN `idVenta_` INT)   BEGIN
UPDATE `encventas` SET `tituloVenta`=titVenta,`metodoPagoVenta`=metodoPagoVenta_,`descuentoVenta`=descuentoVenta_
,`vrTotalVta`=vrTotal,`vrTotalIva`=vrIva,`editado`= 1,`idCliente`=idCliente_ WHERE idVenta = idVenta_ ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarExistencia` (IN `unidVend` INT(11), IN `_idProducto` INT(11))   BEGIN
UPDATE productos SET existenciaProducto = existenciaProducto - unidVend WHERE idProducto = _idProducto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarNota` (IN `_idNota` INT(11), IN `_tituloNota` VARCHAR(20), IN `_contenidoNota` VARCHAR(100))   UPDATE `notas` SET `idNota`=_idNota,`tituloNota`=_tituloNota,`contenidoNota`=_contenidoNota WHERE idNota = _idNota$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarProducto` (IN `_idProducto` INT(11), IN `_nombreProducto` VARCHAR(30), IN `_descripcionProducto` VARCHAR(100), IN `_costoProducto` INT(8), IN `_precioVenta` INT(8), IN `_existenciaProducto` INT(7), IN `_idImagen` INT(11))   UPDATE `productos` SET `nombreProducto`=_nombreProducto,`descripcionProducto`=_descripcionProducto,`costoProducto`=_costoProducto,`precioVenta`=_precioVenta,
`existenciaProducto`=_existenciaProducto,`idImagen`=_idImagen WHERE idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarProveedor` (IN `_idProveedor` INT(11), IN `_nombreProveedor` VARCHAR(40), IN `_direccionProveedor` VARCHAR(30), IN `_telefonoProveedor` VARCHAR(15))   BEGIN
UPDATE `proveedor` SET `nombreProveedor`=_nombreProveedor,`direccionProveedor`=_direccionProveedor,`telefonoProveedor`=_telefonoProveedor WHERE idProveedor = _idProveedor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesFacturasDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
	SELECT 
		COUNT(encventas.idCliente) as nroFacturas, 
		    CONCAT(SUBSTRING_INDEX(clientes.nombresCliente, ' ', 1), ' ' ,SUBSTRING_INDEX(clientes.apellidosCliente, ' ', 1) ) AS nombres
	FROM 
    	encventas
	INNER JOIN 
    	clientes ON encventas.idCliente = clientes.idCliente
    INNER JOIN 
    	ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
	WHERE 
    	encventas.fechaVenta BETWEEN inicio AND fin
	GROUP BY clientes.nombresCliente
	ORDER BY nroFacturas DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesFacturasHoras` (IN `dia` VARCHAR(30))   BEGIN
DECLARE
        fecha DATE;
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY);
    ELSE
    SET
        fecha = CURDATE();
    END IF;
SELECT
    COUNT(encventas.idCliente) as nroFacturas,
    CONCAT(SUBSTRING_INDEX(clientes.nombresCliente, ' ', 1), ' ' ,SUBSTRING_INDEX(clientes.apellidosCliente, ' ', 1) ) AS 				nombres
FROM encventas
INNER JOIN
clientes ON encventas.idCliente = clientes.idCliente
    INNER JOIN
    ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
WHERE
DATE(encVentas.fechaVenta) = fecha
GROUP BY clientes.nombresCliente
ORDER BY nroFacturas DESC;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarNota` (IN `_idNota` INT(11))   DELETE FROM `Notas` WHERE idNota = _idNota$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarAjustes` (IN `nombreEmpresa_` VARCHAR(40))   BEGIN
DECLARE cantidad_registros INT;
SELECT COUNT(*) INTO cantidad_registros FROM ajustes;

IF cantidad_registros = 0 THEN
INSERT INTO `ajustes`(`nombreEmpresa`, `horaApertura`, `horaCierre`, `tipoGrafico`) VALUES (nombreEmpresa_,'07:00:00','17:00:00','barras');
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarCliente` (IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))   INSERT INTO `clientes`(`nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES (_nombresCliente,_apellidosCliente,_telefonoCliente,_cedulaCliente)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetCompra` (IN `_cantidadCompra` INT(11), IN `_precioCompra` INT(8), IN `_precioVenta` INT, IN `_idCompra` INT(11), IN `_idProducto` INT(11))   INSERT INTO `detcompraproducto`(`cantidadCompra`, `precioCompra`, `precioVenta`,`idCompra`, `idProducto`) 
VALUES (_cantidadCompra,_precioCompra,_precioVenta,_idCompra,_idProducto)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetEgreso` (IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100), IN `_idEgreso` INT(11))   INSERT INTO `detalleegreso`(`valorEgreso`, `descripcion`, `idEgreso`) VALUES (_valorEgreso,_descripcion,_idEgreso)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetVenta` (IN `_uniVendidas` INT(8), IN `precioUnit` INT(11), IN `_idVenta` INT(11), IN `idProducto` INT(11))   BEGIN
INSERT INTO `detalleventa` (`uniVendidas`, `precioUnitario`, `idVenta`, `idProducto`) VALUES (_uniVendidas, precioUnit, _idVenta, idProducto); END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncCompra` (IN `_idCompra` INT(11), IN `_idProveedor` INT(11), IN `_vrTotalCompra` INT(11))   INSERT INTO enccompraproducto(idCompra,  fechaCompra, idProveedor, vrTotalCompra) 
VALUES (_idCompra, now(),_idProveedor,_vrTotalCompra)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncEgreso` (IN `_idEgreso` INT(11), IN `_tituloEgreso` VARCHAR(80), IN `_vrTotalEgreso` INT(8), IN `_idTipoEgreso` INT(11))   INSERT INTO `encegreso`(`idEgreso`, `fechaEgreso`, `tituloEgreso`, `vrTotalEgreso`, `idTipoEgreso`) VALUES (_idEgreso, now(),_tituloEgreso,_vrTotalEgreso,_idTipoEgreso)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncVenta` (IN `_idVenta` INT(11), IN `_metPago` INT(11), IN `dto` INT(11), IN `vrTotal` INT(11), IN `_idCliente` INT(11))   BEGIN
INSERT INTO `encventas`(`idVenta`, `fechaVenta`, `descuentoVenta`,`idMetodoPago`,  `vrTotalVta`, `idCliente`) VALUES (_idVenta,now(), dto, _metPago,  vrTotal, _idCliente);                                         
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarNota` (IN `_tituloNota` VARCHAR(20), IN `_contenidoNota` VARCHAR(100))   INSERT INTO `Notas`(`tituloNota`, `contenidoNota`) VALUES (_tituloNota,_contenidoNota)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarProducto` (IN `_nombreProducto` VARCHAR(30), IN `_descripcionProducto` VARCHAR(100), IN `_costoProducto` INT(8), IN `_precioVenta` INT(8), IN `_existenciaProducto` INT(7), IN `_idImagen` INT(11))   INSERT INTO `productos`(`nombreProducto`, `descripcionProducto`, `costoProducto`, `precioVenta`, `existenciaProducto`, `idImagen`) VALUES (_nombreProducto,_descripcionProducto,_costoProducto,_precioVenta,_existenciaProducto,_idImagen)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarAjustes` ()   BEGIN
SELECT * FROM ajustes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarClientes` ()   BEGIN
SELECT * FROM clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarCompra` (IN `_idCompra` INT(11))   SELECT enccompraproducto.idCompra, enccompraproducto.fechaCompra, enccompraproducto.vrTotalCompra, 
proveedor.nombreProveedor, proveedor.idProveedor,
detcompraproducto.idDetCompra, detcompraproducto.cantidadCompra, detcompraproducto.precioCompra,detcompraproducto.precioVenta, 
productos.nombreProducto, productos.idProducto, productos.existenciaProducto,
imagen.nombreImagen
FROM enccompraproducto 
INNER JOIN proveedor ON proveedor.idProveedor = enccompraproducto.idProveedor
INNER JOIN detcompraproducto ON detcompraproducto.idCompra = enccompraproducto.idCompra
INNER JOIN productos ON productos.idProducto = detcompraproducto.idProducto
INNER JOIN imagen ON imagen.idImagen = productos.idImagen
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarMetodoPago` ()   SELECT * FROM metodopago$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProductos` ()   BEGIN
SELECT idProducto, nombreProducto, existenciaProducto, precioVenta, costoProducto FROM productos ORDER BY nombreProducto ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProveedores` ()   select * from proveedor order by idProveedor desc$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarTipoEgreso` ()   SELECT * FROM tipoegreso$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarVenta` (IN `idVenta_` INT)   BEGIN
    SELECT
        encventas.idVenta,
        encventas.fechaVenta,
        metodopago.metodoPago,
        metodopago.idMetodoPago,
        encventas.descuentoVenta,
        encventas.vrTotalVta,
        clientes.idCliente,
        clientes.nombresCliente,
        detalleventa.idDetVenta,
        detalleventa.uniVendidas,
        detalleventa.precioUnitario,
        detalleventa.idProducto,
        productos.nombreProducto,
        productos.existenciaProducto,
        imagen.nombreImagen
    FROM
        encventas
    INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta
    INNER JOIN productos ON detalleventa.idProducto = productos.idProducto
    INNER JOIN clientes ON clientes.idCliente = encventas.idCliente
    INNER JOIN metodopago ON metodopago.idMetodoPago = encventas.idMetodoPago
    INNER JOIN imagen ON imagen.idImagen = productos.idImagen
    WHERE
        encventas.idVenta = idVenta_; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarVentas` ()   BEGIN
SELECT idVenta, fechaVenta, metodoPago, descuentoVenta, vrTotalVta, nombresCliente, apellidosCliente FROM encventas 
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente 
INNER JOIN metodopago ON metodopago.idMetodoPago = encventas.idMetodoPago
order by idVenta DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mayorEgreso` ()   BEGIN
SELECT SUM(detalleegreso.valorEgreso)as mayorValor, detalleegreso.descripcion, encegreso.tituloEgreso FROM detalleegreso INNER JOIN encegreso ON encegreso.idEgreso = detalleegreso.idEgreso GROUP BY detalleegreso.idegreso ORDER BY mayorValor DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mayoresComprasDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(enccompraproducto.vrTotalCompra) AS vrTotalDia,
        DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d') AS Dia
    FROM
        enccompraproducto
    INNER JOIN ajustes ON TIME(enccompraproducto.fechaCompra) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        enccompraproducto.fechaCompra BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
    ORDER BY
        vrTotalDia
    DESC
LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mayoresComprasPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        enccompraproducto.vrTotalCompra, 
        TIME(DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        enccompraproducto
    INNER JOIN ajustes ON TIME(enccompraproducto.fechaCompra) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(enccompraproducto.fechaCompra) = fecha
    ORDER BY
        enccompraproducto.vrTotalCompra
    DESC
LIMIT 10;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mayoresEgresosDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(encegreso.vrTotalEgreso) AS vrTotalDia,
        DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d') AS Dia
    FROM
        encegreso
    INNER JOIN ajustes ON TIME(encegreso.fechaEgreso) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        encegreso.fechaEgreso BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
            ORDER BY
        vrTotalDia
    DESC
LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mayoresEgresosPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        encegreso.vrTotalEgreso, 
        TIME(DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        encegreso
    INNER JOIN ajustes ON TIME(encegreso.fechaEgreso) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(encegreso.fechaEgreso) = fecha
    ORDER BY
        encegreso.vrTotalEgreso
    DESC
LIMIT 10;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresClientesFacturasDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
SELECT
COUNT(encventas.idCliente) as nroFacturas,
    CONCAT(SUBSTRING_INDEX(clientes.nombresCliente, ' ', 1), ' ' ,SUBSTRING_INDEX(clientes.apellidosCliente, ' ', 1) ) AS nombres
FROM encventas
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente
INNER JOIN ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
WHERE encventas.fechaVenta BETWEEN inicio AND fin
GROUP BY clientes.nombresCliente
ORDER BY nroFacturas desc limit 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresClientesFacturasHoras` (IN `dia` VARCHAR(10))   BEGIN
DECLARE
        fecha DATE;
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY);
    ELSE
    SET
        fecha = CURDATE();
    END IF;
SELECT
COUNT(encventas.idCliente) as nroFacturas,     CONCAT(SUBSTRING_INDEX(clientes.nombresCliente, ' ', 1), ' ' ,SUBSTRING_INDEX(clientes.apellidosCliente, ' ', 1) ) AS nombres
FROM encventas
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente
INNER JOIN ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
WHERE
DATE(encVentas.fechaVenta) = fecha
GROUP BY clientes.nombresCliente
ORDER BY nroFacturas desc limit 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresProductosFacturasDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d')AS Dia, COUNT(detalleventa.idProducto)AS nroFacturas, productos.nombreProducto
FROM encventas
INNER JOIN detalleventa ON detalleventa.idVenta = encventas.idVenta
INNER JOIN productos ON productos.idProducto = detalleventa.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto
ORDER BY nroFacturas DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresProductosFacturasHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT HOUR(DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d %H:%i:%s'))AS hora, COUNT(detalleventa.idProducto)AS nroFacturas, productos.nombreProducto
FROM encventas
INNER JOIN detalleventa ON detalleventa.idVenta = encventas.idVenta
INNER JOIN productos ON productos.idProducto = detalleventa.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto
ORDER BY nroFacturas DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresVentasDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(encventas.vrTotalVta) AS vrTotalDia,
        DATE_FORMAT(fechaVenta, '%Y-%m-%d') AS Dia
    FROM
        encVentas
    INNER JOIN ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        encVentas.fechaVenta BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
    ORDER BY
        vrTotalDia
    DESC
LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresVentasPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        encventas.vrTotalVta, 
        TIME(DATE_FORMAT(fechaVenta, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        encVentas
    INNER JOIN ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(encVentas.fechaVenta) = fecha
    ORDER BY
        encventas.vrTotalVta
    DESC
LIMIT 10;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menorEgreso` ()   BEGIN
SELECT SUM(detalleegreso.valorEgreso)as mayorValor, detalleegreso.descripcion, encegreso.tituloEgreso FROM detalleegreso INNER JOIN encegreso ON encegreso.idEgreso = detalleegreso.idEgreso GROUP BY detalleegreso.idegreso ORDER BY mayorValor ASC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menoresComprasDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(enccompraproducto.vrTotalCompra) AS vrTotalDia,
        DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d') AS Dia
    FROM
        enccompraproducto
    INNER JOIN ajustes ON TIME(enccompraproducto.fechaCompra) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        enccompraproducto.fechaCompra BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
    ORDER BY
        vrTotalDia
    ASC
LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menoresComprasPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        enccompraproducto.vrTotalCompra, 
        TIME(DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        enccompraproducto
    INNER JOIN ajustes ON TIME(enccompraproducto.fechaCompra) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(enccompraproducto.fechaCompra) = fecha
    ORDER BY
        enccompraproducto.vrTotalCompra
    ASC
LIMIT 10;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menoresEgresosDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(encegreso.vrTotalEgreso) AS vrTotalDia,
        DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d') AS Dia
    FROM
        encegreso
    INNER JOIN ajustes ON TIME(encegreso.fechaEgreso) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        encegreso.fechaEgreso BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
    ORDER BY
        vrTotalDia
    ASC
LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menoresEgresosPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        encegreso.vrTotalEgreso, 
        TIME(DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        encegreso
    INNER JOIN ajustes ON TIME(encegreso.fechaEgreso) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(encegreso.fechaEgreso) = fecha
    ORDER BY
        encegreso.vrTotalEgreso
    ASC
LIMIT 10;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menoresVentasDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(encventas.vrTotalVta) AS vrTotalDia,
        DATE_FORMAT(fechaVenta, '%Y-%m-%d') AS Dia
    FROM
        encVentas
    INNER JOIN ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        encVentas.fechaVenta BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
    ORDER BY
        vrTotalDia
    ASC
LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `menoresVentasPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        encventas.vrTotalVta, 
        TIME(DATE_FORMAT(fechaVenta, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        encVentas
    INNER JOIN ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(encVentas.fechaVenta) = fecha
    ORDER BY
        encventas.vrTotalVta
    ASC
LIMIT 10;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarNotas` ()   BEGIN
SELECT * FROM notas ORDER BY idNota DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarProductos` ()   SELECT productos.idProducto, productos.nombreProducto,productos.descripcionProducto, productos.costoProducto, productos.precioVenta, productos.existenciaProducto, imagen.nombreImagen
FROM productos INNER JOIN imagen
ON productos.idImagen = imagen.idImagen
ORDER BY productos.nombreProducto ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarUnaNota` (IN `_idNota` INT(11))   BEGIN
SELECT * FROM notas WHERE idNota = _idNota;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarUnProducto` (IN `_idProducto` INT(11))   SELECT productos.idProducto, productos.nombreProducto, productos.existenciaProducto, productos.precioVenta, productos.costoProducto, imagen.nombreImagen, imagen.idImagen
FROM productos 
INNER JOIN imagen
ON productos.idImagen = imagen.idImagen
WHERE productos.idProducto = _idProducto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peoresClientesFacturasDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
	SELECT 
        COUNT(encventas.idCliente) as nroFacturas, 
            CONCAT(SUBSTRING_INDEX(clientes.nombresCliente, ' ', 1), ' ' ,SUBSTRING_INDEX(clientes.apellidosCliente, ' ', 1) ) AS nombres	
	FROM 
    	encventas
	INNER JOIN 
    	clientes ON encventas.idCliente = clientes.idCliente
    INNER JOIN 
    	ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
	WHERE 
    	encventas.fechaVenta BETWEEN inicio AND fin
	GROUP BY clientes.nombresCliente
	ORDER BY nroFacturas ASC limit 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peoresClientesFacturasHoras` (IN `dia` VARCHAR(10))   BEGIN
	DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
	SELECT  
        COUNT(encventas.idCliente) as nroFacturas, 
            CONCAT(SUBSTRING_INDEX(clientes.nombresCliente, ' ', 1), ' ' ,SUBSTRING_INDEX(clientes.apellidosCliente, ' ', 1) ) AS nombres
	FROM 
    	encventas
    INNER JOIN 
    	clientes ON encventas.idCliente = clientes.idCliente
	INNER JOIN 
    	ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
	WHERE 
		DATE(encVentas.fechaVenta) = fecha
	GROUP BY clientes.nombresCliente
	ORDER BY nroFacturas ASC limit 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peoresProductosFacturasDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d')AS Dia, COUNT(detalleventa.idProducto)AS nroFacturas, productos.nombreProducto
FROM encventas
INNER JOIN detalleventa ON detalleventa.idVenta = encventas.idVenta
INNER JOIN productos ON productos.idProducto = detalleventa.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto
ORDER BY nroFacturas ASC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peoresProductosFacturasHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT HOUR(DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d %H:%i:%s'))AS hora, COUNT(detalleventa.idProducto)AS nroFacturas, productos.nombreProducto
FROM encventas
INNER JOIN detalleventa ON detalleventa.idVenta = encventas.idVenta
INNER JOIN productos ON productos.idProducto = detalleventa.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto
ORDER BY nroFacturas ASC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMasStock` ()   SELECT MAX(productos.stockProducto) AS stockMayor, productos.nombreProducto, imagen.nombreImagen 
FROM productos 
INNER JOIN imagen ON productos.idImagen = imagen.idImagen
GROUP BY productos.idProducto, productos.nombreProducto, imagen.nombreImagen
ORDER BY stockMayor DESC 
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `prodMenStock` ()   SELECT MIN(productos.stockProducto) AS stockMayor, productos.nombreProducto, imagen.nombreImagen 
FROM productos 
INNER JOIN imagen ON productos.idImagen = imagen.idImagen
GROUP BY productos.idProducto, productos.nombreProducto, imagen.nombreImagen
ORDER BY stockMayor ASC 
LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productoExistencia` ()   SELECT MAX(productos.existenciaProducto) AS existencia, productos.nombreProducto
FROM productos
GROUP BY productos.idProducto, productos.nombreProducto
ORDER BY existencia DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productoExistenciaMayor` ()   SELECT MAX(productos.existenciaProducto) AS existenciaMayor, productos.nombreProducto
FROM productos
GROUP BY productos.idProducto, productos.nombreProducto
ORDER BY existenciaMayor DESC 
LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productoExistenciaMenor` ()   SELECT MAX(productos.existenciaProducto) AS menorExistencia, productos.nombreProducto
FROM productos
GROUP BY productos.idProducto, productos.nombreProducto
ORDER BY menorExistencia ASC
LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productosFacturasDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d')AS Dia, COUNT(detalleventa.idProducto)AS nroFacturas, productos.nombreProducto
FROM encventas
INNER JOIN detalleventa ON detalleventa.idVenta = encventas.idVenta
INNER JOIN productos ON productos.idProducto = detalleventa.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto
ORDER BY nroFacturas DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productosFacturasHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT HOUR(DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d %H:%i:%s'))AS hora, COUNT(detalleventa.idProducto)AS nroFacturas, productos.nombreProducto
FROM encventas
INNER JOIN detalleventa ON detalleventa.idVenta = encventas.idVenta
INNER JOIN productos ON productos.idProducto = detalleventa.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto
ORDER BY nroFacturas DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productosMayorRentabilidadDia` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d')AS Dia, SUM(productos.precioVenta - productos.costoProducto)/(detalleventa.precioUnitario* detalleventa.uniVendidas)* 100 AS Rentabilidad, productos.nombreProducto 
FROM encventas 
INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta
INNER JOIN productos ON detalleventa.idProducto = productos.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto ORDER BY Rentabilidad DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productosMayorRentabilidadHora` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT HOUR(DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d %H:%i:%s'))AS hora, SUM(productos.precioVenta - productos.costoProducto)/(detalleventa.precioUnitario* detalleventa.uniVendidas)* 100 AS Rentabilidad, productos.nombreProducto 
FROM encventas 
INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta
INNER JOIN productos ON detalleventa.idProducto = productos.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto  ORDER BY Rentabilidad DESC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productosMenorRentabilidadDia` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d')AS Dia, SUM(productos.precioVenta - productos.costoProducto)/(detalleventa.precioUnitario* detalleventa.uniVendidas)* 100 AS Rentabilidad, productos.nombreProducto 
FROM encventas 
INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta
INNER JOIN productos ON detalleventa.idProducto = productos.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto ORDER BY Rentabilidad ASC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productosMenorRentabilidadHora` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT HOUR(DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d %H:%i:%s'))AS hora, SUM(productos.precioVenta - productos.costoProducto)/(detalleventa.precioUnitario* detalleventa.uniVendidas)* 100 AS Rentabilidad, productos.nombreProducto 
FROM encventas 
INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta
INNER JOIN productos ON detalleventa.idProducto = productos.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto ORDER BY Rentabilidad ASC LIMIT 10$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productosRentabilidadDias` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d')AS Dia, SUM(productos.precioVenta - productos.costoProducto)/(detalleventa.precioUnitario* detalleventa.uniVendidas)* 100 AS Rentabilidad, productos.nombreProducto 
FROM encventas 
INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta
INNER JOIN productos ON detalleventa.idProducto = productos.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto ORDER BY Rentabilidad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `productosRentabilidadHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   SELECT HOUR(DATE_FORMAT(encventas.fechaVenta, '%Y-%m-%d %H:%i:%s'))AS hora, SUM(productos.precioVenta - productos.costoProducto)/(detalleventa.precioUnitario* detalleventa.uniVendidas)* 100 AS Rentabilidad, productos.nombreProducto 
FROM encventas 
INNER JOIN detalleventa ON encventas.idVenta = detalleventa.idVenta
INNER JOIN productos ON detalleventa.idProducto = productos.idProducto
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY productos.nombreProducto ORDER BY Rentabilidad$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarEmpresa` (IN `nombreUsuario_` VARCHAR(40), IN `correoUsuario_` VARCHAR(40), IN `contrasenaUsuario_` VARCHAR(255))   INSERT INTO `usuarios`(`nombreUsuario`, `correoUsuario`, `contrasenaUsuario`) 
VALUES (nombreUsuario_,correoUsuario_,contrasenaUsuario_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarImagen` (IN `rutaImg_` VARCHAR(100), IN `nombreImg_` VARCHAR(30))   INSERT INTO `imagen`( `rutaImagen`, `nombreImagen`) VALUES ( rutaImg_, nombreImg_)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenCompras` (IN `fecha1_` DATE, IN `fecha2_` DATE)   SELECT enccompraproducto.vrTotalCompra as total, enccompraproducto.conceptoCompra, enccompraproducto.fechaCompra FROM enccompraproducto WHERE
enccompraproducto.fechaCompra >= fecha1_ AND enccompraproducto.fechaCompra <= fecha2_ GROUP BY enccompraproducto.idCompra ORDER BY enccompraproducto.fechaCompra ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenEgreso` (IN `fecha1_` DATE, IN `fecha2_` DATE)   SELECT encegreso.vrTotalEgreso as total, encegreso.tituloEgreso, encegreso.fechaEgreso FROM encegreso WHERE
encegreso.fechaEgreso >= fecha1_ AND encegreso.fechaEgreso <= fecha2_ GROUP BY encegreso.idEgreso ORDER BY encegreso.fechaEgreso ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `resumenVenta` (IN `fecha1_` DATE, IN `fecha2_` DATE)   SELECT encventas.vrTotalVta as total, encventas.tituloVenta, encventas.fechaVenta FROM encventas WHERE
encventas.fechaVenta >= fecha1_ AND encventas.fechaVenta <= fecha2_ GROUP BY encventas.idVenta ORDER BY encventas.fechaVenta ASC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalComprasDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(enccompraproducto.vrTotalCompra) AS vrTotalDia,
        DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d') AS Dia
    FROM
        enccompraproducto
    INNER JOIN ajustes ON TIME(enccompraproducto.fechaCompra) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        enccompraproducto.fechaCompra BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
    ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalComprasPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        enccompraproducto.vrTotalCompra, 
        TIME(DATE_FORMAT(enccompraproducto.fechaCompra, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        enccompraproducto
    INNER JOIN ajustes ON TIME(enccompraproducto.fechaCompra) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(enccompraproducto.fechaCompra) = fecha
     ORDER BY hora ASC;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalEgresosDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(encegreso.vrTotalEgreso) AS vrTotalDia,
        DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d') AS Dia
    FROM
        encegreso
    INNER JOIN ajustes ON TIME(encegreso.fechaEgreso) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        encegreso.fechaEgreso BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
    ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalEgresosPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        encegreso.vrTotalEgreso, 
        TIME(DATE_FORMAT(encegreso.fechaEgreso, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        encegreso
    INNER JOIN ajustes ON TIME(encegreso.fechaEgreso) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(encegreso.fechaEgreso) = fecha
     ORDER BY hora ASC;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalVentasDias` (IN `diaInicio` DATE, IN `diaFin` DATE)   BEGIN
    SELECT
        SUM(encventas.vrTotalVta) AS vrTotalDia,
        DATE_FORMAT(fechaVenta, '%Y-%m-%d') AS Dia
    FROM
        encVentas
    INNER JOIN ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        encVentas.fechaVenta BETWEEN diaInicio AND diaFin
    GROUP BY
        Dia
    ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `totalVentasPorHora` (IN `dia` VARCHAR(10))   BEGIN
    DECLARE
        fecha DATE; 
    IF dia = 'ayer' THEN
    SET
        fecha = DATE_SUB(CURDATE(), INTERVAL 1 DAY); 
    ELSE
    SET
        fecha = CURDATE();
    END IF;
    SELECT
        encventas.vrTotalVta, 
        TIME(DATE_FORMAT(fechaVenta, '%Y-%m-%d %H:%i:%s')) AS hora
    FROM
        encVentas
    INNER JOIN ajustes ON TIME(encVentas.fechaVenta) BETWEEN ajustes.horaApertura AND ajustes.horaCierre
    WHERE
        DATE(encVentas.fechaVenta) = fecha
     ORDER BY hora ASC;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `verificarRegistro` (IN `email_` VARCHAR(40), IN `contrasena_` VARCHAR(255))   SELECT * FROM usuarios WHERE correoUsuario = email_ AND contrasenaUsuario = contrasena_$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ajustes`
--

CREATE TABLE `ajustes` (
  `nombreEmpresa` varchar(250) NOT NULL,
  `horaApertura` time DEFAULT '08:00:00',
  `horaCierre` time DEFAULT '17:00:00',
  `tipoGrafico` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ajustes`
--

INSERT INTO `ajustes` (`nombreEmpresa`, `horaApertura`, `horaCierre`, `tipoGrafico`) VALUES
('Licorera Elite', '07:00:00', '21:00:00', 'barras');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idCliente` int(11) NOT NULL,
  `nombresCliente` varchar(30) NOT NULL,
  `apellidosCliente` varchar(30) DEFAULT NULL,
  `telefonoCliente` varchar(15) DEFAULT NULL,
  `cedulaCliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idCliente`, `nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES
(4, 'Andrei', 'Peña', '31548792', 1111111111),
(6, 'Keanu', 'Reeves', '555693987', 101099853),
(7, 'Antonio', 'Alvarez', '78642211', 1010994788),
(8, 'Manuela', 'gomez orozco', '4789621', 1010998789),
(9, 'Panfilos', 'Castaño ', '3198752016', 12315124),
(10, 'Rodolfo', 'Hernandez', '312498652', 1010998654),
(11, 'Pancho', 'Sansa', '0', 1010948769),
(14, 'Mallerli', 'Ramirez', '1595020119', 1036251514);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleegreso`
--

CREATE TABLE `detalleegreso` (
  `idDetEgreso` int(11) NOT NULL,
  `valorEgreso` int(8) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `idEgreso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalleegreso`
--

INSERT INTO `detalleegreso` (`idDetEgreso`, `valorEgreso`, `descripcion`, `idEgreso`) VALUES
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
(22, 240000, 'Curso manejo y conservación de vinos', 8),
(24, 2000000, 'Arriendo', 9),
(25, 1000000, 'Pago a juan', 10),
(26, 1000000, 'pago a maria', 10),
(27, 150000, 'mano de obra', 11),
(32, 525321, ' Pago Agua', 12),
(33, 1200000, ' Pago Arriendo', 12),
(34, 255000, 'Vidrio Roto', 13),
(35, 20000, 'Fuga de agua', 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleventa`
--

CREATE TABLE `detalleventa` (
  `idDetVenta` int(11) NOT NULL,
  `uniVendidas` int(8) NOT NULL,
  `precioUnitario` int(11) DEFAULT NULL,
  `idVenta` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalleventa`
--

INSERT INTO `detalleventa` (`idDetVenta`, `uniVendidas`, `precioUnitario`, `idVenta`, `idProducto`) VALUES
(37, 6, 3500, 24, 11),
(38, 1, 50000, 24, 6),
(39, 2, 6000, 25, 7),
(40, 1, 50000, 26, 6),
(41, 12, 3500, 27, 11),
(42, 1, 50000, 27, 12),
(43, 1, 42000, 28, 2),
(44, 1, 50000, 28, 12),
(45, 7, 3500, 28, 11),
(46, 2, 6000, 28, 7),
(47, 1, 3500, 29, 11),
(48, 1, 3500, 30, 11),
(49, 1, 3500, 31, 11),
(50, 1, 6000, 32, 7),
(51, 1, 6000, 33, 7),
(52, 1, 20000, 34, 5),
(53, 2, 50000, 34, 9),
(54, 4, 3500, 34, 11),
(55, 1, 50000, 50, 12),
(56, 1, 3500, 50, 11),
(57, 6, 3500, 51, 11),
(58, 1, 50000, 51, 12),
(59, 1, 3500, 52, 11),
(60, 2, 3500, 53, 11),
(61, 1, 42000, 54, 2),
(62, 6, 4000, 55, 11),
(63, 1, 20000, 55, 5),
(64, 3, 6000, 56, 7),
(65, 1, 36000, 57, 8),
(66, 110, 42000, 58, 2),
(67, 12, 4000, 59, 11),
(68, 1, 4000, 60, 11),
(69, 1, 5000, 60, 4),
(70, 1, 20000, 61, 5),
(71, 7, 4000, 61, 11),
(72, 1, 50000, 62, 9),
(73, 1, 50000, 63, 12),
(74, 3, 5500, 64, 3),
(75, 2, 50000, 65, 6),
(76, 12, 4000, 65, 11),
(77, 2, 50000, 66, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detcompraproducto`
--

CREATE TABLE `detcompraproducto` (
  `idDetCompra` int(11) NOT NULL,
  `cantidadCompra` int(8) NOT NULL,
  `precioCompra` int(11) NOT NULL,
  `precioVenta` int(11) NOT NULL,
  `idCompra` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detcompraproducto`
--

INSERT INTO `detcompraproducto` (`idDetCompra`, `cantidadCompra`, `precioCompra`, `precioVenta`, `idCompra`, `idProducto`) VALUES
(104, 7, 5000, 6000, 1, 7),
(105, 57, 25000, 20000, 1, 5),
(106, 69, 40000, 50000, 1, 12),
(107, 10, 3000, 4000, 2, 11),
(108, 10, 5000, 6000, 2, 7),
(109, 10, 30000, 50000, 2, 9),
(110, 100, 30000, 42000, 2, 2),
(111, 89, 40000, 50000, 3, 6),
(112, 20, 3000, 4000, 4, 11),
(113, 22, 3000, 4000, 5, 11),
(114, 10, 30000, 42000, 5, 2),
(115, 12, 42000, 50000, 5, 1),
(116, 2, 40000, 55000, 6, 10),
(117, 4, 40000, 50000, 7, 6),
(118, 11, 25000, 20000, 8, 5),
(119, 1, 25000, 36000, 9, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enccompraproducto`
--

CREATE TABLE `enccompraproducto` (
  `idCompra` int(11) NOT NULL,
  `fechaCompra` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `idProveedor` int(11) DEFAULT NULL,
  `vrTotalCompra` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `enccompraproducto`
--

INSERT INTO `enccompraproducto` (`idCompra`, `fechaCompra`, `idProveedor`, `vrTotalCompra`) VALUES
(0, '2023-05-05 21:18:00', 17, 3000),
(1, '2023-05-05 21:22:19', 17, 4220),
(2, '2023-05-05 21:23:18', 9, 3380),
(3, '2023-05-05 21:25:24', 9, 3560),
(4, '2023-05-10 16:23:09', 17, 60000),
(5, '2023-05-15 23:34:48', 17, 870000),
(6, '2023-05-15 23:34:57', 17, 80000),
(7, '2023-05-15 23:35:07', 16, 160000),
(8, '2023-05-15 23:35:19', 11, 275000),
(9, '2023-05-15 23:35:58', 17, 25000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encegreso`
--

CREATE TABLE `encegreso` (
  `idEgreso` int(11) NOT NULL,
  `fechaEgreso` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tituloEgreso` varchar(80) DEFAULT NULL,
  `vrTotalEgreso` int(8) NOT NULL,
  `idTipoEgreso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `encegreso`
--

INSERT INTO `encegreso` (`idEgreso`, `fechaEgreso`, `tituloEgreso`, `vrTotalEgreso`, `idTipoEgreso`) VALUES
(2, '2023-04-07 15:28:03', 'Pago Alcantarillado', 242000, 0),
(3, '2023-04-18 15:28:03', 'Compra de utilería', 342000, 6),
(4, '2023-04-30 15:59:23', 'Arriendo Local', 2000000, 1),
(5, '2023-04-12 16:28:03', 'Barriles Vino', 460500, 5),
(6, '2023-04-16 13:28:03', 'Subsidio Transporte', 300000, 4),
(7, '2023-04-17 12:28:03', 'Nomina 2023', 561400, 2),
(8, '2023-04-06 17:28:03', 'Curso Empleados', 240000, 3),
(9, '2023-04-16 18:09:55', 'Arriendo', 2000000, 1),
(10, '2023-04-30 16:59:11', 'Pago a empleados', 2000000, 2),
(11, '2023-04-30 14:28:03', 'Reparacion nevera', 150000, 5),
(12, '2023-05-16 00:00:18', 'Servicios Mes Marzo', 1725321, 0),
(13, '2023-05-16 00:07:35', 'Reparaciones', 275000, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encventas`
--

CREATE TABLE `encventas` (
  `idVenta` int(11) NOT NULL,
  `fechaVenta` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `descuentoVenta` int(11) NOT NULL,
  `idMetodoPago` int(11) DEFAULT NULL,
  `vrTotalVta` int(11) NOT NULL,
  `idCliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `encventas`
--

INSERT INTO `encventas` (`idVenta`, `fechaVenta`, `descuentoVenta`, `idMetodoPago`, `vrTotalVta`, `idCliente`) VALUES
(1, '2023-04-26 15:40:23', 0, 1, 0, 14),
(5, '2023-04-20 19:53:41', 10000, 1, 284000, 9),
(6, '2023-04-20 19:53:41', 8000, 1, 160000, 7),
(7, '2023-04-20 19:53:41', 0, 1, 7000, 4),
(8, '2023-04-20 19:53:41', 0, 1, 42000, 8),
(9, '2023-04-20 19:53:41', 0, 1, 36000, 11),
(10, '2023-04-20 19:53:41', 7000, 1, 70000, 10),
(11, '2023-04-20 19:53:41', 8500, 1, 91500, 6),
(12, '2023-04-20 19:53:41', 0, 1, 56000, 7),
(13, '2023-04-25 21:17:33', 0, 1, 50000, 14),
(14, '2023-04-25 21:21:05', 0, 1, 60500, 14),
(15, '2023-04-25 22:29:19', 0, 1, 55000, 14),
(16, '2023-04-26 15:27:09', 0, 1, 500000, 9),
(17, '2023-04-26 15:35:49', 0, 1, 0, 10),
(18, '2023-04-26 15:39:00', 0, 1, 50000, 14),
(20, '2023-04-27 12:17:29', 1000, 1, 35000, 7),
(21, '2023-04-27 12:27:56', 0, 1, 6000, 7),
(22, '2023-04-27 17:25:55', 2000, 1, 140000, 8),
(23, '2023-04-28 13:05:32', 2000, 1, 48000, 8),
(24, '2023-04-30 16:04:37', 0, 2, 71000, 11),
(25, '2023-04-30 16:04:51', 0, 1, 12000, 4),
(26, '2023-04-30 13:05:06', 0, 4, 50000, 8),
(27, '2023-05-01 13:02:27', 2000, 1, 90000, 7),
(28, '2023-05-01 16:41:43', 500, 1, 128000, 10),
(29, '2023-05-01 16:43:51', 500, 1, 3000, 14),
(30, '2023-05-01 16:46:48', 500, 1, 3000, 14),
(31, '2023-05-01 17:10:49', 0, 1, 3500, 4),
(32, '2023-05-02 12:41:09', 0, 1, 6000, 6),
(33, '2023-05-02 13:03:29', 0, 1, 6000, 6),
(34, '2023-05-02 14:55:14', 0, 1, 134000, 4),
(35, '2023-05-02 15:01:41', 0, 1, 50000, 10),
(36, '2023-05-02 15:01:41', 0, 1, 50000, 8),
(37, '2023-05-02 15:01:41', 0, 1, 50000, 9),
(38, '2023-05-02 15:01:41', 0, 1, 50000, 7),
(39, '2023-05-02 15:01:41', 0, 1, 50000, 11),
(41, '2023-05-02 15:01:41', 0, 1, 50000, 4),
(42, '2023-05-02 15:01:41', 0, 1, 50000, 9),
(43, '2023-05-02 15:01:41', 0, 1, 50000, 9),
(44, '2023-05-02 15:01:41', 0, 1, 50000, 6),
(45, '2023-05-02 15:01:41', 0, 1, 50000, 10),
(47, '2023-05-02 15:01:41', 0, 1, 50000, 9),
(48, '2023-05-02 15:01:41', 0, 1, 50000, 6),
(49, '2023-05-02 15:01:41', 0, 1, 50000, 9),
(50, '2023-05-02 16:30:28', 0, 1, 53500, 4),
(51, '2023-05-02 16:31:06', 1000, 1, 70000, 4),
(52, '2023-05-03 23:25:31', 0, 2, 3500, 6),
(53, '2023-05-03 23:28:13', 0, 1, 7000, 4),
(54, '2023-05-04 00:02:19', 0, 2, 42000, 14),
(55, '2023-05-05 15:42:00', 0, 1, 44000, 11),
(56, '2023-05-05 15:42:13', 0, 1, 18000, 9),
(57, '2023-05-05 15:42:26', 0, 2, 36000, 6),
(58, '2023-05-05 21:28:30', 0, 1, 4620, 7),
(59, '2023-05-10 16:23:33', 0, 1, 48000, 11),
(60, '2023-05-13 20:52:13', 0, 1, 9000, 8),
(61, '2023-05-15 23:31:17', 0, 1, 48000, 11),
(62, '2023-05-15 23:31:43', 0, 1, 50000, 6),
(63, '2023-05-15 23:31:55', 0, 2, 50000, 4),
(64, '2023-05-15 23:32:17', 500, 3, 16000, 14),
(65, '2023-05-15 23:32:37', 0, 2, 148000, 14),
(66, '2023-05-15 23:34:11', 0, 2, 100000, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen`
--

CREATE TABLE `imagen` (
  `idImagen` int(11) NOT NULL,
  `rutaImagen` varchar(100) NOT NULL,
  `nombreImagen` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `imagen`
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
(21, './../../../public/img/productos/', 'gatoNegro.png'),
(22, './../../../public/img/productos/', '20230427165000.png'),
(23, './../../../public/img/productos/', '20230427165047.png'),
(24, './../../../public/img/productos/', '20230427171202.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodopago`
--

CREATE TABLE `metodopago` (
  `idMetodoPago` int(11) NOT NULL,
  `metodoPago` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metodopago`
--

INSERT INTO `metodopago` (`idMetodoPago`, `metodoPago`) VALUES
(1, 'Efectivo'),
(2, 'Transferencia'),
(3, 'Cheque'),
(4, 'Tarjeta de Crédito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notas`
--

CREATE TABLE `notas` (
  `idNota` int(11) NOT NULL,
  `tituloNota` varchar(20) DEFAULT NULL,
  `contenidoNota` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `notas`
--

INSERT INTO `notas` (`idNota`, `tituloNota`, `contenidoNota`) VALUES
(6, 'Pagar arriendo', 'El miércoles 19 de Abril a Humberto'),
(7, 'Keanu Reeves (Debe)', '2 litros de ron'),
(9, 'Comprar pilsenones', 'Necesito 3 cajas'),
(13, 'Comprar Crema de Whi', 'Comprar 200 unidades');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL,
  `nombreProducto` varchar(30) NOT NULL,
  `descripcionProducto` varchar(100) DEFAULT NULL,
  `costoProducto` int(8) NOT NULL,
  `precioVenta` int(8) NOT NULL,
  `existenciaProducto` int(7) NOT NULL,
  `idImagen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProducto`, `nombreProducto`, `descripcionProducto`, `costoProducto`, `precioVenta`, `existenciaProducto`, `idImagen`) VALUES
(1, 'Vino gato negro', 'Vino Tinto merlot 2020', 42000, 50000, 20, 21),
(2, 'Crema de whiskey', 'Crema dulce', 30000, 42000, 10, 20),
(3, 'Pilsenon litro', 'Cerveza pilsen litro', 3000, 5500, 42, 19),
(4, 'Pilsenon 750', 'Pilsenon 750ml\r\n', 2500, 5000, 99, 18),
(5, 'Media de guaro', 'Media de guaro tapa roja', 25000, 20000, 100, 9),
(6, 'litro de ron caldas', 'Litro de ron caldas', 40000, 50000, 110, 17),
(7, 'Aguilon litro', 'Aguilon litro', 5000, 6000, 60, 16),
(8, 'Vino Vientos del sur', 'Cavernet vientos del sur 750ml', 25000, 36000, 31, 15),
(9, 'Botella de champaña', 'Botella de champaña blanca, espumosa ', 30000, 50000, 39, 14),
(10, 'Botella de gin', 'Botella de ginebra ', 40000, 55000, 26, 13),
(11, 'Aguila lata', 'Lata de aguila negra 330cm3', 3000, 4000, 40, 12),
(12, 'Botella de vodka', 'botella de vodka smirnoff', 40000, 50000, 89, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `idProveedor` int(11) NOT NULL,
  `nombreProveedor` varchar(40) NOT NULL,
  `direccionProveedor` varchar(30) DEFAULT NULL,
  `telefonoProveedor` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`idProveedor`, `nombreProveedor`, `direccionProveedor`, `telefonoProveedor`) VALUES
(9, 'Licores de cundinamarca S.A', 'calle 12', '124'),
(11, 'Variedades S.A', 'Cll Sa', '36588912'),
(12, 'FLA', 'Cll Santo tequila', '52424788'),
(14, 'Bavaria', 'Calle Elm', '555 666 4548'),
(15, 'Licores el gallo', 'avenida central', '3169874503'),
(16, 'Rones el pistolero', '...', '9561059878'),
(17, 'tequila es mescal', 'calle banano', '2225487');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoegreso`
--

CREATE TABLE `tipoegreso` (
  `idTipoEgreso` int(11) NOT NULL,
  `nombreTipoEgreso` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipoegreso`
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
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nombreUsuario` varchar(40) NOT NULL,
  `correoUsuario` varchar(40) NOT NULL,
  `contrasenaUsuario` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nombreUsuario`, `correoUsuario`, `contrasenaUsuario`) VALUES
(6, 'Licorera Elite', 'licoreraelite@licorera.com', '58fbd821dd0563b8f2d822133c0be54148c59ef1d1467d45a7d7b5769ceed1a9'),
(8, 'Juan', 'jasoyop726@ngopy.com', 'f7f6559e8e752885c6dd9451f63a3fb5b4e05f29746622fdd28c0b055da52570'),
(9, 'Licores elite', 'campuzanomiguel2208@gmail.com', 'macampu420'),
(10, 'Licores elite', 'campuzanomiguel2208@gmail.com', '123miguel');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ajustes`
--
ALTER TABLE `ajustes`
  ADD PRIMARY KEY (`nombreEmpresa`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `detalleegreso`
--
ALTER TABLE `detalleegreso`
  ADD PRIMARY KEY (`idDetEgreso`),
  ADD KEY `detalleEgreso` (`idEgreso`);

--
-- Indices de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  ADD PRIMARY KEY (`idDetVenta`),
  ADD KEY `ventaProducto` (`idProducto`),
  ADD KEY `detEncVta` (`idVenta`);

--
-- Indices de la tabla `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
  ADD PRIMARY KEY (`idDetCompra`),
  ADD KEY `compraProducto` (`idCompra`),
  ADD KEY `detalleCompraProducto` (`idProducto`);

--
-- Indices de la tabla `enccompraproducto`
--
ALTER TABLE `enccompraproducto`
  ADD PRIMARY KEY (`idCompra`),
  ADD KEY `encCompraProductos` (`idProveedor`);

--
-- Indices de la tabla `encegreso`
--
ALTER TABLE `encegreso`
  ADD PRIMARY KEY (`idEgreso`),
  ADD KEY `egresosTipo` (`idTipoEgreso`);

--
-- Indices de la tabla `encventas`
--
ALTER TABLE `encventas`
  ADD PRIMARY KEY (`idVenta`),
  ADD KEY `clientesVentas` (`idCliente`),
  ADD KEY `metodoPago` (`idMetodoPago`);

--
-- Indices de la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD PRIMARY KEY (`idImagen`);

--
-- Indices de la tabla `metodopago`
--
ALTER TABLE `metodopago`
  ADD PRIMARY KEY (`idMetodoPago`);

--
-- Indices de la tabla `notas`
--
ALTER TABLE `notas`
  ADD PRIMARY KEY (`idNota`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `productoImagen` (`idImagen`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`idProveedor`);

--
-- Indices de la tabla `tipoegreso`
--
ALTER TABLE `tipoegreso`
  ADD PRIMARY KEY (`idTipoEgreso`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `detalleegreso`
--
ALTER TABLE `detalleegreso`
  MODIFY `idDetEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  MODIFY `idDetVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
  MODIFY `idDetCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT de la tabla `imagen`
--
ALTER TABLE `imagen`
  MODIFY `idImagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `metodopago`
--
ALTER TABLE `metodopago`
  MODIFY `idMetodoPago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `notas`
--
ALTER TABLE `notas`
  MODIFY `idNota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `idProveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `tipoegreso`
--
ALTER TABLE `tipoegreso`
  MODIFY `idTipoEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalleegreso`
--
ALTER TABLE `detalleegreso`
  ADD CONSTRAINT `detalleEgreso` FOREIGN KEY (`idEgreso`) REFERENCES `encegreso` (`idEgreso`) ON DELETE CASCADE;

--
-- Filtros para la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  ADD CONSTRAINT `EncDetVta` FOREIGN KEY (`idVenta`) REFERENCES `encventas` (`idVenta`) ON DELETE CASCADE,
  ADD CONSTRAINT `ventaProducto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

--
-- Filtros para la tabla `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
  ADD CONSTRAINT `compraProducto` FOREIGN KEY (`idCompra`) REFERENCES `enccompraproducto` (`idCompra`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalleCompraProducto` FOREIGN KEY (`idProducto`) REFERENCES `productos` (`idProducto`);

--
-- Filtros para la tabla `enccompraproducto`
--
ALTER TABLE `enccompraproducto`
  ADD CONSTRAINT `encCompraProductos` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`) ON DELETE CASCADE;

--
-- Filtros para la tabla `encegreso`
--
ALTER TABLE `encegreso`
  ADD CONSTRAINT `egresosTipo` FOREIGN KEY (`idTipoEgreso`) REFERENCES `tipoegreso` (`idTipoEgreso`) ON DELETE CASCADE;

--
-- Filtros para la tabla `encventas`
--
ALTER TABLE `encventas`
  ADD CONSTRAINT `encClientes` FOREIGN KEY (`idCliente`) REFERENCES `clientes` (`idCliente`) ON DELETE CASCADE,
  ADD CONSTRAINT `metodoPago` FOREIGN KEY (`idMetodoPago`) REFERENCES `metodopago` (`idMetodoPago`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productoImagen` FOREIGN KEY (`idImagen`) REFERENCES `imagen` (`idImagen`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
