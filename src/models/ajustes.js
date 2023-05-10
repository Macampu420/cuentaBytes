const fs = require('fs');
const { exec } = require('child_process');
const nodemon = require('nodemon');
const mysql = require('mysql');
const { promisify } = require('util');

const databaseConfig = {
	host: 'localhost',
	user: 'root',
	password: '',
	database: 'cuentabytes'
};  

const pool = mysql.createPool(databaseConfig);
pool.query = promisify(pool.query);

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
    };

    cambiarAjustes = async (query)=>{
        await pool.query(query);
    };

	callbackCmdBackup = (error, stdout, stderr, backupFilePath, res) => {
		if (error) {
		  console.error(`Error al crear la copia de seguridad: ${stderr}`);
		  res.status(500).send('Error al crear la copia de seguridad');
		} else {
		  console.log(`Copia de seguridad creada correctamente`);

		  //se sirve el archivo al cliente
		  res.download(backupFilePath, (err) => { //callback del metodo res.download
			if (err) {
			  console.error(`Error al descargar la copia de seguridad: ${err}`);
			  res.status(500).send('Error al descargar la copia de seguridad');
			} else {
			  console.log(`Copia de seguridad descargada correctamente`);
			  fs.unlinkSync(backupFilePath); // Eliminar el archivo de copia de seguridad del servidor después de descargarlo
			}
		  });
		}
	};

    backupDatabase = async function(req, res) {
        try {
          const backupFilePath = `${__dirname}/../../cuentabytes.sql`; // Ruta completa del archivo de copia de seguridad
            
          const cmd = `mysqldump -h localhost -u root --databases cuentabytes --routines > ${backupFilePath}`; // Comando para hacer la copia de seguridad          
          
		  //se ejecuta el comando para realizar la copia de seguridad
          exec(cmd, (error, stdout, stderr) => this.callbackCmdBackup(error, stdout, stderr, backupFilePath, res));
        } catch (err) {
          console.error(err);
        }
    };
    
	restarurarBd = async (req, res) => {
		try {
			await pool.query('DROP DATABASE IF EXISTS cuentabytes');
			await pool.query('CREATE DATABASE IF NOT EXISTS cuentabytes');
			await pool.query('USE cuentabytes');

			const backupFilePath = `${__dirname}/../../cuentabytes.sql`;
			const cmd = `mysql -u root cuentabytes < ${backupFilePath}`;

			exec(cmd, (error, stdout, stderr) => {
				if (error) {
					console.log(error);
					res.status(500).send('Error al importar la base de datos');
				} else {
					console.log('Bd importada exitosamente');
					res.status(200).send();
					// Reiniciar el servidor usando nodemon
					nodemon.restart();
				}
			});
		} catch (error) {
			console.log(error);
			res.status(500).send('Error al importar la base de datos');
		}
	};
            
}

module.exports = Ajustes;