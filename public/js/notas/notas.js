var vObjsNotas = [];
var vItemNota = [];

const renderizarNotas = async () => {
    await fetch("http://localhost:3000/listarNotas")
        .then(res => res.json())
        .then(data => {

            //se da formato a la fecha y se empuja cada item en el vector indicado
            data.forEach(element => {

                vObjsNotas.push(element);
            })
        })
        .catch((error) => {
            console.log(error)
        });

    console.log(vObjsNotas);

    if (vObjsNotas.length > 0) {
        vObjsNotas.forEach(element => {

            document.getElementById("filaNotas").insertAdjacentHTML('beforeend', `

            <div id="${element.idNota}" cartaItem="true" class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
            <div class="card-body mt-2 mx-auto">
                <h5 btnAcciones idNota="${element.idNota}" class="puntosAcciones m-2 w-25">...</h5>
                <h5 class="text-center" idNota="${element.idNota}">${element.tituloNota}</h5>
                <h5 class="text-center" idNota="${element.idNota}">${element.contenidoNota}</h5>
            </div>
        </div>
    
            `)
        }

        );
    } else {
        document.getElementById("filaNotas").innerHTML = "<h2 class='text-center'>No hay Notas registradas.</h2/>"
    }
}

const registrarNota = async () => {
    let tituloNota = document.getElementById("inpTituloNota").value;
    let cuerpoNota = document.getElementById("inpCuerpoNota").value;

    let notaActual = {
        tituloNota,
        cuerpoNota
    };

    console.log(notaActual);

    await fetch('http://localhost:3000/registrarNota', {
        method: "POST",
        credentials: "same-origin",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(notaActual)
    })
        .then(response => response.text())
        .then(mensaje => {
            alert(mensaje);
            location.reload();
        })
        .catch(err => {
            alert("Ha ocurrido un error registrando la nota, por favor intentalo mas tarde");
            location.reload();
        });

}

const desplegarModalNotas = (modal, event) => {

    //configura el modal dependiendo del estado editar
    if (modal.getAttribute('editar') == "true") {
        modalEditarNota(event);

    }
    //se muestra el modal
    modalAgregarNota.show();

}

const modalEditarNota = async event => {
    document.getElementById('divAccionesNotas').classList.remove("d-none");
    //desabilita el btn guardar que se habilitara cuando el usuario clickee editar
    document.getElementById('btnGuardarNotas').disabled = true;
    //cambia el valor del btn actualizar
    document.getElementById('btnGuardarNotas').innerHTML = "Actualizar";

    let idNota = event.target.getAttribute("idNota");

    document.getElementById("btnGuardarNotas").setAttribute("idNota", idNota);
    document.querySelector("form").setAttribute("idNota", idNota);


    //trae la venta (enc y dets) para renderizarlos
    await fetch(`http://localhost:3000/listarUnaNota${idNota}`)
        .then(res => res.json())
        .then(data => {
            vItemNota = data
        })
        .catch(e => console.log(e));

    document.getElementById("inpTituloNota").value = vItemNota[0].tituloNota;
    document.getElementById("inpCuerpoNota").value = vItemNota[0].contenidoNota;

    document.getElementById('btnEliminarNotas').setAttribute("idNota", vItemNota[0].idNota)


}

const actualizarNota = async (idNota) => {

    let tituloNota = document.getElementById("inpTituloNota").value;
    let cuerpoNota = document.getElementById("inpCuerpoNota").value
    let notaEditar = {
        idNota,
        tituloNota,
        cuerpoNota
    }

    await fetch(`http://localhost:3000/actualizarNota`,{
        method: "POST",
        credentials: "same-origin",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(notaEditar)
    })
        .then(response => response.text())
        .then(mensaje => {
            alert(mensaje);
            location.reload();
        })
        .catch(err => {
            alert("Ha ocurrido un error registrando la nota, por favor intentalo mas tarde");
            location.reload();
        });

        console.log(notaEditar);
}