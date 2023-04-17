const { query } = require('express');
const pool = require('../conexion');
const CryptoJS = require('crypto-js');

class moduloInicioSesion {


    verificarRegistro = async (req, res) => {

        const contrasena = CryptoJS.SHA256(req.params.contrasena).toString(CryptoJS.enc.Hex);


        await pool.query("CALL verificarRegistro(?,?)", [req.params.email, contrasena],
            (err, rows) => {
                //si hay error lo imprime y lo envia como respuesta
                if (err) {
                    console.log("internal error", err);
                    res.write(err);
                    res.end();
                } else if (rows[0].length === 0) { 
                    res.write("No existe un usario registrado");
                    res.end();
                } else {
                    res.send(rows[0])
                }
            });
    }
}

module.exports = moduloInicioSesion;