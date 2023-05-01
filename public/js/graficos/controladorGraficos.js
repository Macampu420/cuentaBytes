import modeloGraficos from "./acordeon.js";

let datosProductos, datosVentas, datosCompras, datosClientes, datosEgresos;
let swTipoGraficoVentas = 'horas';
let swTipoGraficoCompras = 'horas';  
let swTipoGraficoEgresos = 'horas';

const hoy = moment();
const ayer = moment().subtract(1, 'days');
const objModeloGraficos = new modeloGraficos();
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
                objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasHoras', 'vrTotalVta', 'hora', 'Total de ventas');
                swTipoGraficoVentas = 'horas';
            } else {
                datosVentas = await objModeloGraficos.traerDatosVentas(inicio, fin, "dias");
                objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasDias', 'vrTotalDia', 'Dia', 'Total de ventas', 'Total de ventas');
                swTipoGraficoVentas = 'dias';
            }
            objModeloGraficos.mostrarRango(inicio, fin, "pFechaGraficoVentas");
        }
    }, {
        id: "compras",
        titulo: "Compras",
        dropdown: {
            id: "dropdownCompras",
            opciones: ["Total compras", "Mayores compras", "Menores compras"],
            container: "containerDropdownCompras"
        },
        canvasId: "canvaCompras",
        slcpFecha: "slcFechaGraficoCompras",
        pFecha: "pFechaGraficoCompras",
        callbackFecha: async function(pInicio, pFin) {
            let inicio = pInicio.format('YYYY-MM-DD');
            let fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
    
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                datosCompras = await objModeloGraficos.traerDatosCompras(pInicio, pFin, "horas");
                objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosTotalComprasHoras', 'vrTotalCompra', 'hora', 'Total de Compras');
                swTipoGraficoCompras = 'horas';
            } else {
                datosCompras = await objModeloGraficos.traerDatosCompras(inicio, fin, "dias");
                objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosTotalComprasDias', 'vrTotalDia', 'Dia', 'Total de Compras');
                swTipoGraficoCompras = 'dias';
            }
            objModeloGraficos.mostrarRango(inicio, fin, "pFechaGraficoClientes");
        }
    },{
        id: "acordionEgresos",
        titulo: "Egresos",
        dropdown: {
            id: "dropdownEgresos",
            opciones: ["Total egresos", "Mayores egresos", "Menores egresos"],
            container: "containerDropdownEgresos"
        },
        canvasId: "canvaEgresos",
        slcpFecha: "slcFechaGraficoEgresos",
        pFecha: "pFechaGraficoEgresos",
        callbackFecha: async function(pInicio, pFin) {
            let inicio = pInicio.format('YYYY-MM-DD');
            let fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
    
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                datosEgresos = await objModeloGraficos.traerDatosEgresos(pInicio, pFin, "horas");
                objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosTotalEgresosHoras', 'vrTotalEgreso', 'hora', 'Total de Egresos');
                swTipoGraficoEgresos = 'horas';
            } else {
                datosEgresos = await objModeloGraficos.traerDatosEgresos(inicio, fin, "dias");
                objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosTotalEgresosDias', 'vrTotalDia', 'Dia', 'Total de Egresos');
                swTipoGraficoEgresos = 'dias';
            }
            objModeloGraficos.mostrarRango(inicio, fin, "pFechaGraficoClientes");
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
            let inicio = pInicio.format('YYYY-MM-DD');
            let fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
    
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                datosClientes = await objModeloGraficos.traerDatosClientes(pInicio, pFin, "horas");
                objModeloGraficos.mostrarDatosClientes(datosClientes, 'datosTotalClientesHoras', 'vrTotalCompra', 'hora', 'Total de Clientes');
                swTipoGraficoClientes = 'horas';
            } else {
                datosClientes = await objModeloGraficos.traerDatosClientes(inicio, fin, "dias");
                objModeloGraficos.mostrarDatosClientes(datosClientes, 'datosTotalClientesDias', 'vrTotalDia', 'Dia', 'Total de Clientes');
                swTipoGraficoClientes = 'dias';
            }
            objModeloGraficos.mostrarRango(inicio, fin, "pFechaGraficoClientes");
        }
    }
];
const conficInicialGraficos = {
    // Configuración del gráfico de productos
    configProductos: {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                data: [],
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: true,
                    onClick: null, // deshabilita la funcionalidad de ocultar datasets al hacer click
                }
            }
        }
    },
    // Configuración del gráfico de compras
    configCompras: {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                data: [],
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: true,
                    onClick: null, // deshabilita la funcionalidad de ocultar datasets al hacer click
                }
            }
        }
    },
    // Configuración del gráfico de ventas
    configVentas: {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                data: [],
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: true,
                    onClick: null, // deshabilita la funcionalidad de ocultar datasets al hacer click
                }
            }
        }
    },
    // Configuración del gráfico de egresos
    configEgresos: {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                data: [],
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: true,
                    onClick: null, // deshabilita la funcionalidad de ocultar datasets al hacer click
                }
            }
        }
    },
    // Configuración del gráfico de clientes
    configClientes: {
        type: 'bar',
        data: {
            labels: [],
            datasets: [{
                data: [],
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: true,
                    onClick: null, // deshabilita la funcionalidad de ocultar datasets al hacer click
                }
            }
        }
    }
}

