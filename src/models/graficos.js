const pool = require('./../conexion');

class Graficos {

    //metodo para indicar el total de horas a servir (24 o las horas del dia de hoy)
    llenarVectorHoras(vHoras, datos) {
        //itera sobre el arreglo con el total de horas a mostrar y si encuentra una coincidencia con
        //alguna de las horas arrojadas por la bd la reempleza con los datos
        vHoras.forEach((elemento, index) => {
            let data = datos.find(dato => dato.hora === elemento.hora);
            if (data) {
                vHoras[index] = data;
            }
        });
    }

    async traerDatosVentasHoras(tiempo, nroHoras) {
        try {
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
                    vrTotalHora: 0
                });
            }

            // Llenar el vector de horas con los datos de ventas obtenidos de la base de datos
            this.llenarVectorHoras(vHoras, datos);

            if (vHoras.length == 0) {
                throw new Error("No hay horas por mostrar");
            }

            return vHoras;

        } catch (error) {
            throw error;
        }
    }  

    async traerDatosComprasHoras(tiempo, nroHoras) {
        try {
            // Llamar a un procedimiento almacenado en la base de datos que devuelve un resultado
            let [results] = await pool.query(`CALL comprasPorHoras('${tiempo} 00:00:00', '${tiempo} 23:59:59')`);
            // Convertir el resultado en un arreglo de objetos
            let datos = results.map(element => JSON.parse(JSON.stringify(element)));
            // Obtener la hora actual en formato 24 horas
            let vHoras = [];

            // Agregar objetos al vector de horas para cada hora del día hasta la hora actual
            for (let i = 1; i <= nroHoras; i++) {
                vHoras.push({
                    hora: i,
                    vrTotalHora: 0
                });
            }

            // Llenar el vector de horas con los datos de ventas obtenidos de la base de datos
            this.llenarVectorHoras(vHoras, datos);

            if (vHoras.length == 0) {
                throw new Error("No hay horas por mostrar");
            }

            return vHoras;

        } catch (error) {
            throw error;
        }
    }  

    async traerDatosEgresosHoras(tiempo, nroHoras) {
        try {
            // Llamar a un procedimiento almacenado en la base de datos que devuelve un resultado
            let [results] = await pool.query(`CALL egresosPorHora('${tiempo} 00:00:00', '${tiempo} 23:59:59')`);
            // Convertir el resultado en un arreglo de objetos
            let datos = results.map(element => JSON.parse(JSON.stringify(element)));
            // Obtener la hora actual en formato 24 horas
            let vHoras = [];

            // Agregar objetos al vector de horas para cada hora del día hasta la hora actual
            for (let i = 1; i <= nroHoras; i++) {
                vHoras.push({
                    hora: i,
                    vrTotalHora: 0
                });
            }

            // Llenar el vector de horas con los datos de ventas obtenidos de la base de datos
            this.llenarVectorHoras(vHoras, datos);

            if (vHoras.length == 0) {
                throw new Error("No hay horas por mostrar");
            }

            return vHoras;

        } catch (error) {
            throw error;
        }
    } 

    async traerDatosDias(nroDias, procedimiento) {
        try {
            // Llamar a un procedimiento almacenado en la base de datos que devuelve un resultado
            let [results] = await pool.query(procedimiento);
            // Convertir el resultado en un arreglo de objetos
            let datos = results.map(element => JSON.parse(JSON.stringify(element)));
            // Obtener la hora actual en formato 24 horas
            let vHoras = [];

            // Agregar objetos al vector de horas para cada hora del día hasta la hora actual
            for (let i = 1; i <= nroDias; i++) {
                vHoras.push({
                    hora: i,
                    vrTotalHora: 0
                });
            }

            // Llenar el vector de horas con los datos de ventas obtenidos de la base de datos
            this.llenarVectorHoras(vHoras, datos);

            if (vHoras.length == 0) {
                throw new Error("No hay horas por mostrar");
            }

            return vHoras;

        } catch (error) {
            throw error;
        }
    }  

}

module.exports = Graficos;