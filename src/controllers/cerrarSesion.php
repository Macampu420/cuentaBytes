<?php
session_start();
session_destroy();
header("Location: ./../views/inicioSesion.php");