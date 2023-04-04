const pool = require('./../conexion');

class Graficos {

  async obtenerComprasPorHora(req){
    let {inicio, fin} = req.body;

    let hoy = new Date();
    hoy = hoy.toISOString().slice(0, 10);

    let auxAyer = new Date();
    auxAyer = auxAyer.setDate(auxAyer.getDate() - 1);
    let ayer = new Date(auxAyer).toISOString().slice(0, 10);

    if(inicio == hoy){

      let resDatosVentas = await pool.query(`CALL ventasPorHoras('${hoy} 00:00:00', '${hoy} 23:59:59')`);
      

      console.log("traer datos de hoy");
    } else if(inicio == ayer){
      console.log("traer datos de ayer");
    }

    console.log(inicio, fin);
  }

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