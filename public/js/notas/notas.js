var vObjsNotas = [];

const renderNotas = async () => {
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
                <h5 btnAcciones idventa="${element.idNota}" class="puntosAcciones m-2 w-25">...</h5>
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

const registrarNota = async () =>{
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