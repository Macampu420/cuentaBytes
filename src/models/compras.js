const pool = require('./../conexion')

class moduloCompras {
  idUltimaCompra

  constructor () {
    this.idUltimaCompra = 0
  }

  registrarCompra = async (req, res) => {
    this.idUltimaCompra++

    // se inserta el encabezado de la venta con los campos que vienen del formilario
    await pool.query('CALL insertarEncCompra(?, ?, ?)', [this.idUltimaCompra, req.body.idProveedor, req.body.vrTotalCompra],
      (err, rows) => {
        // si hay error lo imprime y lo envia como respuesta
        if (err) {
          console.log('internal error', err)
          res.write(err)
          res.end()
        } else {
          // si hay items en el cuerpo de la peticion va iterando por cada uno
          // para registrarlo en la bd
          if (req.body.vItemsCompra !== undefined && req.body.vItemsCompra.length > 0) {
            req.body.vItemsCompra.forEach(element => {
              pool.query('CALL insertarDetCompra(?,?,?,?,?)', [element.unidadesCompradas, element.costoProducto, element.precioCompra, this.idUltimaCompra, element.idProducto],
                (err, rows) => {
                  // si hay error lo imprime y termina la peticion
                  if (err) {
                    console.log('internal error', err)
                    res.write(err)
                    res.end()
                  } else {
                    pool.query('CALL actualizarCostoProducto(?,?,?,?)', [element.unidadesCompradas, element.costoProducto, element.precioCompra, element.idProducto],
                      err => {
                        if (err) {
                          console.log(err)
                          res.write(err)
                          res.end()
                        } else {
                          // si no hay error envia el texto y termina la peticion
                          res.write('La compra fue registrada correctamente')
                          res.end()
                        }
                      }

                    )
                  }
                }
              )
            })
          }
        }
      })
  }

  eliminarCompra = async (req, res) => {
    await pool.query('CALL eliminarCompra(?)', [req.params.id], (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.write(err)
        res.end()
      } else {
        res.write('Compra eliminada correctamente')
        res.end()
      }
    })
  }

  traerEncsCompras = async (req, res) => {
    await pool.query('CALL `listarCompras`()', (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.send(null)
      } else if (rows[0].length === 0) {
        res.send(JSON.stringify({ mensaje: 'no hay compras registradas' }))
      } else {
        this.idUltimaCompra = rows[0][0].idCompra
        res.send(rows[0])
      }
    })
  }

  listarCompra = async (req, res) => {
    await pool.query('CALL listarCompra(?)', [req.params.id], (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.write(err)
        res.end()
      } else if (rows[0].length === 0) {
        res.status(400).send(JSON.stringify({ mensaje: 'no hay compras registradas' }))
        res.end()
      } else {
        // si no hay error envia el texto, setea el id de la ultima vta y termina la peticion
        this.idUltimaCompra = rows[0][0].idCompra
        res.send(rows[0])
      }
    })
  }
}

module.exports = moduloCompras
