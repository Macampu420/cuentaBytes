const express = require('express')
const clsModuloNotas = require('../models/notas')
const router = express.Router()

const objModuloNotas = new clsModuloNotas();

router.get('/listarNotas', (req, res) => {
    objModuloNotas.listarNotas(req, res)
})

router.post('/registrarNota', (req,res) => {
    objModuloNotas.registrarNota(req, res)
})


module.exports = router