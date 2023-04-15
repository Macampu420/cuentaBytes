var vObjsTipoEgreso = [];
var vObjsVentaActual = [];
var vItemsEgreso = [];
var numeroItem = 0;
var numeroItemAct = 0;
var vObjsEncEgreso = [];
var vItemsEditar = [];

const conversorColombia = new Intl.NumberFormat('en-CO');

const traerTipoEgreso = async () => {
    //se piden todos los clientes, se guardan en el vector correspondiente y se insertan al html
    await fetch("http://localhost:3000/listarTipoEgreso")
        .then(res => res.json())
        .then(data => {

            //cada item se pone en el vector correspondiente para poderse usar posteriormente en el resto del programa
            data.forEach(element => {

                vObjsTipoEgreso.push(element);
            })

            //se renderizan todos los clientes
            for (let i = 0; i < vObjsTipoEgreso.length; i++) {
                document.getElementById("slcTipoEgreso").innerHTML += `<option value="${vObjsTipoEgreso[i].idTipoEgreso}">${vObjsTipoEgreso[i].nombreTipoEgreso}</option>`
            }
        })
        .catch(err => console.log(err));
}

const vrTotalRegistar = () => {

    let acumEgreso = 0;
    for (let i = 0; i < numeroItem; i++) {

        let valorEgreso = parseInt(document.getElementById(`vr${i}`).value);
        acumEgreso = acumEgreso + valorEgreso;
    }

    document.getElementById("inpVrTotal").value = conversorColombia.format(acumEgreso).toString();
}

const renderItem = () => {
    //agrega un nuevo item de la venta al html

    document.getElementById("rowItems").insertAdjacentHTML('beforeend', `
        <div id="${divModal.getAttribute('editar') == "true" ? "id" + numeroItemAct : "item" + numeroItem}" class="border border-dark rounded item p-2 mx-auto my-3 col-11 col-md-9 col-lg-5">
        <div class="containerBtn">
          <div id="dlt${numeroItem}" class="btnEliminar"></div>
        </div>
        <p class="mb-0 quicksand"><input required type="number" id="${divModal.getAttribute('editar') == "true" ? "vr" + numeroItemAct : "vr" + numeroItem}" placeholder="Valor Egreso"></p><br>
        <p class="mb-0 quicksand"><input required type="text" id="${divModal.getAttribute('editar') == "true" ? "titulo" + numeroItemAct : "titulo" + numeroItem}" placeholder="Titulo Egreso"> </p>
        </div>
        `);


    if (divModal.getAttribute('editar') == "true") {
        numeroItemAct++;
        comparar = "vr" + numeroItemAct;
        if(comparar !== itemsDetEgreso[numeroItemAct-1]){
            itemsDetEgreso.push("vr" + numeroItemAct);
        }
    } 
    numeroItem++; 

    console.log("A " + numeroItemAct);
    console.log("B " + numeroItem);
    console.log(itemsDetEgreso);


}

const detalleVenta = (vectorId) => {

    let acumEgreso = 0;
    for (let i = 0; i < numeroItem; i++) {

        let valorEgreso = parseInt(document.getElementById(`vr${i}`).value);
        let descripcion = document.getElementById(`titulo${i}`).value;
        acumEgreso = acumEgreso + valorEgreso;
        let idDetEgreso = 0;



        if (vectorId.length > 0) {

            if (i < numeroItemAct) {
                // for (let e = 0; e < numeroItemAct; e++) {
                //     idDetEgreso = vectorId[e].idDetEgreso;
                // }
                let idDetEgreso = parseInt(document.getElementById(`id${i}`).className);

                vItemsEgreso.push({
                    valorEgreso,
                    descripcion,
                    idDetEgreso,
                })
            }
            else {
                idDetEgreso = null;
                vItemsEgreso.push({
                    valorEgreso,
                    descripcion,
                    idDetEgreso,
                })
            }
        } else {

            vItemsEgreso.push({
                valorEgreso,
                descripcion,
            })
        }
    }

    vItemsEgreso.push({
        acumEgreso
    })

}

const registrarEgreso = (vector) => {

    let tituloEgreso = document.getElementById("inpTitulo").value;
    let fecha = document.getElementById("inpFecha").value;
    let idTipoEgreso = parseInt(document.getElementById("slcTipoEgreso").value);
    let vrTotalEgreso = 0;
    vector.forEach(element => {
        vrTotalEgreso = element.acumEgreso;
    })

    vector.pop();

    //valida que todos los datos hayan sido ingresados y que haya items en la venta actual
    if (tituloEgreso == "" || fecha == "" || idTipoEgreso == NaN) {
        alert("Por favor llena todos los campos y añade items a el egreso");
    } else {

        let egresoActual = {
            tituloEgreso,
            fecha,
            vrTotalEgreso,
            idTipoEgreso,
            itemsEgreso: vector
        };

        enviarRegEgreso(egresoActual);

    }
}

