const express = require("express");
const clsModuloInicioSesion = require("../models/inicioSesion");
const router = express.Router();

const objModuloInicioSesion = new clsModuloInicioSesion;

router.get('/verificarRegistro:email/:pass', (req,res) =>{
    objModuloInicioSesion.verificarRegistro(req,res)
})

module.exports = router