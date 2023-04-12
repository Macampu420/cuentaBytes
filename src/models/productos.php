
<?php

function registrarImg() {
    if (isset($_FILES['imgProducto'])) {
        $host = 'localhost';
        $user = 'root';
        $pass = '';
        $db = 'cuentabytes';

        $connection = new mysqli($host, $user, $pass, $db);
        $nombreArchivo = $_FILES['imgProducto']['name'];
        $tipo_archivo = $_FILES['imgProducto']['type'];
        $ruta_temporal = $_FILES['imgProducto']['tmp_name'];

        // Obtener la extensión del archivo
        $extension = pathinfo($nombreArchivo, PATHINFO_EXTENSION);

        // Generar un nuevo nombre para la imagen
        $nombreimg = date('YmdHis') . "." . $extension;

        // Verificamos que el archivo sea una imagen
        if ($tipo_archivo == "image/jpeg" || $tipo_archivo == "image/png") {
            $ruta_destino = "./../../../public/img/productos/";

            // Movemos el archivo de su ubicación temporal a la carpeta destino
            move_uploaded_file($ruta_temporal, $ruta_destino.$nombreimg);
            $resultado = mysqli_query($connection, 'call registrarImagen("'.$ruta_destino.'", "'.$nombreimg.'")');

            $resultado = mysqli_query($connection, 'call idUltimaImg()');
            $idUltimaImg = mysqli_fetch_assoc($resultado);

            if($idUltimaImg){
                return $idUltimaImg["idImagen"];
            } else {
                return null;
            }
        }

        $connection -> close();
    }
}

function registrar($sqlRegProduc, $conn) {

    $registro = $conn -> query("$sqlRegProduc");

    if (!$registro) {
        echo "error en el registro";
    } else {
        echo "Registro exitoso";
    }

    header("Location: http://localhost/cuentabytes/src/views/productos.php");

}

function eliminarProducto($sqlEliminar, $conn) {

    $resEliminar = $conn -> query($sqlEliminar);

    if (!$resEliminar) {
        echo "ha ocurrido un error al eliminar el producto";
    } else {
        echo "Producto eliminado correctamente";
    }
}

function listarUnProducto($sqlListar, $conn) {

    $producto = $conn -> query($sqlListar);

    return $producto;

}

function actualizarProducto($sqlActualizar, $conn) {

    $resActualizar = $conn -> query($sqlActualizar);

    if (!$resActualizar) {
        echo "ha ocurrido un error al actualizar el producto";
    } else {
        echo "Producto actualizado correctamente";
    }

    header("Location: http://localhost/cuentabytes/src/views/productos.php");
} 

// <?php 

//     function registrar($sqlRegProduc, $conn){

//         $registro = $conn -> query("$sqlRegProduc");

//         if(!$registro){
//             echo "error en el registro";
//         } else {
//             echo "Registro exitoso";
//         }

//         header("Location: http://localhost/cuentabytes/src/views/productos.php");
        
//     }

//     function eliminarProducto($sqlEliminar, $conn){

//         $resEliminar = $conn -> query($sqlEliminar);
    
//         if(!$resEliminar){
//             echo "ha ocurrido un error al eliminar el producto";
//         } else {
//             echo "Producto eliminado correctamente";
//         }
//     }
    
//     function listarUnProducto($sqlListar, $conn){
    
//         $producto = $conn->query($sqlListar);
    
//         return $producto;
    
//     }
    
//     function actualizarProducto($sqlActualizar, $conn){
    
//         $resActualizar = $conn->query($sqlActualizar);
    
//         if(!$resActualizar){
//             echo "ha ocurrido un error al actualizar el producto";
//         } else {
//             echo "Producto actualizado correctamente";
//         }
    
//         header("Location: http://localhost/cuentabytes/src/views/productos.php");
//     }

// ?>



