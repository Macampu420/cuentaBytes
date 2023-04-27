let vProveedores;
let vProductos = [];
let vItemsCompra = [];
let vCompras, vItemsEditar = [];
const conversorColombia = new Intl.NumberFormat('en-CO');


//trae todos los proveedores de la api y los devuelve como json
let traerProveedores = async () => {
    let resultado = await fetch("http://localhost/cuentabytes/src/controllers/proveedores/apiProveedor.php");

    let proveedores = await resultado.json();
    return proveedores["items"];
}

//pone todos los proveedores en el slc
let mostrarProveedores = async () => {
    let slcProveedores = document.getElementById("slcProveedor");
    vProveedores = await traerProveedores();

    vProveedores.forEach(proveedor => {
        slcProveedores.insertAdjacentHTML('beforeend', `<option value="${proveedor.idProveedor}">${proveedor.nombreProveedor}</option>`)
    })
};

//trae todos los productos de la api y los devuelve como json
// let traerProductos = async () => {
//     let resultado = await fetch("http://localhost/cuentabytes/src/controllers/productos/apiProductos.php");

//     let productos = await resultado.json();
//     return productos["items"];
// }

let traerProductos = async () => {
    //se piden todos los productos y se guardan en el vector correspondiente
    fetch("http://localhost:3000/listarProductos")
        .then(res => res.json())
        .then(data => {

            //cada producto se pone en el vector correspondiente para poderse usar posteriormente en el resto del programa
            data.forEach(element => vProductos.push(element));

        });

        console.log(vProductos);
}

//guarda los productos en el respectivo vector para ser usados posteriormente
// let guardarProductos = async () => {
//     vProductos = await traerProductos();
// };

//trae todos los encs de las compras de la api y los devuelve como json
let traerCompras = async () => {
    let resultado = await fetch("http://localhost:3000/compras/listarcompras");

    let compras = await resultado.json();
    return compras;
}

//guarda las compras en el respectivo vector y muestra la carta de cada una
let mostrarCompras = async () => {
    vCompras = await traerCompras();

    //valida que haya compras registradas y renderiza cada una, si no hay muestra un mensaje indicando esto
    if (Array.isArray(vCompras)) {

        let filaCompras = document.getElementById('filaCompras');

        vCompras.forEach(compra => {
            filaCompras.insertAdjacentHTML('beforeend', `
                
                <div id="${compra.idCompra}" cartaItem="true" class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
                    <div class="card-body mt-2 mx-auto">
                        <h5 btnAcciones idcompra="${compra.idCompra}" class="puntosAcciones m-2 w-25">...</h5>
                        <h5>Concepto: ${compra.conceptoCompra}</h5>
                        <h5>Valor Total: ${conversorColombia.format(compra.vrTotalCompra)}</h5>
                        <h5>Fecha: ${compra.fechaCompra.slice(0, 10)}</h5>
                        <h5>Comprado a: ${compra.nombreProveedor}</h5>
                    </div>
                </div>
                `);
        });
    } else {
        filaCompras.insertAdjacentHTML('beforeend', `
            <h3 class="text-center mt-lg-5 col-12">Aún no has registrado Compras, presiona el boton de arriba para hacerlo</h3>
            `);
    }


}

const eliminarItem = (disparador, vector_) => {

    let item = vector_.findIndex(
        //busca en los elementos de la venta actual uno que coincida con el item modificado
        //si no existe se define como undefined
        element => (element.idItem) == disparador.id.slice(-1)
    );

    //eliminará la carta del elemento y lo quitara del vector segun su posicion, si este existe en el array
    //sino solo eliminara la carta
    if (item != -1) {
        if (item == 0) {
            vector_.shift();
            disparador.parentElement.parentElement.remove();

        } else {
            vector_.splice(vector_.indexOf(item), 1);
            disparador.parentElement.parentElement.remove();
        }
        vrTotal(vector_);
    } else {
        disparador.parentElement.parentElement.remove();
    }

}

