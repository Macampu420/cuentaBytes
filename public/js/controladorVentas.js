const modalBootstrap = new bootstrap.Modal(document.getElementById('modalVtas'));
const divModal = document.getElementById('modalVtas');

traerClientes();
traerProductos();
renderVentas();

document.getElementById('btnAnadirVta').addEventListener('click', event => {

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {

        divModal.setAttribute('editar', false);

        configModal(divModal, event);

        renderItem();
        modalBootstrap.show();
    }

});

document.getElementById('btnAnadir').addEventListener('click', event => {

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        renderItem();
    }

});

document.getElementById("tblItemsVta").addEventListener("change", (event) => {

    let disparador = event.target;

    if (disparador.tagName == "SELECT") {

        let item = vItemsVta.find(
            //busca en los elementos de la venta actual uno que coincida con el item modificado
            //si no existe se define como undefined
            element => element.idItem ==  parseInt(disparador.id.slice(-1)));

        //busca el producto que coincida con el option seleccionado para definir el stockActual
        vObjsProductos.forEach((element) => {
            if (element.idProducto == disparador.value) {
                stockActual = element.stockProducto;
            }
        });

        //valida que haya unidades disponibles para vender
        if (stockActual <= 0) {
            disparador.nextElementSibling.innerHTML = ("No hay unidades disponibles");
        } else {
            actualizarCrearItem(item, event.target, vItemsVta);
        }

        disparador.nextElementSibling.classList.remove("d-none");
    }   

    if (disparador.tagName == "INPUT" && divModal.getAttribute('editar') == "false") {

        actualizarUnidVend(disparador, vItemsVta);

    }

    if (disparador.tagName == "INPUT" && divModal.getAttribute('editar') == "true") {

        actualizarUnidVend(disparador, vItemsEditar);

    }

});

document.getElementById("contItems").addEventListener("input", (event) => {

    disparador = event.target;

    if (disparador.nodeName == "INPUT") {

        divModal.getAttribute("editar") == "true" ? renderNuevoStock(disparador, vItemsEditar) : renderNuevoStock(disparador, vItemsVta);


    }
});

document.getElementById("inpDto").addEventListener("input", () => {

    if (divModal.getAttribute("editar") == "false") {
        vrTotalRegistar(vItemsVta);
    } else {
        vrTotalEditar(vItemsEditar);
    }

});

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

document.getElementById("contItems").addEventListener("click", (event) => {

    if (event.target.id.includes("dlt")) {
        divModal.getAttribute("editar") == "true" ? eliminarItem(event.target, vItemsEditar) : eliminarItem(event.target, vItemsVta);
    }
});

document.getElementById("filaVentas").addEventListener("click", async event => {

    if (event.target.hasAttribute("btnAcciones")) {

        divModal.setAttribute('editar', true);

        configModal(divModal, event);

        modalBootstrap.show();

    }
})

document.getElementById("btnEditar").addEventListener("click", () => document.getElementById('btnGuardar').disabled = false)

document.getElementById("btnEliminar").addEventListener("click", async () => {

    idVenta = document.getElementById("btnEliminar").getAttribute("idventa");

    if (confirm("¿Deseas eliminar la venta?") == true) {

        await fetch(`http://localhost:3000/eliminarVta${idVenta}`)
            .then(res => res.text())
            .then(data => console.log(data));

        location.reload();

    }
})

document.getElementById("buscadorVtas").addEventListener("change", () => {

    let ventas = document.querySelectorAll("[cartaItem]");
    let swNoCoinc = false;
    var alert = document.getElementById("alert");

    console.log(alert);

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