<?php 
include "./../../conexion.php";
include "./../../models/proveedor.php";

$idProveedor = $_REQUEST['idProveedor'];

$sqlElim = "CALL eliminarProvee($idProveedor)";

eliminarProveedor($sqlElim, $connection);

?>  