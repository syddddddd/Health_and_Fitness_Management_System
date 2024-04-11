
let addBtn = document.getElementById("addBtn");
addBtn.onclick = addSession;

function addSession(){
    console.log("ADD SESSION")
    location.href = 'http://localhost:3000/member/addSession';
}



