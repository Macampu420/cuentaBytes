<?php 

function registrar($sqlRegCl, $conn){

    $registro = $conn -> query("$sqlRegCl");

    if(!$registro){
        echo "<script> alert('ha ocurrido un error al crear el cliente ')</script>";
    } else {
        echo "<script> alert('se ha registrado correctamente')</script>";
        echo "<script> window.location.href='http://localhost/cuentabytes/src/views/clientes.php';</script>";
    }
}

function eliminarCliente($sqlEliminar, $conn){

    try{
        $resEliminar = $conn -> query($sqlEliminar);

        // verificar si hay errores
        if (!$resEliminar) {
            echo "<script> alert('ha ocurrido un error al eliminar el cliente ')</script>";
        }
        else {
            echo "se ha eliminado correctamente";
        }
    } catch (mysqli_sql_exception $err) {
    
        if($err->getCode() == 1451){
            echo "No se puede eliminar el cliente debido a que está asociado a una o mas facturas.";
        }
    }

}

function listarUnCliente($sqlListar, $conn){

    $cliente = $conn->query($sqlListar);

    return $cliente;

}
function actualizarCliente($sqlActualizar, $conn){
    
    $resActualizar = $conn->query($sqlActualizar);

    if(!$resActualizar){
        echo "<script> alert('ha ocurrido un error al actualizar el cliente ')</script>";
    } else {
        echo "<script> alert('se ha actualizado correctamente')</script>";
        echo "<script> window.location.href='http://localhost/cuentabytes/src/views/clientes.php';</script>";
    }

}

?>