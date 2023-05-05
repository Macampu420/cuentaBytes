const pool = require('./../conexion');
const fs = require('fs');
const crypto = require('crypto');
const path = require('path');
const { exec } = require('child_process');
const archiver = require('archiver');

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

	encriptarArchivo = (req, res) => {
		try {
		  const sqlFilePath = path.join(__dirname, 'cuentabytes.sql');
		  const encryptedFilePath = path.join(__dirname, 'cuentabytes_encrypted.zip');
	  
		  // Comprimir archivo SQL
		  const output = fs.createWriteStream(encryptedFilePath);
		  const archive = archiver('zip', {
			zlib: { level: 9 } // Nivel de compresión máximo
		  });
	  
		  output.on('close', () => {
			console.log('Archivo SQL comprimido exitosamente');
	  
			// Cifrar archivo comprimido con contraseña
			const password = 'miContraseñaSuperSegura';
			const encryptedWriteStream = fs.createWriteStream(encryptedFilePath);
			const cipher = crypto.createCipher('aes192', password);
			const zipFileStream = fs.createReadStream(encryptedFilePath);
			zipFileStream.pipe(cipher).pipe(encryptedWriteStream);
	  
			encryptedWriteStream.on('close', () => {
			  console.log('Archivo SQL cifrado exitosamente');
			  // Eliminar archivo comprimido sin cifrar
			  fs.unlinkSync(encryptedFilePath);
			});
		  });
	  
		  archive.on('warning', function(err) {
			if (err.code === 'ENOENT') {
			  console.warn(err);
			} else {
			  throw err;
			}
		  });
	  
		  archive.on('error', function(err) {
			throw err;
		  });
	  
		  archive.pipe(output);
		  archive.file(sqlFilePath, { name: 'cuentabytes.sql' });
		  archive.finalize();
	  
		} catch (error) {
		  console.log(error);
		  res.status(500);
		}
	  };	

	desencriptarArchivo = (req, res) => {
		try {
			const clave = 'encriptacionCuentabyes420ñ'; // clave original de 16 caracteres
			const claveEncriptado = crypto.createHash('sha256').update(clave).digest().slice(0, 16); // clave de 128 bits generada a partir de la clave original
	
			const archivoEntrada = fs.createReadStream(path.join(__dirname, '../../', 'cuentabytesEncriptado.sql'));
			const archivoSalida = fs.createWriteStream(path.join(__dirname, '../../', 'cuentabytesDesencriptado.sql'));
	
			// Leer el IV del principio del archivo encriptado
			let iv;
			archivoEntrada.once('readable', () => {
				iv = archivoEntrada.read(12);
			});
	
			// Crear objeto Decipher después de que el IV sea leído
			archivoEntrada.on('readable', () => {
				const decipher = crypto.createDecipheriv('aes-128-gcm', claveEncriptado, iv);
	
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