let renderItemReg = (numeroItem, vProductos_) => {

    //agrega un nuevo item de la compra al modal
    // document.getElementById("rowItems").insertAdjacentHTML('beforeend', `
    //     <div id="item${numeroItem}" class="border border-dark rounded item p-2 mx-auto my-3 col-11 col-md-9 col-lg-5">
    //         <div class="containerBtn">
    //             <div id="dlt${numeroItem}" class="btnEliminar"></div>
    //         </div>
    //         <select id="slc${numeroItem}" class="form-select col-9 mb-2 mt-1" aria-label="Default select example">
    //             <option selected>Selecciona el producto</option>
    //         </select>
    //         <div id="slidecontainer${numeroItem}" class="">
    //             <div class="row">
    //                 <div class="col-7 col-lg-5 mx-auto">
    //                     <label for="inpunidCompslc${numeroItem}">Unidades compradas:</label>
    //                     <input disabled id="inpunidCompslc${numeroItem}" type="number" min="1" value="0" class="unidCompslc${numeroItem} w-100">
    //                 </div>
    //                 <div class="col-7 col-lg-5 mx-auto">
    //                     <label for="inpPrecioUnitslc${numeroItem}">Valor unitario:</label>
    //                     <input disabled id="inpPrecioUnitslc${numeroItem}" type="number" min="1" class="precioUnitslc${numeroItem} w-100">
    //                 </div>
    //             </div>
    //             <p id="pslc${numeroItem}" class="d-none mx-auto mt-2 mb-0 text-center">Actualmente tienes 1. Quedarás con 20.</p>
    //         </div>
    //     </div>
    //     `);

    // //pone todos los productos que se traigan en el select del item creado
    // vProductos_.forEach(producto => {
    //     document.getElementById("slc" + numeroItem).insertAdjacentHTML("beforeend", `
    //      <option value="${producto.idProducto}">${producto.nombreProducto}</option>`)
    // });
    document.getElementById("tblItemsVta").insertAdjacentHTML('beforeend', `
    <tr id="item${numeroItem}" class="h-25">
        <td><img id="imgProductoItem${numeroItem}" class="border border-2 img-size mx-auto" src="./../../public/img/placeholderProducto.jpg" alt="Producto 1"></td>
        <td class="align-middle">
            <div class="mx-auto">
                <select id="slcProducto${numeroItem}" class="" name="slcProductos" required>
                    <option value="">Producto:</option>
                </select>
                <p class="text-center mt-2 d-none"></p>
            </div>
        </td>
        <td class="align-middle">
            <div class="row">
                <input id="inpCantidad${numeroItem}" class="form-control w-75 mx-auto mb-2" type="number" value="1" disabled required>
            </div>                                    
        </td>
        <td class="align-middle">
        <div class="row">
                <input id="pPrecioVenta${numeroItem}" class="form-control w-200 mx-auto mb-2" type="number" value="1" disabled required>
            </div>  
        <td class="align-middle"><p id="pSubtotalItem${numeroItem}" class="text-center">$0</p></td>
        <td class="align-middle">
            <div class="btnAccion row p-1 bg-danger mx-auto" id="btnEliminarItem${numeroItem}">
                <a class="col-12 btnEliminar mx-auto"></a>
            </div>  
        </td>
    </tr>
    `)

    // pone todos los productos que se traigan en el select del item creado
    for (let i = 0; i < vProductos_.length; i++) {
        document.getElementById("slcProducto" + numeroItem).insertAdjacentHTML("beforeend", `
                <option value="${vProductos[i].idProducto}">${vProductos[i].nombreProducto}</option>
        `);
    }

    numeroItem++;
    
}

