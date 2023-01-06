<?php 
include "./../../conexion.php";

$sqlTraerTodo = "select * from clientes order by idCliente desc";
//ventas
$clientes = array();
$datos = $connection -> query($sqlTraerTodo);
$clientes['items'] = array();

if($datos -> num_rows > 0){
    while($row = mysqli_fetch_assoc($datos)){
        $item = array(
            'idCliente' => $row['idCliente'],
            'nombresCliente' => $row['nombresCliente'],
            'apellidosCliente' => $row['apellidosCliente'],
            'telefonoCliente' => $row['telefonoCliente'],
            'cedulaCliente' => $row['cedulaCliente']
        );

        array_push($clientes['items'], $item);

    }
    
    echo json_encode($clientes);
} else {
    echo json_encode(array('mensaje' => "No hay clientes registrados"));;
}

?>