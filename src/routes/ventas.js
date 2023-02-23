const express = require('express');
const clsModuloVentas = require('../models/ventas')
const router = express.Router();
const pool = require('./../conexion');

const objModuloVentas = new clsModuloVentas();

//ejecuta la funcion que viene de los modelos cuando se 
//hace la peticion post a /guardarVta
router.post('/guardarVta', (req, res) => {
    objModuloVentas.registrarVta(req, res);
});

router.get("/ventas", (req, res) => {
    // var idUltimaVenta = 0;
    // models.listarVentas(req, res, idUltimaVenta);

    objModuloVentas.listarVentas(req, res);

});

router.get('/eliminarVta:id', (req, res) => {

    objModuloVentas.eliminarVenta(req, res);

})

router.get("/editVenta:id", (req, res) => {

    objModuloVentas.listarVenta(req, res);

});

router.get("/listarClientes", (req, res) => {

    objModuloVentas.listarClientes(req, res);

})

router.get("/listarProductos", (req, res) => {

    objModuloVentas.listarProductos(req, res);

})

router.post("/actualizarVta:id", (req, res) => {

    objModuloVentas.actualizarVta(req, res);

})
module.exports = router;