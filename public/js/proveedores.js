traerProveedores = async proveedores => {
  await fetch('http://localhost/cuentabytes/src/controllers/proveedores/apiProveedor.php')
    .then(res => res.json())
    .then(data => {
      if (!data.mensaje) {
        data.items.forEach(provee => proveedores.push(provee))
      } else {
        proveedores.length = 0
      }
    })
}

renderProveedores = async proveedores => {
  await traerProveedores(proveedores)

  if (proveedores.length > 0) {
    proveedores.forEach(element => {
      document.getElementById('filaProvee').insertAdjacentHTML('beforeend', `
            
            <div id="${element.idProveedor}" idproveedor="${element.idProveedor}" cartaItem="true"
            class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
            <div idproveedor="${element.idProveedor}" class="card-body mt-2 mx-auto">
                <h5 btnAcciones idproveedor="${element.idProveedor}" class="puntosAcciones m-1">...</h5>
                <h5>Nombre: ${element.nombreProveedor}</h5>
                <h5>Direccion: ${element.direccionProveedor}</h5>
                <h5>Teléfono:     ${element.telefonoProveedor}</h5>
            </div>
            </div>
    
            `)
    }

    )
  } else {
    document.getElementById('filaProvee').innerHTML = "<h2 class='text-center'>No hay proveedores registrados puedes registrarlos clickando el boton de 'Añadir'.</h2/>"
  }
}
