const pool = require('./../conexion');

class Acordeon{

    traerMejoresClientes = async () =>{
        try {
            let resMejoresClientes = await pool.query('CALL mejoresClientes()');

            let mejoresClientes = JSON.stringify(resMejoresClientes[0]);

            return mejoresClientes;
        } catch (error) {
            console.log(error);
            return false;
        }
    }

    traerProductosMasVendidos = async () =>{
        try {
            let resProductosMasVend = await pool.query('CALL prodMasVend()');
            let productosMasVend = JSON.stringify(resProductosMasVend[0]);

            return productosMasVend;
        } catch (error) {
            console.log(error);
            return false;
        }
    }

    traerProductosMenosVendidos = async () =>{
        try {
            let resProductosMenosVend = await pool.query('CALL prodMenVend()');
            let productosMenosVend = JSON.stringify(resProductosMenosVend[0]);

            return productosMenosVend;
        } catch (error) {
            console.log(error);
            return false;
        }
    }

    traerProductosMasRentables = async () =>{
        try {
            let resProductosMasRentables= await pool.query('CALL rentabilidadProductos()');
            let productosMasRentables = JSON.stringify(resProductosMasRentables[0]);

            return productosMasRentables;
        } catch (error) {
            console.log(error);
            return false;
        }
    }

    traerMayorEgreso = async () =>{
        try {
            let resMayorEgreso= await pool.query('CALL mayorEgreso()');
            let mayorEgreso = JSON.stringify(resMayorEgreso[0]);

            return mayorEgreso;
        } catch (error) {
            console.log(error);
            return false;
        }
    }

    traerMenorEgreso = async () =>{
        try {
            let resMenorEgreso= await pool.query('CALL menorEgreso()');
            let menoraEgreso = JSON.stringify(resMenorEgreso[0]);

            return menoraEgreso;
        } catch (error) {
            console.log(error);
            return false;
        }
    }

    traerProducMayorStock = async () =>{
        try {
            let resProducMayorStock = await pool.query('CALL prodMasStock()');
            let producMayorStock = JSON.stringify(resProducMayorStock[0]);

            return producMayorStock;
        } catch (error) {
            console.log(error);
            return false;
        }
    }

    traerProducMenorStock = async () =>{
        try {
            let resProducMenorStock = await pool.query('CALL prodMenStock()');
            let producMenorStock = JSON.stringify(resProducMenorStock[0]);

            return producMenorStock;
        } catch (error) {
            console.log(error);
            return false;
        }
    }
}

module.exports = Acordeon;