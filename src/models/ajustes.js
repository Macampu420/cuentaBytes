const { query } = require('express');
const pool = require('./../conexion');

class Ajustes {

    servirAjustes = async (req, res) => {
        try {

            //se traen los datos de la bd y si todo sale bien se sirve la API
            let resAjustes = await pool.query("CALL listarAjustes");
            let ajustes = JSON.stringify(resAjustes[0][0]);
            res.status(200).send(ajustes);

        } catch (error) {
            //se imprime el error y se envia un json al cliente
            console.log(error);
            res.status(500).send(JSON.stringify({
                error: "Ha ocurrido un error al consultar los ajustes"
            }));
        }
    }

    cambiarAjustes = async (query)=>{
        await pool.query(query);
    }

}

module.exports = Ajustes;