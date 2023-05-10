<?php 
include "./../../conexion.php";
include "./../../models/productos.php";

$idProducto = $_REQUEST['idProducto']; 

$sqlListarProducto = "SELECT * FROM productos WHERE idProducto = '$idProducto'";

$datos = listarUnProducto($sqlListarProducto, $connection);
$producto = array();
$producto['items'] = array();

if($datos -> num_rows > 0){
    while($row = mysqli_fetch_assoc($datos)){
        $item = array(
            'idProducto' => $row['idProducto'],
            'nombreProducto' => $row['nombreProducto'],
            'descripcionProducto' => $row['descripcionProducto'],
            'costoProducto' => $row['costoProducto'],
            'precioVenta' => $row['precioVenta'],
            'existenciaProducto' => $row['existenciaProducto'],
            'idImagen' => $row['idImagen']
        );

        array_push($producto['items'], $item);

    }
    
    echo json_encode($producto);
} else {
    echo "No hay productos registrados";
}


?>  