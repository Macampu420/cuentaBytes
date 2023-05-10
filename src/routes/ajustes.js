const express = require('express');
const clsModuloAjustes = require('../models/ajustes');
const router = express.Router();
const fileUpload = require('express-fileupload');
const objModuloAjustes = new clsModuloAjustes();
const nodemon = require('nodemon');

router.get('/ajustes', (req, res) => {
    objModuloAjustes.servirAjustes(req, res);
});

router.post('/cambiarNombre', async (req, res) => {
    try {
        let nombreEmpresa = req.body.nombreEmpresa;
        let horaApertura = req.body.horaApertura;
        let horaCierre = req.body.horaCierre;

        await objModuloAjustes.cambiarAjustes(`CALL actualizarAjustes('${nombreEmpresa}','${horaApertura}','${horaCierre}')`);
        res.status(200).send();

    }
    catch (error) {
        console.log(error);
        res.status(500);
    }
});

router.post('/cambiarHoras', async (req, res) => {
    try {
        let nombreEmpresa = req.body.nombreEmpresa;
        let horaApertura = req.body.horaApertura;
        let horaCierre = req.body.horaCierre;

        await objModuloAjustes.cambiarAjustes(`CALL actualizarAjustes('${nombreEmpresa}','${horaApertura}','${horaCierre}')`);
        res.status(200).send();
    }
    catch (error) {
        console.log(error);
        res.status(500);
    }
});

router.get('/backup', (req, res) => {
    objModuloAjustes.backupDatabase(req, res);
});

router.post('/subirBackup', (req, res) => {
    if (!req.files || Object.keys(req.files).length === 0) {
        return res.status(400).send('No se ha seleccionado ningún archivo.');
    }
    
    // Acceder al archivo
    let archivo = req.files.archivo;

     // Guardar el archivo en el servidor
    archivo.mv(`${__dirname}/../../cuentabytes.sql`);
    objModuloAjustes.restarurarBd(req, res);
    nodemon.restart();
    
})
module.exports = router