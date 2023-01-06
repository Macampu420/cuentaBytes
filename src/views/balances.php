<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="./../../public/css/bootstrap.css">
    <link rel="stylesheet" href="./../../public/css/ventas.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Barlow+Semi+Condensed:wght@100;300;700;900&family=Questrial&display=swap"
        rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500&display=swap" rel="stylesheet">
    <title>Ventas</title>
</head>

<body>
    <div class="container-fluid">
        <div class="row main">

            <!-- navbar  -->
            <div class="col-2 d-none d-xl-block nav vh-100 py-5 overflow-hidden">
                <?php include 'partials/navbar.php'?>
            </div>

            <!-- contenido principal -->
            <main class="col-12 col-xl-9 mx-auto header pt-lg-4">

                <div class="row">
                    <!-- importacion del header -->
                    <?php include 'partials/header.php'?>

                </div>

                <!-- titulo y barra de busqueda -->
                <div class="row col-12 mx-auto pt-3">



                </div>
            </main>
        </div>

        <?php include './modals/modalRegVenta.php' ?>

        <script src="./../../public/js/bootstrap.js"></script>
        <script src="./../../public/js/ventas.js"></script>
        <script src="./../../public/js/controladorVentas.js"></script>
        <script>



        </script>
</body>

</html>