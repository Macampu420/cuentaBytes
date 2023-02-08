let numeroItem;
let divModal = document.getElementById("modalCompras");
let modalCompras = new bootstrap.Modal(divModal);

mostrarProveedores();
guardarProductos();
mostrarCompras();

//inicializacion y despliegue del modal
document.getElementById('btnAnadirCompra').addEventListener('click', async event => {
    divModal.setAttribute("editar", "false")

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        configModalReg();
        modalCompras.show();
        numeroItem = (divModal.getAttribute('editar') == 'false' ? 0 : null);
    }

});

document.getElementById('btnAnadir').addEventListener('click', event => {

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {

        divModal.getAttribute('editar') == 'false' ? renderItemReg(numeroItem, vProductos) : renderItemEdit(vProductos);
        numeroItem++;
    }

});

document.getElementById("contItems").addEventListener("change", event => {

    let vector = divModal.getAttribute('editar') == 'false' ? vItemsCompra : vItemsEditar;
    let disparador = event.target;
    let numeroItem = disparador.parentElement.id.slice(disparador.parentElement.id.length - 1);
    let item = vector.find(item => item.idItem == ('item' + numeroItem));

    if (disparador.tagName == "SELECT") {
        habilitarInputsItem(disparador);
        if (divModal.getAttribute('editar') == 'false') {
            item == undefined ? crearItemReg(vector, disparador, numeroItem) : actualizarItem(vector, item, disparador, numeroItem);
        } else {
            item == undefined ? crearItemEdit(vector) : actualizarItem(vector, item, disparador, numeroItem);
        }
    }
});

document.getElementById('rowItems').addEventListener('input', event => {
    if (event.target.tagName == "INPUT") {
        let vector = divModal.getAttribute('editar') == 'false' ? vItemsCompra : vItemsEditar;
        let disparador = event.target;
        let numeroItem = disparador.id.slice(disparador.id.length - 1);
        let item = vector.find(item => item.idItem == ('item' + numeroItem));

        if (disparador.id.includes('inpunidCompslc')) {
            actualizarUnidCompradas(vector, item, numeroItem);
            // mostrarNuevoStock(disparador);
        } else if (disparador.id.includes('inpPrecioUnitslc')) {
            actualizarCostoProducto(vector, item, numeroItem);
        }
    }
})

document.getElementById('rowItems').addEventListener('click', event => {
    if (event.target.id.includes('dlt')) {
        let vector = divModal.getAttribute('editar') == 'false' ? vItemsCompra : vItemsEditar;
        let disparador = event.target;
        let numeroItem = disparador.id.slice(disparador.id.length - 1);
        let item = vector.find(item => item.idItem == ('item' + numeroItem));

        disparador.parentElement.parentElement.remove();
        eliminarProducto(vector, item);
    }
});

document.querySelector("form").addEventListener("submit", (event) => {

    //evita que la pagina se recargue
    event.preventDefault();

    divModal.getAttribute("editar") == "false" ? enviarRegCompra() : enviarEditCompra();
});

document.getElementById('filaCompras').addEventListener('click', event => {
    if (event.target.classList.contains("puntosAcciones")) {
        divModal.setAttribute("editar", "true");
        divModal.getAttribute("editar") == "false" ? configModalReg() : configModalEdit(event, vProductos);
        modalCompras.show();
        numeroItem = 0;
    }
})

document.getElementById('btnEliminar').addEventListener("click", async () => {
    let idCompra = document.getElementById('btnEliminar').getAttribute('idcompra');

    if (confirm("¿Deseas eliminar la compra?") == true) {

        await fetch(`http://localhost:3000/eliminarCompra${idCompra}`)
            .then(res => res.text())
            .then(data => alert(data));


    }
})

document.getElementById('btnEditar').addEventListener('click', event => document.getElementById('btnGuardar').disabled = false)