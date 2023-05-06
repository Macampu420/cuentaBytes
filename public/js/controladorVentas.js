const modalBootstrap = new bootstrap.Modal(document.getElementById('modalVtas'));
const divModal = document.getElementById('modalVtas');

traerClientes();
traerProductos();
renderVentas();
traerMetodosPago();
traerAjustesVta();

document.getElementById('btnAnadirVta').addEventListener('click', event => {

    divModal.classList.add("d-flex");
    iniciarModalRegistrar(divModal, event);
    renderItem();
    modalBootstrap.show();
    

});

divModal.addEventListener('hidden.bs.modal', (event) => {
    divModal.classList.remove("d-flex");
});

document.getElementById('btnAnadir').addEventListener('click', event => {
    renderItem();
});

document.getElementById("tblItemsVta").addEventListener("change", (event) => {

    let disparador = event.target;

    if (disparador.tagName == "SELECT") {

        let item = vItemsVta.find(
            //busca en los elementos de la venta actual uno que coincida con el item modificado
            //si no existe se define como undefined
            element => element.idItem ==  parseInt(disparador.id.slice(-1)));

        actualizarCrearItem(item, event.target, vItemsVta);
        
        disparador.nextElementSibling.classList.remove("d-none");
    }   

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

        actualizarUnidadesVendidas(event.target, vItemsVta);
    }

    vrTotalRegistar(vItemsVta);

});

document.getElementById("inpDescuento").addEventListener("input", (event) => {
    //si el valor digitado es menor a  setea el valor del
    //input como 0
    if(event.target.value < 0) event.target.value = 0;
})

document.getElementById("tblItemsVta").addEventListener("click", (event) => {

    if(event.target.id == "" && event.target.nodeName == "A"){
        eliminarItem(event.target.parentElement, vItemsVta);
    }
    if(event.target.id.includes("btnEliminarItem")){
        eliminarItem(event.target, vItemsVta);
    };

});

document.getElementById("inpDescuento").addEventListener("input", (event) => vrTotalRegistar(vItemsVta));

document.querySelector("form").addEventListener("submit", (event) => {

    //evita que la pagina se recargue
    event.preventDefault();

    if (vItemsVta.length != 0) {
        registrarVenta(); 
        generarPdf();
    } else {
        window.alert("Debes seleccionar algún producto para registrar la venta");
    }

});

document.getElementById("buscadorVtas").addEventListener("change", () => {

    let ventas = document.querySelectorAll("[cartaItem]");
    let swNoCoinc = false;
    var alert = document.getElementById("alert");

    ventas.forEach(element => {

        let tituloVta = element.firstElementChild.innerHTML.toLowerCase();

        if (!tituloVta.includes(document.getElementById("buscadorVtas").value.toLowerCase())) {
            element.classList.add("d-none");
            
        } else {
            
            swNoCoinc = true;
            element.classList.remove("d-none");
        }

    })

    console.log(ventas);

    if (swNoCoinc == false) {

        alert.classList.remove("d-none");
        
    } 
    else{
        alert.classList.add("d-none");
    
    }
})

document.getElementById("filaVentas").addEventListener("click", (event) => {
    if(event.target.hasAttribute("btnacciones")){
        iniciarModalDetallesVenta(event.target);
        divModal.classList.add("d-flex");
        modalBootstrap.show();
    }
})

document.getElementById("btnFactura").addEventListener("click", (event) => {

    event.preventDefault();

    if (confirm("¿Deseas generar la factura de esta venta? Al hacerlo no la podrás volver a editar") == true) {

        generarPdf();   
    }
});