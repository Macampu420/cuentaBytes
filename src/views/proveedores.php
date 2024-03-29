<?php
require_once('./../models/InicioSesion.php');

$objInicioSesion = new InicioSesion();
session_start();
error_reporting(0);
$objInicioSesion->verificarSesion($_SESSION['usuario']);

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="./../../public/css/bootstrap.css">
    <link rel="stylesheet" href="./../../public/css/proveedores.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Semi+Condensed:wght@100;300;700;900&family=Questrial&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500&display=swap" rel="stylesheet">
    <title>proveedores</title>
</head>

<body>
    <div class="container-fluid " style="background-color: #E5ECEC">
        <div class="row">

            <!-- navbar  -->
            <div class="col-2 d-none d-xl-block vh-100 py-5 overflow-hidden" style="background-color: #218DA3">
            <?php $parametro = 'linkProveedores'; include 'partials/navbar.php';?>
            </div>

            <!-- contenido principal -->
            <main class="col-12 col-xl-9 mx-auto header pt-lg-4">

                <div class="row">
                    <!-- importacion del header -->
                    <?php include 'partials/header.php' ?>

                </div>

                <!-- titulo y barra de busqueda -->
                <div class="row col-12 mx-auto pt-3">

                    <h2 class="text-center fs-2 mt-5">Proveedores</h2>

                    <input id="buscadorProvee" class="col-12 col-lg-7 mx-auto search__input" type="text" placeholder="Buscar Proveedor">

                </div>

                <!-- btn añadir -->
                <div class="row mt-5 mb-2 text-center">
                    <div class="col-12 col-lg-5 mx-auto">
                        <h3 id="btnAñadirProvee" class="quicksand mx-5"><img src="../../public/img/iconoMas.png" class="mx-2">Añadir</h3><br>
                    </div>
                </div>

                <!-- cartas con todos los proveedores registrados -->
                <div class="col-12 col-lg-7 mx-auto p-4 border border-dark divProvee overflow-scroll">

                    <div id="filaProvee" class="row">
                        <div id="alert" class="d-none alert alert-danger alert-dismissible fade show w-50 mx-auto" role="alert">
                            No se encontraron coincidencias
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>

                    </div>

                </div>

        </div>
        </main>
    </div>

    <?php include './modals/modalRegProvee.php' ?>
    <?php include './partials/notas.php' ?>
    <?php include './modals/modalRegNota.php' ?>
    <?php include './partials/ajustes.php' ?>

    <script src="./../../public/js/bootstrap.js"></script>
    <script src="./../../public/js/proveedores.js"></script>
    <script src="./../../public/js/controladorProveedores.js"></script>
    <script src="./../../public/js/notas/ctrNotas.js"></script>
    <script src="./../../public/js/notas/notas.js"></script>
    <script src="./../../public/js/ajustes/ctrAjustes.js"></script>

</body>

</html>