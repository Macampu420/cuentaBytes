let secciones = [
{
    nombreSeccion: 'Ventas',
    idSeccion: 'graficosVentas'
},
{
    nombreSeccion: 'Egresos',
    idSeccion: 'graficosEgresos'
},
{
    nombreSeccion: 'Compras',
    idSeccion: 'graficosCompras'
},
{
    nombreSeccion: 'Clientes',
    idSeccion: 'graficosClientes'
},
{
    nombreSeccion: 'Productos',
    idSeccion: 'GraficosProductos'
}]

const data = [
    { year: 2010, count: 10 },
    { year: 2011, count: 20 },
    { year: 2012, count: 15 },
    { year: 2013, count: 25 },
    { year: 2014, count: 22 },
    { year: 2015, count: 30 },
    { year: 2016, count: 28 },
  ];

  new Chart(
      document.getElementById('canva1'), {
          type: 'bar',
          data: {
              labels: data.map(row => row.year),
              datasets: [{
                  label: 'Acquisitions by year',
                  data: data.map(row => row.count)
              }]
          }
      }
  );

  // muestra desde hasta cuando se hara el PyG
let mostrarRango = (inicio, fin) => document.querySelector('#pFechaGrafico').innerHTML = ('Estas viendo este reporte Desde: ' + inicio + '. - Hasta: ' + fin);


//jquery necesario para el funcionamiento del date picker
$(function () {
    //creacion y configuracion del rangepicker sobre el elemento #reportrange
    $('#dropdownFecha').daterangepicker({
            locale: {
                format: "YYYY-MM-DD"
            },
            ranges: {
                'Hoy': [moment(), moment()],
                'Ayer': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                'Ultimos 7 dias': [moment().subtract(6, 'days'), moment()],
                'Ultimos 30 dias': [moment().subtract(29, 'days'), moment()],
                'Ultimo mes': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            }
        },
        //callback para cada vez que se ejecute  un cambio de fecha
        async function (pInicio, pFin) {
            inicio = pInicio.format('YYYY-MM-DD');
            fin = pFin.format('YYYY-MM-DD');

            let fechaSeleccionada = pInicio.clone().startOf('day');

            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                actualizarGrafico(inicio, fin, "horas");
            } else {
                actualizarGrafico(inicio, fin, "dias");
            }
            mostrarRango(inicio, fin);
        });
});

// secciones.forEach((elemento, i) => {
//     document.getElementById('accordionExample').insertAdjacentHTML('beforeend', `
//     <div class="accordion-item">
//     <h2 class="accordion-header" id="heading${i}">
//         <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
//             data-bs-target="#collapse${i}" aria-expanded="false" aria-controls="collapse${i}">
//             ${elemento.nombreSeccion}
//         </button>
//     </h2>
//     <div id="collapse${i}" class="accordion-collapse collapse" aria-labelledby="heading${i}"
//         data-bs-parent="#accordionExample">
//         <div class="accordion-body">
//             <strong>This is the second item's accordion body.</strong> It is hidden by default,
//             until the collapse plugin adds the appropriate classes that we use to style each
//             element. These classes control the overall appearance, as well as the showing and
//             hiding via CSS transitions. You can modify any of this with custom CSS or overriding
//             our default variables. It's also worth noting that just about any HTML can go within
//             the <code>.accordion-body</code>, though the transition does limit overflow.
//         </div>
//     </div>
// </div>

//     `);
// });

// //consumir API
// let datosAcordeon; // declarar una variable global para guardar los datos

// function renderMejoresClientes() {
//     let mejoresClientes = JSON.parse(datosAcordeon.mejoresClientes);
//     mejoresClientes.forEach(cliente => {
//         document.getElementById('cuerpomejoresClientes').insertAdjacentHTML('beforeend', `
//         <div class="col-7 col-lg-3 p-3 my-2 mx-auto m-lg-auto text-center fs-4 border border-dark border-1 rounded-pill">
//           ${cliente.nombresCliente}
//         </div>        
//         `);
//     });
// }

// function renderProductosMasVend() {
//     let productosMasVendidos = JSON.parse(datosAcordeon.productosMasVendidos);
//     productosMasVendidos.forEach(producto => {
//         document.getElementById('cuerpoprodMasVend').insertAdjacentHTML('beforeend', `
//         <div class="card border-0 col-4 mx-auto" style="width: 10rem;">
//             <img src="./../../public/img/productos/${producto.nombreImagen}" class="border border-2 card-img-top" alt="...">
//             <div class="card-body">
//                 <p class="card-text text-center fs-5">${producto.nombreProducto}</p>
//             </div>
//         </div>      
//         `);
//     });
// }

