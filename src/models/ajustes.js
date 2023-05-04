const pool = require('./../conexion');
const fs = require('fs');
const moment = require('moment');
const crypto = require('crypto');
const path = require('path');
const util = require('util');
const { exec } = require('child_process');


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

    backupDatabase = async function(req, res) {
       
        try {
          const backupFilePath = `${__dirname}/../../cuentabytes.sql`; // Ruta completa del archivo de copia de seguridad
            
          const cmd = `mysqldump -u root cuentabytes > ${backupFilePath}`; // Comando para hacer la copia de seguridad          
          
          console.log(cmd);

          exec(cmd, (error, stdout, stderr) => {
            if (error) {
              console.error(`Error al crear la copia de seguridad: ${stderr}`);
              res.status(500).send('Error al crear la copia de seguridad');
            } else {
              console.log(`Copia de seguridad creada correctamente en ${backupFilePath}`);
              res.download(backupFilePath, (err) => {
                if (err) {
                  console.error(`Error al descargar la copia de seguridad: ${err}`);
                  res.status(500).send('Error al descargar la copia de seguridad');
                } else {
                  console.log(`Copia de seguridad descargada correctamente`);
                  fs.unlinkSync(backupFilePath); // Eliminar el archivo de copia de seguridad del servidor después de descargarlo
                }
              });
            }
          });
        } catch (err) {
          console.error(err);
        }
      };
      
      
      
}

module.exports = Ajustes;