const pool = require('../conexion')

class ModuloEgresos {
  idUltimoEgreso

  constructor () {
    this.idUltimoEgreso = 0
  }

  registrarEgreso = async (req, res) => {
    if (this.idUltimoEgreso == null) {
      this.idUltimoEgreso = 0
    }

    this.idUltimoEgreso++

    // se inserta el encabezado de la venta con los campos que vienen del formilario
    await pool.query('CALL insertarEncEgreso(?, ?, ?, ?)', [this.idUltimoEgreso, req.body.tituloEgreso, req.body.vrTotalEgreso, req.body.idTipoEgreso],
      (err, rows) => {
        // si hay error lo imprime y lo envia como respuesta
        if (err) {
          console.log('internal error', err)
          res.write(err)
          res.end()
        } else {
          // si hay items en el cuerpo de la peticion va iterando por cada uno
          // para registrarlo en la bd
          if (req.body.itemsEgreso !== undefined && req.body.itemsEgreso.length > 0) {
            req.body.itemsEgreso.forEach(element => {
              pool.query('CALL insertarDetEgreso(?,?,?)', [element.valorEgreso, element.descripcion, this.idUltimoEgreso],
                (err, rows) => {
                  // si hay error lo imprime y termina la peticion
                  if (err) {
                    console.log('internal error', err)
                    res.write(err)
                    res.end()
                  } else {
                    // si no hay error envia el texto y termina la peticion
                    res.write('El egreso fue registrado correctamente')
                    res.end()
                  }
                }
              )
            })
          }
        }
      })
  }

  actualizarEgreso = async (req, res) => {
    await pool.query('CALL actualizarEgreso(?, ?, ?, ?)', [req.body.idEgreso, req.body.tituloEgreso, req.body.vrTotalEgreso, req.body.idTipoEgreso],
      (err, rows) => {
        // si hay error lo imprime y lo envia como respuesta
        if (err) {
          console.log('internal error', err)
          res.write(err)
          res.end()
        } else {
          // si hay items en el cuerpo de la peticion va iterando por cada uno
          // para registrarlo en la bd
          if (req.body.itemsEgreso !== undefined && req.body.itemsEgreso.length > 0) {
            if (req.body.borrarDetEgreso === true) {
              req.body.itemEliminar.forEach(element => {
                pool.query('CALL eliminarDetEgreso(?)', [element.itemId],
                  (err, rows) => {
                    // si hay error lo imprime y termina la peticion
                    if (err) {
                      console.log('internal error', err)
                      res.write(err)
                      res.end()
                    } else {
                      // si no hay error envia el texto y termina la peticion
                      res.write('El egreso fue actualizado correctamente')
                      res.end()
                    }
                  })

                console.log(element.itemId)
              })
            }

            req.body.itemsEgreso.forEach(element => {
              if (element.idDetEgreso == null) {
                pool.query('CALL insertarDetEgreso(?,?,?)', [element.valorEgreso, element.descripcion, req.body.idEgreso],
                  (err, rows) => {
                    // si hay error lo imprime y termina la peticion
                    if (err) {
                      console.log('internal error', err)
                      res.write(err)
                      res.end()
                    } else {
                      // si no hay error envia el texto y termina la peticion
                      res.write('El egreso fue actualizado correctamente')
                      res.end()
                    }
                  }
                )
              } else {
                pool.query('CALL actualizarDetEgreso(?,?,?)', [element.idDetEgreso, element.valorEgreso, element.descripcion],
                  (err, rows) => {
                    // si hay error lo imprime y termina la peticion
                    if (err) {
                      console.log('internal error', err)
                      res.write(err)
                      res.end()
                    } else {
                      // si no hay error envia el texto y termina la peticion
                      res.write('El egreso fue actualizado correctamente')
                      res.end()
                    }
                  }
                )
              }
            })
          }
        }
      })
  }

  listarEgresos = async (req, res) => {
    await pool.query('CALL listarEgresos()', (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.write(err)
        res.end()
      } else if (rows[0].length === 0) {
        res.write('no hay egresos registrados')
        res.end()
      } else {
        // si no hay error envia el texto, setea el id de la ultima vta y termina la peticion
        this.idUltimoEgreso = rows[0][0].idEgreso
        res.send(rows)
      }
    })
  }

  listarEgreso = async (req, res) => {
    await pool.query('CALL listarEgreso(?)', [req.params.id], (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.write(err)
        res.end()
      } else if (rows[0].length === 0) {
        res.write('no hay ventas registradas')
        res.end()
      } else {
        // si no hay error envia el texto, setea el id de la ultima vta y termina la peticion
        this.idUltimoEgreso = rows[0][0].idVenta
        res.send(rows[0])
      }
    })
  }

  eliminarEgreso = async (req, res) => {
    await pool.query('CALL eliminarEgreso(?)', [req.params.id], (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.write(err)
        res.end()
      } else {
        res.write('Egreso eliminado correctamente')
        res.end()
      }
    })
  }

  listarTipoEgreso = async (req, res) => {
    // se traen los productos de la bd y se envian a la api
    await pool.query('CALL listarTipoEgreso()', (err, rows) => {
      if (err) {
        console.log(err)
        res.write(err)
        res.end()
      } else {
        res.send(rows[0])
      }
    })
  }
}

module.exports = ModuloEgresos
