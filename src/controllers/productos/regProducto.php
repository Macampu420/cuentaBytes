<?php 
include "./../../conexion.php";
include "./../../models/productos.php";

$idProducto = $connection -> query("SELECT idProducto from productos order by idProducto desc limit 1");

// $idProducto = mysqli_fetch_assoc($idProducto);
// $idProducto = $idProducto["idProducto"];

$nombreProducto = $_REQUEST['nombreProducto'];
$descripcionProducto = $_REQUEST['descripcionProducto'];
$porcentajeIva = $_REQUEST['porcentajeIva'];
$costoProducto = $_REQUEST['costoProducto'];
$precioVenta = $_REQUEST['precioVenta'];
$stockProducto = $_REQUEST['stockProducto'];

$idImagen = registrarImg();

var_dump($idImagen); 

$sqlReg = "CALL insertarProducto('$nombreProducto','$descripcionProducto',$porcentajeIva,$costoProducto,$precioVenta,$stockProducto,$idImagen)";

$idImagen = $_REQUEST['idImagen'];
$idImagen = '9';
// $idImagen = addslashes(file_get_contents($_FILES['idImagen']['tmp_name']));

// $query = "INSERT INTO imagen(rutaImagen, nombreImagen) VALUES ('$idImagen', '$idImagen')"; 
// $resultado = $connection->query($query);


// $idProducto++;

// $sqlReg = "INSERT INTO `productos`(`idProducto`, `nombreProducto`, `descripcionProducto`, `porcentajeIva`, `costoProducto`, `precioVenta`, `stockProducto`, `imagen`) VALUES ($idProducto, '$nombreProducto', '$descripcionProducto', '$porcentajeIva', $costoProducto, $precioVenta, $stockProducto, $idImagen)";
$sqlReg = "CALL insertarProducto('$nombreProducto','$descripcionProducto',$porcentajeIva,$costoProducto,$precioVenta,$stockProducto,$idImagen)";

registrar($sqlReg, $connection);


?>