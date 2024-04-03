const express = require('express');
const app = express();
const port = 3000;

app.set("view engine", "pug");

app.use(express.static("public"));

app.use(express.urlencoded({extended: true}));

//import session from 'express-session';
const session = require('express-session');
app.use(session({ 
	secret: 'top secret key',
    resave: true,
    saveUninitialized: false,
}));

const { Client } = require('pg');

const client = new Client({
    host: 'localhost',
    database: 'COMP3005Final',
    port: '5432',
	user: 'postgres',
	password: 'student',
});

client.connect().then(() => {
	console.log('Connected to PostgreSQL database');
}).catch((err) => {
	console.error('Error connecting to PostgreSQL database', err);
});


app.get(['/'], async (req, res) => { 
  res.render('../public/home', {});
});

app.get('/login', async (req, res) => { 
    res.render('../public/login', {});
});

app.post('/login', async (req, res) => {

    let username = req.body.username;
    let password = req.body.password;
    let user = req.body.dropdown;

    const query = "SELECT * FROM " + user + " WHERE username=\'" + username + "\' AND password=\'" + password  + "\';";
    //console.log(query);

    client.query(query, (err,result) => {
        //console.log(result.rows);
        
        if (err){
            //console.log("error");
            res.status(401).send("error");
        }
        else{

            if (result.rows.length == 0){
                //console.log("does not exist");
                res.status(401).send("does not exist");
            }
            else{

                console.log("exists");
                req.session.loggedin = true;
                req.session.user = user;
                //console.log(result.rows[0].member_id);
                req.session.id = result.rows[0].member_id;
                res.status(200).send("Logged in");

            }
        }
    });
    
});

app.get('/signup', async (req, res) => { 
    res.render('../public/signup', {});
});

app.post('/signup', async (req, res) => {

    let fname = req.body.fname;
    let lname = req.body.lname;
    let email = req.body.email;
    let phone = req.body.phone;
    let gender = req.body.gender;
    let username = req.body.username;
    let password = req.body.password;

    const query = "INSERT INTO member (fname, lname, email, phone_number, gender, username, password) VALUES ( \'" + fname + "\', \'" + lname + "\', \'" + email + "\', \'" + phone + "\', \'" + gender + "\', \'" + username + "\', \'" + password + "\');";
    //console.log(query);

    client.query(query, (err,result) => {

        if (err){
            console.log("error");
        }
        else{
            console.log("inserted");
            res.render('../public/home', {});
        }
    });
    
});


app.listen(port);
console.log(`Server is listening at http://localhost:${port}`);