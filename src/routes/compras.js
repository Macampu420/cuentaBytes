const express = require('express');
const clsModuloCompras = require('../models/compras')
const router = express.Router();

const objModuloCompras = new clsModuloCompras();

router.get('/compras/listarCompras', async (req, res) => {
    objModuloCompras.traerEncsCompras(req, res);
})

router.post('/guardarCompra', (req, res) => {
    objModuloCompras.registrarCompra(req, res);
})

router.get('/listarCompra:id', (req, res) => {
    objModuloCompras.listarCompra(req, res); 
})

router.post('/compras/editarCompra', async (req, res) => console.log(req.body));

module.exports = router;