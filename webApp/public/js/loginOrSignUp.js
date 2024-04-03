
let loginButton = document.getElementById("loginButton");
loginButton.onclick = login;

function login(){
    location.href = 'http://localhost:3000/login';
}

let signUpButton = document.getElementById("signUpButton");
signUpButton.onclick = register;

function register(){
    location.href = 'http://localhost:3000/signup';
}
