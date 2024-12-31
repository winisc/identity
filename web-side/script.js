window.addEventListener("message", ({ data }) => {
    if (data.action === "open") {
        document.querySelector(".card").style.animation = 'fadeContent ease .5s';
        document.querySelector(".card").style.display = 'flex';
        document.querySelector(".background").style.display = 'flex';
    }
    if (data.action === "close") {
        document.querySelector(".card").style.display = 'none';
        document.querySelector(".background").style.display = 'none';
    }

    const elementName = document.getElementById('name');
    let name1 = data.name1;
    let name2 = data.name2;
    if (elementName) {  // Verifica se o elemento foi encontrado
         elementName.textContent = `${name1} ${name2}`;
    }

    const elementIdade = document.getElementById('idade');
    let idade = data.idade;
    if (elementIdade) {  // Verifica se o elemento foi encontrado
        elementIdade.textContent = `${idade} anos`;
    }

    const elementUser = document.getElementById('user');
    let user = data.user;
    if (elementUser) {  // Verifica se o elemento foi encontrado
        elementUser.textContent = `# ${user}`;
    }

    const elementPhone = document.getElementById('celular');
    let phone = data.phone;
    if (elementPhone) {  // Verifica se o elemento foi encontrado
        elementPhone.textContent = `${phone}`;
    }

    const elementRegistro = document.getElementById('registro');
    let registro = data.registro;
    if (elementRegistro) {  // Verifica se o elemento foi encontrado
        elementRegistro.textContent = `${registro}`;
    }

    const elementAvatar= document.getElementById('avatar');
    let avatar = data.picture;
    if (elementAvatar) {  // Verifica se o elemento foi encontrado
        elementAvatar.src = avatar;
    }

});

function closeIdentity(){
    document.querySelector(".card").style.animation = 'fadeContentOut ease .5s';
    setTimeout(() => {
        fetch('https://trinity_identity/close', { method: 'POST' });
    }, "300");

}

document.addEventListener('keydown', function(event) {
    if (event.key === "Escape") { 
        closeIdentity();  
    }
});