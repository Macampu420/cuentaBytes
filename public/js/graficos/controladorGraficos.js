let hoy = moment();
let ayer = moment().subtract(1, 'days');
let datosProductos;
let datosClientes;
let graficoProductos, graficoVentas, graficoCompras, graficoEgresos, graficoClientes;

const seccionesAcordeon = [
    {
        id: "acordionProductos",
        titulo: "Productos",
        dropdown: {
            id: "dropdownProductos",
            opciones: ["Opción 1", "Opción 2", "Opción 3"],
            container: "containerDropdownProductos"
        },
        canvasId: "canvaProductos",
        fechaId: "pFechaGraficoProductos",
        fechaTexto: "Estas viendo este reporte desde hoy hasta ayer",
    }, {
        id: "acordionVentas",
        titulo: "Ventas",
        dropdown: {
            id: "dropdownVentas",
            opciones: ["Opción 1", "Opción 2", "Opción 3"],
            container: "containerDropdownVentas"
        },
        canvasId: "canvaVentas",
        fechaId: "pFechaGraficoVentas",
        fechaTexto: "Estas viendo este reporte desde hoy hasta ayer",
    }, {
        id: "compras",
        titulo: "Compras",
        dropdown: {
            id: "dropdownCompras",
            opciones: ["Opción 1", "Opción 2", "Opción 3"],
            container: "containerDropdownCompras"
        },
        canvasId: "canvaCompras",
        fechaId: "pFechaGraficoCompras",
        fechaTexto: "Estas viendo este reporte desde hoy hasta ayer",
    },{
        id: "acordionEgresos",
        titulo: "Egresos",
        dropdown: {
            id: "dropdownEgresos",
            opciones: ["Opción 1", "Opción 2", "Opción 3"],
            container: "containerDropdownEgresos"
        },
        canvasId: "canvaEgresos",
        fechaId: "pFechaGraficoEgresos",
        fechaTexto: "Estas viendo este reporte desde hoy hasta ayer",
    },{
        id: "acordionClientes",
        titulo: "Clientes",
        dropdown: {
            id: "dropdownClientes",
            opciones: ["Opción 1", "Opción 2", "Opción 3"],
            container: "containerDropdownClientes"
        },
        canvasId: "canvaClientes",
        fechaId: "pFechaGraficoClientes",
        fechaTexto: "Estas viendo este reporte desde hoy hasta ayer",
    }
];

document.addEventListener("DOMContentLoaded", async function() {
    //una vez cargado todo el DOM se crean todas las secciones del acordeon dinamicamente
    seccionesAcordeon.forEach(seccion => {
        document.getElementById("acordeonBalances").insertAdjacentHTML('beforeend', generarSeccionAccordion(seccion.titulo, seccion.id, seccion.dropdown.id, seccion.fechaId, seccion.canvasId, seccion.fechaId, seccion.dropdown.container));
    });

    //se traen los datos para la seccion de productos
    datosProductos = await traerDatosProductos(hoy, ayer, 'dias');
    
    graficoProductos = new Chart(document.getElementById('canvaProductos'), {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                label: "Productos",
                data: [],
            }]
        },
        options: {
            plugins: {
                legend:{
                    display: false
                }
            }
        }
    });

    graficoVentas = new Chart(document.getElementById('canvaVentas'), {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                label: "Ventas",
                data: [],
            }]
        },
        options: {
            plugins: {
                legend:{
                    display: false
                }
            }
        }
    });

    graficoCompras = new Chart(document.getElementById('canvaCompras'), {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                label: "Compras",
                data: [],
            }]
        },
        options: {
            plugins: {
                legend:{
                    display: false
                }
            }
        }
    });

    graficoEgresos = new Chart(document.getElementById('canvaEgresos'), {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                label: "",
                data: [],
            }]
        },
        options: {
            plugins: {
                legend:{
                    display: false
                }
            }
        }
    });

    graficoClientes = new Chart(document.getElementById('canvaClientes'), {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                label: "",
                data: [],
            }]
        },
        options: {
            plugins: {
                legend:{
                    display: false
                }
            }
        }
    });


    mostrarDatosProductoHora(graficoProductos, datosProductos, "existenciaProductos", "existencia");

    let reportes = [
        "Existencia productos",
        "Mayor existencia",
        "Menor existencia",
        "Mayor rentabilidad",
        "Menor rentabilidad",
        "Productos mas vendidos",
        "Productos menos vendidos"
    ];
    // reportes.forEach(function(value) {
    //     document.getElementById("containerDropdownProductos").insertAdjacentHTML("beforeend", `<li><a id="${value.replace(/ /g, "-")}" class="dropdown-item" href="#">${value}</a></li>`);
    // });

    

    
}); 

// document.getElementById("containerDropdownProductos").addEventListener("click",event => {

//     let tipoBalance = convertirACamelCase(event.target.id.replace(/-/g, " "));

//     switch (tipoBalance) {
//         case "existenciaProductos":
//             mostrarDatosProductoHora(datosProductos, tipoBalance, "existencia");
//             break;
//         case "mayorExistencia":
//             mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
//             break;
//         case "mayorRentabilidad":
//             mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
//             break;
//         case "mejoresProductos":
//             mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
//             break;
//         case "menorExistencia":
//             mostrarDatosProductoHora(datosProductos, tipoBalance, "menorExistencia");
//             break;
//         case "peorRentabilidad":
//             mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
//             break;
//         case "peoresProductos":
//             mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
//             break;

//     }

//     graficoProductos.data
// })

//jquery necesario para el funcionamiento del date picker
$(function () {
    //creacion y configuracion del rangepicker sobre el elemento #reportrange
    $('#dropdownFechaProductos').daterangepicker({
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