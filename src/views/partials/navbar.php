<div class="contenedor-imagen mb-1">
    <img class="w-100" src="./../../public/img/CuentaBytes.png" alt="" />
</div>
<div class="text-white">
<ul>
    <li class="nav-li"><a class="nav-link" href="./balances.php">Inicio</a></li>
    <li class="nav-li"><a class="nav-link" href="./productos.php">Inventario</a></li>
    <li class="nav-li"><a class="nav-link" href="./egresos.php">Egresos</a></li>
    <li class="nav-li"><a class="nav-link" href="./ventas.php">Ventas</a></li>
    <li class="nav-li"><a class="nav-link" href="./compras.php">Compras</a></li>
    <li class="nav-li"><a class="nav-link" href="./clientes.php">Clientes</a></li>
    <li class="nav-li"><a class="nav-link" href="./proveedores.php">Proveedores</a></li>
</ul>
</div>
<style>
    *{
    text-decoration: none;
    list-style: none;
}

.nav{
    background: #218DA3;
}

.nav-li{
    font-size: 35px;
    margin-bottom: 10px;
    font-weight: 500;
    width: 80% !important;
    position: relative;
    cursor: pointer;
    border-bottom: solid 2px transparent;
}

.nav-link{
    color: #fff;
    text-decoration: none;
    margin: 0;
    padding: 0 !important;
}

.nav-link:hover{
    color: #fff !important;
}

.nav-li:hover{
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