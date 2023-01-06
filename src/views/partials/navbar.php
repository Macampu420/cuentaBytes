<div class="contenedor-imagen mb-1">
    <img class="w-100" src="./../../public/img/CuentaBytes.png" alt="" />
</div>
<div class="text-white">
<ul>
    <li ><a href="./balances.php">Inicio</a></li>
    <li><a href="./productos.php">Inventario</a></li>
    <li><a href="./egresos.php">Egresos</a></li>
    <li><a href="./ventas.php">Ventas</a></li>
    <li><a href="#">Compras</a></li>
    <li><a href="./clientes.php">Clientes</a></li>
    <li><a href="./proveedores.php">Proveedores</a></li>
</ul>
</div>
<style>
    *{
    text-decoration: none;
    list-style: none;
}

li{
    font-size: 35px;
    margin-bottom: 10px;
    font-weight: 500;
    width: 80% !important;
    position: relative;
    cursor: pointer;
    border-bottom: solid 2px transparent;
}

a{
    color: #fff;
    text-decoration: none;
}

a:hover{

}

li:hover{
    border-bottom: solid 3px #1CB3D3;
    animation: desplazar-rigth 1s;
    transition: 1s ease;
    transform: translateX(40px);
}

/* @media screen and(min-width: 760px){
    .btnMenuLat{
        display: nonde;
    }
} */
</style>