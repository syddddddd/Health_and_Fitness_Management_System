const express = require('express');
const app = express();
const port = 3000;

app.set("view engine", "pug");

app.use(express.static("public"));
app.use(express.urlencoded({extended: true}));

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
    let table = user.charAt(0).toUpperCase() + user.slice(1) + 's'

    const query = "SELECT * FROM " + table +  " WHERE username=\'" + username + "\' AND password=\'" + password  + "\';";
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
                //res.status(401).send("does not exist");
                res.redirect(`http://localhost:3000/login`);
            }
            else{

                console.log("exists");
                req.session.loggedin = true;
                //req.session.user = user;
                //console.log(result.rows[0].member_id);
                //req.session.id = result.rows[0].member_id;
                req.session.user = result.rows[0];
                req.session.type = user;
                //console.log(user)
                console.log(req.session);
                //res.status(200).send("Logged in");
                res.redirect(`http://localhost:3000/${user}`);
                //res.render(`../public/${user}`, {session : req.session});

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
    let user = req.body.dropdown;
    let table = user.charAt(0).toUpperCase() + user.slice(1) + 's'

    const query = "INSERT INTO " + table + " (fname, lname, email, phone_number, gender, username, password) VALUES ( \'" + fname + "\', \'" + lname + "\', \'" + email + "\', \'" + phone + "\', \'" + gender + "\', \'" + username + "\', \'" + password + "\') RETURNING *;";
    //console.log(query);

    client.query(query, (err,result) => {

        if (err){
            console.log(err);
            console.log("THERE IS ERROR")
        }
        else{
            console.log("inserted");
            req.session.user = result.rows[0];
            req.session.type = user;
            req.session.loggedin = true;
            console.log(req.session);
            res.render(`../public/${user}`, {session : req.session});
        }
    });
    
});

app.get('/member', async (req, res) => { 
    try{
        
        let user = req.session.user.member_id;
        res.redirect(`http://localhost:3000/member/${user}`);
    }
    catch(err){
        res.status(401).send("error");
    }
});

app.get('/trainer', async (req, res) => { 
    try {
        const query = "SELECT * FROM Schedule WHERE trainer_id=$1 ORDER BY time_slot";
        const scheduleResult = await client.query(query, [req.session.user.trainer_id]);
        console.log("getting schedule")

        console.log("exists");
        console.log(scheduleResult.rows)
        req.session.schedule = scheduleResult.rows

        const query2 = "SELECT s.schedule_id, ARRAY_AGG(s.member_id) as ids, ARRAY_AGG(CONCAT(m.fname, ' ', m.lname)) AS members FROM ScheduledMembers s JOIN Members m on m.member_id = s.member_id WHERE trainer_id=$1 Group By schedule_id";
        const classes = await client.query(query2, [req.session.user.trainer_id]);

        console.log("getting members")
        console.log(classes.rows)
        req.session.classes = classes.rows
        
        res.render('../public/trainer', {session : req.session, schedule : req.session.schedule, classes :  req.session.classes});

    } catch (err) {
        res.status(401).send("error");
    }
    
});

app.get('/member/editProfile', async (req, res) => { 
    res.render('../public/editProfile', {session : req.session});
});

