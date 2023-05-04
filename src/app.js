const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const Ajustes = require("./models/ajustes");
const morgan = require('morgan');
let  corsOptions = { origin: 'http://localhost:8012'}

const app = express();

//configuraciones
app.set('port', process.env.PORT || 3000);
app.use(cors(corsOptions));

//middlewares
// parse application/x-www-form-urlencoded
app.use(morgan('tiny'));

app.use(bodyParser.urlencoded({
    extended: false
}))

// parse application/json
app.use(bodyParser.json());

//rutas
app.use(require('./routes/graficos'));
app.use(require('./routes/ventas'));
app.use(require('./routes/egresos'));
app.use(require('./routes/compras'));
app.use(require('./routes/notas'))
app.use(require('./routes/inicioSesion'))
app.use(require('./routes/mailer'));
app.use(require('./routes/ajustes'));


//inicializacion del servidor
app.listen(app.get('port'), () => console.log("App corriendo bien"));