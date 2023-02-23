<?php 

function registrar($sqlRegCl, $conn){

    $registro = $conn -> query("$sqlRegCl");

    if(!$registro){
        echo "error en el registro";
    } else {
        echo "Se registro correctamente";
    }

    
    header("Location: http://localhost/cuentabytes/src/views/clientes.php");
    
}
function eliminarCliente($sqlEliminar, $conn){

    $resEliminar = $conn -> query($sqlEliminar);

    if(!$resEliminar){
        echo "ha ocurrido un error al eliminar el cliente";
    } else {
        echo "Cliente eliminado correctamente";
    }

}

function listarUnCliente($sqlListar, $conn){

    $cliente = $conn->query($sqlListar);

    return $cliente;

}
function actualizarCliente($sqlActualizar, $conn){
    
    $resActualizar = $conn->query($sqlActualizar);

    if(!$resActualizar){
        echo "ha ocurrido un error al actualizar la venta";
    } else {
        echo "todo melo papa";
    }

    header("Location: http://localhost/cuentabytes/src/views/clientes.php");
}

?>