let renderItemEdit = (vProductos_) => {

    crearItemEdit(vItemsEditar);

    //agrega un nuevo item de la compra al modal
    document.getElementById("rowItems").insertAdjacentHTML('beforeend', `
        <div id="item${vItemsEditar.length - 1}" class="border border-dark rounded item p-2 mx-auto my-3 col-11 col-md-9 col-lg-5">
            <div class="containerBtn">
                <div id="dlt${vItemsEditar.length - 1}" class="btnEliminar"></div>
            </div>
            <select id="slc${vItemsEditar.length - 1}" class="form-select col-9 mb-2 mt-1" aria-label="Default select example">
                <option selected>Selecciona el producto</option>
            </select>
            <div id="slidecontainer${vItemsEditar.length - 1}" class="">
                <div class="row">
                    <div class="col-7 col-lg-5 mx-auto">
                        <label for="inpunidCompslc${vItemsEditar.length - 1}">Unidades compradas:</label>
                        <input disabled id="inpunidCompslc${vItemsEditar.length - 1}" type="number" min="1" value="0" class="unidCompslc${vItemsEditar.length - 1} w-100">
                    </div>
                    <div class="col-7 col-lg-5 mx-auto">
                        <label for="inpPrecioUnitslc${vItemsEditar.length - 1}">Valor unitario:</label>
                        <input disabled id="inpPrecioUnitslc${vItemsEditar.length - 1}" type="number" min="1" class="precioUnitslc${vItemsEditar.length - 1} w-100">
                    </div>
                </div>
                <p id="pslc${vItemsEditar.length - 1}" class="d-none mx-auto mt-2 mb-0 text-center">Actualmente tienes 1. Quedarás con 20.</p>
            </div>
        </div>
        `);

    //pone todos los productos que se traigan en el select del item creado
    vProductos_.forEach(producto => {
        document.getElementById(("slc" + (vItemsEditar.length - 1))).insertAdjacentHTML("beforeend", `
         <option value="${producto.idProducto}">${producto.nombreProducto}</option>`)
    });
}
//reinicia el modal
let configModalReg = () => {

    let date = new Date();
    document.getElementById("formCompras").reset();
    document.getElementById('fechaCompra').value = date.toISOString().slice(0, 10);
    document.getElementById('btnGuardar').disabled = false;
    // document.getElementById('divAcciones').classList.add("d-none");
    // document.getElementById('tblItemsVta').classList.add("d-none");
    // document.getElementById('rowItems').innerHTML = "";
    document.getElementById('btnGuardar').innerHTML = "Guardar";
    vItemsCompra = [];

}

let configModalEdit = async (event) => {
    let idCompra = event.target.getAttribute("idcompra");
    let resultado = await fetch(`http://localhost:3000/listarCompra${idCompra}`);
    let compra = await resultado.json();
    let numeroItem = 0;
    vItemsEditar = [];

    reiniciarModal(idCompra);
    llenarEncCompra(compra[0]);
    creaVitemsActualizar(compra);

    compra.forEach((item, index) => {
        document.getElementById("rowItems").insertAdjacentHTML('beforeend', `
        <div id="id${item.index}" class="border border-dark rounded item p-2 mx-auto my-3 col-11 col-md-9 col-lg-5">
            <div class="containerBtn">
                <div id="dlt${index}" class="btnEliminar"></div>
            </div>
            <select disabled id="slc${index}" class="form-select col-9 mb-2 mt-1" aria-label="Default select example">
                <option selected value='${item.idProducto}'>${item.nombreProducto}</option>
            </select>
            <div id="slidecontainer${index}" class="">
                <div class="row">
                    <div class="col-7 col-lg-5 mx-auto">
                        <label for="inpunidCompslc${numeroItem}">Unidades compradas:</label>
                        <input id="inpunidCompslc${numeroItem}" type="number" min="1" value='${item.cantidadCompra}' class="unidCompslc${numeroItem} w-100">
                    </div>
                    <div class="col-7 col-lg-5 mx-auto">
                        <label for="inpPrecioUnitslc${numeroItem}">Valor unitario:</label>
                        <input id="inpPrecioUnitslc${numeroItem}" type="number" min="1" value='${item.precioUnitario}' class="precioUnitslc${numeroItem} w-100">
                    </div>
                </div>
                <p id="pslc${numeroItem}" class="mx-auto mt-2 mb-0 text-center">Quedarás con ${item.stockProducto}.</p>
            </div>
        </div>
        `);
        numeroItem++;
    });
}

