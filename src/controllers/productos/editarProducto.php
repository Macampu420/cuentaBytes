<?php 
include "./../../conexion.php";
include "./../../models/productos.php";

$nombreProducto = $_REQUEST['nombreProducto'];
$descripcionProducto = $_REQUEST['descripcionProducto'];
$porcentajeIva = $_REQUEST['porcentajeIva'];
$costoProducto = $_REQUEST['costoProducto'];
$precioVenta = $_REQUEST['precioVenta'];
$stockProducto = $_REQUEST['stockProducto'];
$idImagenVer = registrarImg();

if($idImagenVer == null){
    $idImagen = 9;
}
else{
    $idImagen = $idImagenVer;
}
$idProducto = $_REQUEST['idProducto'];

// $sqlEdit = "CALL actualizarProducto('$nombreProducto', '$descripcionProducto', '$porcentajeIva', $costoProducto, $precioVenta, $stockProducto, 9,  $idProducto)";
$sqlEdit = "CALL actualizarProducto($idProducto, '$nombreProducto','$descripcionProducto',$porcentajeIva,$costoProducto,$precioVenta,$stockProducto,$idImagen)";

// var_dump($precioVenta);

actualizarProducto($sqlEdit, $connection);

?>  