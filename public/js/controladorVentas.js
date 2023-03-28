const modalBootstrap = new bootstrap.Modal(document.getElementById('modalVtas'));
const divModal = document.getElementById('modalVtas');

traerClientes();
traerProductos();
renderVentas();

document.getElementById('btnAnadirVta').addEventListener('click', event => {

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {

        divModal.setAttribute('editar', false);

        configModal(divModal, event);

        modalBootstrap.show();
    }

});

document.getElementById('btnAnadir').addEventListener('click', event => {

    if (event.target.tagName == "H3" || event.target.tagName == "IMG") {
        renderItem();
    }

});

document.getElementById("contItems").addEventListener("change", (event) => {

    var disparador = event.target;

    if (disparador.tagName == "SELECT" && divModal.getAttribute('editar') == "false") {

        slider = document.querySelector("." + event.target.id);

        let item = vItemsVta.find(
            //busca en los elementos de la venta actual uno que coincida con el item modificado
            //si no existe se define como undefined
            element => element.idItem == disparador.parentElement.id
        );


        //busca el producto que coincida con el option seleccionado para definir el stockActual
        vObjsProductos.forEach((element) => {
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
    } else if (disparador.tagName == "SELECT" && divModal.getAttribute('editar') == "true") {

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
        let props = {
            outputType: jsPDFInvoiceTemplate.OutputType.Save,
            returnJsPDFDocObject: true,
            fileName: "Invoice 2021",
            orientationLandscape: false,
            compress: true,
            logo: {
                src: "./../../public/img/CuentaBytes.png",
                type: 'PNG', //optional, when src= data:uri (nodejs case)
                width: 53.33, //aspect ratio = width/height
                height: 26.66,
                margin: {
                    top: 0, //negative or positive num, from the current position
                    left: 0 //negative or positive num, from the current position
                }
            },
            stamp: {
                inAllPages: true, //by default = false, just in the last page
                src: "https://raw.githubusercontent.com/edisonneza/jspdf-invoice-template/demo/images/qr_code.jpg",
                type: 'JPG', //optional, when src= data:uri (nodejs case)
                width: 20, //aspect ratio = width/height
                height: 20,
                margin: {
                    top: 0, //negative or positive num, from the current position
                    left: 0 //negative or positive num, from the current position
                }
            },
            business: {
                name: "CuentaBytes",
                address: "Albania, Tirane ish-Dogana, Durres 2001",
                phone: "(+355) 069 11 11 111",
                email: "email@example.com",
                email_1: "info@example.al",
                website: "www.example.al",
            },
            contact: {
                label: "Invoice issued for:",
                name: "Client Name",
                address: "Albania, Tirane, Astir",
                phone: "(+355) 069 22 22 222",
                email: "client@website.al",
                otherInfo: "www.website.al",
            },
            invoice: {
                label: "Invoice #: ",
                num: 19,
                invDate: "Payment Date: 01/01/2021 18:12",
                invGenDate: "Invoice Date: 02/02/2021 10:17",
                headerBorder: false,
                tableBodyBorder: false,
                header: [{
                        title: "#",
                        style: {
                            width: 10
                        }
                    },
                    {
                        title: "Title",
                        style: {
                            width: 30
                        }
                    },
                    {
                        title: "Description",
                        style: {
                            width: 80
                        }
                    },
                    {
                        title: "Price"
                    },
                    {
                        title: "Quantity"
                    },
                    {
                        title: "Unit"
                    },
                    {
                        title: "Total"
                    }
                ],
                table: Array.from(Array(10), (item, index) => ([
                    index + 1,
                    "There are many variations ",
                    "Lorem Ipsum is simply dummy text dummy text ",
                    200.5,
                    4.5,
                    "m2",
                    400.5
                ])),
                additionalRows: [{
                        col1: 'Total:',
                        col2: '145,250.50',
                        col3: 'ALL',
                        style: {
                            fontSize: 14 //optional, default 12
                        }
                    },
                    {
                        col1: 'VAT:',
                        col2: '20',
                        col3: '%',
                        style: {
                            fontSize: 10 //optional, default 12
                        }
                    },
                    {
                        col1: 'SubTotal:',
                        col2: '116,199.90',
                        col3: 'ALL',
                        style: {
                            fontSize: 10 //optional, default 12
                        }
                    }
                ],
                invDescLabel: "Invoice Note",
                invDesc: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary.",
            },
            footer: {
                text: "The invoice is created on a computer and is valid without the signature and stamp.",
            },
            pageEnable: true,
            pageLabel: "Page ",
        };

        generarPdf(props);   
    }
});