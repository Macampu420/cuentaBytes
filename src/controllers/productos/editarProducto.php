<?php 
include "./../../conexion.php";
include "./../../models/productos.php";

$nombreProducto = $_REQUEST['nombreProducto'];
$descripcionProducto = $_REQUEST['descripcionProducto'];
$porcentajeIva = $_REQUEST['porcentajeIva'];
$costoProducto = $_REQUEST['costoProducto'];
$precioVenta = $_REQUEST['precioVenta'];
$stockProducto = $_REQUEST['stockProducto'];
$idImagen = $_REQUEST['idImagen'];
$idImagen = '9';

$idProducto = $_REQUEST['idProducto'];

// $sqlEdit = "CALL actualizarProducto('$nombreProducto', '$descripcionProducto', '$porcentajeIva', $costoProducto, $precioVenta, $stockProducto, 9,  $idProducto)";
$sqlEdit = "CALL actualizarProducto($idProducto, '$nombreProducto','$descripcionProducto',$porcentajeIva,$costoProducto,$precioVenta,$stockProducto, 9)";

// var_dump($precioVenta);

actualizarProducto($sqlEdit, $connection);

?>  