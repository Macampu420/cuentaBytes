const {
    query
} = require('express');
const pool = require('./../conexion');

class ModuloVentas {

    idUltimaVenta;

    constructor() {
        this.idUltimaVenta = 0;
    }

    registrarVta = async (req, res) => {

        this.idUltimaVenta++;

        //se inserta el encabezado de la venta con los campos que vienen del formilario
        await pool.query("CALL insertarEncVenta(?, ?, ?, ?, ?, ?, ?, ?)", [this.idUltimaVenta, req.body.tituloVenta, req.body.fecha, req.body.metPago, req.body.dto, req.body.vrTotal, req.body.vrIva, req.body.idCliente, ],
            (err, rows) => {
                //si hay error lo imprime y lo envia como respuesta
                if (err) {
                    console.log("internal error", err);
                    res.write(err);
                    res.end();
                } else {
                    //si hay items en el cuerpo de la peticion va iterando por cada uno 
                    //para registrarlo en la bd
                    if (req.body.itemsVta != undefined && req.body.itemsVta.length > 0) {

                        req.body.itemsVta.forEach(element => {
                            pool.query("CALL insertarDetVenta(?,?,?,?)", [element.unidVend, element.precioVta, this.idUltimaVenta, element.idProducto],
                                (err, rows) => {

                                    //si hay error lo imprime y termina la peticion
                                    if (err) {
                                        console.log("internal error", err);
                                        res.write(err);
                                        res.end();
                                    } else {
                                        pool.query("CALL actualizarStock(?,?)", [element.unidVend, element.idProducto],
                                            err => {
                                                if (err) {
                                                    console.log(err);
                                                    res.write(err);
                                                    res.end();
                                                } else {
                                                    //si no hay error envia el texto y termina la peticion
                                                    res.write("La venta fue registrada correctamente");
                                                    res.end();
                                                }
                                            }

                                        )
                                    }

                                }
                            );
                        });
                    }
                }
            });
    };

    listarVentas = async (req, res) => {

        await pool.query("CALL listarVentas()", (err, rows) => {

            if (err) {
                console.log("internal error", err);
                res.write(err);
                res.end();
            } else if (rows[0].length === 0) {

                res.send({mensaje: "No hay ventas registradas"});
                res.end();

            } else {
                //si no hay error envia el texto, setea el id de la ultima vta y termina la peticion
                this.idUltimaVenta = rows[0][0].idVenta;
                res.send(rows)

            }
        });
    }

    listarVenta = async (req, res) => {

        await pool.query("CALL listarVenta(?)", [req.params.id], (err, rows) => {

            if (err) {
                console.log("internal error", err);
                res.write(err);
                res.end();
            } else if (rows[0].length === 0) {

                res.write("no hay ventas registradas");
                res.end();

            } else {
                //si no hay error envia el texto, setea el id de la ultima vta y termina la peticion
                this.idUltimaVenta = rows[0][0].idVenta;
                res.send(rows[0])

            }
        });


    }

    eliminarVenta = async (req, res) => {

        await pool.query("CALL eliminarVta(?)", [req.params.id], (err, rows) => {
            if (err) {
                console.log("internal error", err);
                res.write(err);
                res.end();
            } else {
                res.write("Venta eliminada correctamente");
                res.end();
            }
        })

    }

    listarClientes = async (req, res) => {

        //se traen los productos de la bd y se envian a la api
        await pool.query("CALL listarClientes()", (err, rows) => {

            if (err) {
                console.log(err);
                res.write(err);
                res.end();
            } else {
                res.send(rows[0]);
            }

        })

    }

    listarProductos = async (req, res) => {

        await pool.query("CALL listarProductos()", (err, rows) => {

            if (err) {
                console.log(err);
                res.write(err);
                res.end();
            } else {
                res.send(rows[0]);
            }
        })
    }

    actualizarVta = async (req, res) => {

        await pool.query("CALL actualizarEncVenta(?,?,?,?,?,?,?,?)",
            [req.body.tituloVenta,
                req.body.fecha,
                req.body.metPago,
                req.body.dto,
                req.body.vrTotal,
                req.body.vrtotalIva,
                req.body.idCliente,
                req.body.idVenta
            ], (err, results) => {

                if (err) {
                    console.log("internal error", err);
                    res.write(err);
                    res.end();
                } else {
                    //si no hay error envia el texto, setea el id de la ultima vta y termina la peticion
                    if (results.affectedRows > 0) {
                        pool.query("DELETE FROM detalleventa WHERE idVenta = ?", [req.body.vItemsEditar[0].idVenta], (err, results) => {
                            if (err) {
                                console.log(err);
                                res.write(err);
                                res.end();
                            } else {
                                req.body.vItemsEditar.forEach(element => {
                                    pool.query("INSERT INTO `detalleventa`(`idDetVenta`, `uniVendidas`, `precioUnitario`, `idVenta`, `idProducto`) VALUES ('', ?, ?, ?, ?)", [element.uniVendidas, element.precioUnitario, req.body.vItemsEditar[0].idVenta, element.idProducto],
                                        (err, result) => {
                                            if (err) {
                                                console.log(err);
                                                res.write(err);
                                                res.end();
                                            } else {
                                                res.write("Venta actualizada correcatamente");
                                                res.end();
                                            }
                                        })
                                })
                            }
                        })

                    }
                }
            })

    }
}

module.exports = ModuloVentas;