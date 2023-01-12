//trae todos los proveedores de la api y los devuelve como json
let traerProveedores = async () => {
    let resultado = await fetch("http://localhost/cuentabytes/src/controllers/proveedores/apiProveedor.php");

    let proveedores = await resultado.json();
    return proveedores["items"];
}

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

//pone todos los proveedores en el slc
let mostrarProveedores = async () => {
    let slcProveedores = document.getElementById("slcProveedor");
    vProveedores = await traerProveedores();

    vProveedores.forEach(proveedor => {
        slcProveedores.insertAdjacentHTML('beforeend', `<option value="${proveedor.idProveedor}">${proveedor.nombreProveedor}</option>`)
    })
};

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
                <input disabled type="range" min="1" max="100" value="50" class="slc${numeroItem}">
                <p id="pValor"></p>
            </div>
        </div>
        `);

    // //pone todos los productos que se traigan en el select del item creado

    vProductos_.forEach(producto => {
        document.getElementById("slc" + numeroItem).insertAdjacentHTML("beforeend", `
         <option value="${producto.idProducto}">${producto.nombreProducto}</option>`)
    });

    return numeroItem++;
}

let configModalReg = () => {

    document.getElementById("formCompras").reset();
    document.getElementById('btnGuardar').disabled = false;
    document.getElementById('divAcciones').classList.add("d-none");
    document.getElementById('rowItems').innerHTML = "";
    document.getElementById('btnGuardar').innerHTML = "Guardar";

}