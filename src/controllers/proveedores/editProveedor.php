<?php 
include "./../../conexion.php";
include "./../../models/proveedor.php";

$nombreProveedor = $_REQUEST['inpNombreProveedor'];
$direccionProveedor = $_REQUEST['inpDireccionProveedor'];
$telefonoProveedor = $_REQUEST['inpTelefonoProveedor'];

$idProveedor = $_REQUEST['idProveedor'];

$sqlEdit = "CALL actualizarProveedor($idProveedor, '$nombreProveedor', '$direccionProveedor', '$telefonoProveedor')";

actualizarProveedor($sqlEdit, $connection);

?>  