let vProveedores, vProductos, numeroItem;

mostrarProveedores();
guardarProductos();

//inicializacion y despliegue del modal
document.getElementById('btnAnadirCompra').addEventListener('click', async event => {
    let divModal = document.getElementById("modalCompras");
    let modalCompras = new bootstrap.Modal(document.getElementById('modalCompras'));
    divModal.setAttribute("editar", "false")

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        divModal.getAttribute("editar") == "false" ? configModalReg() : console.log("editar");
        modalCompras.show();
        numeroItem = 0;
    }

});

document.getElementById('btnAnadir').addEventListener('click', event => {

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        renderItem(numeroItem, vProductos);
    }

});