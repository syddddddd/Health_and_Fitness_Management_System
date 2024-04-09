
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


function discardEdits(user){
    console.log("DISCARDING")
    console.log(user)
    if (user == 'trainer') {
        location.href = 'http://localhost:3000/trainer';
    } else {
        location.href = 'http://localhost:3000/scheduleManagement';
    }
    
}
