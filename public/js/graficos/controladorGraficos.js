import modeloGraficos from "./acordeon.js";

const objModeloGraficos = new modeloGraficos();
const hoy = moment();
const ayer = moment().subtract(1, 'days');
let datosProductos, datosVentas;
let swTipoGrafico = 'horas';
const seccionesAcordeon = [
    {
        id: "acordionProductos",
        titulo: "Productos",
        dropdown: {
            id: "dropdownProductos",
            opciones: [
                "Existencia productos",
                "Mayor existencia",
                "Menor existencia",
                "Mayor rentabilidad",
                "Menor rentabilidad",
                "Productos mas vendidos",
                "Productos menos vendidos"
            ],
            container: "containerDropdownProductos"
        },
        canvasId: "canvaProductos",
        slcpFecha: "slcFechaGraficoProductos",
        pFecha: "pFechaGraficoProductos",
        callbackFecha: async function(pInicio, pFin){
            let inicio = pInicio.format('YYYY-MM-DD');
            let fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
                
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                objModeloGraficos.actualizarGraficoProductos(inicio, fin, "horas");
            } else {
                objModeloGraficos.actualizarGraficoProductos(inicio, fin, "dias");
            }
            objModeloGraficos.mostrarRango(inicio, fin, "pFechaGraficoProductos");
        },
    }, {
        id: "acordionVentas",
        titulo: "Ventas",
        dropdown: {
            id: "dropdownVentas",
            opciones: ["Total ventas", "Mejores ventas", "Menores ventas"],
            container: "containerDropdownVentas"
        },
        canvasId: "canvaVentas",
        slcpFecha: "slcFechaGraficoVentas",
        pFecha: "pFechaGraficoVentas",
        callbackFecha: async function(pInicio, pFin) {
            let inicio = pInicio.format('YYYY-MM-DD');
            let fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
    
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                datosVentas = await objModeloGraficos.traerDatosVentas(pInicio, pFin, "horas");
                console.log(datosVentas);
                objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasHoras', 'vrTotalVta', 'hora', 'Total de ventas');
                swTipoGrafico = 'horas';
            } else {
                datosVentas = await objModeloGraficos.traerDatosVentas(inicio, fin, "dias");
                console.log(datosVentas);
                objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasDias', 'vrTotalDia', 'Dia', 'Total de ventas', 'Total de ventas');
                swTipoGrafico = 'dias';
            }
            objModeloGraficos.mostrarRango(inicio, fin, "pFechaGraficoVentas");
        }
    }, {
        id: "compras",
        titulo: "Compras",
        dropdown: {
            id: "dropdownCompras",
            opciones: ["Opción 1", "Opción 2", "Opción 3"],
            container: "containerDropdownCompras"
        },
        canvasId: "canvaCompras",
        slcpFecha: "slcFechaGraficoCompras",
        pFecha: "pFechaGraficoCompras",
        callbackFecha: async function(pInicio, pFin) {
            let hoy = moment();
            let ayer =  moment().subtract(1, 'day').format('YYYY-MM-DD');
            inicio = pInicio.format('YYYY-MM-DD');
            fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
    
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                actualizarGrafico(inicio, fin, "horas");
            } else {
                actualizarGrafico(inicio, fin, "dias");
            }
            mostrarRango(inicio, fin, this.pFecha);
        }
    },{
        id: "acordionEgresos",
        titulo: "Egresos",
        dropdown: {
            id: "dropdownEgresos",
            opciones: ["Opción 1", "Opción 2", "Opción 3"],
            container: "containerDropdownEgresos"
        },
        canvasId: "canvaEgresos",
        slcpFecha: "slcFechaGraficoEgresos",
        pFecha: "pFechaGraficoEgresos",
        callbackFecha: async function(pInicio, pFin) {
            let hoy = moment();
            let ayer =  moment().subtract(1, 'day').format('YYYY-MM-DD');
            inicio = pInicio.format('YYYY-MM-DD');
            fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
    
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                actualizarGrafico(inicio, fin, "horas");
            } else {
                actualizarGrafico(inicio, fin, "dias");
            }
            mostrarRango(inicio, fin, this.pFecha);
        }
    },{
        id: "acordionClientes",
        titulo: "Clientes",
        dropdown: {
            id: "dropdownClientes",
            opciones: ["Opción 1", "Opción 2", "Opción 3"],
            container: "containerDropdownClientes"
        },
        canvasId: "canvaClientes",
        slcpFecha: "slcFechaGraficoClientes",
        pFecha: "pFechaGraficoClientes",
        callbackFecha: async function(pInicio, pFin) {
            let hoy = moment();
            let ayer =  moment().subtract(1, 'day').format('YYYY-MM-DD');
            inicio = pInicio.format('YYYY-MM-DD');
            fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
    
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                actualizarGrafico(inicio, fin, "horas");
            } else {
                actualizarGrafico(inicio, fin, "dias");
            }
            mostrarRango(inicio, fin, this.pFecha);
    } 
    }
];