const enviarRegEgreso = async (egresoActual_) => {

    await fetch('http://localhost:3000/guardarEgreso', {
        method: "POST",
        credentials: "same-origin",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(egresoActual_)
    })
        .then(response => response.text())
        .then(mensaje => {
            alert(mensaje);
            location.reload();
        })
        .catch(err => {
            alert("Ha ocurrido un error registrando el egreso, por favor intentalo mas tarde");
            location.reload();
        });
}

const eliminarItem = (disparador, vector_) => {

    let item = vector_.find(
        //busca en los elementos de la venta actual uno que coincida con el item modificado
        //si no existe se define como undefined
        element => element.idItem || element.idDetEgreso == disparador.parentElement.parentElement.id
    );

    //eliminará la carta del elemento y lo quitara del vector segun su posicion, si este existe en el array
    //sino solo eliminara la carta
    if (vector_.indexOf(item) != -1) {

        if (vector_.indexOf(item) == 0) {

            vector_.shift();
            disparador.parentElement.parentElement.remove();

        } else {

            vector_.pop(vector_.indexOf(item));
            disparador.parentElement.parentElement.remove();
        }
    } else {
        disparador.parentElement.parentElement.remove();
    }

    numeroItem = numeroItem - 1;
    numeroItemAct = numeroItemAct - 1;

    if (divModal.getAttribute("editar") == "true") {
        itemId = item.idDetEgreso;
        itemEliminar.push({
            itemId
        })
        borrarDetEgreso = true;


    }

    console.log(vItemsEditar);
    console.log(itemEliminar);


}

const renderEgresos = async () => {
    //se traen todos los encabezados de las ventas registradas
    await fetch("http://localhost:3000/egresos")
        .then(res => res.json())
        .then(data => {

            //se da formato a la fecha y se empuja cada item en el vector indicado
            data[0].forEach(element => {

                element.fechaEgreso = element.fechaEgreso.slice(0, 10);

                vObjsEncEgreso.push(element);
            })
        })
        .catch((error) => {
            console.log(error)
        });

    if (vObjsEncEgreso.length > 0) {

        let filaEgresos = document.getElementById('filaEgresos');

        vObjsEncEgreso.forEach((element) => {

            filaEgresos.insertAdjacentHTML('beforeend', `
                
                <div id="${element.idEgreso}" idventa="${element.idEgreso}" cartaItem="true" class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
                    <div class="card-body mt-2 mx-auto">
                    <h5 btnAcciones idventa="${element.idEgreso}" class="puntosAcciones m-2 w-25">...</h5>
                        <h5 idventa="${element.idEgreso}">Titulo: ${element.tituloEgreso}</h5>
                        <h5 idventa="${element.idEgreso}">Valor Total: ${conversorColombia.format(element.vrTotalEgreso)}</h5>
                        <h5 idventa="${element.idEgreso}">Fecha: ${element.fechaEgreso}</h5>
                        <h5 idventa="${element.idEgreso}">Tipo egreso: ${element.nombreTipoEgreso}</h5>
                    </div>
                </div>
        
                `);
        });
    } else {
        filaEgresos.insertAdjacentHTML('beforeend', `
                
            <h3 class="text-center mt-lg-5 col-12">Aún no has registrado egresos, presiona el boton de arriba para hacerlo</h3>
        
            `);
    }

}

const desplegarModal = (modal, event) => {

    //configura el modal dependiendo del estado editar
    if (modal.getAttribute('editar') == "true") {
        modalEditar(event);

    } else {
        modalRegistrar();
    }

    //se muestra el modal
    modalBootstrap.show();

}

