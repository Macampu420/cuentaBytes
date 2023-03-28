let modalReg = new bootstrap.Modal(document.getElementById("modalCl"));
const divModal = document.getElementById("modalCl");
const urlBase = "http://localhost/cuentabytes/src/controllers/clientes/";

document.getElementById("btnAnadirVta").addEventListener("click", () => {

    divModal.setAttribute("editar", "false");
   if(divModal.getAttribute("editar") == "false"){
        document.getElementById("divAcciones").classList.add("d-none");
        document.getElementById("btnGuardar").disabled = false;
        document.getElementById("btnGuardar").innerHTML = "Guardar";
        document.getElementById('btnGuardar').setAttribute('formaction', (urlBase + 'clientes.php'));
        document.querySelector('form').reset();
   }

   modalReg.show();

});

document.getElementById("filaClientes").addEventListener("click", async event => {

    if (event.target.hasAttribute("btnAcciones")) {
        //Le damos valor al atributo
        divModal.setAttribute("editar", "true");

        if (divModal.getAttribute("editar") == "true") {
            document.getElementById("divAcciones").classList.remove("d-none");
            document.getElementById("btnGuardar").disabled = true;
            //Cambiamos el nombre del botón por Actualizar
            document.getElementById("btnGuardar").innerHTML = "Actualizar";
            document.getElementById('btnGuardar').setAttribute('formaction', (urlBase + `/editCliente.php?idCliente=${event.target.getAttribute('idCliente')}`));


            await fetch( urlBase + `listarUnCliente.php?idCliente=${event.target.getAttribute("idCliente")}`)
                .then(res => res.json())
                .then(data => {
                //modal editar get

                console.log(data);

                    document.getElementById("cedulacliente").value = data.items[0].cedulaCliente;
                    document.getElementById("nombresCliente").value = data.items[0].nombresCliente;
                    document.getElementById("apellidosCliente").value = data.items[0].apellidosCliente;
                    document.getElementById("telefonoCliente").value = data.items[0].telefonoCliente;

                    document.getElementById("btnEliminar").setAttribute("idCliente", data.items[0].idCliente);
                });

        }
        modalReg.show()
    }

})

document.getElementById("btnEliminar").addEventListener("click", async event => {

    let conf = confirm("¿Desea eliminar El Cliente?");

    if (conf == true) {
        await fetch(urlBase + `eliminarCliente.php?idCliente=${document.getElementById("btnEliminar").getAttribute("idCliente")}`)
        .then(res => res.text())
        .then(data => {
            alert(data);
            location.reload();
        });
    }

})

document.getElementById("buscadorClientes").addEventListener("change", () => {

    let clientes = document.querySelectorAll("[cartaItem]");
    let swNoCoinc = false;
    var alert = document.getElementById("alert");

    console.log(alert);

    clientes.forEach(element => {

        let nombreCliente = element.firstElementChild.innerHTML.toLowerCase();

        if (!nombreCliente.includes(document.getElementById("buscadorClientes").value.toLowerCase())) {
            element.classList.add("d-none");
            
        } else {
            
            swNoCoinc = true;
            element.classList.remove("d-none");
        }

    })

    console.log(clientes);

    if (swNoCoinc == false) {

        //hay coincidencias
        alert.classList.remove("d-none");
        
    } 
    else{
        alert.classList.add("d-none");
    
    }
})


document.getElementById('btnEditar').addEventListener('click', event => document.getElementById('btnGuardar').disabled = false);

let clientes = [];

// obtenerDatos(ventas);

renderClientes(clientes);