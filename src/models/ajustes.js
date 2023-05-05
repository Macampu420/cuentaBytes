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
    };

    cambiarAjustes = async (query)=>{
        await pool.query(query);
    };

	encriptarArchivo = (req, res) =>{
		try {
			const clave = 'encriptacionCuentabyes420ñ'; // clave original de 16 caracteres
			const claveEncriptado = crypto.createHash('sha256').update(clave).digest('hex').substr(0, 32); // clave de 256 bits generada a partir de la clave original
			const iv = crypto.randomBytes(16);

			const archivoEntrada = fs.createReadStream(path.join(__dirname, '../../', 'cuentabytes.sql'));
			const archivoSalida = fs.createWriteStream(path.join(__dirname, '../../', 'cuentabytesEncriptado.sql'));

			// Escribir el IV al principio del archivo encriptado
			archivoSalida.write(iv);

			// Crear objeto Cipher
			const cipher = crypto.createCipheriv('aes-256-cbc', claveEncriptado, iv);

			// Pipe data de ReadStream a Cipher y luego a WriteStream
			archivoEntrada.pipe(cipher).pipe(archivoSalida);

			// Cuando termine, cerrar los objetos
			archivoSalida.on('finish', () => {
				console.log('Archivo encriptado y guardado correctamente');
				archivoEntrada.close();
				archivoSalida.end();
			});
		} catch (error) {
			console.log(error);
			res.status(500);
		}
	}

	desencriptarArchivo = (req, res) => {
		try {
		  const clave = 'encriptacionCuentabyes420ñ'; // clave original de 16 caracteres
		  const claveEncriptado = crypto.createHash('sha256').update(clave).digest('hex').substr(0, 32); // clave de 256 bits generada a partir de la clave original
	  
		  const archivoEntrada = fs.createReadStream(path.join(__dirname, '../../', 'cuentabytesEncriptado.sql'));
		  const archivoSalida = fs.createWriteStream(path.join(__dirname, '../../', 'cuentabytesDesencriptado.sql'));
	  
		  // Leer el IV del principio del archivo encriptado
		  let iv;
		  archivoEntrada.once('readable', () => {
			iv = archivoEntrada.read(16);
		  });
	  
		  // Crear objeto Decipher después de que el IV sea leído
		  archivoEntrada.on('readable', () => {
			const decipher = crypto.createDecipheriv('aes-256-cbc', claveEncriptado, iv);
	  
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
		  res.status(500);
		}
	  }
	  

	callbackCmdBackup = (error, stdout, stderr) => {
		if (error) {
		  console.error(`Error al crear la copia de seguridad: ${stderr}`);
		  res.status(500).send('Error al crear la copia de seguridad');
		} else {
		  console.log(`Copia de seguridad creada correctamente en ${backupFilePath}`);

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
       
		res.send(path.join(__dirname, '../../', 'cuentabytes.sql'))

        try {
          const backupFilePath = `${__dirname}/../../cuentabytes.sql`; // Ruta completa del archivo de copia de seguridad
            
          const cmd = `mysqldump -u root cuentabytes > ${backupFilePath}`; // Comando para hacer la copia de seguridad          
          
		  //se ejecuta el comando para realizar la copia de seguridad
          exec(cmd, this.callbackCmdBackup(error, stdout, stderr));
        } catch (err) {
          console.error(err);
        }
    };
      
      
      
}

module.exports = Ajustes;