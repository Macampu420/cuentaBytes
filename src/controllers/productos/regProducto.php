<?php 
include "./../../conexion.php";
include "./../../models/productos.php";

$nombreProducto = $_REQUEST['nombreProducto'];
$descripcionProducto = $_REQUEST['descripcionProducto'];
$costoProducto = $_REQUEST['costoProducto'];
$precioVenta = $_REQUEST['precioVenta'];
$existenciaProducto = $_REQUEST['existenciaProducto'];
$idImagenVer = registrarImg();

if($idImagenVer == null){
    $idImagen = 9;
}
else{
    $idImagen = $idImagenVer;
}

var_dump($idImagen); 

$sqlReg = "CALL insertarProducto('$nombreProducto','$descripcionProducto',$costoProducto,$precioVenta,$existenciaProducto,$idImagen)";

registrar($sqlReg, $connection);


?>