app.post('/member/editProfile', async (req, res) => {

    // personal info
    let fname = req.body.fname;
    let lname = req.body.lname;
    let email = req.body.email;
    let phone = req.body.phone;
    let gender = req.body.gender;

    // fitness goals
    let goalWeight = req.body.goalWeight;
    let distance = req.body.distance;
    let time = req.body.time;

    // health metrics
    let sleep = req.body.sleep;
    let curWeight = req.body.currentWeight;
    let height = req.body.height;
    let calories = req.body.calories;

    // current user
    let user = req.session.user.member_id;

    // update personal info based on input by user
    let setPersonalInfo = [];
    
    if (fname){
        setPersonalInfo.push("fname = \'" + fname + "\'");
    }
    if (lname){
        setPersonalInfo.push("lname = \'" + lname + "\'");
    }
    if (email){
        setPersonalInfo.push("email = \'" + email + "\'");
    }
    if (phone){
        setPersonalInfo.push("phone = \'" + phone + "\'");
    }
    if (gender != "empty"){
        setPersonalInfo.push("gender = \'" + gender + "\'");
    }

    // if the personal info is not empty, update it
    if (setPersonalInfo.length > 0){

        let setString = "";

        setString += setPersonalInfo.join(', ');
        //console.log(setString);

        const pInfoquery = "UPDATE Members SET " + setString + " WHERE member_id= " + user;
        //console.log(pInfoquery);

        client.query(pInfoquery, (err,result) => {

            if (err){
                console.log(err);
                console.log("error updating personal info");
                res.status(401).send("error");
            }
            else{
                console.log("updated personal info");
            }
        });
    }

    // update fitness files based on input by user
    let setFitnessFiles = [];

    if (goalWeight){
        setFitnessFiles.push("goal_weight = " + goalWeight);
    }
    if (distance){
        setFitnessFiles.push("distance = " + distance);
    }
    if (time){
        setFitnessFiles.push("goal_time = \'" + time + "\'");
    }

    // if the fitness files is not empty, update it
    if (setFitnessFiles.length > 0){

        let setFileString = "";

        setFileString += setFitnessFiles.join(', ');
       //console.log(setFileString);

        const fitnessQuery = "UPDATE FitnessFiles SET " + setFileString + " WHERE member_id= " + user;
        //console.log(fitnessQuery);

        client.query(fitnessQuery, (err,result) => {

            if (err){
                console.log("error updating fitness files");
                res.status(401).send("error");
            }
            else{
                console.log("updated fitness goals");
            }
        });
    }

    updateHealthMetrics(user, sleep, curWeight, height, calories);
    insertHealthStats(user, sleep, curWeight, height, calories);


    const query = "SELECT * FROM Members WHERE member_id= " + user;

    client.query(query, (err,result) => {
        //console.log(result.rows);
        
        if (err){
            console.log("error findng the user after update");
            res.status(401).send("error");
        }
        else{
            req.session.user = result.rows[0];
            //console.log(user)
            //console.log(req.session);
            res.redirect(`http://localhost:3000/member`);
        }
    });
    
});

function updateHealthMetrics(user, sleep, curWeight, height, calories){

    let setHealthMetrics = [];

    if (sleep){
        setHealthMetrics.push("hours_slept = " + sleep);
    }
    if (curWeight){
        setHealthMetrics.push("curr_weight = " + curWeight);
    }
    if (height){
        setHealthMetrics.push("height = " + height);
    }
    if (calories){
        setHealthMetrics.push("calories_consummed = " + calories);
    }

    if (setHealthMetrics.length > 0){

        let setMetricsString = "";

        setMetricsString += setHealthMetrics.join(', ');
        //console.log(setMetricsString);

        const fitnessQuery = "UPDATE HealthMetrics SET " + setMetricsString + " WHERE member_id= " + user;
        //console.log(fitnessQuery);

        client.query(fitnessQuery, (err,result) => {

            if (err){
                console.log("error updating health metrics");
                res.status(401).send("error");
            }
            else{
                console.log("updated health metrics");
            }
        });
    }
}

function insertHealthStats(user, sleep, curWeight, height, calories){

    let setHMvariables = [];
    let setHMData = [];

    if (sleep){
        setHMvariables.push("hours_slept");
        setHMData.push(sleep);
    }
    if (curWeight){
        setHMvariables.push("curr_weight");
        setHMData.push(curWeight);
    }
    if (height){
        setHMvariables.push("height");
        setHMData.push(height);
    }
    if (calories){
        setHMvariables.push("calories_consummed");
        setHMData.push(calories);
    }

    // if the stats are not empty, update it
    if (setHMvariables.length > 0){

        let varString = "";
        let dataString = "";

        varString += setHMvariables.join(', ');
       //console.log(varString);

        dataString += "\'";
        dataString += setHMData.join("\', \'");
        dataString += "\'"
        //console.log(dataString);

        const healthQuery = "INSERT INTO HealthStatistics (member_id, " + varString + " ) VALUES ( \'" + user + "\', " + dataString + ");";
        //console.log(healthQuery);

        client.query(healthQuery, (err,result) => {

            if (err){
                console.log("error updating health stats");
                //res.status(401).send("error");
            }
            else{
                console.log("updated health stats");
            }
        });
    }
}

