<?php 
include "./../../conexion.php";
include "./../../models/proveedor.php";

$idProveedor = $connection -> query("SELECT idProveedor from proveedor order by idProveedor desc limit 1");
$idProveedor = mysqli_fetch_assoc($idProveedor);
$idProveedor = $idProveedor["idProveedor"];

$nombreProveedor = $_REQUEST['inpNombreProveedor'];
$direccionProveedor = $_REQUEST['inpDireccionProveedor'];
$telefonoProveedor = $_REQUEST['inpTelefonoProveedor'];

$sqlReg = "INSERT INTO `proveedor`(`idProveedor`, `nombreProveedor`, `direccionProveedor`, `telefonoProveedor`) VALUES ('', '$nombreProveedor', '$direccionProveedor', '$telefonoProveedor')";

registrar($sqlReg, $connection);


?>  