let btnAgregarNota = document.getElementById('btnAgregarNota');
let modalAgregarNota = new bootstrap.Modal(document.getElementById('modalAgregarNota'));

let btnDesplegarNotas = document.getElementById('btnDesplegarNotas');
var offcanvasNotas = new bootstrap.Offcanvas(document.getElementById('offcanvasNotas'));

btnAgregarNota.onclick = () => {
    modalAgregarNota.show();
}

btnDesplegarNotas.onclick = () => {
    offcanvasNotas.show();
}

document.getElementById("formNotas").addEventListener("submit", (event) => {

    //evita que la pagina se recargue
    event.preventDefault();

    registrarNota();

    console.log("HOLAAAAAAAAAAA");

});