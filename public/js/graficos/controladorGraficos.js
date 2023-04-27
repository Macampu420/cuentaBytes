let hoy = moment();
let ayer = moment().subtract(1, 'days');
let datosProductos;
let datosClientes;

window.onload = async () => {
    datosProductos = await traerDatosProductos(hoy, ayer, 'dias');
    mostrarDatosProductoHora(datosProductos, "existenciaProductos", "existencia");
}

document.addEventListener("DOMContentLoaded", function() {
    let reportes = [
        "Existencia productos",
        "Mayor existencia",
        "Menor existencia",
        "Mayor rentabilidad",
        "Menor rentabilidad",
        "Productos mas vendidos",
        "Productos menos vendidos"
    ];
    reportes.forEach(function(value) {
        document.getElementById("containerDropdownProductos").insertAdjacentHTML("beforeend", `<li><a id="${value.replace(/ /g, "-")}" class="dropdown-item" href="#">${value}</a></li>`);
    });
}); 

document.getElementById("containerDropdownProductos").addEventListener("click",event => {

    let tipoBalance = convertirACamelCase(event.target.id.replace(/-/g, " "));

    switch (tipoBalance) {
        case "existenciaProductos":
            mostrarDatosProductoHora(datosProductos, tipoBalance, "existencia");
            break;
        case "mayorExistencia":
            mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
            break;
        case "mayorRentabilidad":
            mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
            break;
        case "mejoresProductos":
            mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
            break;
        case "menorExistencia":
            mostrarDatosProductoHora(datosProductos, tipoBalance, "menorExistencia");
            break;
        case "peorRentabilidad":
            mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
            break;
        case "peoresProductos":
            mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
            break;

    }

    graficoProductos.data
})

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