let traerDataGraficos = async () => {
    //se traen los datos para la seccion de productos
    datosProductos = await objModeloGraficos.traerDatosProductos(hoy, ayer, 'dias');
    objModeloGraficos.mostrarDatosProductoHora(datosProductos, "existenciaProductos", "existencia");
    
    //se traen los datos para la seccion de ventas
    datosVentas = await objModeloGraficos.traerDatosVentas(hoy, hoy, 'horas');
    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasHoras', 'vrTotalVta', 'hora', 'Total de ventas');

    //se traen los datos para la seccion de compra
    datosCompras = await objModeloGraficos.traerDatosCompras(hoy, hoy, 'horas');
    objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosTotalComprasHoras', 'vrTotalCompra', 'hora', 'Total compras');

    //se traen los datos para la seccion de Egreso
    datosEgresos = await objModeloGraficos.traerDatosEgresos(hoy, hoy, 'horas');
    console.log(datosEgresos);
    objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosTotalEgresosHoras', 'vrTotalEgreso', 'hora', 'Total egresos');


    //se traen los datos para la seccion de Cliente
    // datosClientes = await objModeloGraficos.traerDatosClientes(hoy, hoy, 'horas');
    // objModeloGraficos.mostrarDatosClientes(datosClientes, 'datosTotalClientesHoras', 'vrTotalCompra', 'hora', 'Total clientes');
    
}

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

    let graficoClientes = new Chart(document.getElementById('canvaClientes'), conficInicialGraficos.configClientes);
    let graficoEgresos = new Chart(document.getElementById('canvaEgresos'), conficInicialGraficos.configEgresos);
    let graficoVentas = new Chart(document.getElementById('canvaVentas'), conficInicialGraficos.configVentas);
    let graficoCompras = new Chart(document.getElementById('canvaCompras'), conficInicialGraficos.configCompras);
    let graficoProductos = new Chart(document.getElementById('canvaProductos'), conficInicialGraficos.configProductos);

    objModeloGraficos.setGraficos(graficoProductos, graficoVentas, graficoCompras, graficoEgresos, graficoClientes);
    
    traerDataGraficos();

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

        if (swTipoGraficoVentas == 'horas') {
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

    });

    document.getElementById('containerDropdownCompras').addEventListener('click', event => {

        let tipoBalance = objModeloGraficos.convertirACamelCase(event.target.id.replace(/-/g, " "));

        if (swTipoGraficoCompras == 'horas') {
            switch (tipoBalance) {
                case "totalCompras":
                    objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosTotalComprasHoras', 'vrTotalCompra', 'hora', 'Total de Compras');
                    break;
                case "mayoresCompras":
                    objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosMejoresComprasHoras', 'vrTotalCompra', 'hora', 'Mayores Compras');
                    break;
                case "menoresCompras":
                    objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosMenoresComprasHoras', 'vrTotalCompra', 'hora', 'Menores Compras');
                    break;
            }
        } else {
            switch (tipoBalance) {
                case "totalCompras":
                    objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosTotalComprasDias', 'vrTotalDia', 'Dia', 'Total de Compras');
                    break;
                case "mayoresCompras":
                    objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosMejoresComprasDias', 'vrTotalDia', 'Dia', 'Mayores Compras');
                    break;
                case "menoresCompras":
                    objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosMenoresComprasDias', 'vrTotalDia', 'Dia', 'Menores Compras');
                    break;
            }
        }

    });

    document.getElementById('containerDropdownEgresos').addEventListener('click', event => {

        let tipoBalance = objModeloGraficos.convertirACamelCase(event.target.id.replace(/-/g, " "));

        if (swTipoGraficoEgresos == 'horas') {
            switch (tipoBalance) {
                case "totalEgresos":
                    objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosTotalEgresosHoras', 'vrTotalEgreso', 'hora', 'Total de Egresos');
                    break;
                case "mayoresEgresos":
                    objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosMejoresEgresosHoras', 'vrTotalEgreso', 'hora', 'Mayores Egresos');
                    break;
                case "menoresEgresos":
                    objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosMenoresEgresosHoras', 'vrTotalEgreso', 'hora', 'Menores Egresos');
                    break;
            }
        } else {
            switch (tipoBalance) {
                case "totalEgresos":
                    objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosTotalEgresosDias', 'vrTotalDia', 'Dia', 'Total de Egresos');
                    break;
                case "mayoresEgresos":
                    objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosMejoresEgresosDias', 'vrTotalDia', 'Dia', 'Mayores Egresos');
                    break;
                case "menoresEgresos":
                    objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosMenoresEgresosDias', 'vrTotalDia', 'Dia', 'Menores Egresos');
                    break;
            }
        }

    });

});