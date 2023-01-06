//importacion de modulos
const mysql = require('mysql');
const  database = {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'cuentabytes'
}

const { promisify } = require('util');

//se crea el pool de las conexiones
const pool = mysql.createPool(database);

//se hace la conexion a la base de datos
pool.getConnection((err, connection) => {
    if (err) {
        console.error(err);
    } else {
        connection.release();
        console.log('bd conectada');
    }
});

//se convierten los callbacks en promesas
pool.query = promisify(pool.query);

module.exports = pool;