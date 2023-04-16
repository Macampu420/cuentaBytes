<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio Sesión</title>
    <link rel="stylesheet" href="./../../public/css/registro.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>

<body>
    <div class="logo">
        <center><img src="./../../public/img/CuentaBytes.png" class="img" alt="" width="400px"></center>
        <h1 class="h1">Bienvenidos</h1>
    </div>
    <div class="center my-5">
        <h2 class="titRegistro">Inicio de Sesión</h2>
        <form action="./../views/modals/codigo.html" method="GET" id="inicioSesion">
            <div class="txt_field">
                <input type="email" type="text" name="email" id="email" maxlength="40" required>
                <span></span>
                <label>Correo</label>
            </div>
            <div class="txt_field">
                <input type="password" id="mostrar1" name="contrasena" maxlength="20" required>
                <span></span>
                <label>Contraseña</label>
            </div>
            <div class="pass">Haz Olvidado tu Contraseña?</div>
            <input type="submit" id="btn" value="Iniciar Sesión" onclick="comprobarUsuario()">
        </form>
    </div>
    <script src="./../../public/js/bootstrap.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <?php include './modals/modalCodigo.php' ?>
    
</body>

</html>