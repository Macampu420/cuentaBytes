let modalReg = new bootstrap.Modal(document.getElementById("modalReg"));
let swAlertImg = false;
let swAlertPrecioVenta = false;
const divModal = document.getElementById("modalReg");
const urlBase = "http://localhost/cuentabytes/src/controllers/productos/";

document.getElementById("inpImg").addEventListener("focus", event => {

    if(swAlertImg){
        window.alert("Te recomendamos que la foto sea en un fondo blanco y en formato jpg o png");
        swAlertImg = false;
    }
})

document.getElementById("inpPrecioVenta").addEventListener('focus', () => {
    if(swAlertPrecioVenta){
        window.alert("Ten en cuenta que este es el valor con IVA incluido");
        swAlertPrecioVenta = false;
    }
})

document.getElementById("btnAnadirProd").addEventListener("click", () => {

    swAlertImg = true;
    swAlertPrecioVenta = true;
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

    let resProducto = await fetch( urlBase + `listarUnProducto.php?idProducto=${event.target.getAttribute("idProducto")}`);
    let datosProducto = await resProducto.json(); 

    if (event.target.hasAttribute("btnAcciones")) {
        //Le damos valor al atributo
        divModal.setAttribute("editar", "true");

        if (divModal.getAttribute("editar") == "true") {
            document.getElementById("divAcciones").classList.remove("d-none");
            document.getElementById("btnGuardar").disabled = true;
            //Cambiamos el nombre del botón por Actualizar
            document.getElementById("btnGuardar").innerHTML = "Actualizar";
            document.getElementById('btnGuardar').setAttribute('formaction', urlBase + `editarProducto.php?idProducto=${event.target.getAttribute('idProducto')}`);

            document.getElementById("nombreProducto").value = datosProducto.items[0].nombreProducto;
            document.getElementById("nombreProducto").disabled = true;

            document.getElementById("descripcionProducto").value = datosProducto.items[0].descripcionProducto;
            document.getElementById("descripcionProducto").disabled = true;

            document.getElementById("costoProducto").value = datosProducto.items[0].costoProducto;
            document.getElementById("costoProducto").disabled = true;

            document.getElementById("inpPrecioVenta").value = datosProducto.items[0].precioVenta;
            document.getElementById("inpPrecioVenta").disabled = true;

            document.getElementById("inpExistenciaProducto").value = datosProducto.items[0].stockProducto;
            document.getElementById("inpExistenciaProducto").disabled = true;

            document.getElementById("inpImg").disabled = true;

            document.getElementById("btnEliminar").setAttribute("idProducto", datosProducto.items[0].idProducto);
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

document.getElementById('btnEditar').addEventListener('click', event => {
    
    document.getElementById('btnGuardar').disabled = false;
    document.getElementById("nombreProducto").disabled = false;
    document.getElementById("descripcionProducto").disabled = false;
    document.getElementById("costoProducto").disabled = false;
    document.getElementById("inpPrecioVenta").disabled = false;
    document.getElementById("inpExistenciaProducto").disabled = false;
    document.getElementById("inpImg").disabled = false;

});

let Productos = [];

renderProductos(Productos);