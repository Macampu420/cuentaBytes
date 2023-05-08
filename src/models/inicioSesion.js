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

                res.status(400).send('0');
                res.end();

            } else {
                //si no hay error envia el texto, setea el id de la ultima vta y termina la peticion
                res.status(200).send(rows[0])

            }
            });
    }
}

module.exports = moduloInicioSesion;