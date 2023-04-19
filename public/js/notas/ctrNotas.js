let btnAgregarNota = document.getElementById('btnAgregarNota');
let divModalNotas = document.getElementById('modalAgregarNota');
let modalAgregarNota = new bootstrap.Modal(divModalNotas);

let btnDesplegarNotas = document.getElementById('btnDesplegarNotas');
var offcanvasNotas = new bootstrap.Offcanvas(document.getElementById('offcanvasNotas'));

btnAgregarNota.onclick = () => {
    divModalNotas.setAttribute('editar', false);
    desplegarModalNotas(divModalNotas);
}

btnDesplegarNotas.onclick = () => {
    offcanvasNotas.show();
}

window.onload = () => {
    renderizarNotas();
}

document.getElementById("formNotas").addEventListener("submit", (event) => {

    //evita que la pagina se recargue
    idNota = document.getElementById("btnEliminarNotas").getAttribute("idNota");

    event.preventDefault();
    divModalNotas.getAttribute("editar") == "false" ? registrarNota() : console.log("me tengo que actualizar");
    divModalNotas.getAttribute("editar") == "true" ? actualizarNota(idNota) : console.log("me tengo que actualizar");


});

document.getElementById("filaNotas").addEventListener("click", async event => {

    if (event.target.hasAttribute("btnAcciones")) {

        divModalNotas.setAttribute('editar', true);

        desplegarModalNotas(divModalNotas, event);

    }
})

document.getElementById("btnEditarNotas").addEventListener("click", () => document.getElementById('btnGuardarNotas').disabled = false)

document.getElementById("btnEliminarNotas").addEventListener("click", async () => {

    idNota = document.getElementById("btnEliminarNotas").getAttribute("idNota");

    if (confirm("¿Deseas eliminar la nota") == true) {

        await fetch(`http://localhost:3000/eliminarNota${idNota}`)
            .then(res => res.text())
            .then(data => console.log(data));

        location.reload();

    }
})