const modalEditar = async event => {
    borrarDetEgreso = false;
    itemEliminar = [];
    itemsDetEgreso = [];
    //deja el contenedor de items vacios para evitar interferencia de ventas pasadas
    document.getElementById('rowItems').innerHTML = "";
    //muestra las acciones para poder ejecutarlas
    document.getElementById('divAcciones').classList.remove("d-none");
    //desabilita el btn guardar que se habilitara cuando el usuario clickee editar
    document.getElementById('btnGuardar').disabled = true;
    //cambia el valor del btn actualizar
    document.getElementById('btnGuardar').innerHTML = "Actualizar";

    let idVenta = event.target.getAttribute("idventa");

    document.getElementById("btnGuardar").setAttribute("idVenta", idVenta);

    //trae la venta (enc y dets) para renderizarlos
    await fetch(`http://localhost:3000/editEgreso${idVenta}`)
        .then(res => res.json())
        .then(data => {
            vItemsEditar = data
        })
        .catch(e => console.log(e));

    //da un formato legible a la fecha de la venta
    vItemsEditar[0].fechaEgreso = vItemsEditar[0].fechaEgreso.slice(0, 10);


    //setea en los inputs los valores traidos de la bd para que el usuario los pueda editar
    document.getElementById('inpFecha').value = vItemsEditar[0].fechaEgreso;
    document.getElementById('inpTitulo').value = vItemsEditar[0].tituloEgreso;
    document.getElementById('slcTipoEgreso').value = vItemsEditar[0].idTipoEgreso;
    document.getElementById('inpVrTotal').value = conversorColombia.format(vItemsEditar[0].vrTotalEgreso);


    //renderiza todos los detalles traidos de la bd para poderlos editar
    vItemsEditar.forEach(element => {

        document.getElementById('rowItems').insertAdjacentHTML('beforeend', `
        <div id="${element.idDetEgreso}" class="border border-dark rounded item p-2 mx-auto my-3 col-11 col-md-9 col-lg-5">
            <div class="containerBtn">
                <div id="dlt${element.idDetEgreso}" class="btnEliminar"></div>
            </div>
            <div  id="id${numeroItem}" class="${element.idDetEgreso}"></div>
            <p class="mb-0 quicksand"><input type="number" id="vr${numeroItem}" placeholder="Valor Egreso" value="${element.valorEgreso}"></p><br>
            <p class="mb-0 quicksand"><input type="text" id="titulo${numeroItem}" placeholder="Titulo Egreso" value=" ${element.descripcion}"></p>
            </div>`)

        numeroItem++;
        numeroItemAct++;

        itemsDetEgreso.push("vr" + numeroItem);


    });

    document.getElementById('btnEliminar').setAttribute("idVenta", vItemsEditar[0].idEgreso)


}

const modalRegistrar = () => {

    //setea todos los inputs/items como vacios para registrar una venta nueva
    vItemsEgreso = [];
    let date = new Date();

    document.getElementById('btnGuardar').disabled = false;
    document.getElementById('divAcciones').classList.add("d-none");
    document.getElementById('rowItems').innerHTML = "";
    document.getElementById('btnGuardar').innerHTML = "Guardar";
    document.getElementById('inpFecha').value = date.toISOString().slice(0, 10);
    document.getElementById('inpTitulo').value = "";
    document.getElementById('slcTipoEgreso').value = 0;
    document.getElementById('inpVrTotal').value = 0;

}

const actualizarEgreso = (vector, vectorId) => {

    let tituloEgreso = document.getElementById("inpTitulo").value;
    let fecha = document.getElementById("inpFecha").value;
    let idTipoEgreso = parseInt(document.getElementById("slcTipoEgreso").value);
    let vrTotalEgreso = 0;

    vectorId.forEach(element => {
        idEgreso = element.idEgreso;
    })

    vector.forEach(element => {
        vrTotalEgreso = element.acumEgreso;
    })


    vector.pop();


    //valida que todos los datos hayan sido ingresados y que haya items en la venta actual
    if (tituloEgreso == "" || fecha == "" || idTipoEgreso == NaN) {
        alert("Por favor llena todos los campos y añade items a el egreso");
    } else {

        let egresoActual = {
            idEgreso,
            tituloEgreso,
            fecha,
            vrTotalEgreso,
            idTipoEgreso,
            itemsEgreso: vector,
            itemEliminar: itemEliminar,
            borrarDetEgreso
        };

        enviarActEgreso(egresoActual);

        console.log(egresoActual);



    }
}


const enviarActEgreso = async (egresoActual_) => {

    await fetch('http://localhost:3000/actualizarEgreso', {
        method: "POST",
        credentials: "same-origin",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(egresoActual_)
    })
        .then(response => response.text())
        .then(mensaje => {
            alert(mensaje);
            location.reload();
        })
        .catch(err => {
            alert("Ha ocurrido un error registrando el egreso, por favor intentalo mas tarde");
            location.reload();
        });
}


