-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-05-2023 a las 19:19:57
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCliente` (IN `_idCliente` INT(11), IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))   UPDATE `clientes` SET `idCliente`=_idCliente,`nombresCliente`=_nombresCliente,`apellidosCliente`=_apellidosCliente,`telefonoCliente`=_telefonoCliente,`cedulaCliente`=_cedulaCliente WHERE idCliente = _idCliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarCostoProducto` (IN `_stockProducto` INT(7), IN `_costoProducto` INT(8), IN `_idProducto` INT)   UPDATE productos SET existenciaProducto = existenciaProducto + _stockProducto, costoProducto = _costoProducto WHERE idProducto = _idProducto$$

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
SELECT DATE_FORMAT(fechaVenta, '%Y-%m-%d') AS Dia,COUNT(encventas.idCliente) as nroFacturas, clientes.nombresCliente
FROM encventas
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY clientes.nombresCliente
ORDER BY nroFacturas DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `clientesFacturasHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
SELECT HOUR(DATE_FORMAT(fechaVenta, '%Y-%m-%d %H:%i:%s')) as hora, COUNT(encventas.idCliente) as nroFacturas, clientes.nombresCliente
FROM encventas
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarCliente` (IN `_nombresCliente` VARCHAR(30), IN `_apellidosCliente` VARCHAR(30), IN `_telefonoCliente` VARCHAR(15), IN `_cedulaCliente` INT(11))   INSERT INTO `clientes`(`nombresCliente`, `apellidosCliente`, `telefonoCliente`, `cedulaCliente`) VALUES (_nombresCliente,_apellidosCliente,_telefonoCliente,_cedulaCliente)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetCompra` (IN `_cantidadCompra` INT(11), IN `_precioUnitario` INT(8), IN `_idCompra` INT(11), IN `_idProducto` INT(11))   INSERT INTO `detcompraproducto`(`cantidadCompra`, `precioUnitario`, `idCompra`, `idProducto`) 
VALUES (_cantidadCompra,_precioUnitario,_idCompra,_idProducto)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetEgreso` (IN `_valorEgreso` INT(8), IN `_descripcion` VARCHAR(100), IN `_idEgreso` INT(11))   INSERT INTO `detalleegreso`(`valorEgreso`, `descripcion`, `idEgreso`) VALUES (_valorEgreso,_descripcion,_idEgreso)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetVenta` (IN `_uniVendidas` INT(8), IN `precioUnit` INT(11), IN `_idVenta` INT(11), IN `idProducto` INT(11))   BEGIN
INSERT INTO `detalleventa` (`uniVendidas`, `precioUnitario`, `idVenta`, `idProducto`) VALUES (_uniVendidas, precioUnit, _idVenta, idProducto); END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarEncCompra` (IN `_idCompra` INT(11), IN `_conceptoCompra` VARCHAR(50), IN `_idProveedor` INT(11), IN `_vrTotalCompra` INT(11), IN `_vrTotalIva` INT(11))   INSERT INTO enccompraproducto(idCompra, conceptoCompra, fechaCompra, idProveedor, vrTotalCompra, vrTotalIva) 
VALUES (_idCompra,_conceptoCompra, now(),_idProveedor,_vrTotalCompra,_vrTotalIva)$$

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
detcompraproducto.idDetCompra, detcompraproducto.cantidadCompra, detcompraproducto.precioUnitario, 
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
        encventas.idVenta = idVenta_; -- Reemplazar el valor constante por el parámetro de entrada
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
SELECT DATE_FORMAT(fechaVenta, '%Y-%m-%d') AS Dia,COUNT(encventas.idCliente) as nroFacturas, clientes.nombresCliente
FROM encventas
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY clientes.nombresCliente
ORDER BY nroFacturas desc limit 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `mejoresClientesFacturasHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
SELECT HOUR(DATE_FORMAT(fechaVenta, '%Y-%m-%d %H:%i:%s')) as hora, COUNT(encventas.idCliente) as nroFacturas, clientes.nombresCliente
FROM encventas
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
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
SELECT DATE_FORMAT(fechaVenta, '%Y-%m-%d') AS Dia,COUNT(encventas.idCliente) as nroFacturas, clientes.nombresCliente
FROM encventas
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
GROUP BY clientes.nombresCliente
ORDER BY nroFacturas ASC limit 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `peoresClientesFacturasHoras` (IN `inicio` VARCHAR(30), IN `fin` VARCHAR(30))   BEGIN
SELECT HOUR(DATE_FORMAT(fechaVenta, '%Y-%m-%d %H:%i:%s')) as hora, COUNT(encventas.idCliente) as nroFacturas, clientes.nombresCliente
FROM encventas
INNER JOIN clientes ON encventas.idCliente = clientes.idCliente
WHERE encventas.fechaVenta >= inicio AND encventas.fechaVenta <= fin
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
('Licorera Elite', '08:00:00', '17:00:00', 'barras');

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
(13, 'gfdgfadga', 'fgfadag', '123213', 123123),
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
(28, 2000000, '...', 12),
(29, 2000, 'destornillador', 13),
(30, 10000, 'sacacorchos', 14),
(31, 15000, 'almuerzo', 15);

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
(21, 16, 3500, 12, 11),
(22, 1, 50000, 14, 1),
(23, 3, 3500, 14, 11),
(24, 1, 55000, 15, 10),
(25, 10, 50000, 16, 12),
(26, 0, 5000, 17, 4),
(27, 1, 50000, 18, 12),
(28, 0, 50000, 1, 12),
(29, 1, 50000, 19, 6),
(30, 1, 36000, 20, 8),
(31, 1, 6000, 21, 7),
(34, 2, 50000, 22, 1),
(35, 1, 42000, 22, 2),
(36, 1, 50000, 23, 1),
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
(49, 1, 3500, 31, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detcompraproducto`
--

