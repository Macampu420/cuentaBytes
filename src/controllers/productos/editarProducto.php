<?php 
include "./../../conexion.php";
include "./../../models/productos.php";

//declaracion de variables que vienen desde el formulario
$nombreProducto = $_REQUEST['nombreProducto'];
$descripcionProducto = $_REQUEST['descripcionProducto'];
$costoProducto = $_REQUEST['costoProducto'];
$precioVenta = $_REQUEST['precioVenta'];
$existenciaProducto = $_REQUEST['existenciaProducto'];
$idImagen = registrarImg();
$idProducto = $_REQUEST['idProducto'];

//sql a ejecutar
$sqlEdit = "CALL actualizarProducto($idProducto, '$nombreProducto','$descripcionProducto',$costoProducto,$precioVenta,$existenciaProducto,9)";

//se ejecuta el metodo que actualiza el producto
actualizarProducto($sqlEdit, $connection);

?>  