const pool = require('./../conexion')

class Graficos {
  async traerDatosVentas (query) {
    try {
      // Llamar a un procedimiento almacenado en la base de datos que devuelve un resultado
      const [results] = await pool.query(query)
      // Convertir el resultado en un arreglo de objetos
      const datosVentas = results.map(element => JSON.parse(JSON.stringify(element)))

      return datosVentas
    } catch (error) {
      console.log(error)
      res.status(500)
    }
  }

  async traerDatosCompras (query) {
    try {
      // Llamar a un procedimiento almacenado en la base de datos que devuelve un resultado
      const [results] = await pool.query(query)
      // Convertir el resultado en un arreglo de objetos
      const datosCompras = results.map(element => JSON.parse(JSON.stringify(element)))

      return datosCompras
    } catch (error) {
      console.log(error)
      res.status(500)
    }
  }

  async traerDatosEgresos (query) {
    try {
      // Llamar a un procedimiento almacenado en la base de datos que devuelve un resultado
      const [results] = await pool.query(query)
      // Convertir el resultado en un arreglo de objetos
      const datosEgresos = results.map(element => JSON.parse(JSON.stringify(element)))

      return datosEgresos
    } catch (error) {
      console.log(error)
      res.status(500)
    }
  }

  async traerProductosFacturas (procedimiento) {
    try {
      const [results] = await pool.query(procedimiento)
      const datos = results.map(element => JSON.parse(JSON.stringify(element)))

      // Obtener la hora actual en formato 24 horas
      const vProductos = datos

      return vProductos
    } catch (error) {
      console.log(error)
      res.status(500)
    }
  }

  async traerClientesFacturas (procedimiento) {
    try {
      const [results] = await pool.query(procedimiento)
      const vClientes = results.map(element => JSON.parse(JSON.stringify(element)))

      return vClientes
    } catch (error) {
      console.log(error)
      res.status(500)
    }
  }
}

module.exports = Graficos
