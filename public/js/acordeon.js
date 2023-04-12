let secciones = [{
    nombreSeccion: 'Mejores clientes',
    idSeccion: 'mejoresClientes'
},
{
    nombreSeccion: 'Productos mas vendidos',
    idSeccion: 'prodMasVend'
},
{
    nombreSeccion: 'Productos menos vendidos',
    idSeccion: 'prodMenVend'
},
{
    nombreSeccion: 'Productos mas rentables',
    idSeccion: 'prodMasRentables'
},
{
    nombreSeccion: 'Mayor Egreso',
    idSeccion: 'mayorEgreso'
},
{
    nombreSeccion: 'Menor Egreso',
    idSeccion: 'menorEgreso'
},
{
    nombreSeccion: 'Producto con mayor stock',
    idSeccion: 'prodMasStock'
},
{
    nombreSeccion: 'Producto con menor stock',
    idSeccion: 'prodMenStock'
}]

secciones.forEach((elemento, i) => {
   if(i == 0){
        document.getElementById('acordeonBalances').insertAdjacentHTML('beforeend', `
        <div class="accordion-item">
            <h2 class="accordion-header" id="titulo${elemento.idSeccion}" style="background-color: #68AEBD;">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#${elemento.idSeccion}" aria-expanded="true" aria-controls="${elemento.idSeccion}">
                ${elemento.nombreSeccion}
            </button>
            </h2>
            <div id="${elemento.idSeccion}" class="accordion-collapse collapse show" aria-labelledby="titulo${elemento.idSeccion}" data-bs-parent="#accordionExample">
                <div class="accordion-body">
                    <div id="cuerpo${elemento.idSeccion}" class="row">

                    </div>
                </div>
            </div>
        </div>
        `);
   } else {
        document.getElementById('acordeonBalances').insertAdjacentHTML('beforeend', `
        <div class="accordion-item">
            <h2 class="accordion-header" id="titulo${elemento.idSeccion}">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#${elemento.idSeccion}" aria-expanded="true" aria-controls="${elemento.idSeccion}">
                ${elemento.nombreSeccion}
            </button>
            </h2>
            <div id="${elemento.idSeccion}" class="accordion-collapse collapse" aria-labelledby="titulo${elemento.idSeccion}" data-bs-parent="#accordionExample">
            <div class="accordion-body">
                    <div id="cuerpo${elemento.idSeccion}" class="row">

                    </div>
                </div>
            </div>
        </div>
        `);
   }
});

//consumir API
let datosAcordeon; // declarar una variable global para guardar los datos

function renderMejoresClientes() {
    let mejoresClientes = JSON.parse(datosAcordeon.mejoresClientes);
    mejoresClientes.forEach(cliente => {
        document.getElementById('cuerpomejoresClientes').insertAdjacentHTML('beforeend', `
        <div class="col-7 col-lg-3 p-3 my-2 mx-auto m-lg-auto text-center fs-4 border border-dark border-1 rounded-pill">
          ${cliente.nombresCliente}
        </div>        
        `);
    });
}

function renderProductosMasVend() {
    let productosMasVendidos = JSON.parse(datosAcordeon.productosMasVendidos);
    productosMasVendidos.forEach(producto => {
        document.getElementById('cuerpoprodMasVend').insertAdjacentHTML('beforeend', `
        <div class="card border-0 col-4 mx-auto" style="width: 10rem;">
            <img src="./../../public/img/productos/${producto.nombreImagen}" class="border border-2 card-img-top" alt="...">
            <div class="card-body">
                <p class="card-text text-center fs-5">${producto.nombreProducto}</p>
            </div>
        </div>      
        `);
    });
}

function renderProductosMenVend() {
    let productosMenosVendidos = JSON.parse(datosAcordeon.productosMenosVendidos);
    productosMenosVendidos.forEach(producto => {
        document.getElementById('cuerpoprodMenVend').insertAdjacentHTML('beforeend', `
        <div class="card border-0 col-4 mx-auto" style="width: 10rem;">
            <img src="./../../public/img/productos/${producto.nombreImagen}"
                class="border border-2 card-img-top" alt="...">
            <div class="card-body">
                <p class="card-text text-center fs-5">${producto.nombreProducto}</p>
            </div>
        </div>      
        `);
    });
}

