let modalProvee = new bootstrap.Modal(document.getElementById("modalProvee"));
const divModal = document.getElementById("modalProvee");
const urlBase = "http://localhost/cuentabytes/src/controllers/proveedores/";

document.getElementById("btnAñadirProvee").addEventListener("click", () => {

    divModal.setAttribute("editar", "false");
   if(divModal.getAttribute("editar") == "false"){
        document.getElementById("divAcciones").classList.add("d-none");
        document.getElementById("btnGuardar").disabled = false;
        document.getElementById("btnGuardar").innerHTML = "Guardar";
        document.getElementById('btnGuardar').setAttribute('formaction', (urlBase + 'regProveedor.php'));
        document.querySelector('form').reset();
   }

   modalProvee.show();

});

document.getElementById("filaProveedores").addEventListener("click", async event => {

    if (event.target.hasAttribute("btnAcciones")) {
        //Le damos valor al atributo
        divModal.setAttribute("editar", "true");

        if (divModal.getAttribute("editar") == "true") {
            document.getElementById("divAcciones").classList.remove("d-none");
            document.getElementById("btnGuardar").disabled = true;
            //Cambiamos el nombre del botón por Actualizar
            document.getElementById("btnGuardar").innerHTML = "Actualizar";
            document.getElementById('btnGuardar').setAttribute('formaction', urlBase + `editProveedor.php?idProveedor=${event.target.getAttribute('idproveedor')}`);


            await fetch( urlBase + `listarUnProveedor.php?idProveedor=${event.target.getAttribute("idproveedor")}`)
                .then(res => res.json())
                .then(data => {

                    document.getElementById("inpNombreProvee").value = data.items[0].nombreProveedor;
                    document.getElementById("inpDireccion").value = data.items[0].direccionProveedor;
                    document.getElementById("inpTelefono").value = data.items[0].telefonoProveedor;

                    document.getElementById("btnEliminar").setAttribute("idproveedor", data.items[0].idProveedor);
                });

        }
        modalProvee.show()
    }

})

document.getElementById("btnEliminar").addEventListener("click", async event => {

    let conf = confirm("¿Desea eliminar el proveedor?");

    if (conf == true) {
        await fetch(urlBase + `eliminarProveedor.php?idProveedor=${document.getElementById("btnEliminar").getAttribute("idproveedor")}`)
        .then(res => res.text())
        .then(data => {
            alert(data);
            location.reload();
        });
    }

})

document.getElementById('btnEditar').addEventListener('click', event => document.getElementById('btnGuardar').disabled = false);

let proveedores = [];

// obtenerDatos(proveedores);

renderProveedores(proveedores);