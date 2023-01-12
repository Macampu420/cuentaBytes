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
let traerProductos = async () => {
    let resultado = await fetch("http://localhost/cuentabytes/src/controllers/productos/apiProductos.php");

    let productos = await resultado.json();
    return productos["items"];
}

//guarda los productos en el respectivo vector para ser usados posteriormente
let guardarProductos = async () => {
    vProductos = await traerProductos();
};

let traerCompras = async () => {
    let resultado = await fetch("http://localhost:3000/compras/listarcompras");

    let compras = await resultado.json();
    return compras;
}

let mostrarCompras = async () => {
    vCompras = await traerCompras();

    if (vCompras.length > 0) {
        let filaCompras = document.getElementById('filaCompras');

        vCompras.forEach(compra => {
            filaCompras.insertAdjacentHTML('beforeend', `
                
                <div id="${compra.idCompra}" cartaItem="true" class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
                    <div class="card-body mt-2 mx-auto">
                        <h5 btnAcciones idventa="${compra.idCompra}" class="puntosAcciones m-2 w-25">...</h5>
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

let renderItem = (numeroItem, vProductos_) => {

    //agrega un nuevo item de la venta al html
    document.getElementById("rowItems").insertAdjacentHTML('beforeend', `
        <div id="item${numeroItem}" class="border border-dark rounded item p-2 mx-auto my-3 col-11 col-md-9 col-lg-5">
            <div class="containerBtn">
                <div id="dlt${numeroItem}" class="btnEliminar"></div>
            </div>
            <select id="slc${numeroItem}" class="form-select col-9 mb-2 mt-1" aria-label="Default select example">
                <option selected>Selecciona el producto</option>
            </select>
            <div id="slidecontainer${numeroItem}" class="">
                <div class="row">
                    <div class="col-7 col-lg-5 mx-auto">
                        <label for="1">Unidades compradas:</label>
                        <input disabled id="1" type="number" min="1" max="100" value="50" class="sliderslc${numeroItem} w-100">
                    </div>
                    <div class="col-7 col-lg-5 mx-auto">
                        <label for="1">Valor unitario:</label>
                        <input disabled id="1" type="number" min="1" max="100" value="50" class="sliderslc${numeroItem} w-100">
                    </div>
                </div>
                <p id="p${numeroItem}" class="mx-auto mt-2 mb-0 text-center">Actualmente tienes 1. Quedarás con 20.</p>
            </div>
        </div>

        `);

    // //pone todos los productos que se traigan en el select del item creado

    vProductos_.forEach(producto => {
        document.getElementById("slc" + numeroItem).insertAdjacentHTML("beforeend", `
         <option value="${producto.idProducto}">${producto.nombreProducto}</option>`)
    });
}

let configModalReg = () => {

    document.getElementById("formCompras").reset();
    document.getElementById('btnGuardar').disabled = false;
    document.getElementById('divAcciones').classList.add("d-none");
    document.getElementById('rowItems').innerHTML = "";
    document.getElementById('btnGuardar').innerHTML = "Guardar";

}

let habilitarSlider = (slider, stockActual) => {
    //habilita el input range
    slider.removeAttribute("disabled");
    //setea el valor maximo(stock actual del prod)
    slider.setAttribute("max", stockActual);
    slider.setAttribute("value", 1);
    //genera el nuevo stock del producto
    let nuevoStock = (slider.max - slider.value);
    //imprime las unidades actuales  y el stock restante
    slider.nextElementSibling.innerHTML = (slider.value + " unidades. " + nuevoStock + " restantes");
}

let actualizarCrearItem = (item, disparador, vector) => {

    //si el disparador existe lo actualiza, sino lo crea
    if (item != undefined) {
        vProductos.forEach(producto => {
            if (disparador.value == producto.idProducto) {
                vector[vector.indexOf(item)] = {
                    idItem: disparador.parentElement.id,
                    idProducto: producto.idProducto,
                    precioVenta: producto.precioVenta,
                    unidVend: parseInt(slider.value),
                    porcentajeIva: producto.porcentajeIva,
                    nuevoStock: producto.stockProducto
                }
            }
        });
    } else {
        agregarItem(disparador, vector);
    }
    divModal.getAttribute("editar") == "true" ? vrTotalEditar(vector) : vrTotalRegistar(vector);
}