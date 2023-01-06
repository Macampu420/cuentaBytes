<?php 
include "./../conexion.php";
include "./../models/productos.php";

$nombreProducto = $_REQUEST['nombreProducto'];
$descripcionProducto = $_REQUEST['descripcionProducto'];
$costoProducto = $_REQUEST['costoProducto'];
$precioVenta = $_REQUEST['precioVenta'];
$stockProducto = $_REQUEST['stockProducto'];
$idImagen = $_REQUEST['idImagen'];

// var_dump($nombreProducto, $descripcionProducto, $costoProducto, $precioVenta, $stockProducto, $idImagen);

$sqlReg = "INSERT INTO `productos`(`idProducto`, `nombreProducto`, `descripcionProducto`, `porcentajeIva`, `costoProducto`, `precioVenta`, `stockProducto`, `idImagen`)
 VALUES ('','$nombreProducto', '$descripcionProducto', 10, $costoProducto, $precioVenta, $stockProducto, 9);";

registrar($sqlReg, $connection);

?>  