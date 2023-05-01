const Graficos = require('../models/graficos');
const Acordeon = require('../models/acordeon');
const express = require('express');
const moment = require('moment-timezone');
const router = express.Router();

const objAcordeon = new Acordeon();
const objGraficos = new Graficos();
moment.tz.setDefault('America/Bogota');

router.post('/reportesProductos:tiempo', async (req, res, next) => {
    try {
        if (req.params.tiempo == "horas") {

            let { inicio, fin } = req.body;
            let totalProductos, mejoresProductos, peoresProductos,
                rentabilidadProductos, mayorRentabilidad, peorRentabilidad,
                existenciaProductos, mayorExistencia, menorExistencia;

            let queryTotal = `CALL productosFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryMejores = `CALL mejoresProductosFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryPeores = `CALL peoresProductosFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryRentabilidad = `CALL productosRentabilidadHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryMejorRentabilidad = `CALL productosMayorRentabilidadHora('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryPeorRentabilidad = `CALL productosMenorRentabilidadHora('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryExistencia = `CALL productoExistencia()`;
            let queryMayorExistencia = `CALL productoExistenciaMayor()`;
            let queryMenorExistencia = `CALL productoExistenciaMenor()`;

            try {
                totalProductos = await objGraficos.traerProductosFacturas(queryTotal);
                mejoresProductos = await objGraficos.traerProductosFacturas(queryMejores);
                peoresProductos = await objGraficos.traerProductosFacturas(queryPeores);
                rentabilidadProductos = await objGraficos.traerProductosFacturas(queryRentabilidad);
                mayorRentabilidad = await objGraficos.traerProductosFacturas(queryMejorRentabilidad);
                peorRentabilidad = await objGraficos.traerProductosFacturas(queryPeorRentabilidad);
                existenciaProductos = await objGraficos.traerProductosFacturas(queryExistencia);
                mayorExistencia = await objGraficos.traerProductosFacturas(queryMayorExistencia);
                menorExistencia = await objGraficos.traerProductosFacturas(queryMenorExistencia);
            } catch (error) {
                console.log(error);
                res.status(500).json({ error: 'Hubo un problema al traer los datos.' });
                return;
            }

            // Validación de datos
            if (!totalProductos || !mejoresProductos || !peoresProductos) {
                res.status(500).json({ error: 'Los datos solicitados no están disponibles.' });
                return;
            }

            datosGraficos = {
                totalProductos,
                mejoresProductos,
                peoresProductos,
                rentabilidadProductos,
                mayorRentabilidad,
                peorRentabilidad,
                existenciaProductos,
                mayorExistencia,
                menorExistencia
            };

            console.log(datosGraficos);

            res.status(200).send(JSON.stringify(datosGraficos));
        } else if (req.params.tiempo == "dias") {

            let { inicio, fin } = req.body;
            let totalProductos, mejoresProductos, peoresProductos,
                rentabilidadProductos, mayorRentabilidad, peorRentabilidad,
                existenciaProductos, mayorExistencia, menorExistencia;


            let queryTotal = `CALL productosFacturasDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryMejores = `CALL mejoresProductosFacturasDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryPeores = `CALL peoresProductosFacturasDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryRentabilidad = `CALL productosRentabilidadDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryMejorRentabilidad = `CALL productosMayorRentabilidadDia('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryPeorRentabilidad = `CALL productosMenorRentabilidadDia('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryExistencia = `CALL productoExistencia()`;
            let queryMayorExistencia = `CALL productoExistenciaMayor()`;
            let queryMenorExistencia = `CALL productoExistenciaMenor()`;

            try {
                totalProductos = await objGraficos.traerProductosFacturas(queryTotal);
                mejoresProductos = await objGraficos.traerProductosFacturas(queryMejores);
                peoresProductos = await objGraficos.traerProductosFacturas(queryPeores);
                rentabilidadProductos = await objGraficos.traerProductosFacturas(queryRentabilidad);
                mayorRentabilidad = await objGraficos.traerProductosFacturas(queryMejorRentabilidad);
                peorRentabilidad = await objGraficos.traerProductosFacturas(queryPeorRentabilidad);
                existenciaProductos = await objGraficos.traerProductosFacturas(queryExistencia);
                mayorExistencia = await objGraficos.traerProductosFacturas(queryMayorExistencia);
                menorExistencia = await objGraficos.traerProductosFacturas(queryMenorExistencia);

            } catch (error) {
                console.log(error);
                res.status(500).json({ error: 'Hubo un problema al traer los datos.' });
                return;
            }

            // Validación de datos
            if (!totalProductos || !mejoresProductos || !peoresProductos) {
                res.status(500).json({ error: 'Los datos solicitados no están disponibles.' });
                return;
            }

            datosGraficos = {
                totalProductos,
                mejoresProductos,
                peoresProductos,
                rentabilidadProductos,
                mayorRentabilidad,
                peorRentabilidad,
                existenciaProductos,
                mayorExistencia,
                menorExistencia
            };

            console.log(datosGraficos);

            res.status(200).send(JSON.stringify(datosGraficos));
        } else {
            const error = new Error("El parámetro de tiempo no es válido");
            error.statusCode = 400;
            throw error;
        }
    } catch (error) {
        next(error);
    }

});

router.post('/reportesClientes:tiempo', async (req, res, next) => {
    try {
        if (req.params.tiempo == "horas") {

            let { inicio, fin } = req.body;
            let totalClientes, mejoresClientes, peoresClientes;

            let queryTotal = `CALL clientesFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryMejores = `CALL mejoresClientesFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryPeores = `CALL peoresClientesFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;

            try {
                totalClientes = await objGraficos.traerClientesFacturas(queryTotal);
                mejoresClientes = await objGraficos.traerClientesFacturas(queryMejores);
                peoresClientes = await objGraficos.traerClientesFacturas(queryPeores);
            } catch (error) {
                console.log(error);
                res.status(500).json({ error: 'Hubo un problema al traer los datos.' });
                return;
            }

            // Validación de datos
            if (!totalClientes || !mejoresClientes || !peoresClientes) {
                res.status(500).json({ error: 'Los datos solicitados no están disponibles.' });
                return;
            }

            datosGraficos = {
                totalClientes,
                mejoresClientes,
                peoresClientes
            };

            console.log(datosGraficos);

            res.status(200).send(JSON.stringify(datosGraficos));
        } else if (req.params.tiempo == "dias") {

            let { inicio, fin } = req.body;
            let totalClientes, mejoresClientes, peoresClientes;

            let queryTotal = `CALL clientesFacturasDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryMejores = `CALL mejoresClientesFacturasDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryPeores = `CALL peoresClientesFacturasDias('${inicio} 00:00:00', '${fin} 23:59:59')`;

            try {
                totalClientes = await objGraficos.traerProductosFacturas(queryTotal);
                mejoresClientes = await objGraficos.traerProductosFacturas(queryMejores);
                peoresClientes = await objGraficos.traerProductosFacturas(queryPeores);
            } catch (error) {
                console.log(error);
                res.status(500).json({ error: 'Hubo un problema al traer los datos.' });
                return;
            }

            // Validación de datos
            if (!totalClientes || !mejoresClientes || !peoresClientes) {
                res.status(500).json({ error: 'Los datos solicitados no están disponibles.' });
                return;
            }

            datosGraficos = {
                totalClientes,
                mejoresClientes,
                peoresClientes
            };

            console.log(datosGraficos);

            res.status(200).send(JSON.stringify(datosGraficos));
        } else {
            const error = new Error("El parámetro de tiempo no es válido");
            error.statusCode = 400;
            throw error;
        }
    } catch (error) {
        next(error);
    }

});

router.post('/reportesVentas/:tiempo', async (req, res, next) => {

    try {

        if (req.params.tiempo == "horas") {
            let datosTotalVentasHoras, datosMejoresVentasHoras, datosMenoresVentasHoras;
            //se define si se van a traer los datos de ayer o de hoy
            let { dia } = req.body;

            //se guarda el resultado de cada consulta de datos segun el dia que mando el cliente
            datosTotalVentasHoras = await objGraficos.traerDatosVentas(`CALL totalVentasPorHora('${dia}')`);
            datosMejoresVentasHoras = await objGraficos.traerDatosVentas(`CALL mejoresVentasPorHora('${dia}')`);
            datosMenoresVentasHoras = await objGraficos.traerDatosVentas(`CALL menoresVentasPorHora('${dia}')`);
            
            let datosVentas = {
                datosTotalVentasHoras,
                datosMejoresVentasHoras,
                datosMenoresVentasHoras
            };

            //se envian los datos junto con el codigo 200
            res.status(200).send(datosVentas);
        }
        else{
            let datosTotalVentasDias, datosMejoresVentasDias, datosMenoresVentasDias;
            //se definen los dias entre los cuales se van a traer los datos
            let { diaInicio, diaFin } = req.body;

            //se guarda el resultado de cada consulta de datos segun el rango que mando el cliente
            datosTotalVentasDias = await objGraficos.traerDatosVentas(`CALL totalVentasDias('${diaInicio}', '${diaFin}')`);
            datosMejoresVentasDias = await objGraficos.traerDatosVentas(`CALL mejoresVentasDias('${diaInicio}', '${diaFin}')`);
            datosMenoresVentasDias = await objGraficos.traerDatosVentas(`CALL menoresVentasDias('${diaInicio}', '${diaFin}')`);
            
            let datosVentas = {
                datosTotalVentasDias,
                datosMejoresVentasDias,
                datosMenoresVentasDias
            };

            //se envian los datos junto con el codigo 200
            res.status(200).send(datosVentas);

        }

    } catch (error) {
        console.log(error);
        res.status(500);
    }

});

router.post('/reportesCompras/:tiempo', async (req, res, next) => {

    try {

        if (req.params.tiempo == "horas") {
            let datosTotalComprasHoras, datosMejoresComprasHoras, datosMenoresComprasHoras;
            //se define si se van a traer los datos de ayer o de hoy
            let { dia } = req.body;

            //se guarda el resultado de cada consulta de datos segun el dia que mando el cliente
            datosTotalComprasHoras = await objGraficos.traerDatosCompras(`CALL totalComprasPorHora('${dia}')`);
            datosMejoresComprasHoras = await objGraficos.traerDatosCompras(`CALL mayoresComprasPorHora('${dia}')`);
            datosMenoresComprasHoras = await objGraficos.traerDatosCompras(`CALL menoresComprasPorHora('${dia}')`);
            
            let datosCompras = {
                datosTotalComprasHoras,
                datosMejoresComprasHoras,
                datosMenoresComprasHoras
            };

            //se envian los datos junto con el codigo 200
            res.status(200).send(datosCompras);
        }
        else{
            let datosTotalComprasDias, datosMejoresComprasDias, datosMenoresComprasDias;
            //se definen los dias entre los cuales se van a traer los datos
            let { diaInicio, diaFin } = req.body;

            //se guarda el resultado de cada consulta de datos segun el rango que mando el cliente
            datosTotalComprasDias = await objGraficos.traerDatosCompras(`CALL totalComprasDias('${diaInicio}', '${diaFin}')`);
            datosMejoresComprasDias = await objGraficos.traerDatosCompras(`CALL mayoresComprasDias('${diaInicio}', '${diaFin}')`);
            datosMenoresComprasDias = await objGraficos.traerDatosCompras(`CALL menoresComprasDias('${diaInicio}', '${diaFin}')`);
            
            let datosCompras = {
                datosTotalComprasDias,
                datosMejoresComprasDias,
                datosMenoresComprasDias
            };

            //se envian los datos junto con el codigo 200
            res.status(200).send(datosCompras);

        }

    } catch (error) {
        console.log(error);
        res.status(500);
    }

});

router.post('/reportesEgresos/:tiempo', async (req, res, next) => {

    try {

        if (req.params.tiempo == "horas") {
            let datosTotalEgresosHoras, datosMejoresEgresosHoras, datosMenoresEgresosHoras;
            //se define si se van a traer los datos de ayer o de hoy
            let { dia } = req.body;

            //se guarda el resultado de cada consulta de datos segun el dia que mando el cliente
            datosTotalEgresosHoras = await objGraficos.traerDatosEgresos(`CALL totalEgresosPorHora('${dia}')`);
            datosMejoresEgresosHoras = await objGraficos.traerDatosEgresos(`CALL mayoresEgresosPorHora('${dia}')`);
            datosMenoresEgresosHoras = await objGraficos.traerDatosEgresos(`CALL menoresEgresosPorHora('${dia}')`);
            
            let datosEgresos = {
                datosTotalEgresosHoras,
                datosMejoresEgresosHoras,
                datosMenoresEgresosHoras
            };

            //se envian los datos junto con el codigo 200
            res.status(200).send(datosEgresos);
        }
        else{
            let datosTotalEgresosDias, datosMejoresEgresosDias, datosMenoresEgresosDias;
            //se definen los dias entre los cuales se van a traer los datos
            let { diaInicio, diaFin } = req.body;

            //se guarda el resultado de cada consulta de datos segun el rango que mando el cliente
            datosTotalEgresosDias = await objGraficos.traerDatosEgresos(`CALL totalEgresosDias('${diaInicio}', '${diaFin}')`);
            datosMejoresEgresosDias = await objGraficos.traerDatosEgresos(`CALL mayoresEgresosDias('${diaInicio}', '${diaFin}')`);
            datosMenoresEgresosDias = await objGraficos.traerDatosEgresos(`CALL menoresEgresosDias('${diaInicio}', '${diaFin}')`);
            
            let datosEgresos = {
                datosTotalEgresosDias,
                datosMejoresEgresosDias,
                datosMenoresEgresosDias
            };

            //se envian los datos junto con el codigo 200
            res.status(200).send(datosEgresos);

        }

    } catch (error) {
        console.log(error);
        res.status(500);
    }

});
// Middleware de error
router.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Error interno del servidor');
});

module.exports = router;