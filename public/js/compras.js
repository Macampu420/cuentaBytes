let vProveedores;
let vProductos = [];
let vItemsCompra = [];
let vCompras, vItemsEditar = [];
let numeroItem = 0;
const conversorColombia = new Intl.NumberFormat('en-CO');

//trae todos los proveedores de la api y los devuelve como json
let traerProveedores = async () => {
    let resultado = await fetch("http://localhost/cuentabytes/src/controllers/proveedores/apiProveedor.php");

    let proveedores = await resultado.json();
    return proveedores["items"];
}

//pone todos los proveedores en el slc
let mostrarProveedores = async () => {
    let slcProveedor = document.getElementById("slcProveedor");
    vProveedores = await traerProveedores();

    vProveedores.forEach(proveedor => {
        slcProveedor.insertAdjacentHTML('beforeend', `<option value="${proveedor.idProveedor}">${proveedor.nombreProveedor}
</option>`)
    })
};

let traerProductos = async () => {
    //se piden todos los productos y se guardan en el vector correspondiente
    fetch("http://localhost:3000/listarProductos")
        .then(res => res.json())
        .then(data => {

            //cada producto se pone en el vector correspondiente para poderse usar posteriormente en el resto del programa
            data.forEach(element => vProductos.push(element));
        });
}

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

<div id="${compra.idCompra}" cartaItem="true" class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;"
    role="button">
    <div class="card-body mt-2 mx-auto">
        <h5 btnAcciones idcompra="${compra.idCompra}" class="puntosAcciones m-2 w-25">...</h5>
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

let renderItemReg = () => {

    document.getElementById("tblItemsVta").insertAdjacentHTML('beforeend', `
<tr id="item${numeroItem}" class="h-25">
    <td><img id="imgProductoItem${numeroItem}" class="border border-2 img-size mx-auto"
            src="./../../public/img/placeholderProducto.jpg" alt="Producto 1"></td>
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
            <input id="inpCantidad${numeroItem}" class="form-control w-75 mx-auto mb-2" type="number" value="1" disabled
                required>
        </div>
    </td>
    <td class="align-middle">
        <div class="row">
            <input id="pCostoUnitario${numeroItem}" class="form-control w-200 mx-auto mb-2" type="number" value="0"
                disabled required>
        </div>
    </td>
    <td class="align-middle">
        <div class="row">
            <input id="pPrecioCompra${numeroItem}" class="form-control w-200 mx-auto mb-2" type="number" value="0"
                disabled required>
        </div>
    </td>
    <td class="align-middle">
        <p id="pSubtotalItem${numeroItem}" class="text-center">$0</p>
    </td>
    <td class="align-middle">
        <div class="btnAccion row p-1 bg-danger mx-auto" id="btnEliminarItem${numeroItem}">
            <a class="col-12 btnEliminar mx-auto"></a>
        </div>
    </td>
</tr>
`)

    // pone todos los productos que se traigan en el select del item creado
    for (let i = 0; i < vProductos.length; i++) {
        document.getElementById("slcProducto" +
            numeroItem).insertAdjacentHTML("beforeend", ` <option value="${vProductos[i].idProducto}">
    ${vProductos[i].nombreProducto}</option>
    `);
    }

    numeroItem++;

}


let configModalEdit = async (event) => {
    let idCompra = event.target.getAttribute("idcompra");
    let resultado = await fetch(`http://localhost:3000/listarCompra${idCompra}`);
    let compra = await resultado.json();
    let numeroItem = 0;
    vItemsEditar = [];

    reiniciarModal(idCompra);
    document.getElementById("tblItemsVta").innerHTML = "";

    document.getElementById("fechaCompra").value = compra[0].fechaCompra.slice(0, 10);
    document.getElementById("slcProveedor").value = compra[0].idProveedor;

    document.getElementById("btnAnadir").disabled = true;
    document.getElementById("btnGuardar").disabled = true;
    document.getElementById("slcProveedor").disabled = true;
    document.getElementById("pValorTotal").innerHTML = `$${conversorColombia.format(compra[0].vrTotalCompra)}`;    

    compra.forEach(detalle => {
        document.getElementById("tblItemsVta").insertAdjacentHTML('beforeend', `
        <tr id="item${numeroItem}" class="h-25">
            <td><img id="imgProductoItem${numeroItem}" class="border border-2 img-size mx-auto" src="./../../public/img/productos/${detalle.nombreImagen}" alt="Producto 1"></td>
            <td class="align-middle">
                <p id="pPrecioVenta${numeroItem}" class="text-center">${detalle.nombreProducto}</p>                                  
            </td>
            <td class="align-middle">
                <div class="row">
                    <input id="inpCantidad${numeroItem}" class="form-control w-75 mx-auto mb-2" type="number" value="${detalle.cantidadCompra}" disabled required>
                </div>                                    
            </td>
            <td class="align-middle"><p id="pPrecioVenta${numeroItem}" class="text-center">$${conversorColombia.format(detalle.precioUnitario)}</p></td>
            <td class="align-middle"><p id="pSubtotalItem${numeroItem}" class="text-center">$${conversorColombia.format(detalle.precioUnitario * detalle.cantidadCompra)}</p></td>
            <td class="align-middle">
                <div class="btnAccion row p-1 bg-danger mx-auto">
                    <p class="col-12 btnEliminar mx-auto"></p>
                </div>  
            </td>
        </tr>
        `);
    });
}

