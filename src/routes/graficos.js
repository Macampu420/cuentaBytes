const Graficos = require('../models/graficos');
const express = require('express');
const moment = require('moment-timezone');
const router = express.Router();

const objGraficos = new Graficos();
moment.tz.setDefault('America/Bogota');

router.post('/graficos:tiempo', async (req, res, next) => {

    try {
        // bloque para traer los datos de ayer u hoy
        if (req.params.tiempo == "horas") {

            let { inicio } = req.body;
            let ventas, compras;

            // Obtener la fecha de hoy
            const hoy = moment().format('YYYY-MM-DD');
            // Obtener la fecha de ayer
            const ayer = moment().subtract(1, 'days').format('YYYY-MM-DD');

            // Si el inicio es la fecha de hoy trae los datos de hoy sino pregunta y trae los de ayer
            if (inicio == hoy) {
                let horaActual = moment().format('HH:mm:ss').slice(0, 2);
                ventas = await objGraficos.traerDatosVentasHoras(hoy, horaActual);
                compras = await objGraficos.traerDatosComprasHoras(hoy, horaActual);
            } else if (inicio == ayer) {
                ventas = await objGraficos.traerDatosVentasHoras(ayer, 24);
                compras = await objGraficos.traerDatosComprasHoras(ayer, 24);
            }

            datosGraficos = {
                ventas,
                compras
            };

            console.log(datosGraficos);

            res.status(200).json(datosGraficos);
        } else if (req.params.tiempo == "dias") {
            console.log("traer resultados por dias", req.body);
            res.send("Resultados por días");
        } else {
            const error = new Error("El parámetro de tiempo no es válido");
            error.statusCode = 400;
            throw error;
        }
    } catch (error) {
        next(error);
    }

})

// Middleware de error
router.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Error interno del servidor');
});  

module.exports = router;