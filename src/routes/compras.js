const express = require('express');
const clsModuloCompras = require('../models/compras')
const router = express.Router();

const objModuloCompras = new clsModuloCompras();

router.get('/compras/listarCompras', async (req, res) => {
    objModuloCompras.traerEncsCompras(req, res)
})

module.exports = router;