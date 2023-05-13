const { query } = require('express');
const pool = require('../conexion');
const CryptoJS = require('crypto-js');

class moduloInicioSesion {


    verificarRegistro = async (req, res) => {

        let contrasena = CryptoJS.SHA256(req.params.pass).toString(CryptoJS.enc.Hex);


        await pool.query("CALL verificarRegistro(?,?)", [req.params.email, contrasena],
            (err, rows) => {
            if (err) {
                console.log("internal error", err);
                res.write(err);
                res.end();
            } else if (rows[0].length === 0) {
                res.status(400).send();
                res.end();
            } else {
                res.status(200).send(rows[0])
            }
            });
    }
}

module.exports = moduloInicioSesion;