let reiniciarModal = idCompra => {
    //deja el contenedor de items vacios para evitar interferencia de ventas pasadas
    document.getElementById('rowItems').innerHTML = "";
    //muestra las acciones para poder ejecutarlas
    document.getElementById('divAcciones').classList.remove("d-none");
    //desabilita el btn guardar que se habilitara cuando el usuario clickee editar
    document.getElementById('btnGuardar').disabled = true;
    //cambia el valor del btn actualizar
    document.getElementById('btnGuardar').innerHTML = "Actualizar";

    document.getElementById("btnGuardar").setAttribute("idCompra", idCompra);
    document.querySelector("form").setAttribute("idCompra", idCompra);
    document.getElementById('btnEliminar').setAttribute("idCompra", idCompra);
}

const actualizarUnidadesVendidas = (disparador, vector) => {

    let nroIdItem = disparador.id.slice(-1);
    let item = vector.find(itemVenta => itemVenta.idItem == parseInt(nroIdItem));

    vector[vector.indexOf(item)].unidadesVendidas = disparador.value;
    document.getElementById(`pSubtotalItem${nroIdItem}`).innerHTML = `$${conversorColombia.format(item.unidadesVendidas * item.costoProducto)}`;

}
const actualizarCrearItem = (item, disparador, vector) => {
    
    let nroItemDisparador = parseInt(disparador.id.slice(-1));
    let productoItem = vProductos.find(producto => producto.idProducto == disparador.value);

    if(item == undefined){
        vector.push({
            idItem: nroItemDisparador,
            idProducto: productoItem.idProducto,
            precioUnitario: productoItem.precioVenta,
            costoProducto: productoItem.costoProducto,
            unidadesVendidas: 0,
        }) 
    } else {
        vector[vector.indexOf(item)] = {
            idItem: nroItemDisparador,
            idProducto: productoItem.idProducto,
            precioUnitario: productoItem.precioVenta,
            costoProducto: productoItem.costoProducto,
            unidadesVendidas: document.getElementById(`inpCantidad${nroItemDisparador}`).value,
        }
    }

    document.getElementById(`imgProductoItem${nroItemDisparador}`).src = `./../../public/img/productos/${productoItem.nombreImagen}`;
    document.getElementById(`pPrecioVenta${nroItemDisparador}`).innerHTML = "$" + conversorColombia.format(`${productoItem.precioVenta}`);
    document.getElementById(`pSubtotalItem${nroItemDisparador}`).innerHTML = "$" + conversorColombia.format(`${productoItem.costoProducto}`);

    if(productoItem.stockProducto == 0){
        disparador.nextElementSibling.innerHTML = `No hay unidades disponibles.`;
        document.getElementById(`inpCantidad${nroItemDisparador}`).setAttribute("readonly", "");
        document.getElementById(`inpCantidad${nroItemDisparador}`).value = 0;
        document.getElementById(`inpCantidad${nroItemDisparador}`).removeAttribute("disabled");
    } else {
        document.getElementById(`inpCantidad${nroItemDisparador}`).removeAttribute("readonly");
        document.getElementById(`inpCantidad${nroItemDisparador}`).disabled = false;
        disparador.nextElementSibling.innerHTML = `Actualmente tienes: ${productoItem.stockProducto} unidades.`; 
        document.getElementById(`pPrecioVenta${nroItemDisparador}`).removeAttribute("readonly")
        document.getElementById(`pPrecioVenta${nroItemDisparador}`).disabled = false;
        document.getElementById(`pPrecioVenta${nroItemDisparador}`).value = productoItem.costoProducto;

        

    }   
    vrTotal(vector);

}
let llenarEncCompra = compra => {
    document.getElementById('fechaCompra').value = compra.fechaCompra.slice(0, 10);
    document.getElementById('conceptoCompra').value = compra.conceptoCompra;
    document.getElementById('slcProveedor').value = compra.idProveedor;
    document.getElementById('vrTotalIva').value = conversorColombia.format(compra.vrTotalIva);
    document.getElementById('vrTotalCompra').value = conversorColombia.format(compra.vrTotalCompra);
}

