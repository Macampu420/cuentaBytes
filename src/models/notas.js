const { query } = require('express');
const pool = require('../conexion');

class ModuloNotas {

    registrarNota = async (req, res) => {
        await pool.query("CALL insertarNota(?, ?)", [req.body.tituloNota, req.body.cuerpoNota],
            (err, rows) => {
                //si hay error lo imprime y lo envia como respuesta
                if (err) {
                    console.log("internal error", err);
                    res.write(err);
                    res.end();
                } else {
                    res.write("La Nota fue registrado correctamente");
                    res.end();
                }
            });
    }

    listarNotas = async (req, res) => {

        await pool.query("CALL mostrarNotas()", (err, rows) => {

            if (err) {
                console.log("internal error", err);
                res.write(err);
                res.end();
            } else if (rows[0].length === 0) {

                res.write("no hay notas registrados");
                res.end();

            } else {
                res.send(rows)
            }
        });
    }
}

module.exports = ModuloNotas;