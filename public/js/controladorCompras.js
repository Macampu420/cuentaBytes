let divModal = document.getElementById("modalCompras");
let modalCompras = new bootstrap.Modal(divModal);

traerCompras();
traerProductos();
traerProveedores();
mostrarProveedores();
// guardarProductos();
mostrarCompras();

//inicializacion y despliegue del modal
document.getElementById('btnAnadirCompra').addEventListener('click', async event => {
    divModal.setAttribute("editar", "false")

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        reiniciarModal();
        divModal.classList.add("d-flex");
        modalCompras.show();
        numeroItem = (divModal.getAttribute('editar') == 'false' ? 0 : null);
        
    }

});

divModal.addEventListener('hidden.bs.modal', () => {
    divModal.classList.remove("d-flex");
});

document.getElementById("tblItemsVta").addEventListener("change", (event) => {

    let disparador = event.target;

    if (disparador.tagName == "SELECT") {

        let item = vItemsCompra.find(
            //busca en los elementos de la venta actual uno que coincida con el item modificado
            //si no existe se define como undefined
            element => element.idItem ==  parseInt(disparador.id.slice(-1)));

        actualizarCrearItem(item, event.target, vItemsCompra);
        console.log("A");
        
        disparador.nextElementSibling.classList.remove("d-none");
    }   

});

document.getElementById('btnAnadir').addEventListener('click', event => {
        divModal.getAttribute('editar') == 'false' ? renderItemReg(numeroItem, vProductos) : renderItemEdit(vProductos);
});

document.getElementById("tblItemsVta").addEventListener("click", (event) => {

    if(event.target.id == "" && event.target.nodeName == "A"){
        eliminarItem(event.target.parentElement, vItemsCompra);
    }
    if(event.target.id.includes("btnEliminarItem")){
        eliminarItem(event.target, vItemsCompra);
    };

});

document.getElementById("tblItemsVta").addEventListener("input", (event) => {
    //codigo a ejecutar si el diparador es un inpCantidad producto
    if (event.target.id.includes("inpCantidad")) {
        //si el valor digitado es mayor que las unidades disponibles setea el valor del
        //input como este numero de unidades
        if (event.target.value > parseInt(event.target.getAttribute("max")))
            event.target.value = parseInt(event.target.getAttribute("max"));

        //si el valor digitado es menor a  setea el valor del
        //input como 0
        if (event.target.value < 0) event.target.value = 0;

        actualizarUnidadesCompradas(event.target, vItemsCompra);
    }
    else if(event.target.id.includes("pCostoUnitario")){
        actualizarPropiedadItem(event.target, vItemsCompra, "costoProducto");
        subtotal(event.target, vItemsCompra);
    }
    else if(event.target.id.includes("pPrecioCompra")){
        actualizarPropiedadItem(event.target, vItemsCompra, "precioCompra");
    }

    vrTotal(vItemsCompra);

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
        divModal.classList.add("d-flex");
        modalCompras.show();
        numeroItem = 0;
    }
})

document.getElementById("buscadorCompras").addEventListener("change", () => {

    let compras = document.querySelectorAll("[cartaItem]");
    let swNoCoinc = false;
    var alert = document.getElementById("alert");

    console.log(alert);

    compras.forEach(element => {

        let conceptoCompra = element.firstElementChild.innerHTML.toLowerCase();

        if (!conceptoCompra.includes(document.getElementById("buscadorCompras").value.toLowerCase())) {
            element.classList.add("d-none");
            
        } else {
            
            swNoCoinc = true;
            element.classList.remove("d-none");
        }

    })

    console.log(compras);

    if (swNoCoinc == false) {
        //hay coincidencias
        alert.classList.remove("d-none");     
    } 
    else{
        alert.classList.add("d-none");
    
    }
})