// function renderProductosMenVend() {
//     let productosMenosVendidos = JSON.parse(datosAcordeon.productosMenosVendidos);
//     productosMenosVendidos.forEach(producto => {
//         document.getElementById('cuerpoprodMenVend').insertAdjacentHTML('beforeend', `
//         <div class="card border-0 col-4 mx-auto" style="width: 10rem;">
//             <img src="./../../public/img/productos/${producto.nombreImagen}"
//                 class="border border-2 card-img-top" alt="...">
//             <div class="card-body">
//                 <p class="card-text text-center fs-5">${producto.nombreProducto}</p>
//             </div>
//         </div>      
//         `);
//     });
// }

// function renderProductosMasRentables() {
//     let productosMasRentables = JSON.parse(datosAcordeon.productosMasRentables);
//     productosMasRentables.forEach(producto => {
//         document.getElementById('cuerpoprodMasRentables').insertAdjacentHTML('beforeend', `
//         <div class="card border-0 col-4 mx-auto" style="width: 10rem;">
//             <img src="./../../public/img/productos/${producto.nombreImagen}"
//                 class="border border-2 card-img-top" alt="...">
//             <div class="card-body">
//                 <p class="card-text text-center fs-5">${producto.nombreProducto}</p>
//             </div>
//         </div>      
//         `);
//     });
// }

// function renderResumenEgresos() {
//     let mayorEgreso = JSON.parse(datosAcordeon.mayorEgreso);
//     mayorEgreso.forEach(producto => {
//         document.getElementById('cuerpomayorEgreso').insertAdjacentHTML('beforeend', `
//         <p class="card-text text-center fs-4">Mayor Egreso:</p>
//         <div class="col-7 col-lg-4 p-2 my-2 mx-auto m-lg-auto text-center fs-4 border border-dark border-1 rounded-pill" background-color: #73C7DA">
//             <h4 class="card-title">${producto.tituloEgreso}</h4>
//             <p class="card-text">$${producto.mayorValor}</p>
//         </div>
//         `);
//     });
//     let menorEgreso = JSON.parse(datosAcordeon.menorEgreso);
//     menorEgreso.forEach(producto => {
//         document.getElementById('cuerpomenorEgreso').insertAdjacentHTML('beforeend', `
//         <p class="card-text text-center fs-4">Menor Egreso:</p>
//         <div class="col-10 col-lg-4 p-2 my-2 mx-auto m-lg-auto text-center fs-4 border border-dark border-1 rounded-pill">
//             <h4 class="card-title">${producto.tituloEgreso}</h4>
//             <p class="card-text">$${producto.mayorValor}</p>
//         </div>
//         `);
//     });
// }

// function renderResumenStock() {
//     let productosMayorStock = JSON.parse(datosAcordeon.productosMayorStock);
//     productosMayorStock.forEach(producto => {
//         document.getElementById('cuerpoprodMasStock').insertAdjacentHTML('beforeend', `
//             <div class="card mx-auto mt-3" style="width: 400px;">
//                 <div class="row no-gutters">
//                     <div class="col-md-4">
//                     <img src="./../../public/img/productos/${producto.nombreImagen}" class="border border-2 card-img-top" alt="...">
//                     </div>
//                     <div class="col-md-8">
//                     <div class="card-body">
//                         <h4 class="card-title">${producto.nombreProducto}</h4>
//                         <p class="card-text">${producto.stockMayor} Unidades disponibles</p>
//                     </div>
//                     </div>
//                 </div>
//             </div>

//         `);
//     });
//     let productosMenorStock = JSON.parse(datosAcordeon.productosMenorStock);
//     productosMenorStock.forEach(producto => {
//         document.getElementById('cuerpoprodMenStock').insertAdjacentHTML('beforeend', `
//         <div class="card mx-auto mt-3" style="width: 400px;">
//             <div class="row no-gutters">
//                 <div class="col-md-8">
//                     <div class="card-body">
//                         <h4 class="card-title">${producto.nombreProducto}</h4>
//                         <p class="card-text">${producto.stockMayor} Unidades disponibles</p>
//                     </div>
//                 </div>
//                 <div class="col-md-4">
//                     <img src="./../../public/img/productos/${producto.nombreImagen}" class="border border-2 card-img-top" alt="...">
//                 </div>
//             </div>
//         </div>    
//         `);
//     });
// }

// async function traerDatosAcordeon() {
//     let resDatosAcordeon = await fetch('http://localhost:3000/acordeon');
//     let datos = await resDatosAcordeon.json();
//     datosAcordeon = datos; // asignar los datos obtenidos a la variable global
//     renderMejoresClientes();
//     renderProductosMasVend();
//     renderProductosMenVend();
//     renderProductosMasRentables();
//     renderResumenEgresos();
//     renderResumenStock();
// }

// traerDatosAcordeon(); // llamar la función para obtener los datos