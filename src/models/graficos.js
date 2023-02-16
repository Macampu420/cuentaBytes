const pool = require('./../conexion');

class Graficos {

  obtenerDatosCompras = (req) => {
    return new Promise((resolve, reject) => {
      // Hacer la consulta a varias tablas
      pool.query('CALL resumenCompras(?, ?)', [req.body.inicio, req.body.fin], (error, results, fields) => {
        if (error) reject(error);

        // Guardar los resultados en una variable
        let datos = results[0].map(element => JSON.parse(JSON.stringify(element)));

        // Resolver la promesa con los resultados
        resolve(datos);
      });
    });
  }

  obtenerDatosVentas = (req) => {
    return new Promise((resolve, reject) => {
      // Hacer la consulta a varias tablas
      pool.query('CALL resumenVenta(?, ?)', [req.body.inicio, req.body.fin], (error, results, fields) => {
        if (error) reject(error);

        // Guardar los resultados en una variable
        let datos = results[0].map(element => JSON.parse(JSON.stringify(element)));

        // Resolver la promesa con los resultados
        resolve(datos);
      });
    });
  }

  obtenerDatosEgresos = (req) => {
    return new Promise((resolve, reject) => {
      // Hacer la consulta a varias tablas
      pool.query('CALL resumenEgreso(?, ?)', [req.body.inicio, req.body.fin], (error, results, fields) => {
        if (error) reject(error);

        // Guardar los resultados en una variable
        let datos = results[0].map(element => JSON.parse(JSON.stringify(element)));

        // Resolver la promesa con los resultados
        resolve(datos);
      });
    });
  }


}

module.exports = Graficos;