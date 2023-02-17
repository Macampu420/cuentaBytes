<?php 

    function registrar($sqlRegProveedor, $conn){

        $registro = $conn -> query("$sqlRegProveedor");

        if(!$registro){
            echo "error en el registro";
        } else {
            echo "todo melo papa";
        }

        header("Location: http://localhost/cuentabytes/src/views/proveedores.php");
        
    }

    function eliminarProveedor($sqlEliminar, $conn){

        $resEliminar = $conn -> query($sqlEliminar);
    
        if(!$resEliminar){
            echo "ha ocurrido un error al eliminar el proveedor";
        } else {
            echo "El proveedor fue eliminado correctamente";
        }
    }
    
    function listarUnProveedor($sqlListar, $conn){
    
        $proveedor = $conn->query($sqlListar);
    
        return $proveedor;
    
    }
    
    function actualizarProveedor($sqlActualizar, $conn){
    
        $resActualizar = $conn->query($sqlActualizar);
    
        if(!$resActualizar){
            echo "ha ocurrido un error al actualizar el proveedor";
        } else {
            echo "todo melo papa";
        }
    
        header("Location: http://localhost/cuentabytes/src/views/proveedores.php");
    }
?>