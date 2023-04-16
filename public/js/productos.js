
const traerProductos = async productos => {

    await fetch('http://localhost/cuentabytes/src/controllers/productos/apiProductos.php')
        .then(res => res.json())
        .then(data => {
            if (!data.mensaje) {
                data['items'].forEach(product => productos.push(product));
            } else {
                productos.length = 0;
            }

            console.log(data);

        });

}

renderProductos = async productos => {

    await traerProductos(Productos);

    if (Productos.length > 0) {
        Productos.forEach(element => {

            document.getElementById("filaProductos").insertAdjacentHTML('beforeend', `
            
            <div id="${element.idProducto}" idProducto="${element.idProducto}" cartaItem="true"
            class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
                <div idProducto="${element.idProducto}" class="card-body mt-2 mx-auto">
                    <h5 btnAcciones idProducto="${element.idProducto}" class="puntosAcciones">...</h5>
                    <h5>Nombre: ${element.nombreProducto}</h5>
                    <h5>Precio: ${element.precioVenta}</h5>
                    <h5>Stock:     ${element.stockProducto}</h5>

                    <img src="./../../public/img/productos/${element.nombreImagen}">

                    <h5>Imagen: ${element.nombreImagen}</h5>
                </div>
            </div>
    
            `)
        }

        );
    } else {
        document.getElementById("filaProductos").innerHTML = "<h2 class='text-center'>No hay productos registradas, registra alguno clickando el boton añadir.</h2/>"
    }

}