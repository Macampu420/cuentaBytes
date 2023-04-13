<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="./../../public/css/bootstrap.css">
    <link rel="stylesheet" href="./../../public/css/ventas.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Semi+Condensed:wght@100;300;700;900&family=Questrial&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500&display=swap" rel="stylesheet">
    <title>clientes</title>
</head>

<body>
    <div class="container-fluid">
        <div class="row">

            <!-- navbar  -->
            <div class="col-2 d-none d-xl-block nav vh-100 py-5 overflow-hidden">
                <?php include 'partials/navbar.php' ?>
            </div>

            <!-- contenido principal -->
            <main class="col-12 col-xl-9 mx-auto header pt-lg-4">

                <div class="row">
                    <!-- importacion del header -->
                    <?php include 'partials/header.php' ?>

                </div>

                <!-- titulo y barra de busqueda -->
                <div class="row col-12 mx-auto pt-3">

                    <h2 class="text-center fs-2 mt-5">Clientes</h2>

                    <input id="buscadorClientes" class="col-12 col-lg-7 mx-auto search__input" type="text" placeholder="Buscar Cliente">                  
                   
                </div>
                


<<<<<<< HEAD
                <!-- btn añadir item y cartas con las ventas -->
=======
                <!-- btn añadir item y cartas con cliente -->
>>>>>>> Jota
                <div class="row col-12 mx-auto pt-5">

                    <!-- btn añadir -->
                    <div class="row mt-5 mb-2 text-center">
                        <div class="col-12 col-lg-5 mx-auto">
                            <h3 id="btnAnadirVta" class="quicksand mx-5"><img src="../../public/img/iconoMas.png" class="mx-2">Añadir</h3>
                        </div>
                    </div>

<<<<<<< HEAD
                    <!-- cartas con todas las ventas registradas -->
=======
                    <!-- cartas con todas los clientes registradas -->
>>>>>>> Jota
                    <div class="col-12 col-lg-7 mx-auto p-3 border border-dark divVtas overflow-scroll">

                        <div id="filaClientes" class="row">
                            
                        <div id="alert" class="d-none alert alert-danger alert-dismissible fade show w-50 mx-auto" role="alert">
                            No se encontraron coincidencias
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>

                        </div>

                    </div>

                </div>
            </main>
        </div>

        <?php include './modals/modalRegClientes.php' ?>

        <script src="./../../public/js/bootstrap.js"></script>
        <script src="https://unpkg.com/jspdf-invoice-template@1.4.0/dist/index.js"></script>
        <script src="./../../public/js/clientes.js"></script>
        <script src="./../../public/js/controladorClientes.js"></script>
</body>

</html>