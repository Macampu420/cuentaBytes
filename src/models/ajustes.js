const fs = require('fs');
const { exec } = require('child_process');
const nodemon = require('nodemon');
const mysql = require('mysql');
const { promisify } = require('util');
const crypto = require('crypto');
const path = require('path');

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

	encriptarArchivo = (req, res) =>{
		try {
			let rutaSalida = path.join(__dirname, '../../', 'cuentabytesEncriptado.sql');
			const clave = 'encriptacionCuentabyes420ñ';
			const claveEncriptado = crypto.createHash('md5').update(clave).digest(); // clave de 128 bits generada a partir de la clave original
			const iv = crypto.randomBytes(16);
			const archivoEntrada = fs.createReadStream(path.join(__dirname, '../../', 'cuentabytes.sql'));
			const archivoSalida = fs.createWriteStream(rutaSalida);

			// Escribir el IV al principio del archivo encriptado
			archivoSalida.write(iv);

			// Crear objeto Cipher
			const cipher = crypto.createCipheriv('aes-128-cbc', claveEncriptado, iv);

			// Pipe data de ReadStream a Cipher y luego a WriteStream
			archivoEntrada.pipe(cipher).pipe(archivoSalida);

			// Cuando termine, cerrar los objetos
			archivoSalida.on('finish', () => {
				console.log('Archivo encriptado y guardado correctamente');
				archivoEntrada.close();
				archivoSalida.end();
				//se sirve el archivo al cliente
				res.download(rutaSalida, (err) => { //callback del metodo res.download
				if (err) {
					console.error(`Error al descargar la copia de seguridad: ${err}`);
					res.status(500).send('Error al descargar la copia de seguridad');
				} else {
					console.log(`Copia de seguridad descargada correctamente`);
				}
				});
			});
		} catch (error) {
			console.log(error);
			res.status(500);
		}
	}

	desencriptarArchivo = () => {
		try {
			let iv;
			const clave = 'encriptacionCuentabyes420ñ'; // clave original de 16 caracteres
			const claveEncriptado = crypto.createHash('md5').update(clave).digest(); // clave de 128 bits generada a partir de la clave original

			const archivoEntrada = fs.createReadStream(path.join(__dirname, '../../', 'cuentabytesEncriptado.sql'));
			const archivoSalida = fs.createWriteStream(path.join(__dirname, '../../', 'cuentabytesDesencriptado.sql'));

			// Leer el IV del principio del archivo encriptado
			archivoEntrada.once('readable', () => {
				iv = archivoEntrada.read(16);
				const decipher = crypto.createDecipheriv('aes-128-cbc', claveEncriptado, iv);
				// Pipe data de ReadStream a Decipher y luego a WriteStream
				archivoEntrada.pipe(decipher).pipe(archivoSalida);
			});

			// Cuando termine, cerrar los objetos
			archivoSalida.on('finish', () => {
				console.log('Archivo desencriptado y guardado correctamente');
				archivoEntrada.close();
				archivoSalida.end();
			});
		} catch (error) {
			console.log(error);
		}
	}

	callbackCmdBackup = (error, stdout, stderr, req, res) => {
		if (error) {
		  console.error(`Error al crear la copia de seguridad: ${stderr}`);
		  res.status(500).send('Error al crear la copia de seguridad');
		} else {
		  console.log(`Copia de seguridad creada correctamente`);
		  this.encriptarArchivo(req, res);
		}
	};

    backupDatabase = async function(req, res) {
        try {
          const backupFilePath = `${__dirname}/../../cuentabytes.sql`; // Ruta completa del archivo de copia de seguridad
            
          const cmd = `mysqldump -h localhost -u root --databases cuentabytes --routines > ${backupFilePath}`; // Comando para hacer la copia de seguridad          
          
		  //se ejecuta el comando para realizar la copia de seguridad
          exec(cmd, (error, stdout, stderr) => this.callbackCmdBackup(error, stdout, stderr, req, res));
        } catch (err) {
          console.error(err);
        }
    };
    
	restarurarBd = async (req, res) => {
		try {

			await pool.query('DROP DATABASE IF EXISTS cuentabytes');
			await pool.query('CREATE DATABASE IF NOT EXISTS cuentabytes');
			await pool.query('USE cuentabytes');

			const backupFilePath = `${__dirname}/../../cuentabytesDesencriptado.sql`;
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