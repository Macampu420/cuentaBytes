<?php
require_once('./../models/InicioSesion.php');

$objInicioSesion = new InicioSesion();

$usuario = $_POST['usuario'];
$clave = $_POST['clave'];

$usuarioPasa = $objInicioSesion->verificarUsuario($usuario, $clave);

if ($usuarioPasa > 0) {
    session_start();
    $_SESSION['usuario'] = $usuario;
    header("Location: ./../views/balances.php");
} else {
    header("Location: ./../views/inicioSesion.php");
}

