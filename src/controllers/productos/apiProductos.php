<?php 
include "./../../conexion.php";

$sqlTraerTodo = "CALL mostrarProductos()";
$productos = array();
$datos = $connection -> query($sqlTraerTodo);
$productos['items'] = array();

if($datos -> num_rows > 0){
    while($row = mysqli_fetch_assoc($datos)){
        $item = array(
            'idProducto' => $row['idProducto'],
            'nombreProducto' => $row['nombreProducto'],
            'descripcionProducto' => $row['descripcionProducto'],
            'porcentajeIva' => $row['porcentajeIva'],
            'costoProducto' => $row['costoProducto'],
            'precioVenta' => $row['precioVenta'],
            'stockProducto' => $row['stockProducto'],
            'idImagen' => $row['idImagen']
        );

        array_push($productos['items'], $item);

    }
    echo json_encode($productos);
} else {
    echo json_encode(array("mensaje" => "No hay productos registrados"));
}

?>