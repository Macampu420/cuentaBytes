<?php 
include "./../../conexion.php";
include "./../../models/clientes.php";

$idCliente = $_REQUEST['idCliente'];

$sqlElim = "CALL eliminarCliente($idCliente)";

eliminarCliente($sqlElim, $connection);


?>  