function renderProductosMasRentables() {
    let productosMasRentables = JSON.parse(datosAcordeon.productosMasRentables);
    productosMasRentables.forEach(producto => {
        document.getElementById('cuerpoprodMasRentables').insertAdjacentHTML('beforeend', `
        <div class="card border-0 col-4 mx-auto" style="width: 10rem;">
            <img src="./../../public/img/productos/${producto.nombreImagen}"
                class="border border-2 card-img-top" alt="...">
            <div class="card-body">
                <p class="card-text text-center fs-5">${producto.nombreProducto}</p>
            </div>
        </div>      
        `);
    });
}

function renderResumenEgresos() {
    let mayorEgreso = JSON.parse(datosAcordeon.mayorEgreso);
    mayorEgreso.forEach(producto => {
        document.getElementById('cuerpomayorEgreso').insertAdjacentHTML('beforeend', `
        <p class="card-text text-center fs-4">Mayor Egreso:</p>
        <div class="col-7 col-lg-4 p-2 my-2 mx-auto m-lg-auto text-center fs-4 border border-dark border-1 rounded-pill" background-color: #73C7DA">
            <h4 class="card-title">${producto.tituloEgreso}</h4>
            <p class="card-text">$${producto.mayorValor}</p>
        </div>
        `);
    });
    let menorEgreso = JSON.parse(datosAcordeon.menorEgreso);
    menorEgreso.forEach(producto => {
        document.getElementById('cuerpomenorEgreso').insertAdjacentHTML('beforeend', `
        <p class="card-text text-center fs-4">Menor Egreso:</p>
        <div class="col-10 col-lg-4 p-2 my-2 mx-auto m-lg-auto text-center fs-4 border border-dark border-1 rounded-pill">
            <h4 class="card-title">${producto.tituloEgreso}</h4>
            <p class="card-text">$${producto.mayorValor}</p>
        </div>
        `);
    });
}

function renderResumenStock() {
    let productosMayorStock = JSON.parse(datosAcordeon.productosMayorStock);
    productosMayorStock.forEach(producto => {
        document.getElementById('cuerpoprodMasStock').insertAdjacentHTML('beforeend', `
            <div class="card mx-auto mt-3" style="width: 400px;">
                <div class="row no-gutters">
                    <div class="col-md-4">
                    <img src="./../../public/img/productos/${producto.nombreImagen}" class="border border-2 card-img-top" alt="...">
                    </div>
                    <div class="col-md-8">
                    <div class="card-body">
                        <h4 class="card-title">${producto.nombreProducto}</h4>
                        <p class="card-text">${producto.stockMayor} Unidades disponibles</p>
                    </div>
                    </div>
                </div>
            </div>

        `);
    });
    let productosMenorStock = JSON.parse(datosAcordeon.productosMenorStock);
    productosMenorStock.forEach(producto => {
        document.getElementById('cuerpoprodMenStock').insertAdjacentHTML('beforeend', `
        <div class="card mx-auto mt-3" style="width: 400px;">
            <div class="row no-gutters">
                <div class="col-md-8">
                    <div class="card-body">
                        <h4 class="card-title">${producto.nombreProducto}</h4>
                        <p class="card-text">${producto.stockMayor} Unidades disponibles</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <img src="./../../public/img/productos/${producto.nombreImagen}" class="border border-2 card-img-top" alt="...">
                </div>
            </div>
        </div>    
        `);
    });
}

async function traerDatosAcordeon() {
    let resDatosAcordeon = await fetch('http://localhost:3000/acordeon');
    let datos = await resDatosAcordeon.json();
    datosAcordeon = datos; // asignar los datos obtenidos a la variable global
    renderMejoresClientes();
    renderProductosMasVend();
    renderProductosMenVend();
    renderProductosMasRentables();
    renderResumenEgresos();
    renderResumenStock();
}

traerDatosAcordeon(); // llamar la función para obtener los datos