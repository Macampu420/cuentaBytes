<?php 
include "./../../conexion.php";
include "./../../models/clientes.php";

$cedulaCliente = $_REQUEST['cedulaCliente'];
$nombresCliente = $_REQUEST['nombresCliente'];
$apellidosCliente = $_REQUEST['apellidosCliente'];
$telefonoCliente = $_REQUEST['telefonoCliente'];
$idCliente=$_REQUEST["idCliente"];

$sqlEdit = "CALL actualizarCliente($idCliente,'$nombresCliente','$apellidosCliente','$telefonoCliente',$cedulaCliente)";

actualizarCliente($sqlEdit, $connection);

?>  