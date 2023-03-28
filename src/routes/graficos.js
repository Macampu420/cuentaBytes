const Graficos = require('../models/graficos');
const express = require('express');
const router = express.Router();

const objGraficos = new Graficos();

router.post('/graficos', async (req, res) => {
    let datosGrafica = [];

    try {
        let datosCompras = await objGraficos.obtenerDatosCompras(req);
        let datosEgresos = await objGraficos.obtenerDatosEgresos(req);
        let datosVentas = await objGraficos.obtenerDatosVentas(req);
        
        datosGrafica = [datosCompras, datosEgresos, datosVentas];
        
        res.status(200).send({ datosGrafica });
      } catch (error) {
        console.error(error);
        res.status(500).send({ mensaje: 'Ha ocurrido un error al acceder a la base de datos' });
      }

})

module.exports = router;