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
        divModal.getAttribute("editar") == "false" ? configModalReg() : console.log("editar");
        modalCompras.show();
        numeroItem = 0;
    }

});

document.getElementById('btnAnadir').addEventListener('click', event => {

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        renderItem(numeroItem, vProductos);
        numeroItem++;
    }

});

document.getElementById("contItems").addEventListener("change", event => {

    let disparador = event.target;
    let numeroItem = disparador.parentElement.id.slice(disparador.parentElement.id.length - 1);
    let item = vItemsCompra.find(item => item.idItem == ('item' + numeroItem));

    if (disparador.tagName == "SELECT") {
        if (divModal.getAttribute('editar') == "false") habilitarInputsItem(disparador), item == undefined ? crearItem(disparador, numeroItem) : actualizarItem(item, disparador, numeroItem);
    } else if (disparador.tagName == "SELECT" && divModal.getAttribute('editar') == "true") {

        slider = document.querySelector("." + event.target.id);

        let item = vItemsEditar.find(
            //busca en los elementos de la venta actual uno que coincida con el item modificado
            //si no existe se define como undefined
            element => element.idVenta == disparador.parentElement.id
  
        )
    }
});

document.getElementById('rowItems').addEventListener('input', event => {
    let disparador = event.target;
    let numeroItem = disparador.id.slice(disparador.id.length - 1);
    let item = vItemsCompra.find(item => item.idItem == ('item' + numeroItem));

    if (disparador.id.includes('inpunidCompslc')) {
        mostrarNuevoStock(disparador);
        actualizarUnidCompradas(item, numeroItem);
    } else if (disparador.id.includes('inpPrecioUnitslc')) {
        mostrarNuevoStock(disparador);
        actualizarCostoProducto(item, numeroItem);
    }
})

document.getElementById('rowItems').addEventListener('click', event => {
    if (event.target.id.includes('dlt')) {
        let disparador = event.target;
        let numeroItem = disparador.id.slice(disparador.id.length - 1);
        let item = vItemsCompra.find(item => item.idItem == ('item' + numeroItem));

        disparador.parentElement.parentElement.remove();
        eliminarProducto(item);
    }
});

document.querySelector("form").addEventListener("submit", (event) => {

    //evita que la pagina se recargue
    event.preventDefault();

    divModal.getAttribute("editar") == "false" ? enviarCompra() : actualizarVenta(event);
});

document.getElementById('filaCompras').addEventListener('click', event => {
    if(event.target.classList.contains("puntosAcciones")){
        divModal.setAttribute("editar", "true");
        divModal.getAttribute("editar") == "false" ? configModalReg() : configModalEdit(event);
        modalCompras.show();
        numeroItem = 0;
    }
})

document.getElementById('btnEliminar').addEventListener("click", async event => {
    let idCompra = document.getElementById('btnEliminar').getAttribute('idcompra');

    if (confirm("¿Deseas eliminar la compra?") == true) {

        await fetch(`http://localhost:3000/eliminarCompra${idCompra}`)
            .then(res => res.text())
            .then(data => alert(data));


    }
})