let reiniciarModal = () => {
    //deja el contenedor de items vacios para evitar interferencia de ventas pasadas
    vItemsCompra = [];
    let date = new Date();
    numeroItem = 0;

    document.getElementById('btnAnadir').disabled = false;
    document.getElementById('btnGuardar').disabled = false;
    document.getElementById('slcProveedor').disabled = false;

    document.getElementById('fechaCompra').value = date.toISOString().slice(0, 10);
    document.getElementById('tblItemsVta').innerHTML = "";
    document.getElementById('pValorTotal').innerHTML = "$0";
    document.getElementById('slcProveedor').selectedIndex = 0;

}

const actualizarUnidadesCompradas = (disparador, vector) => {

    let nroIdItem = disparador.id.slice(-1);
    let item = vector.find(itemVenta => itemVenta.idItem == parseInt(nroIdItem));

    vector[vector.indexOf(item)].unidadesCompradas = disparador.value;
    document.getElementById(`pSubtotalItem${nroIdItem}`).innerHTML = `$${conversorColombia.format(item.unidadesCompradas
        * item.costoProducto)}`;

}

const actualizarPropiedadItem = (disparador, vector, propiedad) => {

    let nroIdItem = disparador.id.slice(-1);
    let item = vector.find(itemVenta => itemVenta.idItem == parseInt(nroIdItem));

    vector[vector.indexOf(item)][propiedad] = parseInt(disparador.value);
}

const subtotal = (disparador, vector) => {
    let nroIdItem = disparador.id.slice(-1);
    let item = vector.find(itemVenta => itemVenta.idItem == parseInt(nroIdItem));

    document.getElementById(`pSubtotalItem${nroIdItem}`).innerHTML = `$${conversorColombia.format(item.unidadesCompradas
        * item.costoProducto)}`;
}
const actualizarCrearItem = (item, disparador, vector) => {

    let nroItemDisparador = parseInt(disparador.id.slice(-1));
    let productoItem = vProductos.find(producto => producto.idProducto == disparador.value);

    document.getElementById(`imgProductoItem${nroItemDisparador}`).src =
        `./../../public/img/productos/${productoItem.nombreImagen}`;
    document.getElementById(`pPrecioCompra${nroItemDisparador}`).innerHTML = "$" +
        conversorColombia.format(`${productoItem.precioCompra}`);
    document.getElementById(`pSubtotalItem${nroItemDisparador}`).innerHTML = "$" +
        conversorColombia.format(`${productoItem.costoProducto}`);

    if (productoItem.stockProducto == 0) {
        disparador.nextElementSibling.innerHTML = `No hay unidades disponibles.`;
        document.getElementById(`inpCantidad${nroItemDisparador}`).setAttribute("readonly", "");
        document.getElementById(`inpCantidad${nroItemDisparador}`).value = 0;
        document.getElementById(`inpCantidad${nroItemDisparador}`).removeAttribute("disabled");
    } else {
        document.getElementById(`inpCantidad${nroItemDisparador}`).removeAttribute("readonly");
        document.getElementById(`inpCantidad${nroItemDisparador}`).disabled = false;
        disparador.nextElementSibling.innerHTML = `Actualmente tienes: ${productoItem.existenciaProducto} unidades.`;
        document.getElementById(`pPrecioCompra${nroItemDisparador}`).removeAttribute("readonly")
        document.getElementById(`pPrecioCompra${nroItemDisparador}`).disabled = false;
        document.getElementById(`pCostoUnitario${nroItemDisparador}`).disabled = false;
        document.getElementById(`pCostoUnitario${nroItemDisparador}`).value = productoItem.costoProducto;
        document.getElementById(`pPrecioCompra${nroItemDisparador}`).value = productoItem.precioVenta;
    }

    if (item == undefined) {
        vector.push({
            idItem: nroItemDisparador,
            idProducto: productoItem.idProducto,
            costoProducto: parseInt(document.getElementById(`pCostoUnitario${nroItemDisparador}`).value),
            precioCompra: parseInt(document.getElementById(`pPrecioCompra${nroItemDisparador}`).value),
            unidadesCompradas: productoItem.existenciaProducto > 0 ? 1 : 0,
        })
    } else {
        vector[vector.indexOf(item)] = {
            idItem: nroItemDisparador,
            idProducto: productoItem.idProducto,
            costoProducto: parseInt(document.getElementById(`pCostoUnitario${nroItemDisparador}`).value),
            precioCompra: parseInt(document.getElementById(`pPrecioCompra${nroItemDisparador}`).value),
            unidadesCompradas: productoItem.existenciaProducto > 0 ? document.getElementById(`inpCantidad${nroItemDisparador}`).value : 0,
        }
    }
    vrTotal(vector);

}

const vrTotal = (vItems) => {
    //calcula el valor total de la venta y del IVA cuando se va a registrar
    let vrTot = 0;

    //por cada item de la venta calcula el valor de las unidVend * precioUnit
    vItems.forEach(item => vrTot += item.unidadesCompradas * item.costoProducto);

    document.getElementById("pValorTotal").innerHTML = "$" + conversorColombia.format(vrTot);
}

let enviarRegCompra = async () => {

    let idProveedor = document.getElementById('slcProveedor').value;
    let vrTotalCompra = document.getElementById('pValorTotal').innerHTML.replace(',', '');
    vrTotalCompra = vrTotalCompra.slice(1);

    let compraActual = {
        idProveedor,
        vrTotalCompra,
        vItemsCompra
    };

    console.log(compraActual);

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