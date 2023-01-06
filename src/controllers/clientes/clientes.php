<?php 
include "./../../conexion.php";
include "./../../models/clientes.php";
//idventa = connection...
$cedulaCliente = $connection -> query("SELECT cedulaCliente from  clientes order by  cedulaCliente desc limit 1");
$cedulaCliente = mysqli_fetch_assoc($cedulaCliente);
$cedulaCliente = $cedulaCliente["cedulaCliente"];

$cedulaCliente = $_REQUEST['cedulaCliente'];
$nombresCliente = $_REQUEST['nombresCliente'];
$apellidosCliente = $_REQUEST['apellidosCliente'];
$telefonoCliente = $_REQUEST['telefonoCliente'];



$sqlReg = "CALL insertarCliente('$nombresCliente','$apellidosCliente','$telefonoCliente',$cedulaCliente)";

registrar($sqlReg, $connection);


?>