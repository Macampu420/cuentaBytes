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
            <h2 class="accordion-header" id="titulo${elemento.idSeccion}">
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
        <div class="col-7 col-lg-3 p-3 my-2 mx-auto m-lg-auto text-center fs-4 border border-dark border-2 rounded-pill">
          ${cliente.nombresCliente}
        </div>        
        `);
    });
}


traerDatosAcordeon(); // llamar la función para obtener los datos