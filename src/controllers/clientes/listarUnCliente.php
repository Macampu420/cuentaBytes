<?php 
include "./../../conexion.php";
include "./../../models/clientes.php";

$idCliente = $_REQUEST['idCliente'];

$sqlListarCliente = "SELECT * FROM clientes WHERE idCliente = '$idCliente'";

$datos = listarUnCliente($sqlListarCliente, $connection);
$Cliente = array();
$Cliente['items'] = array();

if($datos -> num_rows > 0){
    while($row = mysqli_fetch_assoc($datos)){
        $item = array(
            'idCliente' => $row['idCliente'],
            'nombresCliente' => $row['nombresCliente'],
            'apellidosCliente' => $row['apellidosCliente'],
            'telefonoCliente' => $row['telefonoCliente'],
            'cedulaCliente' => $row['cedulaCliente']
        );

        array_push($Cliente['items'], $item);

    }
    
    echo json_encode($Cliente);
} else {
    echo "No hay Clientes registrados";
}


?>  