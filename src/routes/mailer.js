const express = require("express");
const clsModuloEmpresa = require("../models/registro");
const router = express.Router();

const objModuloEmpresa = new clsModuloEmpresa

router.post("/send", (req, res) => {
    objModuloEmpresa.enviarCorreo(req, res);
})

router.post("/validarCodigo", async (req, res) => {
    objModuloEmpresa.verificarCodigo(req, res);
})


module.exports = router;