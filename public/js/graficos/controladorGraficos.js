import modeloGraficos from "./acordeon.js";

let datosProductos, datosVentas, datosCompras, datosClientes, datosEgresos;
let swTipoGraficoVentas = 'horas';
let swTipoGraficoCompras = 'horas';  
let swTipoGraficoEgresos = 'horas';
let swTipoGraficoClientes = 'horas';
let swTipoGraficoProductos = 'horas';

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
                "Rentabilidad productos",
                "Mayor rentabilidad",
                "Peor rentabilidad",
                "Productos vendidos",
                "Productos mas vendidos",
                "Productos menos vendidos"
            ],
            container: "containerDropdownProductos"
        },
        canvasId: "canvaProductos",
        slcpFecha: "slcFechaGraficoProductos",
        pFecha: "pFechaGraficoProductos",
        callbackFecha: async function(pInicio, pFin) {
            let inicio = pInicio.format('YYYY-MM-DD');
            let fin = pFin.format('YYYY-MM-DD');
    
            let fechaSeleccionada = pInicio.clone().startOf('day');
    
            // Compara la fecha seleccionada con las fechas de hoy y ayer
            if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
                datosProductos = await objModeloGraficos.traerDatosProductos(pInicio, pFin, "horas");
                objModeloGraficos.mostrarDatosProductos(datosProductos, 'productosVendidos', 'nroFacturas', 'Total de Productos por factura');
                swTipoGraficoProductos = 'horas';
            } else {
                datosProductos = await objModeloGraficos.traerDatosProductos(pInicio, pFin, "dias");
                objModeloGraficos.mostrarDatosProductos(datosProductos, 'productosVendidos', 'nroFacturas', 'Total de Productos por factura');
                swTipoGraficoProductos = 'dias';
            }
            objModeloGraficos.mostrarRango(inicio, fin, "pFechaGraficoProductos");
        }
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
            opciones: ["Total clientes por facturas", "Mayores clientes por facturas", "Menores clientes por facturas"],
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
                objModeloGraficos.mostrarDatosClientes(datosClientes, 'totalClientes', 'nroFacturas', 'nombres', 'Total de Clientes');
                swTipoGraficoClientes = 'horas';
            } else {
                datosClientes = await objModeloGraficos.traerDatosClientes(inicio, fin, "dias");
                objModeloGraficos.mostrarDatosClientes(datosClientes, 'totalClientes', 'nroFacturas', 'nombres', 'Total de Clientes');
                swTipoGraficoClientes = 'dias';
            }

            console.log(datosCliente);

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
    datosProductos = await objModeloGraficos.traerDatosProductos(hoy.toISOString().slice(0, 10), hoy.toISOString().slice(0, 10), 'horas');
    objModeloGraficos.mostrarDatosProductos(datosProductos, "productosVendidos", "nroFacturas", "Total productos por facturas");
    
    //se traen los datos para la seccion de ventas
    datosVentas = await objModeloGraficos.traerDatosVentas(hoy, hoy, 'horas');
    objModeloGraficos.mostrarDatosVentas(datosVentas, 'datosTotalVentasHoras', 'vrTotalVta', 'hora', 'Total de ventas');

    //se traen los datos para la seccion de compra
    datosCompras = await objModeloGraficos.traerDatosCompras(hoy, hoy, 'horas');
    objModeloGraficos.mostrarDatosCompras(datosCompras, 'datosTotalComprasHoras', 'vrTotalCompra', 'hora', 'Total compras');

    //se traen los datos para la seccion de Egreso
    datosEgresos = await objModeloGraficos.traerDatosEgresos(hoy, hoy, 'horas');
    objModeloGraficos.mostrarDatosEgresos(datosEgresos, 'datosTotalEgresosHoras', 'vrTotalEgreso', 'hora', 'Total egresos');

    //se traen los datos para la seccion de Cliente
    datosClientes = await objModeloGraficos.traerDatosClientes(hoy, hoy, 'horas');
    objModeloGraficos.mostrarDatosClientes(datosClientes, 'totalClientes', 'nroFacturas', 'nombres', 'Total de Clientes');
    
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

    document.getElementById('acordionProductos').classList.add('show');

    Chart.register(ChartDataLabels);

    // Change default options for ALL charts
    Chart.defaults.set('plugins.datalabels', {
        display: true,
        formatter: function(value, context) {
          return value.toLocaleString('en-US');
    }});
    
    let graficoClientes = new Chart(document.getElementById('canvaClientes'), conficInicialGraficos.configClientes);
    let graficoEgresos = new Chart(document.getElementById('canvaEgresos'), conficInicialGraficos.configEgresos);
    let graficoVentas = new Chart(document.getElementById('canvaVentas'), conficInicialGraficos.configVentas);
    let graficoCompras = new Chart(document.getElementById('canvaCompras'), conficInicialGraficos.configCompras);
    let graficoProductos = new Chart(document.getElementById('canvaProductos'), conficInicialGraficos.configProductos);


    objModeloGraficos.setGraficos(graficoProductos, graficoVentas, graficoCompras, graficoEgresos, graficoClientes);
    
    traerDataGraficos();

    document.getElementById("containerDropdownProductos").addEventListener("click", event => {

        let tipoBalance = objModeloGraficos.convertirACamelCase(event.target.id.replace(/-/g, " "));

        console.log(tipoBalance);

        switch (tipoBalance) {

            //casos para balances productos por ventas
            case "productosVendidos":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "nroFacturas", "Total productos por facturas");
                break;
            case "productosMasVendidos":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "nroFacturas", "Productos mas vendidos");
                break;
            case "productosMenosVendidos":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "nroFacturas", "Productos menos vendidos");
                break;   

            //casos para balances productos por rentabilidad
            case "rentabilidadProductos":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "Rentabilidad", "Rentabilidad productos");
                break; 
            case "mayorRentabilidad":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "Rentabilidad", "Mayor rentabilidad");
                break;
            case "peorRentabilidad":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "Rentabilidad", "Peor rentabilidad");
                break;

            //casos para balances productos por existencia
            case "existenciaProductos":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "existencia", "Existencia productos");
                break;
            case "mayorExistencia":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "existenciaMayor", "Mayor existencia");
                break;
            case "menorExistencia":
                objModeloGraficos.mostrarDatosProductos(datosProductos, tipoBalance, "menorExistencia", "Menor existencia");
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

    document.getElementById('containerDropdownClientes').addEventListener('click', event => {

        let tipoBalance = objModeloGraficos.convertirACamelCase(event.target.id.replace(/-/g, " "));

        console.log(tipoBalance);

        if (swTipoGraficoClientes == 'horas') {
            switch (tipoBalance) {
                case "totalClientesPorFacturas":
                    objModeloGraficos.mostrarDatosClientes(datosClientes, 'totalClientes', 'nroFacturas', 'nombres', 'Total de Clientes');
                    break;
                case "mayoresClientesPorFacturas":
                    objModeloGraficos.mostrarDatosClientes(datosClientes, 'mejoresClientes', 'nroFacturas', 'nombres', 'Mejores Clientes por factura');
                    break;
                case "menoresClientesPorFacturas":
                    objModeloGraficos.mostrarDatosClientes(datosClientes, 'peoresClientes', 'nroFacturas', 'nombres', 'Menores Clientes por factura');
                    break;
            }
        } else {
            switch (tipoBalance) {
                case "totalClientesPorFacturas":
                    objModeloGraficos.mostrarDatosClientes(datosClientes, 'totalClientes', 'nroFacturas', 'nombres', 'Total de Clientes');
                    break;
                case "mayoresClientesPorFacturas":
                    objModeloGraficos.mostrarDatosClientes(datosClientes, 'mejoresClientes', 'nroFacturas', 'nombres', 'Mejores Clientes por factura');
                    break;
                case "menoresClientesPorFacturas":
                    objModeloGraficos.mostrarDatosClientes(datosClientes, 'peoresClientes', 'nroFacturas', 'nombres', 'Menores Clientes por factura');
                    break;
            }
        }

    });

});