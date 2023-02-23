<?php 
include "./../../conexion.php";
include "./../../models/productos.php";

$idProducto = $_REQUEST['idProducto'];

$sqlElim = "CALL eliminarProducto($idProducto)";

eliminarProducto($sqlElim, $connection);


?>  