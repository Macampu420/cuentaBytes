<?php 
include "./../../conexion.php";
include "./../../models/proveedor.php";

$idProveedor = $_REQUEST['idProveedor'];

$sqlListarProveedor = "SELECT * FROM proveedor WHERE idProveedor = '$idProveedor'";

$datos = listarUnProveedor($sqlListarProveedor, $connection);
$proveedor = array();
$proveedor['items'] = array();

if($datos -> num_rows > 0){
    while($row = mysqli_fetch_assoc($datos)){
        $item = array(
            'idProveedor' => $row['idProveedor'],
            'nombreProveedor' => $row['nombreProveedor'],
            'direccionProveedor' => $row['direccionProveedor'],
            'telefonoProveedor' => $row['telefonoProveedor']
        );

        array_push($proveedor['items'], $item);

    }
    
    echo json_encode($proveedor);
} else {
    echo "No hay proveedores registrados";
}


?>  