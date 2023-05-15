<?php
class InicioSesion{
    private $conexion;

    public function __construct() {
        $this->conexion = mysqli_connect('localhost', 'root', '', 'cuentabytes');
    }

    function verificarUsuario($usuario, $clave){
        $sql = "CALL verificarRegistro('$usuario', '$clave')";
        $resultado = mysqli_query($this->conexion, $sql);
        return mysqli_num_rows($resultado);
    }

    function verificarSesion($sesionUsuario){
        if($sesionUsuario == null || $sesionUsuario == ''){
            echo 'Debes iniciar sesion primero';
            die();
        }
    }
}


?>