let creaVitemsActualizar = (compra) => {
    compra.forEach(item => {
        let producto = vProductos.find(element => element.idProducto == item.idProducto);
        let {cantidadCompra, idProducto} = item;

        vItemsEditar.push({
            cantidadCompra,
            idItem: ('item'+compra.indexOf(item)),
            idProducto: parseInt(idProducto),
            porcentajeIva: parseInt(producto.porcentajeIva),
            costoProducto: parseInt(producto.costoProducto)
        })
    });
}
    
// let vrTotal = vector => {
//     let vrTotal = vector.reduce((acum, item) => acum += (item.costoProducto * item.cantidadCompra), 0);
//     document.getElementById('vrTotalCompra').value = conversorColombia.format(vrTotal).toString()
// }

const vrTotal = (vItems) => {
    //calcula el valor total de la venta y del IVA cuando se va a registrar
    let dto = document.getElementById("inpDescuento").value;
    let vrTot = 0;

    //por cada item de la venta calcula el valor de las unidVend * precioUnit
    vItems.forEach(item => vrTot += item.unidadesVendidas * item.costoProducto);

    vrTot -= dto;

    document.getElementById("pValorTotal").innerHTML = "$"+conversorColombia.format(vrTot);
}



//añade un item de la compra al vector correspondiente
let crearItemReg = (vector, disparador, numeroItem) => {
    let producto = vProductos.find(producto => producto.idProducto == disparador.value);

    vector.push({
        idItem: ('item' + numeroItem),
        idProducto: parseInt(producto.idProducto),
        costoProducto: parseInt(document.querySelector('#inpPrecioUnitslc' + numeroItem).value),
        cantidadCompra: parseInt(document.querySelector('#inpunidCompslc' + numeroItem).value),
        porcentajeIva: parseInt(producto.porcentajeIva)
    })

    vrTotal(vector);
    vrIva(vector);
}

//añade un item de la compra al vector correspondiente
let crearItemEdit = (vector) => {
    vector.push({
        idItem: ('item' + vector.length),
        costoProducto: 0,
        cantidadCompra: 0,
        porcentajeIva: 0
    })
}

//actualiza un item completo de la compra 
let actualizarItem = (vector, item, disparador, numeroItem) => {

    let producto = vProductos.find(producto => producto.idProducto == disparador.value)
    let indexItem = vector.indexOf(item);

    vector[indexItem].idProducto = parseInt(producto.idProducto);
    vector[indexItem].costoProducto = parseInt(document.querySelector('#inpPrecioUnitslc' + numeroItem).value);
    vector[indexItem].cantidadCompra = parseInt(document.querySelector('#inpunidCompslc' + numeroItem).value);
    vector[indexItem].porcentajeIva = parseInt(producto.porcentajeIva);

    vrTotal(vector);
    vrIva(vector);
}

let actualizarUnidCompradas = (vector, item, numeroItem) => {
    let indexItem = vector.indexOf(item);

    vector[indexItem].cantidadCompra = document.querySelector('#inpunidCompslc' + numeroItem).value == '' ? 0 : parseInt(document.querySelector('#inpunidCompslc' + numeroItem).value);
    vrTotal(vector);
    vrIva(vector);
}

let actualizarCostoProducto = (vector, item, numeroItem) => {
    let indexItem = vector.indexOf(item);

    vector[indexItem].costoProducto = document.querySelector('#inpPrecioUnitslc' + numeroItem).value == '' ? 0 : parseInt(document.querySelector('#inpPrecioUnitslc' + numeroItem).value);
    vrTotal(vector);
    vrIva(vector);
}

