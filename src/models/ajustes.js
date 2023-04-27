const pool = require('./../conexion');

class Ajustes {

    servirAjustes = async (req, res) => {
        try {

            let resAjutes = await pool.query("CALL listarAjustes");
            let ajustes = JSON.stringify(resAjutes[0][0]);
            res.status(200).send(ajustes);

        } catch (error) {
            console.log(error);
            res.status(500).send(JSON.stringify({
                error: "Ha ocurrido un error al consultar los ajustes"
            }));
        }
    }

}

module.exports = Ajustes;