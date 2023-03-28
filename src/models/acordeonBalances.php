<?php 

function mejoresClientes($sql, $conn){
    
    $clientes = array();
    $auxClientes = $conn -> query($sql);

    if($auxClientes -> num_rows > 0){
        while($row = mysqli_fetch_assoc($auxClientes)){
            $cliente = array(
                'nroFacturas' => $row['nroFacturas'],
                'nombresCliente' => $row['nombresCliente'],
            );
    
            array_push($clientes, $cliente);
    
        }

        if ($auxClientes) {
            mysqli_free_result($auxClientes);
        }
        
        return json_encode($clientes);
    } else {
        return json_encode(array("mensaje" => "No hay productos registrados"));
        }

}

        
function productosMasVendidos($sql, $conn){
            $productos = array();
            $auxProductos = $conn -> query($sql);
        
            if($auxProductos -> num_rows > 0){
                while($row = mysqli_fetch_assoc($auxProductos)){
                    $producto = array(
                        'nombreProducto' => $row['nombreProducto'],
                    );
            
                    array_push($productos, $producto);
            
                }
                return json_encode($productos);
            } else {
                return json_encode(array("mensaje" => "No hay productos registrados"));
            }
}


function productosMenosVendidos($sql, $conn){
    $productos = array();
    $auxProductos = $conn -> query($sql);

    if($auxProductos -> num_rows > 0){
        while($row = mysqli_fetch_assoc($auxProductos)){
            $producto = array(
                'nombreProducto' => $row['nombreProducto'],
            );
    
            array_push($productos, $producto);
    
        }
        return json_encode($productos);
    } else {
        return json_encode(array("mensaje" => "No hay productos registrados"));
    }
    }

function productosMasRentables($sql, $conn){
$productos = array();
$auxProductos = $conn -> query($sql);

if($auxProductos -> num_rows > 0){
    while($row = mysqli_fetch_assoc($auxProductos)){
        $producto = array(
            'nombreProducto' => $row['nombreProducto'],
        );

        array_push($productos, $producto);

    }
    return json_encode($productos);
} else {
    return json_encode(array("mensaje" => "No hay productos registrados"));
}
}

function mayorEgreso($sql, $conn){
$egresos = array();
$auxEgresos = $conn -> query($sql);

if($auxEgresos -> num_rows > 0){
    while($row = mysqli_fetch_assoc($auxEgresos)){
        $egreso = array(
            'tituloEgreso' => $row['tituloEgreso'],
            'vrTotalEgreso' => $row['vrTotalEgreso'],
        );

        array_push($egresos, $egreso);

    }
    return json_encode($egresos);
} else {
    return json_encode(array("mensaje" => "No hay egresos registrados"));
}

}

function menorEgreso($sql, $conn){
    $egresos = array();
    $auxEgresos = $conn -> query($sql);
    
    if($auxEgresos -> num_rows > 0){
        while($row = mysqli_fetch_assoc($auxEgresos)){
            $egreso = array(
                'descripcion' => $row['descripcion'],
                'mayorValor' => $row['mayorValor'],
            );
    
            array_push($egresos, $egreso);
    
        }
        return json_encode($egresos);
    } else {
        return json_encode(array("mensaje" => "No hay egresos registrados"));
    }
    
    }

    function productoMayorStock($sql, $conn){
        $productos = array();
        $auxProductos = $conn -> query($sql);
        
        if($auxProductos -> num_rows > 0){
            while($row = mysqli_fetch_assoc($auxProductos)){
                $producto = array(
                    'stockMayor' => $row['stockMayor'],
                    'nombreProducto' => $row['nombreProducto'],
                );
        
                array_push($productos, $producto);
        
            }
            return json_encode($productos);
        } else {
            return json_encode(array("mensaje" => "No hay egresos registrados"));
        }
        
        }

?>