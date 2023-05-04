const express = require('express');
const clsModuloAjustes = require('../models/ajustes');
const Ajustes = require('../models/ajustes');
const router = express.Router();

const objModuloAjustes = new clsModuloAjustes();

router.get('/ajustes', (req, res) => {
    objModuloAjustes.servirAjustes(req, res);
});

router.post('/cambiarNombre', async (req, res) => {
    try {
        let nombreEmpresa = req.body.nombreEmpresa;
        let horaApertura = req.body.horaApertura;
        let horaCierre = req.body.horaCierre;

        await objModuloAjustes.cambiarAjustes(`CALL actualizarAjustes('${nombreEmpresa}','${horaApertura}','${horaCierre}')`);
        res.status(200);

    }
    catch (error) {
        console.log(error);
        res.status(500);
    }
})

router.post('/cambiarHoras', async (req, res) => {
    try {
        let nombreEmpresa = req.body.nombreEmpresa;
        let horaApertura = req.body.horaApertura;
        let horaCierre = req.body.horaCierre;

        await objModuloAjustes.cambiarAjustes(`CALL actualizarAjustes('${nombreEmpresa}','${horaApertura}','${horaCierre}')`);
        res.status(200);
    }
    catch (error) {
        console.log(error);
        res.status(500);
    }
})

router.get('/backup', (req, res) => {
    objModuloAjustes.backupDatabase(req, res);
} )
module.exports = router