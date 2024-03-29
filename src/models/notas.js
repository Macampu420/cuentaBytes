const pool = require('../conexion')

class ModuloNotas {
  registrarNota = async (req, res) => {
    await pool.query('CALL insertarNota(?, ?)', [req.body.tituloNota, req.body.cuerpoNota],
      (err, rows) => {
        // si hay error lo imprime y lo envia como respuesta
        if (err) {
          console.log('internal error', err)
          res.write(err)
          res.end()
        } else {
          res.write('La nota fue registrada correctamente')
          res.end()
        }
      })
  }

  actualizarNota = async (req, res) => {
    await pool.query('CALL actualizarNota(?,?,?)', [req.body.idNota, req.body.tituloNota, req.body.cuerpoNota],
      (err, rows) => {
        // si hay error lo imprime y lo envia como respuesta
        if (err) {
          console.log('internal error', err)
          res.write(err)
          res.end()
        } else {
          res.write('La nota fue actualizada correctamente')
          res.end()
        }
      })
  }

  eliminarNota = async (req, res) => {
    await pool.query('CALL eliminarNota(?)', [req.params.id], (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.write(err)
        res.end()
      } else {
        res.write('Nota eliminada correctamente')
        res.end()
      }
    })
  }

  listarUnaNota = async (req, res) => {
    await pool.query('CALL mostrarUnaNota(?)', [req.params.id], (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.write(err)
        res.end()
      } else if (rows[0].length === 0) {
        res.write('no hay notas registradas')
        res.end()
      } else {
        res.send(rows[0])
      }
    })
  }

  listarNotas = async (req, res) => {
    await pool.query('CALL mostrarNotas()', (err, rows) => {
      if (err) {
        console.log('internal error', err)
        res.write(err)
        res.end()
      } else if (rows[0].length === 0) {
        res.write('no hay notas registrados')
        res.end()
      } else {
        res.send(rows[0])
      }
    })
  }
}

module.exports = ModuloNotas