document.addEventListener("DOMContentLoaded", async function () {

    //una vez cargado todo el DOM se crean todas las secciones del acordeon dinamicamente
    seccionesAcordeon.forEach((seccion) => {
        //se crea el layout de cada item del acordeon
        document.getElementById("acordeonBalances").insertAdjacentHTML('beforeend', objModeloGraficos.generarSeccionAccordion(seccion.titulo, seccion.id, seccion.dropdown.id, seccion.slcpFecha, seccion.pFecha, seccion.canvasId, seccion.dropdown.container));

        //se crean los dropdowns de cada item del acordeon
        objModeloGraficos.generarReportesDropdown(seccion.dropdown.opciones, seccion.dropdown.container);
        
        //jquery necesario para el funcionamiento de los date picker
        //creacion y configuracion de los elementos datePicker
        objModeloGraficos.crearDatePickers(seccion.slcpFecha, seccion.callbackFecha);
        objModeloGraficos.mostrarRango(hoy.format('YYYY-MM-DD'), hoy.format('YYYY-MM-DD'), seccion.pFecha);

    });

    objModeloGraficos.crearGraficos();

    //se traen los datos para la seccion de productos
    datosProductos = await objModeloGraficos.traerDatosProductos(hoy, ayer, 'dias');
    objModeloGraficos.mostrarDatosProductoHora(datosProductos, "existenciaProductos", "existencia");

    datosVentas = await objModeloGraficos.traerDatosVentas(hoy, hoy, 'horas');
    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasHoras', 'vrTotalVta', 'hora', 'Total de ventas');

    document.getElementById("containerDropdownProductos").addEventListener("click", event => {

        let tipoBalance = objModeloGraficos.convertirACamelCase(event.target.id.replace(/-/g, " "));

        switch (tipoBalance) {
            case "existenciaProductos":
                objModeloGraficos.mostrarDatosProductoHora(datosProductos, tipoBalance, "existencia");
                break;
            case "mayorExistencia":
                objModeloGraficos.mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
                break;
            case "mayorRentabilidad":
                objModeloGraficos.mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
                break;
            case "mejoresProductos":
                objModeloGraficos.mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
                break;
            case "menorExistencia":
                objModeloGraficos.mostrarDatosProductoHora(datosProductos, tipoBalance, "menorExistencia");
                break;
            case "peorRentabilidad":
                objModeloGraficos.mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
                break;
            case "peoresProductos":
                objModeloGraficos.mostrarDatosProductoHora(datosProductos, tipoBalance, "existenciaMayor");
                break;

        }

    });

    document.getElementById('containerDropdownVentas').addEventListener('click', event => {

        let tipoBalance = objModeloGraficos.convertirACamelCase(event.target.id.replace(/-/g, " "));

        if (swTipoGrafico == 'horas') {
            switch (tipoBalance) {
                case "totalVentas":
                    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasHoras', 'vrTotalVta', 'hora', 'Total de ventas');
                    break;
                case "mejoresVentas":
                    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosMejoresVentasHoras', 'vrTotalVta', 'hora', 'Mejores ventas');
                    break;
                case "menoresVentas":
                    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosMenoresVentasHoras', 'vrTotalVta', 'hora', 'Menores ventas');
                    break;
            }
        } else {
            switch (tipoBalance) {
                case "totalVentas":
                    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasDias', 'vrTotalDia', 'Dia', 'Total de ventas');
                    break;
                case "mejoresVentas":
                    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosMejoresVentasDias', 'vrTotalDia', 'Dia', 'Mejores ventas');
                    break;
                case "menoresVentas":
                    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosMenoresVentasDias', 'vrTotalDia', 'Dia', 'Menores ventas');
                    break;
            }
        }

    })
});