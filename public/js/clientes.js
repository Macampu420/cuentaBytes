
const traerClientes = async clientes => {
    
    await fetch('http://localhost/cuentabytes/src/controllers/clientes/apiClientes.php')

    .then(res => res.json())
    .then(data => {
        if(!data.mensaje){
            data['items'].forEach(vta => clientes.push(vta));
        } else {
            clientes.length = 0;
        }
    });
}

renderClientes = async clientes => {

    await traerClientes(clientes);

    if (clientes.length > 0) {
        clientes.forEach(element => {

            document.getElementById("filaClientes").insertAdjacentHTML('beforeend', `
        
        <div id="${element.idCliente}" idCliente="${element.idCliente}" cartaItem="true"
        class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
        <div idCliente="${element.idCliente}" class="card-body mt-2 mx-auto">
            <h5 btnAcciones idCliente="${element.idCliente}" class="puntosAcciones">...</h5>
            <h5>Cedula: ${element.cedulaCliente}</h5>
            <h5>Nombres: ${element.nombresCliente}</h5>
            <h5>Apellido: ${element.apellidosCliente}</h5>
            <h5>Telefono: ${element.telefonoCliente}</h5>
        </div>
        </div>
        `)
        }

        );
    } else {
        document.getElementById("filaClientes").innerHTML = "<h2 class='text-center'>No hay clientes registrados, puedes registrar uno presionando el boton de arriba</h2/>"
    }

}