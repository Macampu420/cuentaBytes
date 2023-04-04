const Graficos = require('../models/graficos');
const express = require('express');
const router = express.Router();

const objGraficos = new Graficos();

router.post('/graficos:tiempo', async (req, res) => {

    if (req.params.tiempo == "horas") {

        datosGraficos = {
            ventas: await objGraficos.servirComprasPorHora(req)
        }

    } else if (req.params.tiempo == "dias"){

        console.log("traer resultados por dias", req.body);
   
    }

   
})

module.exports = router;