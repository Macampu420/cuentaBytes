const Graficos = require('../models/graficos');
const Acordeon = require('../models/acordeon');
const express = require('express');
const router = express.Router();

const objGraficos = new Graficos();
const objAcordeon = new Acordeon();

router.post('/graficos', async (req, res) => {
  let datosGrafica = [];

  try {
    let datosCompras = await objGraficos.obtenerDatosCompras(req);
    let datosEgresos = await objGraficos.obtenerDatosEgresos(req);
    let datosVentas = await objGraficos.obtenerDatosVentas(req);

    datosGrafica = [datosCompras, datosEgresos, datosVentas];

    res.status(200).send({
      datosGrafica
    });
  } catch (error) {
    console.error(error);
    res.status(500).send({
      mensaje: 'Ha ocurrido un error al acceder a la base de datos'
    });
  }

})

router.get('/acordeon', async (req, res) => {

  try {

    let datosAcordeon = {
      mejoresClientes: await objAcordeon.traerMejoresClientes(),
      productosMasVendidos: await objAcordeon.traerProductosMasVendidos(),
      productosMenosVendidos: await objAcordeon.traerProductosMenosVendidos(),
      productosMasRentables: await objAcordeon.traerProductosMasRentables(),
      mayorEgreso: await objAcordeon.traerMayorEgreso(),
      menorEgreso: await objAcordeon.traerMenorEgreso(),
      productosMayorStock: await objAcordeon.traerProducMayorStock(),
      productosMenorStock: await objAcordeon.traerProducMenorStock()
    }

    // console.log(datosAcordeon);

    res.send(datosAcordeon).status(200);
  } catch (error) {
    console.log(error);
    res.send(JSON.stringify({
      error: true
    })).status(500);
  }

});

module.exports = router;