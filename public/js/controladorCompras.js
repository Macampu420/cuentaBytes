let vProveedores, vProductos;

mostrarProveedores(vProveedores);

document.getElementById('btnAnadirCompra').addEventListener('click', async event => {

    let modalCompras = new bootstrap.Modal(document.getElementById('modalCompras'));

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        modalCompras.show();
    }

});