app.get('/member/dashboard', async (req, res) => { 

    try{

        let user = req.session.user.member_id;

        let healthstats = {};

        const avgSleep = "SELECT AVG(CAST(hours_slept as FLOAT)) FROM HealthStatistics WHERE member_id= " + user;
        const sleepResults = await client.query(avgSleep);
        healthstats.sleep = sleepResults.rows[0].avg;

        const avgWeight = "SELECT AVG(CAST(curr_weight as FLOAT)) FROM HealthStatistics WHERE member_id= " + user;
        const weightResults = await client.query(avgWeight);
        healthstats.weight = weightResults.rows[0].avg;

        const avgCalories = "SELECT AVG(CAST(calories_consummed as FLOAT)) FROM HealthStatistics WHERE member_id= " + user;
        const caloriesResults = await client.query(avgCalories);
        healthstats.calories = caloriesResults.rows[0].avg;
        
        //console.log(healthstats);
        res.render('../public/memberDashboard', {session : req.session, health : healthstats});
    }
    catch(err){
        res.status(401).send("error");
    }
});

app.get('/member/:memberId', async (req, res) => { 
    let id = req.params.memberId;
    console.log(id)

    try {
        const query = "SELECT * FROM Members WHERE member_id=$1";
        const member = await client.query(query, [id]);
        console.log("getting member")

        console.log("exists");
        console.log(member.rows[0])

        const query2 = "SELECT * FROM FitnessFiles WHERE member_id=$1";
        const fitnessResults = await client.query(query2, [id]);
        //console.log(fitnessResults.rows);

        const query3 = "SELECT * FROM HealthMetrics WHERE member_id=$1";
        const healthResults = await client.query(query3, [id]);
        
        res.render('../public/member', {session : req.session, member : member.rows[0], fitness : fitnessResults.rows[0], health : healthResults.rows[0]});
        //res.render('../public/member', {session : req.session, member : member.rows[0]});

    } catch (err) {
        res.status(401).send("error");
    }

});


app.get('/addSession', async (req, res) => { 
    res.render('../public/addSession', {session : req.session});
});

app.post('/addSession', async (req, res) => {

    let day = req.body.day;
    let time = req.body.hour + ':' + req.body.min;
    let sessType = req.body.sessType;
    let id = req.session.user.trainer_id
    //console.log("session:")
    //console.log(req.session.user)
    //let table = req.session.type.charAt(0).toUpperCase() + req.session.type.slice(1) + 's'

    const query = "INSERT INTO SCHEDULE (trainer_id, day, time_slot, availability, session_type) VALUES ( \'" + id + "\', \'" + day + "\', \'" + time + "\', \'true\', \'" + sessType + "\') RETURNING *;";
    //console.log(query);

    client.query(query, (err,result) => {

        if (err){
            console.log(err);
            console.log("THERE IS ERROR")
            res.status(401).send("error");
        }
        else{
            console.log("inserted");
            //console.log(result.rows)
            //console.log(req.session.schedule)

            // if (!req.session.hasOwnProperty("schedule")) {  
            //     req.session.schedule = []
            // } 
            
            // req.session.schedule.push(result.rows[0])
            
            //console.log(req.session.schedule)
            res.redirect(`http://localhost:3000/trainer`);
            //res.render(`../public/trainer`, {session : req.session, schedule: req.session.schedule});
        }
    });
    
});

app.get('/editSession/:schedId', async (req, res) => { 
    let id = req.params.schedId;
    console.log(id)

    try {
        const query = "SELECT * FROM Schedule WHERE schedule_id=$1";
        const session = await client.query(query, [id]);
        console.log("getting session")

        console.log("exists");
        console.log(session.rows[0])

        const query2 = "SELECT s.schedule_id, ARRAY_AGG(s.member_id) as ids, ARRAY_AGG(CONCAT(m.fname, ' ', m.lname)) AS members FROM ScheduledMembers s JOIN Members m on m.member_id = s.member_id WHERE trainer_id=$1 and schedule_id=$2 Group By schedule_id";
        const theClass = await client.query(query2, [req.session.user.trainer_id, id]);

        console.log(theClass.rows[0])

        res.render('../public/editSession', {session : req.session, schedule : session.rows[0], theClass: theClass.rows[0]});

        
    } catch (err) {
        res.status(401).send("error");
    }

});


app.listen(port);
console.log(`Server is listening at http://localhost:${port}`);