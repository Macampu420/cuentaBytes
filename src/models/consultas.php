<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td,
        th {
            border: 1px solid black;
            text-align: left;
            padding: 8px;
        }
                 
        tr:nth-child(1) {
            background-color: #A5C9CA;
        }
    </style>
</head>

<body>
    <?php

    function ClienteMasFrecuente()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Frecuencia</th>
                <th>Nombres</th>
            </tr>

            <?php

            $query = "SELECT COUNT(encventas.idCliente) AS frecuencia, clientes.nombresCliente AS Nombres FROM encventas 
        INNER JOIN clientes ON clientes.idCliente = encventas.idCliente
        GROUP BY encventas.idCliente ORDER BY frecuencia DESC";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["frecuencia"]; ?></td>
                    <td> <?php echo $fila["Nombres"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }

    function ClienteMasGasto()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Gastado</th>
                <th>Nombres</th>
                <th>Apellidos</th>
            </tr>

            <?php

            $query = "SELECT SUM(uniVendidas * precioVenta) AS Gastado, vta_ventas.nombresCliente AS Nombres, clientes.apellidosCliente AS Apellidos
            FROM vta_ventas
            INNER JOIN clientes ON vta_ventas.idCliente = clientes.idCliente
            GROUP BY vta_ventas.idCliente ORDER BY Gastado DESC;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["Gastado"]; ?></td>
                    <td> <?php echo $fila["Nombres"]; ?></td>
                    <td> <?php echo $fila["Apellidos"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }

    function ProductoMasRentable()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Nombre Producto</th>
                <th>Rentabilidad</th>
            </tr>

            <?php

            $query = "SELECT productos.nombreProducto, 
            MAX((productos.precioVenta- productos.costoProducto)/productos.costoProducto)*100 AS Rentabilidad 
            FROM productos WHERE idEmpresa = 1
            GROUP BY productos.nombreProducto ORDER BY Rentabilidad DESC;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["nombreProducto"]; ?></td>
                    <td> <?php echo $fila["Rentabilidad"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }
    function ProductoMasVendido()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Unidades Vendidas</th>
                <th>Producto Top</th>
            </tr>

            <?php

            $query = "SELECT MAX(uniVendidas)AS UnidadesVendidas, 
            nombreProducto AS ProductoTop 
            FROM vta_ventas 
            GROUP BY idProducto ORDER BY uniVendidas DESC;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["UnidadesVendidas"]; ?></td>
                    <td> <?php echo $fila["ProductoTop"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }
    function ProductoMenosVendido()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Unidades Vendidas</th>
                <th>Producto Top</th>
            </tr>

            <?php

            $query = "SELECT MAX(uniVendidas)AS UnidadesVendidas, 
            nombreProducto AS ProductoTop 
            FROM vta_ventas 
            GROUP BY idProducto ORDER BY uniVendidas;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["UnidadesVendidas"]; ?></td>
                    <td> <?php echo $fila["ProductoTop"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }
    function ProductoMasGenera()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Generado</th>
                <th>Producto</th>
            </tr>

            <?php

            $query = "SELECT SUM(uniVendidas * precioVenta) AS Generado,
            nombreProducto AS Producto 
            FROM vta_ventas 
            GROUP BY idProducto ORDER BY Generado DESC;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["Generado"]; ?></td>
                    <td> <?php echo $fila["Producto"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }
    function ProductoMenosStock()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Stock</th>
                <th>Producto</th>
            </tr>

            <?php

            $query = "SELECT MIN(stockProducto) AS Stock, 
            nombreProducto AS Producto 
            FROM productos 
            WHERE idEmpresa = 1
            GROUP BY idProducto ORDER BY Stock;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["Stock"]; ?></td>
                    <td> <?php echo $fila["Producto"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }
    function MayoresVentas()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Valor</th>
                <th>Producto</th>
                <th>Fecha</th>
                <th>Cedula</th>
                <th>Nombres</th>
                <th>Apellidos</th>
            </tr>

            <?php

            $query = "SELECT SUM(uniVendidas * precioVenta) AS ValorCompra, 
            tituloVenta AS Titulo, vta_ventas.fechaVenta AS Fecha, vta_ventas.idCliente AS Cedula, vta_ventas.nombresCliente AS Nombres, clientes.apellidosCliente AS Apellidos
            FROM vta_ventas 
            INNER JOIN encventas ON encventas.idVenta = vta_ventas.idVenta 
            INNER JOIN clientes ON vta_ventas.idCliente = clientes.idCliente
            GROUP BY encventas.tituloVenta ORDER BY ValorCompra DESC;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["ValorCompra"]; ?></td>
                    <td> <?php echo $fila["Titulo"]; ?></td>
                    <td> <?php echo $fila["Fecha"]; ?></td>
                    <td> <?php echo $fila["Cedula"]; ?></td>
                    <td> <?php echo $fila["Nombres"]; ?></td>
                    <td> <?php echo $fila["Apellidos"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }

    function TotalVenta()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Ventas</th>
                <th>Nombre Empresa</th>
            </tr>

            <?php

            $query = "SELECT SUM(uniVendidas * precioVenta) AS Ventas, nombreEmpresa As NombreEmpresa
            FROM vta_ventas
            GROUP BY nombreEmpresa ORDER BY Ventas DESC;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["Ventas"]; ?></td>
                    <td> <?php echo $fila["NombreEmpresa"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }
    function TotalCompra()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th>Compras</th>
                <th>Nombre Empresa</th>
            </tr>

            <?php

            $query = "SELECT SUM(detcompraproducto.cantidadCompra * detcompraproducto.precioUnitario) AS Compras, regempresa.nombreEmpresa
            FROM detcompraproducto
            INNER JOIN enccompraproducto ON detcompraproducto.idCompra = enccompraproducto.idCompra
            INNER JOIN regempresa ON enccompraproducto.idEmpresa = regempresa.idEmpresa
            GROUP BY regempresa.nombreEmpresa ORDER BY Compras DESC;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["Compras"]; ?></td>
                    <td> <?php echo $fila["nombreEmpresa"]; ?></td>
                </tr>
            <?php
            }
            ?>
        </table>
    <?php
    }
    function FacturaVenta()
    {
        include "conexion.php";

    ?>
        <table>
            <tr>
                <th style="text-align: center;">ID Factura</th>
                <th style="text-align: center;">Factura</th>
                <th style="text-align: center;">Fecha Ventas</th>
                <th style="text-align: center;">Metodo Pago</th>
                <th style="text-align: center;">Descuento</th>
                <th style="text-align: center;">Apellido Cliente</th>
                <th style="text-align: center;">Nombre Cliente</th>
            </tr>

            <?php

            $query = "SELECT encventas.idVenta,encventas.tituloVenta ,vta_ventas.fechaVenta, encventas.metodoPagoVenta, encventas.descuentoVenta,
            clientes.nombresCliente, clientes.apellidosCliente
            FROM vta_ventas
            INNER JOIN encventas ON encventas.idVenta = vta_ventas.idVenta
            INNER JOIN clientes ON clientes.idCliente = vta_ventas.idCliente
            WHERE encventas.idVenta = 1
            GROUP BY vta_ventas.idVenta;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td> <?php echo $fila["idVenta"]; ?></td>
                    <td> <?php echo $fila["tituloVenta"]; ?></td>
                    <td> <?php echo $fila["fechaVenta"]; ?></td>
                    <td> <?php echo $fila["metodoPagoVenta"]; ?></td>
                    <td> <?php echo $fila["descuentoVenta"]; ?></td>
                    <td> <?php echo $fila["nombresCliente"]; ?></td>
                    <td> <?php echo $fila["apellidosCliente"]; ?></td>

                </tr>
                
            <tr>
                <th style="text-align: center;" colspan="2" >Producto</th>
                <th style="text-align: center;" colspan="1">Unidades Vendidas</th>
                <th style="text-align: center;" colspan="2">Precio Unitario</th>
                <th style="text-align: center;" colspan="2">Precio Total Producto</th>
            </tr>

            <?php

            $query = "SELECT nombreProducto, uniVendidas, precioVenta, 
            SUM(uniVendidas * precioVenta)AS Total
            FROM vta_ventas
            WHERE idVenta = 1
            GROUP BY nombreProducto;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                <tr>
                    <td colspan="2"> <?php echo $fila["nombreProducto"]; ?></td>
                    <td colspan="1"> <?php echo $fila["uniVendidas"]; ?></td>
                    <td colspan="2"> <?php echo $fila["precioVenta"]; ?></td>
                    <td colspan="2"> <?php echo $fila["Total"]; ?></td>
                </tr>
            <?php
            }
            ?>
             <tr>
                <th colspan="5">Total Pago</th>
            

            <?php

            $query = "SELECT SUM(vta_ventas.uniVendidas * vta_ventas.precioVenta)- encventas.descuentoVenta AS Ventas 
            FROM vta_ventas        
            INNER JOIN encventas ON encventas.idVenta = vta_ventas.idVenta
            WHERE vta_ventas.idVenta = 1
            GROUP BY vta_ventas.idVenta ORDER BY Ventas DESC;";

            $connection->query($query);
            $consulta = mysqli_query($connection, $query);

            while ($fila = mysqli_fetch_array($consulta)) {
            ?>

                
                    <td colspan="2"> <?php echo $fila["Ventas"]; ?></td>
                </tr>
            <?php
            }
            ?>

        </table>

            <?php
            }
            ?>
        </table>
    <?php
    }
    ?>
</body>

</html>