const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => { // request to the URL '/'
    res.send('Test') // Sends the HTTP response
});

app.listen(port);
console.log(`Server is listening at http://localhost:${port}`);