const express = require('express')
const clsModuloNotas = require('../models/notas')
const router = express.Router()

const objModuloNotas = new clsModuloNotas()

router.post('/actualizarNota', (req, res) => {
  objModuloNotas.actualizarNota(req, res)
})

router.post('/registrarNota', (req, res) => {
  objModuloNotas.registrarNota(req, res)
})

router.get('/listarNotas', (req, res) => {
  objModuloNotas.listarNotas(req, res)
})

router.get('/eliminarNota:id', (req, res) => {
  objModuloNotas.eliminarNota(req, res)
})

router.get('/listarUnaNota:id', (req, res) => {
  objModuloNotas.listarUnaNota(req, res)
})

module.exports = router
