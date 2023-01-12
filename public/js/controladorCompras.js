let vProveedores, vProductos, numeroItem, vCompras;
let vItemsCompra = [];
let divModal = document.getElementById("modalCompras");
const conversorColombia = new Intl.NumberFormat('en-CO');

mostrarProveedores();
guardarProductos();
mostrarCompras();

//inicializacion y despliegue del modal
document.getElementById('btnAnadirCompra').addEventListener('click', async event => {
    let modalCompras = new bootstrap.Modal(document.getElementById('modalCompras'));
    divModal.setAttribute("editar", "false")

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        divModal.getAttribute("editar") == "false" ? configModalReg() : console.log("editar");
        modalCompras.show();
        numeroItem = 0;
    }

});

document.getElementById('btnAnadir').addEventListener('click', event => {

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        renderItem(numeroItem, vProductos);
        numeroItem++;
    }

});

document.getElementById("contItems").addEventListener("change", (event) => {

    let disparador = event.target;

    if(disparador.tagName == "SELECT"){

        console.log("productoSeleccionado");

        let stockActual;
        let slider = document.querySelector(".slider" + disparador.id);

        if(divModal.getAttribute('editar') == "false"){

            let item = vItemsCompra.find(
                //busca en los elementos de la compra actual uno que coincida con el item modificado retorna undefined si no encuentra nd
                item => item.idItem == disparador.parentElement.id
            );
    
            //busca el producto que coincida con el option seleccionado para definir el stockActual
            vProductos.forEach(element => {
                if (element.idProducto == disparador.value) {
                    stockActual = element.stockProducto;
                }
            });
    
            //valida que haya unidades disponibles para vender
            if (stockActual <= 0) {
                slider.nextElementSibling.innerHTML = ("No hay unidades disponibles");
            } else {
                habilitarSlider(slider, stockActual);
                actualizarCrearItem(item, event.target, vItemsVta);
            }
        }

    }

    if (disparador.tagName == "SELECT" && divModal.getAttribute('editar') == "true") {

        slider = document.querySelector("." + event.target.id);

        let item = vItemsEditar.find(
            //busca en los elementos de la venta actual uno que coincida con el item modificado
            //si no existe se define como undefined
            element => element.idVenta == disparador.parentElement.id
        );

        //busca el producto que coincida con el option seleccionado para definir el stockActual
        let producto = vObjsProductos.find(element => element.idProducto == parseInt(disparador.value));

        stockActual = producto.stockProducto;

        //valida que haya unidades disponibles para vender
        if (stockActual <= 0) {
            slider.nextElementSibling.innerHTML = ("No hay unidades disponibles");
        } else {
            habilitarSlider(slider, stockActual);
            actualizarCrearItem(item, event.target, vItemsEditar);
        }
    }

    if (disparador.tagName == "INPUT" && divModal.getAttribute('editar') == "false") {

        actualizarUnidVend(disparador, vItemsVta);

    }

    if (disparador.tagName == "INPUT" && divModal.getAttribute('editar') == "true") {

        actualizarUnidVend(disparador, vItemsEditar);

    }

});
