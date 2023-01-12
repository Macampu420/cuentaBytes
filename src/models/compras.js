const { query } = require('express');
const pool = require('./../conexion');

class moduloCompras {

    traerEncsCompras = async (req, res) => {    

        await pool.query("CALL `listarCompras`()", (err, rows) => {

            if (err) {
                console.log("internal error", err);
                res.send(null);
            } else if (rows[0].length === 0) {
                res.send("No hay compras registradas");
            } else {
                res.send(rows[0]);
            }
        });
    }
}

module.exports = moduloCompras