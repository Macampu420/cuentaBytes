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
    <link rel="stylesheet" href="./../../public/css/compras.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <link
        href="https://fonts.googleapis.com/css2?family=Barlow+Semi+Condensed:wght@100;300;700;900&family=Questrial&display=swap"
        rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500&display=swap" rel="stylesheet">
    <title id="pageTitle">Inicio</title>
    <style>
        .containerA{
            display: flex;
            justify-content: right !important;
        }
        .nav {
            position: fixed;
            z-index: 56;
            height: 100vh;
            
            left: 0;
        }

    </style>
</head>
<body>
<div class="container-fluid vh-100 overflow-auto" style="background-color: #E5ECEC">
    <div class="row containerA">

        <!-- navbar  -->
        <div class="col-2 d-none d-xl-block nav aside py-5 overflow-hidden">
        <?php $parametro = 'linkInicio'; include 'partials/navbar.php';?>
        </div>

        <!-- contenido principal -->
        <main class="col-12 col-xl-10 px-lg-5 header pt-lg-4">
            
            <!-- importacion del header -->
            <div class="row">
                <?php include 'partials/header.php'?>
            </div>

            <!-- titulo y barra de busqueda -->
            <div class="row col-12 mx-0 mx-lg-auto pt-3">


                <div class="col-12 col-lg-10 row mx-auto d-none">
                    <canvas class="col-11 px-auto mb-3" id="myChart"></canvas>
                        <div id="reportrange"
                        class="btn btn-secondary col-10 col-lg-4 mx-auto my-3 fs-4 fs-lg-3 text-white text-center ">
                        <span class="rounded" id="spanFechaGrafico">Generar Estado PyG desde:</span> <i
                            class="fa fa-caret-down"></i>
                    </div>

                    <button class="btn btn-secondary col-10 col-lg-3 mx-auto my-3 fs-2 fs-lg-3">Generar PDF</button>

                </div>


                <div class="row">

                    <div class="col-12 col-lg-10 accordion mx-auto mb-5" id="acordeonBalances">

                    </div>

                </div>

        </main>
    </div>

        <?php include './partials/notas.php' ?>
        <?php include './partials/ajustes.php' ?>
        <?php include './modals/modalRegNota.php' ?>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <script src="./../../public/js/popper.js"></script>
        <script src="./../../public/js/bootstrap.js"></script>
        <script src="./../../public/js/notas/notas.js"></script>
        <script src="./../../public/js/notas/ctrNotas.js"></script>
        <script src="./../../public/js/ajustes/ctrAjustes.js"></script>
        <script type="module" src="./../../public/js/graficos/controladorGraficos.js"></script>
</body>

</html>