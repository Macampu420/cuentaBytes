function MostrarPass() {
    var x1 = document.getElementById("mostrar1");
    if (x1.type === "password") {
        x1.type = "text";
    } else {
        x1.type = "password";
    }
}

function verificarRegistro() {

    document.getElementById("inicioSesion").onsubmit = async (e) => {
        e.preventDefault();
        let email = document.getElementById("email").value;
        let contrasena = document.getElementById("mostrar1").value;

        fetch(`http://localhost:3000/verificarRegistro${email}/${contrasena}`)
            .then(response => response.text())
            .then(mensaje => {
                if (response == 'No existe un usario registrado') {
                    alert('Bienvenido!');
                    location.href = 'http://localhost/cuentabytes/src/views/balances.php'
                }
                else{
                    alert('NO')
                }
            })
            .catch(err => {
                alert("Ha ocurrido un error, por favor intentalo mas tarde");
                location.reload();
            });
    }

}