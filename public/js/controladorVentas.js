const modalBootstrap = new bootstrap.Modal(document.getElementById('modalVtas'));
const divModal = document.getElementById('modalVtas');

traerClientes();
traerProductos();
renderVentas();
traerMetodosPago();

document.getElementById('btnAnadirVta').addEventListener('click', event => {

    divModal.classList.add("d-flex");
    iniciarModalRegistrar(divModal, event);
    renderItem();
    modalBootstrap.show();
    

});

divModal.addEventListener('hdden.bs.modal', (event) => {
    divModal.classList.remove("d-flex");
    console.log("modal cerrado");
});

document.getElementById('btnAnadir').addEventListener('click', event => {
    console.log(event.target);
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
    if(event.target.id.includes("inpCantidad")){
        actualizarUnidadesVendidas(event.target, vItemsVta);
    }

    vrTotalRegistar(vItemsVta);

});

document.getElementById("tblItemsVta").addEventListener("click", (event) => {

    console.log(event.target.id);

    // if(event.target.)

    if(event.target.id.includes("btnEliminarItem")){
        console.log("eliminame");        
        eliminarItem(event.target, vItemsVta);
    };

});

document.getElementById("inpDescuento").addEventListener("input", (event) => vrTotalRegistar(vItemsVta));

document.querySelector("form").addEventListener("submit", (event) => {

    //evita que la pagina se recargue
    event.preventDefault();

    if(divModal.getAttribute("editar") == "false")
        registrarVenta()
   else{
    let confirmacion = confirm("Solo podrás editar la venta una unica vez");
    if(confirmacion) actualizarVenta(event);
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

document.getElementById("btnFactura").addEventListener("click", (event) => {

    event.preventDefault();

    if (confirm("¿Deseas generar la factura de esta venta? Al hacerlo no la podrás volver a editar") == true) {

        generarPdf();   
    }
});