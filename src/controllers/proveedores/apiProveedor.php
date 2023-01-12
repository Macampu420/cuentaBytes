<?php 
include "./../../conexion.php";

$sqlTraerTodo = "CALL listarProveedores";
$proveedores = array();
$datos = $connection -> query($sqlTraerTodo);
$proveedores['items'] = array();

if($datos -> num_rows > 0){
    while($row = mysqli_fetch_assoc($datos)){
        $item = array(
            'idProveedor' => $row['idProveedor'],
            'nombreProveedor' => $row['nombreProveedor'],
            'direccionProveedor' => $row['direccionProveedor'],
            'telefonoProveedor' => $row['telefonoProveedor']
        );

        array_push($proveedores['items'], $item);

    }
    
    echo json_encode($proveedores);
} else {
    echo "No hay proveedores registradas";
}

?>