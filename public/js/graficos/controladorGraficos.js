import modeloGraficos from "./acordeon.js";

const objModeloGraficos = new modeloGraficos();
let hoy = moment();
let ayer = moment().subtract(1, 'days');
let datosProductos, datosVentas;
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
        fechaId: "pFechaGraficoProductos",
        fechaTexto: "Estas viendo este reporte desde hoy hasta ayer",
    }, {
        id: "acordionVentas",
        titulo: "Ventas",
        dropdown: {
            id: "dropdownVentas",
            opciones: ["Total ventas", "Mejores ventas", "Menores ventas"],
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

document.addEventListener("DOMContentLoaded", async function () {

    //una vez cargado todo el DOM se crean todas las secciones del acordeon dinamicamente
    seccionesAcordeon.forEach(seccion => {
        //se crea el layout de cada item del acordeon
        document.getElementById("acordeonBalances").insertAdjacentHTML('beforeend', objModeloGraficos.generarSeccionAccordion(seccion.titulo, seccion.id, seccion.dropdown.id, seccion.fechaId, seccion.canvasId, seccion.fechaId, seccion.dropdown.container));
        //se crean los dropdowns de cada item del acordeon
        objModeloGraficos.generarReportesDropdown(seccion.dropdown.opciones, seccion.dropdown.container);
        
        //jquery necesario para el funcionamiento de los date picker
        $(function () {
            //creacion y configuracion de los elementos datePicker
            objModeloGraficos.crearDatePickers(seccion.fechaId);
        });
    });

    objModeloGraficos.crearGraficos();

    //se traen los datos para la seccion de productos
    datosProductos = await objModeloGraficos.traerDatosProductos(hoy, ayer, 'dias');
    objModeloGraficos.mostrarDatosProductoHora(datosProductos, "existenciaProductos", "existencia");

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

});