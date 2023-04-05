const Graficos = require('../models/graficos');
const express = require('express');
const router = express.Router();

const objGraficos = new Graficos();

router.post('/graficos:tiempo', async (req, res, next) => {

    try {
        if (req.params.tiempo == "horas") {
            datosGraficos = {
                ventas: await objGraficos.servirComprasPorHora(req)
            };
            res.json(datosGraficos);
        }
        //  else if (req.params.tiempo == "dias") {
        //     console.log("traer resultados por dias", req.body);
        //     res.send("Resultados por días");
        // }
         else {
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