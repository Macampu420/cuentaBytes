<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>

    <form method="post" action="verConsultas.php">
        <input type="submit" name="A" value="Cliente Mas Frecuente">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="B" value="Cliente Mas Gasto">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="C" value="Producto Mas Rentable">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="D" value="Producto Mas Vendido">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="E" value="Producto Menos Vendido">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="F" value="Producto Que Mas Genera">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="G" value="Producto Menos Stock">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="H" value="Mayores Ventas">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="I" value="Ventas Totales">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="J" value="Compras Totales">
    </form>
    <form method="post" action="verConsultas.php">
        <input type="submit" name="K" value="Factura">
    </form>

    <?php
    include "consultas.php";

    if (isset($_POST['A'])) {
        ClienteMasFrecuente();
    } else if (isset($_POST['B'])) {
        ClienteMasGasto();
    } else if (isset($_POST['C'])) {
        ProductoMasRentable();
    } else if (isset($_POST['D'])) {
        ProductoMasVendido();
    } else if (isset($_POST['E'])) {
        ProductoMenosVendido();
    } else if (isset($_POST['F'])) {
        ProductoMasGenera();
    } else if (isset($_POST['G'])) {
        ProductoMenosStock();
    } else if (isset($_POST['H'])) {
        MayoresVentas();
    } else if (isset($_POST['I'])) {
        TotalVenta();
    } else if (isset($_POST['J'])) {
        TotalCompra();
    } else if (isset($_POST['K'])) {
        FacturaVenta();
    }


    ?>
</body>

</html>