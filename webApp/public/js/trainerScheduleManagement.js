
let addBtn = document.getElementById("addSession");
addBtn.onclick = addSession;

function addSession(){
    location.href = 'http://localhost:3000/addSession';
}

let signUpButton = document.getElementById("signUpButton");
signUpButton.onclick = register;

function register(){
    location.href = 'http://localhost:3000/signup';
}