CREATE TABLE `detcompraproducto` (
  `idDetCompra` int(11) NOT NULL,
  `cantidadCompra` int(8) NOT NULL,
  `precioUnitario` int(11) NOT NULL,
  `idCompra` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(70, 5, 30000, 8, 9),
(71, 5, 25000, 9, 8),
(72, 10, 2000, 10, 11),
(73, 20, 40000, 10, 6),
(74, 10, 5000, 10, 7),
(75, 20, 40000, 11, 6),
(76, 20, 5000, 12, 7),
(77, 20, 2000, 12, 11),
(78, 15, 30000, 13, 9),
(79, 5, 30000, 13, 2),
(80, 10, 5000, 13, 7),
(81, 15, 25000, 14, 5),
(82, 32, 2000, 14, 11),
(83, 12, 40000, 14, 10),
(84, 12, 25000, 15, 8),
(85, 13, 40000, 16, 12),
(86, 10, 2000, 17, 11),
(87, 12, 5000, 17, 7),
(88, 12, 40000, 18, 12),
(89, 12, 25000, 19, 8),
(90, 12, 40000, 20, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enccompraproducto`
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
-- Volcado de datos para la tabla `enccompraproducto`
--

INSERT INTO `enccompraproducto` (`idCompra`, `conceptoCompra`, `fechaCompra`, `idProveedor`, `vrTotalCompra`, `vrTotalIva`) VALUES
(1, 'Cervezas', '2023-04-15 17:26:14', 15, 110000, 18900),
(2, 'licor fuerte', '2023-04-04 17:27:17', 17, 400000, 84000),
(3, 'Guaro', '2023-03-20 17:28:20', 14, 250000, 52500),
(4, 'Vino', '2023-04-15 17:28:50', 11, 989000, 207690),
(5, 'Cerveza', '2023-03-21 17:29:38', 12, 101000, 10830),
(6, 'Champaña', '2023-03-31 17:30:07', 11, 150000, 31500),
(7, 'Trago fuerte', '2023-03-17 17:31:04', 11, 600000, 126000),
(8, 'Champaña', '2023-04-08 17:32:14', 15, 150000, 31500),
(9, 'aaaa', '2023-04-27 17:24:36', 17, 125000, 0),
(10, 'aaaa', '2023-04-30 16:01:43', 17, 870000, 0),
(11, 'qqq', '2023-04-30 16:03:27', 16, 800000, 0),
(12, '223', '2023-04-30 16:03:45', 12, 140000, 0),
(13, 'wuaaaa', '2023-04-30 21:09:15', 17, 650000, 0),
(14, 'xdxdxd', '2023-04-30 19:09:15', 16, 919000, 0),
(15, 'xdxdxd', '2023-04-30 17:09:15', 14, 300000, 0),
(16, 'wua', '2023-04-30 15:09:15', 11, 520000, 0),
(17, 'jijijija', '2023-05-01 16:55:55', 17, 80000, 0),
(18, 'cunchunfluis', '2023-05-01 15:55:55', 16, 480000, 0),
(19, 'wuaaaa', '2023-05-01 14:55:55', 12, 300000, 0),
(20, 'miau', '2023-05-01 13:55:55', 12, 480000, 0);

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
(12, '2023-04-13 19:28:03', '...', 2000000, 3),
(13, '2023-05-01 15:00:39', 'wya', 2000, 2),
(14, '2023-05-01 15:00:54', 'ajua', 10000, 0),
(15, '2023-05-01 15:01:09', 'xdxdxd', 15000, 0);

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
(19, '2023-04-26 15:46:24', 0, 1, 50000, 13),
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
(31, '2023-05-01 17:10:49', 0, 1, 3500, 4);

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
(9, 'Comprar pilsenones', 'Necesito 3 cajas');

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
(1, 'Vino gato negro', 'Vino Tinto merlot 2020', 42000, 50000, 7, 21),
(2, 'Crema de whiskey', 'Crema dulce', 30000, 42000, 11, 20),
(3, 'Pilsenon litro', 'Cerveza pilsen litro', 3000, 5500, 44, 19),
(4, 'Pilsenon 750', 'Pilsenon 750ml\r\n', 2500, 5000, 0, 18),
(5, 'Media de guaro', 'Media de guaro tapa roja', 25000, 20000, 35, 9),
(6, 'litro de ron caldas', 'Litro de ron caldas', 40000, 50000, 18, 17),
(7, 'Aguilon litro', 'Aguilon litro', 5000, 6000, 38, 16),
(8, 'Vino Vientos del sur', 'Cavernet vientos del sur 750ml', 25000, 36000, 24, 15),
(9, 'Botella de champaña', 'Botella de champaña blanca, espumosa ', 30000, 50000, 32, 14),
(10, 'Botella de gin', 'Botella de ginebra ', 40000, 55000, 24, 13),
(11, 'Aguila lata', 'Lata de aguila negra 330cm3', 2000, 3500, 34, 12),
(12, 'Botella de vodka', 'botella de vodka smirnoff', 40000, 50000, 23, 11);

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
(1, 'licorera elite', 'example@example.com', '123'),
(2, 'Licores elite', 'campuzanomiguel2208@gmail.com', '3f944f9c37e525fdc0e2f9935d5dac22f366d14364777ff8d9c5a0ea33b7b87b');

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
  MODIFY `idDetEgreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `detalleventa`
--
ALTER TABLE `detalleventa`
  MODIFY `idDetVenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de la tabla `detcompraproducto`
--
ALTER TABLE `detcompraproducto`
  MODIFY `idDetCompra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

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
  MODIFY `idNota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
