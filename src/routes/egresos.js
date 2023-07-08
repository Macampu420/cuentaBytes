const express = require('express')
const ClsModuloEgresos = require('../models/egresosM')
const router = express.Router()

const objModuloEgresos = new ClsModuloEgresos()

// MODULO EGRESOS
router.get('/listarTipoEgreso', (req, res) => {
  objModuloEgresos.listarTipoEgreso(req, res)
})

router.post('/guardarEgreso', (req, res) => {
  objModuloEgresos.registrarEgreso(req, res)
})

router.get('/egresos', (req, res) => {
  objModuloEgresos.listarEgresos(req, res)
})

router.get('/eliminarEgreso:id', (req, res) => {
  objModuloEgresos.eliminarEgreso(req, res)
})

router.get('/editEgreso:id', (req, res) => {
  objModuloEgresos.listarEgreso(req, res)
})

router.post('/actualizarEgreso', (req, res) => {
  objModuloEgresos.actualizarEgreso(req, res)
})

module.exports = router
