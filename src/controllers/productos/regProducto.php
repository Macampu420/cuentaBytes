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

var_dump($idImagen); 

$sqlReg = "CALL insertarProducto('$nombreProducto','$descripcionProducto',$porcentajeIva,$costoProducto,$precioVenta,$stockProducto,$idImagen)";

registrar($sqlReg, $connection);


?>