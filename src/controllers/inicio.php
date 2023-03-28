<?php 
include './../conexion.php';
include './../models/acordeonBalances.php';

$sqlTraerMejoresClientes = "CALL mejoresClientes()";
$sqlTraerProductosMasVendidos = "CALL prodMasVend()";
$sqlTraerProductosMenosVendidos = "CALL prodMenVend()";
$sqlTraerProductosMasRentables = "CALL rentabilidadProductos()";
$sqlTraerMayorEgreso = "CALL mayorEgreso()";
$sqlTraerMenorEgreso = "CALL menorEgreso()";
$sqlTraerProducMayorStock = "CALL prodMasStock()";
$sqlTraerProducMenorStock = "CALL prodMenStock()";

$datosAcordeon = array();
$datosAcordeon["mejoresClientes"] = mejoresClientes($sqlTraerMejoresClientes, $connection);
$datosAcordeon["productosMasVendidos"] = productosMasVendidos($sqlTraerProductosMasVendidos, $connection);
$datosAcordeon["productosMenosVendidos"] = productosMenosVendidos($sqlTraerProductosMenosVendidos, $connection);
$datosAcordeon["productosMasRentables"] = productosMasRentables($sqlTraerProductosMasRentables, $connection);
$datosAcordeon["mayorEgreso"] = mayorEgreso($sqlTraerMayorEgreso, $connection);
$datosAcordeon["menorEgreso"] = menorEgreso($sqlTraerMenorEgreso, $connection);
$datosAcordeon["productosMayorStock"] = productosMayorStock($sqlTraerProductosMayorStock, $connection);
$datosAcordeon["productosMenorStock"] = productosMenorStock($sqlTraerProductosMenorStock, $connection);


echo json_encode($datosAcordeon);

?>  