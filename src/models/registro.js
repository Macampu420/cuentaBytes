const { query } = require('express');
const pool = require('../conexion');
const nodemailer = require("nodemailer");
const CryptoJS = require('crypto-js');


class moduloRegistro {

    codigoEnv; email; contrasena; nombreEmpresa;

    enviarCorreo = async (req, res) => {

        const {
            email,
            codigo,
            contrasena,
            nombreEmpresa
        } = req.body;

        this.codigoEnv = codigo;
        this.nombreEmpresa = nombreEmpresa;
        this.contrasena = contrasena;
        this.email = email;

        let transporter = nodemailer.createTransport({
            host: "smtp.gmail.com",
            port: 587,
            secure: false,
            auth: {
                user: "ricrdo.henao568@gmail.com",
                pass: "nown vgif jvqn dmtp"
            },
        });
        let info = await transporter.sendMail({
            from: "ricrdo.henao568@gmail.com",
            to: email,
            subject: "Codigo de validacion",
            html: `su codigo es: ${codigo}`,
        });
        res.send({
            status: 200,
            messaje: "codigo de verificacion creado y enviado con exito",
        })
    }

    verificarCodigo = async (req, res) => {

        const {
            codigo
        } = req.body;


        if (codigo == this.codigoEnv) {

            const contrasena = CryptoJS.SHA256(this.contrasena).toString(CryptoJS.enc.Hex);

            await pool.query("CALL registrarEmpresa(?, ?, ?)", [this.nombreEmpresa, this.email, contrasena],
                (err, rows) => {
                    //si hay error lo imprime y lo envia como respuesta
                    if (err) {
                        console.log("internal error", err);
                        res.write(err);
                        res.end();
                    } else {
                        res.send({
                            status: 200,
                            messaje: "Registrado Correctamente"
                        })

                        pool.query("CALL insertarAjustes(?)", [this.nombreEmpresa],
                            (err, rows) => {
                                if (err) {
                                    console.log("internal error", err);
                                    res.write(err);
                                    res.end();
                                }
                                else {
                                    res.send({
                                        status: 200,
                                        messaje: "Registrado Correctamente"
                                    })
                                }
                            }
                        )
                    }
                });


        } else {
            res.send({
                status: 300,
                messaje: "Codigo invalido",
            })
        }
    }

}

module.exports = moduloRegistro;