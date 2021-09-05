const express = require('express'),
    path = require('path'),
    morgan = require('morgan'),
    mysql = require('mysql'),
    myConnection = require('express-myconnection');

const app = express();

// importing routes
const pacienteRoutes = require('./routes/paciente');

// settings
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// middlewares
app.use(morgan('dev'));
app.use(myConnection(mysql, {
    host: process.env.DBHOST,
    user: process.env.DBUSER,
    password: process.env.DBPW,
    port: process.env.DBPORT,
    database: process.env.DBNAME
}, 'single'));
app.use(express.urlencoded({extended: false}));

// routes
app.use('/', pacienteRoutes);

// static files
app.use(express.static(path.join(__dirname, 'public')));

// starting the server
app.listen(app.get('port'), () => {
    console.log(`server on port ${app.get('port')}`);
});
