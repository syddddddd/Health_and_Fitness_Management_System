
let addBtn = document.getElementById("addBtn");
addBtn.onclick = addSession;

let groupBtn = document.getElementById("groupBtn");
groupBtn.onclick = joinGroup;

function addSession(){
    console.log("ADD SESSION")
    location.href = 'http://localhost:3000/addSession';
}

function joinGroup(){
    console.log("ADD SESSION")
    location.href = 'http://localhost:3000/member/addSession';
}



