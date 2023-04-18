let modalReg = new bootstrap.Modal(document.getElementById("modalReg"));
const divModal = document.getElementById("modalReg");
const urlBase = "http://localhost/cuentabytes/src/controllers/productos/";

document.getElementById("btnAnadirProd").addEventListener("click", () => {

    divModal.setAttribute("editar", "false");
   if(divModal.getAttribute("editar") == "false"){
        document.getElementById("divAcciones").classList.add("d-none");
        document.getElementById("btnGuardar").disabled = false;
        document.getElementById("btnGuardar").innerHTML = "Guardar";
        document.getElementById('btnGuardar').setAttribute('formaction', (urlBase + 'regProducto.php'));
        document.querySelector('form').reset();
   }

   modalReg.show();

});

document.getElementById("filaProductos").addEventListener("click", async event => {

    if (event.target.hasAttribute("btnAcciones")) {
        //Le damos valor al atributo
        divModal.setAttribute("editar", "true");

        if (divModal.getAttribute("editar") == "true") {
            document.getElementById("divAcciones").classList.remove("d-none");
            document.getElementById("btnGuardar").disabled = true;
            //Cambiamos el nombre del botón por Actualizar
            document.getElementById("btnGuardar").innerHTML = "Actualizar";
            document.getElementById('btnGuardar').setAttribute('formaction', urlBase + `editarProducto.php?idProducto=${event.target.getAttribute('idProducto')}`);


            await fetch( urlBase + `listarUnProducto.php?idProducto=${event.target.getAttribute("idProducto")}`)
                .then(res => res.json())
                .then(data => {

                    document.getElementById("nombreProducto").value = data.items[0].nombreProducto;
                    document.getElementById("descripcionProducto").value = data.items[0].descripcionProducto;
                    document.getElementById("porcentajeIva").value = data.items[0].porcentajeIva;
                    document.getElementById("costoProducto").value = data.items[0].costoProducto;
                    document.getElementById("precioVenta").value = data.items[0].precioVenta;
                    document.getElementById("stockProducto").value = data.items[0].stockProducto;

                    document.getElementById("btnEliminar").setAttribute("idProducto", data.items[0].idProducto);
                });

        }
        modalReg.show()
    }

})

document.getElementById("btnEliminar").addEventListener("click", async event => {

    let conf = confirm("¿Desea eliminar el producto?");

    if (conf == true) {
        await fetch(urlBase + `eliminarProducto.php?idProducto=${document.getElementById("btnEliminar").getAttribute("idProducto")}`)
        .then(res => res.text())
        .then(data => {
            alert(data);
            location.reload();
        });
    }

})

document.getElementById("buscadorProd").addEventListener("change", () => {

    let productos = document.querySelectorAll("[cartaItem]");
    let swNoCoinc = false;
    var alert = document.getElementById("alert");

    console.log(alert);

    productos.forEach(element => {

        let nombreProducto = element.firstElementChild.innerHTML.toLowerCase();

        if (!nombreProducto.includes(document.getElementById("buscadorProd").value.toLowerCase())) {
            element.classList.add("d-none");
            
        } else {
            
            swNoCoinc = true;
            element.classList.remove("d-none");
        }

    })

    console.log(productos);

    if (swNoCoinc == false) {

        //hay coincidencias
        alert.classList.remove("d-none");
        
    } 
    else{
        alert.classList.add("d-none");
    
    }
})

document.getElementById('btnEditar').addEventListener('click', event => document.getElementById('btnGuardar').disabled = false);

let Productos = [];

// obtenerDatos(Productos);

renderProductos(Productos);