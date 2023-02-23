<?php 

    function registrar($sqlRegProduc, $conn){

        $registro = $conn -> query("$sqlRegProduc");

        if(!$registro){
            echo "error en el registro";
        } else {
            echo "Registro exitoso";
        }

        header("Location: http://localhost/cuentabytes/src/views/productos.php");
        
    }

    function eliminarProducto($sqlEliminar, $conn){

        $resEliminar = $conn -> query($sqlEliminar);
    
        if(!$resEliminar){
            echo "ha ocurrido un error al eliminar el producto";
        } else {
            echo "Producto eliminado correctamente";
        }
    }
    
    function listarUnProducto($sqlListar, $conn){
    
        $producto = $conn->query($sqlListar);
    
        return $producto;
    
    }
    
    function actualizarProducto($sqlActualizar, $conn){
    
        $resActualizar = $conn->query($sqlActualizar);
    
        if(!$resActualizar){
            echo "ha ocurrido un error al actualizar el producto";
        } else {
            echo "Producto actualizado correctamente";
        }
    
        header("Location: http://localhost/cuentabytes/src/views/productos.php");
    }
?>