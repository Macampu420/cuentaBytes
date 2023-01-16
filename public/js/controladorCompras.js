let numeroItem;
let divModal = document.getElementById("modalCompras");

mostrarProveedores();
guardarProductos();
mostrarCompras();

//inicializacion y despliegue del modal
document.getElementById('btnAnadirCompra').addEventListener('click', async event => {
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
        numeroItem++;
    }

});

document.getElementById("contItems").addEventListener("change", event => {

    let disparador = event.target;
    let numeroItem = disparador.parentElement.id.slice(disparador.parentElement.id.length - 1);

    if(disparador.tagName == "SELECT"){
        let item = vItemsCompra.find(item => item.idItem == ('item' + numeroItem));

        if(divModal.getAttribute('editar') == "false") habilitarInputsItem(disparador), item == undefined ? crearItem(disparador, numeroItem) : actualizarItem();
    }     

});

document.getElementById('rowItems').addEventListener('input', event => {
    if (event.target.id.includes('inpunidCompslc')) mostrarNuevoStock(event.target)
})

document.getElementById('rowItems').addEventListener('click', event => {
   if (event.target.id.includes('dlt')) event.target.parentElement.parentElement.remove(); 
});