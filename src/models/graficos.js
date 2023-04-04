const pool = require('./../conexion');
const moment = require('moment-timezone');
moment.tz.setDefault('America/Bogota');

class Graficos {

    llenarVectorHoras(vHoras, datos) {
        vHoras.forEach((elemento, index) => {
            let data = datos.find(dato => dato.hora === elemento.hora);
            if (data) {
                vHoras[index] = data;
            }
        });
    }

    async traerDatosComprasHoras(tiempo, nroHoras) {
        // Llamar a un procedimiento almacenado en la base de datos que devuelve un resultado
        let [results] = await pool.query(`CALL ventasPorHoras('${tiempo} 00:00:00', '${tiempo} 23:59:59')`);
        // Convertir el resultado en un arreglo de objetos
        let datos = results.map(element => JSON.parse(JSON.stringify(element)));
        // Obtener la hora actual en formato 24 horas
        let vHoras = [];

        // Agregar objetos al vector de horas para cada hora del día hasta la hora actual
        for (let i = 1; i <= nroHoras; i++) {
        vHoras.push({
            hora: i,
            VrTotalHora: 0
        });
        }

        // Llenar el vector de horas con los datos de ventas obtenidos de la base de datos
        this.llenarVectorHoras(vHoras, datos);
        
        console.log(vHoras);

        return vHoras;
    }

    async servirComprasPorHora(req) {
        let { inicio } = req.body;

        // Obtener la fecha de hoy
        const hoy = moment().tz('America/Bogota').format('YYYY-MM-DD');
        // Obtener la fecha de ayer
        const ayer = moment().tz('America/Bogota').subtract(1, 'days').format('YYYY-MM-DD');

        // Si el inicio es la fecha de hoy trae los datos de hoy sino pregunta y trae los de ayer
        if (inicio == hoy) {
            let horaActual = moment().tz('America/Bogota').format('HH:mm:ss').slice(0, 2);
            this.traerDatosComprasHoras(hoy, horaActual);
        } else if (inicio == ayer) {
            this.traerDatosComprasHoras(ayer, 24);
        }
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