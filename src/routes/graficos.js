const Graficos = require('../models/graficos');
const express = require('express');
const router = express.Router();

const objGraficos = new Graficos();

router.post('/graficos', async (req, res) => {
    let datosGrafica = [];

    // Llamar a la función y manejar los resultados
    objGraficos.obtenerDatosCompras(req)
        .then((datos) => {
            datosGrafica[0] = (datos);
            objGraficos.obtenerDatosEgresos(req)
                .then((datos) => {
                    datosGrafica[1] = datos;
                    // Llamar a la función y manejar los resultados
                    objGraficos.obtenerDatosVentas(req)
                        .then((datos) => {
                            datosGrafica[2] = datos;
                            // Hacer algo con los datos obtenidos

                            res.status(200).send(JSON.stringify({datosGrafica}));
                        })
                        .catch((error) => {
                            console.error(error);
                            res.status(500).send(JSON.stringify({
                                mensaje: 'Ha ocurrido un error al acceder a la base de datos'
                            }));
                            // Manejar el error de la consulta
                        });
                })
                .catch((error) => {
                    console.error(error);
                    res.status(500).send(JSON.stringify({
                        mensaje: 'Ha ocurrido un error al acceder a la base de datos'
                    }));
                    // Manejar el error de la consulta
                });
        })
        .catch((error) => {
            console.error(error);
            res.status(500).send(JSON.stringify({
                mensaje: 'Ha ocurrido un error al acceder a la base de datos'
            }));
            // Manejar el error de la consulta
        });
})

module.exports = router;