let eliminarProducto = (vector, item) => {
    let indexItem = vector.indexOf(item);
    vector.splice(indexItem, 1);

    vrTotal(vector);
    vrIva(vector);
}

let habilitarInputsItem = disparador => {
    let producto = vProductos.find(producto => parseInt(disparador.value) == producto.idProducto);
        
    document.querySelector("#inpunidComp" + disparador.id).disabled = false;
    document.querySelector("#inpPrecioUnit" + disparador.id).disabled = false;
    document.querySelector("#inpPrecioUnit" + disparador.id).value = producto.costoProducto;
    document.querySelector("#p" + disparador.id).innerHTML = `Actualmente tienes ${producto.stockProducto}. Quedarás con ${parseInt(document.querySelector(".unidComp" + disparador.id).value) + parseInt(producto.stockProducto)}.`
    document.querySelector("#p" + disparador.id).classList.remove('d-none');
    document.querySelector("#p" + disparador.id).setAttribute('stockActual', producto.stockProducto);
}

//calcula el nuevo stock del producto y lo muestra en la leyenda de la carta del mismo
let mostrarNuevoStock = disparador => {

    //busca la leyenda que pertenece al item en base al id del input disparador del evento
    let leyendaItem = document.querySelector("#pslc" + disparador.id[disparador.id.length - 1]);

    //valida que el usuario haya ingresado un # de unidades adquiridas y calcula el valor del nuevostock
    let nuevoStock = (disparador.value.length == 0 ? 0 : parseInt(disparador.value)) + parseInt(leyendaItem.getAttribute('stockactual'));
    leyendaItem.innerHTML = `Actualmente tienes ${leyendaItem.getAttribute('stockactual')}. Quedarás con ${nuevoStock}`;
}

let enviarRegCompra = async () => {

    let compraActual = {
        conceptoCompra: document.getElementById('conceptoCompra').value,
        fechaCompra: document.getElementById('fechaCompra').value,
        idProveedor: document.getElementById('slcProveedor').value,
        vrTotalCompra: document.getElementById('vrTotalCompra').value.replace(',', ''),
        vrTotalIva: document.getElementById('vrTotalIva').value.replace(',', ''),
        vItemsCompra
    };

    await fetch('http://localhost:3000/guardarCompra', {
            method: "POST",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(compraActual)
        })
        .then(response => response.text())
        .then(mensaje => {
            alert(mensaje);
            location.reload();
        })
        .catch(err => {
            alert("Ha ocurrido un error registrando la compra, por favor intentalo mas tarde");
            location.reload();
        });
}

let enviarEditCompra = async () => {

    let compraActual = {
        conceptoCompra: document.getElementById('conceptoCompra').value,
        fechaCompra: document.getElementById('fechaCompra').value,
        idProveedor: document.getElementById('slcProveedor').value,
        vrTotalCompra: document.getElementById('vrTotalCompra').value.replace(',', ''),
        vrTotalIva: document.getElementById('vrTotalIva').value.replace(',', ''),
        vItemsEditar
    };

    console.log(compraActual);

    await fetch('http://localhost:3000/compras/editarCompra', {
            method: "POST",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(compraActual)
        })
        .then(response => response.text())
        .then(mensaje => {
            alert(mensaje);
            location.reload();
        })
        .catch(err => {
            alert("Ha ocurrido un error actualizando la compra, por favor intentalo mas tarde");
            location.reload();
        });
}

// let modalEditar = async event => {
//     let idCompra = event.target.getAttribute("idcompra");

//     //trae la venta (enc y dets) para renderizarlos
//     await fetch(`http://localhost:3000/editCompra${idCompra}`)
//         .then(res => res.json())
//         .then(data => {
//             vItemsEditar = data
//         })
//         .catch(e => console.log(e));

//     console.log(vItemsEditar);

// }
