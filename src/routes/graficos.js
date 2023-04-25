const Graficos = require('../models/graficos');
const Acordeon = require('../models/acordeon');
const express = require('express');
const moment = require('moment-timezone');
const router = express.Router();

const objAcordeon = new Acordeon();
const objGraficos = new Graficos();
moment.tz.setDefault('America/Bogota');

router.post('/graficos:tiempo', async (req, res, next) => {

    try {
        // bloque para traer los datos de ayer u hoy
        if (req.params.tiempo == "horas") {

            let { inicio } = req.body;
            let ventas, compras, egresos;

            // Obtener la fecha de hoy
            const hoy = moment().format('YYYY-MM-DD');
            // Obtener la fecha de ayer
            const ayer = moment().subtract(1, 'days').format('YYYY-MM-DD');

            // Si el inicio es la fecha de hoy trae los datos de hoy sino pregunta y trae los de ayer

            try {
                if (inicio == hoy) {
                    let horaActual = moment().format('HH:mm:ss').slice(0, 2);
                    ventas = await objGraficos.traerDatosVentasHoras(hoy, horaActual);
                    compras = await objGraficos.traerDatosComprasHoras(hoy, horaActual);
                    egresos = await objGraficos.traerDatosEgresosHoras(hoy, horaActual);
                } else if (inicio == ayer) {
                    ventas = await objGraficos.traerDatosVentasHoras(ayer, 24);
                    compras = await objGraficos.traerDatosComprasHoras(ayer, 24);
                    egresos = await objGraficos.traerDatosEgresosHoras(ayer, 24);
                }
            } catch (error) {
                res.status(500).json({ error: 'Hubo un problema al traer los datos.' });
                return;
            }

            // Validación de datos
            if (!ventas || !compras || !egresos) {
                res.status(500).json({ error: 'Los datos solicitados no están disponibles.' });
                return;
            }

            datosGraficos = {
                ventas,
                compras,
                egresos
            };

            console.log(datosGraficos);

            res.status(200).json(datosGraficos);

        } else if (req.params.tiempo == "dias") {

            let { inicio, fin } = req.body;
            let ventas, compras, egresos;

            let queryVentas = `CALL ventasPorDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryCompras = `CALL comprasPorDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryEgresos = `CALL egresosPorDias('${inicio} 00:00:00', '${fin} 23:59:59')`;

            try {
                ventas = await objGraficos.traerDatosDias(inicio, fin, queryVentas);
                compras = await objGraficos.traerDatosDias(inicio, fin, queryCompras);
                egresos = await objGraficos.traerDatosDias(inicio, fin, queryEgresos);
            } catch (error) {
                res.status(500).json({ error: 'Hubo un problema al traer los datos.' });
                return;
            }

            // Validación de datos
            if (!ventas || !compras || !egresos) {
                res.status(500).json({ error: 'Los datos solicitados no están disponibles.' });
                return;
            }

            datosGraficos = {
                ventas,
                compras,
                egresos
            };

            res.status(200).send(JSON.stringify(datosGraficos));
        } else {
            const error = new Error("El parámetro de tiempo no es válido");
            error.statusCode = 400;
            throw error;
        }
    } catch (error) {
        next(error);
    }

})

router.post('/reportesProductos:tiempo', async (req, res, next) => {
    try {
        if (req.params.tiempo == "horas") {

            let { inicio, fin } = req.body;
            let totalProductos, mejoresProductos, peoresProductos;

            let queryTotal = `CALL productosFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryMejores = `CALL mejoresProductosFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryPeores = `CALL peoresProductosFacturasHoras('${inicio} 00:00:00', '${fin} 23:59:59')`;

            try {
                totalProductos = await objGraficos.traerProductosFacturas(queryTotal);
                mejoresProductos = await objGraficos.traerProductosFacturas(queryMejores);
                peoresProductos = await objGraficos.traerProductosFacturas(queryPeores);
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
                peoresProductos
            };

            console.log(datosGraficos);

            res.status(200).send(JSON.stringify(datosGraficos));
        } else if (req.params.tiempo == "dias") {

            let { inicio, fin } = req.body;
            let totalProductos, mejoresProductos, peoresProductos;

            let queryTotal = `CALL ventasPorDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryMejores = `CALL comprasPorDias('${inicio} 00:00:00', '${fin} 23:59:59')`;
            let queryPeores = `CALL egresosPorDias('${inicio} 00:00:00', '${fin} 23:59:59')`;

            try {
                totalProductos = await objGraficos.traerProductosFacturas(queryTotal);
                mejoresProductos = await objGraficos.traerProductosFacturas(queryMejores);
                peoresProductos = await objGraficos.traerProductosFacturas(queryPeores);
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
                peoresProductos
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

    res.status(200).send(JSON.stringify(datosGraficos));
})

// router.get('/acordeon', async (req, res) => {

//     try {

//         let datosAcordeon = {
//             mejoresClientes: await objAcordeon.traerMejoresClientes(),
//             productosMasVendidos: await objAcordeon.traerProductosMasVendidos(),
//             productosMenosVendidos: await objAcordeon.traerProductosMenosVendidos(),
//             productosMasRentables: await objAcordeon.traerProductosMasRentables(),
//             mayorEgreso: await objAcordeon.traerMayorEgreso(),
//             menorEgreso: await objAcordeon.traerMenorEgreso(),
//             productosMayorStock: await objAcordeon.traerProducMayorStock(),
//             productosMenorStock: await objAcordeon.traerProducMenorStock()
//         }

//         // console.log(datosAcordeon);

//         res.send(datosAcordeon).status(200);
//     } catch (error) {
//         console.log(error);
//         res.send(JSON.stringify({
//             error: true
//         })).status(500);
//     }

// });

// Middleware de error
router.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Error interno del servidor');
});

module.exports = router;