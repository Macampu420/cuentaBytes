let modalReg = new bootstrap.Modal(document.getElementById("modalRegistro"));
var vDatos = [];
document.getElementById('reenviar').addEventListener("click", (event) =>{
    
    let email = vDatos[0];
    let nombreEmpresa = vDatos[1];
    let contrasena = vDatos[2]
    let codigo = generarCodigo();


    fetch('http://localhost:3000/send', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                email,
                nombreEmpresa,
                contrasena,
                codigo
            }),
        })
            .then((response) => response.json())
            .then((data) => {
                console.log(data);
                if (data.status == 200) {
                    alert("El Codigo a sido reenviado")
                    localStorage.setItem("email", email);
                } else {
                    alert(data.messaje);
                };
            })

            event.preventDefault();
    
})

document.getElementById('formCod').addEventListener("submit", (event) => {
    //evita que la pagina se recargue
    event.preventDefault();

    validarCodigo();
});

const generarCodigo = () => {
    let min = 1000;
    let max = 9999;
    let numero = Math.random() * (max - min) + min;
    return parseInt(numero);
}

function enviarCodigo() {
    document.getElementById("registro").onsubmit = async (e) => {
        e.preventDefault();
        let codigo = generarCodigo();
        let email = document.getElementById("email").value;
        let nombreEmpresa = document.getElementById("nombreEmpresa").value;
        let contrasena = document.getElementById("mostrar1").value;

        vDatos.push(email, nombreEmpresa, contrasena);

        fetch('http://localhost:3000/send', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                email,
                nombreEmpresa,
                contrasena,
                codigo
            }),
        })
            .then((response) => response.json())
            .then((data) => {
                console.log(data);
                if (data.status == 200) {
                    localStorage.setItem("email", email);
                } else {
                    alert(data.messaje);
                };
            })
    }

    modalReg.show();

}


function MostrarPass() {
    var x1 = document.getElementById("mostrar1");
    var x2 = document.getElementById("mostrar2");
    if (x1.type === "password") {
        x1.type = "text";
        x2.type = "text";
    } else {
        x1.type = "password";
        x2.type = "password";
    }
}

function comprobarClave() {
    var clave1 = document.getElementById("mostrar1").value;
    var clave2 = document.getElementById("mostrar2").value;
    let form = document.querySelector("form");

    if ((clave1 == clave2) && (clave1 !== '')) {
        if (clave1.length >= 8) {
            enviarCodigo();
        } else {
            form.addEventListener("submit", event => {
                event.preventDefault();

                document.getElementById('alerta').innerHTML = `
                        <div id="alerta" class="my-3 alert show alert-danger alert-dismissible" role="alert">
                    <strong>Contraseñas no coinciden.<br></strong> Las contraseñas no tienen un tamaño de 8 caracteres, corrigelas e intentalo nuevamente pikos
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>`;


            });
        }

    } else {
        form.addEventListener("submit", event => {
            event.preventDefault();

            document.getElementById('alerta').innerHTML = `
                    <div id="alerta" class="my-3 alert show alert-danger alert-dismissible" role="alert">
                <strong>Contraseñas no coinciden.<br></strong> Las contraseñas que has ingresado no son iguales, corrigelas e intentalo nuevamente pikos
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>`;


        });
    }
}

function validarCodigo() {

    let cod1 = document.getElementById('cod1').value;
    let cod2 = document.getElementById('cod2').value;
    let cod3 = document.getElementById('cod3').value;
    let cod4 = document.getElementById('cod4').value;
    let codigo = cod1 + cod2 + cod3 + cod4;

    console.log(codigo);
    fetch('http://localhost:3000/validarCodigo', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            codigo
        }),
    })
        .then((response) => response.json())
        .then((data) => {
            console.log(data);
            if (data.status == 200) {
                alert(data.messaje);
                window.location.href = "./../views/registro.php";
            } else {
                alert(data.messaje);
            };
        })
}



