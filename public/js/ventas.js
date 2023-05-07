let vObjsProductos = [];
let vObjAjustes;
let vObjsCliente = [];
let vObjsVentaActual = [];
let vItemsVta = [];
let numeroItem = 0;
let stockActual = 0;
let nuevoStock = 0;
let vObjsEncVentas = [];
let vItemsEditar = [];
let vItemsElim = [];
let vObjsMetodosPago;
let vPDF = [];
let idUltimaVenta;
const conversorColombia = new Intl.NumberFormat('en-CO');

//METODOS PARA TRAER DE LA BD LA INFORMACION NECESARIA

const traerAjustesVta = async () => {
    //se consume el API de los ajustes
    let resAjustes = await fetch('http://localhost:3000/ajustes');
    vObjAjustes = await resAjustes.json();
    console.log(vObjAjustes);
}

const traerMetodosPago = async () => {

    try {
        let resMetodosPago = await fetch('http://localhost:3000/listarMetodoPago');
        vObjsMetodosPago = await resMetodosPago.json();
    } catch (error) {
        console.log(error);
    }


    vObjsMetodosPago.forEach(metodoPago => {
        document.getElementById("slcMetodoPago").insertAdjacentHTML('beforeend', `
        
            <option value="${metodoPago.idMetodoPago}">${metodoPago.metodoPago}</option>


        `);

    });

}

const traerProductos = async () => {
    //se piden todos los productos y se guardan en el vector correspondiente
    fetch("http://localhost:3000/listarProductos")
        .then(res => res.json())
        .then(data => {

            //cada producto se pone en el vector correspondiente para poderse usar posteriormente en el resto del programa
            data.forEach(element => vObjsProductos.push(element));

        });
}

const traerClientes = async () => {
    //se piden todos los clientes, se guardan en el vector correspondiente y se insertan al html
    await fetch("http://localhost:3000/listarClientes")
        .then(res => res.json())
        .then(data => {

            //cada item se pone en el vector correspondiente para poderse usar posteriormente en el resto del programa
            data.forEach(element => vObjsCliente.push(element));

            //se renderizan todos los clientes
            vObjsCliente.forEach(cliente => {
                document.getElementById("slcClientes").innerHTML += `<option value="${cliente.idCliente}">${cliente.nombresCliente + " " + cliente.apellidosCliente}</option>`
            })
        })
        .catch(err => console.log(err));
}

const vrTotalRegistar = (vItems) => {
    //calcula el valor total de la venta y del IVA cuando se va a registrar
    let dto = document.getElementById("inpDescuento").value;
    let vrTot = 0;

    //por cada item de la venta calcula el valor de las unidVend * precioUnit
    vItems.forEach(item => vrTot += item.unidadesVendidas * item.precioUnitario);

    vrTot -= dto;

    document.getElementById("pValorTotal").innerHTML = "$" + conversorColombia.format(vrTot);
}

const renderItem = () => {
    //agrega un nuevo item de la venta al html

    document.getElementById("tblItemsVta").insertAdjacentHTML('beforeend', `
    <tr id="item${numeroItem}" class="h-25">
        <td><img id="imgProductoItem${numeroItem}" class="border border-2 img-size mx-auto" src="./../../public/img/placeholderProducto.jpg" alt="Producto 1"></td>
        <td class="align-middle">
            <div class="mx-auto">
                <select id="slcProducto${numeroItem}" class="" name="slcProductos" required>
                    <option value="">Producto:</option>
                </select>
                <p class="text-center mt-2 d-none"></p>
            </div>
        </td>
        <td class="align-middle">
            <div class="row">
                <input id="inpCantidad${numeroItem}" class="form-control w-75 mx-auto mb-2" type="number" value="1" disabled required>
            </div>                                    
        </td>
        <td class="align-middle"><p id="pPrecioVenta${numeroItem}" class="text-center">$0</p></td>
        <td class="align-middle"><p id="pSubtotalItem${numeroItem}" class="text-center">$0</p></td>
        <td class="align-middle">
            <div class="btnAccion row p-1 bg-danger mx-auto" id="btnEliminarItem${numeroItem}">
                <a class="col-12 btnEliminar mx-auto"></a>
            </div>  
        </td>
    </tr>
    `)

    //pone todos los productos que se traigan en el select del item creado
    for (let i = 0; i < vObjsProductos.length; i++) {
        document.getElementById("slcProducto" + numeroItem).insertAdjacentHTML("beforeend", `
                <option value="${vObjsProductos[i].idProducto}">${vObjsProductos[i].nombreProducto}</option>
        `);
    }

    numeroItem++;
}

const actualizarCrearItem = (item, disparador, vector) => {

    let nroItemDisparador = parseInt(disparador.id.match(/\d+$/)[0]);
    let productoItem = vObjsProductos.find(producto => producto.idProducto == disparador.value);

    if (item == undefined) {
        vector.push({
            idItem: nroItemDisparador,
            idProducto: productoItem.idProducto,
            precioUnitario: productoItem.precioVenta,
            unidadesVendidas: productoItem.existenciaProducto > 0 ? 1 : 0,
            nombreProducto: productoItem.nombreProducto,
        })
    } else {
        vector[vector.indexOf(item)] = {
            idItem: nroItemDisparador,
            idProducto: productoItem.idProducto,
            precioUnitario: productoItem.precioVenta,          
            unidadesVendidas: productoItem.existenciaProducto > 0 ? document.getElementById(`inpCantidad${nroItemDisparador}`).value : 0,
            nombreProducto: productoItem.nombreProducto,

        }
    }

    document.getElementById(`imgProductoItem${nroItemDisparador}`).src = `./../../public/img/productos/${productoItem.nombreImagen}`;
    document.getElementById(`pPrecioVenta${nroItemDisparador}`).innerHTML = "$" + conversorColombia.format(`${productoItem.precioVenta}`);
    document.getElementById(`pSubtotalItem${nroItemDisparador}`).innerHTML = "$" + conversorColombia.format(`${productoItem.precioVenta}`);

    if (productoItem.existenciaProducto == 0) {
        disparador.nextElementSibling.innerHTML = `No hay unidades disponibles.`;
        document.getElementById(`inpCantidad${nroItemDisparador}`).setAttribute("readonly", "");
        document.getElementById(`inpCantidad${nroItemDisparador}`).value = 0;
        document.getElementById(`inpCantidad${nroItemDisparador}`).removeAttribute("disabled");
    } else {
        document.getElementById(`inpCantidad${nroItemDisparador}`).removeAttribute("readonly");
        document.getElementById(`inpCantidad${nroItemDisparador}`).disabled = false;
        document.getElementById(`inpCantidad${nroItemDisparador}`).setAttribute('max', productoItem.existenciaProducto);
        disparador.nextElementSibling.innerHTML = `Actualmente tienes: ${productoItem.existenciaProducto} unidades.`;
    }

    vrTotalRegistar(vector);

}

const actualizarUnidadesVendidas = (disparador, vector) => {

    let nroIdItem = parseInt(disparador.id.match(/\d+$/)[0]);
    console.log(nroIdItem);
    let item = vector.find(itemVenta => itemVenta.idItem == parseInt(nroIdItem));

    vector[vector.indexOf(item)].unidadesVendidas = disparador.value;
    document.getElementById(`pSubtotalItem${nroIdItem}`).innerHTML = `$${conversorColombia.format(item.unidadesVendidas * item.precioUnitario)}`;

}

const registrarVenta = () => {

    let idMetPago = document.getElementById("slcMetodoPago").value;
    let idCliente = parseInt(document.getElementById("slcClientes").value);
    let descuento = parseInt(document.getElementById("inpDescuento").value);
    let fecha = document.getElementById("inpFecha").value
    let vrTotal = document.getElementById("pValorTotal").innerHTML.replace(',', '');
    vrTotal = vrTotal.replace(',', '');
    vrTotal = vrTotal.slice(1);


    //valida que todos los datos hayan sido ingresados y que haya items en la venta actual
    if (idMetPago == "" || idCliente == "" || descuento == NaN || vrTotal == NaN || vItemsVta.length == 0) {
        alert("Por favor llena todos los campos y añade items a la venta");
    } else {

        let ventaActual = {
            idMetPago,
            idCliente,
            descuento,
            vrTotal,
            fecha,
            itemsVta: vItemsVta
        };

        llenarPDF();
        enviarRegVenta(ventaActual);
    }
}

const enviarRegVenta = async (ventaActual_) => {

    await fetch('http://localhost:3000/guardarVta', {
        method: "POST",
        credentials: "same-origin",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(ventaActual_)
    })
        .then(response => response.text())
        .then(mensaje => {
            alert(mensaje);
            location.reload();
        })
        .catch(err => {
            alert("Ha ocurrido un error registrando la venta, por favor intentalo mas tarde");
            location.reload();
        });
}

const eliminarItem = (disparador, vector_) => {

    let item = vector_.findIndex(
        //busca en los elementos de la venta actual uno que coincida con el item modificado
        //si no existe se define como undefined
        element => (element.idItem) == parseInt(disparador.id.match(/\d+$/)[0])
    );

    //eliminará la carta del elemento y lo quitara del vector segun su posicion, si este existe en el array
    //sino solo eliminara la carta
    if (item != -1) {
        if (item == 0) {
            vector_.shift();
            disparador.parentElement.parentElement.remove();

        } else {
            vector_.splice(vector_.indexOf(item), 1);
            disparador.parentElement.parentElement.remove();
        }
        vrTotalRegistar(vector_);
    } else {
        disparador.parentElement.parentElement.remove();
    }

}

const renderVentas = async () => {
    //se traen todos los encabezados de las ventas registradas
    await fetch("http://localhost:3000/ventas")
        .then(res => res.json())
        .then(data => {

            if (!data.mensaje) {
                //se da formato a la fecha y se empuja cada item en el vector indicado
                data[0].forEach(element => {

                    element.fechaVenta = element.fechaVenta.slice(0, 10);

                    vObjsEncVentas.push(element);
                    idUltimaVenta = data[0][0].idVenta;
                })
            }
        })
        .catch((error) => {
            console.log(error)
        });

    if (vObjsEncVentas.length > 0) {

        let filaVentas = document.getElementById('filaVentas');

        vObjsEncVentas.forEach((element) => {

            filaVentas.insertAdjacentHTML('beforeend', `
                
                <div id="${element.idVenta}" cartaItem="true" class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
                    <div class="card-body mt-2 mx-auto">
                        <h5 btnAcciones idventa="${element.idVenta}" class="puntosAcciones m-2 w-25">...</h5>
                        <h5>Valor Total: ${conversorColombia.format(element.vrTotalVta)}</h5>
                        <h5>Fecha: ${element.fechaVenta}</h5>
                        <h5>Vendido a: ${element.nombresCliente + " " + element.apellidosCliente}</h5>
                    </div>
                </div>
        
                `);
        });
    } else {
        filaVentas.insertAdjacentHTML('beforeend', `
                
            <h3 class="text-center mt-lg-5 col-12">Aún no has registrado ventas, presiona el boton de arriba para hacerlo</h3>
        
            `);
    }

}

const iniciarModalRegistrar = () => {

    //setea todos los inputs/items como vacios para registrar una venta nueva
    vItemsVta = [];
    let date = new Date();
    numeroItem = 0;

    document.getElementById('btnAnadir').disabled = false;
    document.getElementById('btnGuardar').disabled = false;
    document.getElementById('slcClientes').disabled = false;
    document.getElementById('slcMetodoPago').disabled = false;
    document.getElementById('inpDescuento').disabled = false;

    document.getElementById('inpFecha').value = date.toISOString().slice(0, 10);
    document.getElementById('tblItemsVta').innerHTML = "";
    document.getElementById('inpDescuento').value = 0;
    document.getElementById('pValorTotal').innerHTML = "$0";
    document.getElementById('slcClientes').selectedIndex = 0;
    document.getElementById('slcMetodoPago').selectedIndex = 0;

}

const iniciarModalDetallesVenta = async (disparador) => {

    let resVenta = await fetch(`http://localhost:3000/editVenta${disparador.getAttribute('idVenta')}`);
    let venta = await resVenta.json();

    document.getElementById("tblItemsVta").innerHTML = "";

    document.getElementById("inpFecha").value = venta[0].fechaVenta.slice(0, 10);
    document.getElementById("slcMetodoPago").value = venta[0].idMetodoPago;
    document.getElementById("slcClientes").value = venta[0].idCliente;
    document.getElementById("inpDescuento").value = venta[0].descuentoVenta;

    document.getElementById("btnAnadir").disabled = true;
    document.getElementById("btnGuardar").disabled = true;
    document.getElementById("slcMetodoPago").disabled = true;
    document.getElementById("slcClientes").disabled = true;
    document.getElementById("inpDescuento").disabled = true;
    document.getElementById("pValorTotal").innerHTML = `$${conversorColombia.format(venta[0].vrTotalVta)}`;

    venta.forEach(detalle => {
        document.getElementById("tblItemsVta").insertAdjacentHTML('beforeend', `
        <tr id="item${numeroItem}" class="h-25">
            <td><img id="imgProductoItem${numeroItem}" class="border border-2 img-size mx-auto" src="./../../public/img/productos/${detalle.nombreImagen}" alt="Producto 1"></td>
            <td class="align-middle">
                <p id="pPrecioVenta${numeroItem}" class="text-center">${detalle.nombreProducto}</p>                                  
            </td>
            <td class="align-middle"><p id="inpCantidad${numeroItem}" class="text-center">${detalle.uniVendidas}</p></td>                                                                
            <td class="align-middle"><p id="pPrecioVenta${numeroItem}" class="text-center">$${conversorColombia.format(detalle.precioUnitario)}</p></td>
            <td class="align-middle"><p id="pSubtotalItem${numeroItem}" class="text-center">$${conversorColombia.format(detalle.precioUnitario * detalle.uniVendidas)}</p></td>
            <td class="align-middle">
                <div class="btnAccion row p-1 bg-danger mx-auto">
                    <p class="col-12 btnEliminar mx-auto"></p>
                </div>  
            </td>
        </tr>
        `);
    });

}

const llenarPDF = async () => {
    let nombreCliente, apellidoCliente, telefonoCliente, cedulaCliente, metodoPago;
    let idMetPago = document.getElementById("slcMetodoPago").value;
    let idCliente = parseInt(document.getElementById("slcClientes").value);
    let descuento = parseInt(document.getElementById("inpDescuento").value);
    let vrTotal = document.getElementById("pValorTotal").innerHTML.replace(',', '');
    let fecha = document.getElementById("inpFecha").value
    vrTotal = vrTotal.slice(1);

    vObjsCliente.forEach(cliente => {
        if (cliente.idCliente == idCliente) {
            nombreCliente = cliente.nombresCliente;
            apellidoCliente = cliente.apellidosCliente;
        }
    })

    vObjsMetodosPago.forEach(element => {
        if (element.idMetodoPago == idMetPago) {
            metodoPago = element.metodoPago
        }
    })


    let PDFActual = {
        descuento,
        vrTotal,
        fecha,
        nombreCliente,
        apellidoCliente,
        cedulaCliente,
        telefonoCliente,
        metodoPago,
        itemsVta: vItemsVta,
    };

    vPDF.push(PDFActual);

}

const generarPdf = () => {
    vPDF.forEach(element => {
        descuento = parseInt(vPDF[0].descuento)
        total = parseInt(vPDF[0].vrTotal)
        subtotal = total + descuento;

        props = {
            outputType: jsPDFInvoiceTemplate.OutputType.Save,
            returnJsPDFDocObject: true,
            fileName: `Factura ${idUltimaVenta}`,
            orientationLandscape: false,
            compress: true,
            logo: {
                src: "./../../public/img/CuentaBytes.png",
                type: 'PNG', //optional, when src= data:uri (nodejs case)
                width: 53.33, //aspect ratio = width/height
                height: 53.33,
                margin: {
                    top: -15, //negative or positive num, from the current position
                    left: 0 //negative or positive num, from the current position
                }
            },
            business: {
                name: vObjAjustes.nombreEmpresa,
            },
            contact: {
                label: "Factura venta",
                name: "Cliente: " + vPDF[0].nombreCliente + " " + vPDF[0].apellidoCliente,
                otherInfo: "Metodo de Pago: " + vPDF[0].metodoPago
            },
            invoice: {
                label: "Factura #: ",
                num: idUltimaVenta + 1,
                invDate: "Fecha Venta: " + vPDF[0].fecha,
                invGenDate: "Fecha Factura: " + vPDF[0].fecha,
                headerBorder: false,
                tableBodyBorder: false,
                header: [{
                    title: "Codigo",
                    style: {
                        width: 20
                    }
                },
                {
                    title: "Producto",
                    style: {
                        width: 50,

                    }
                },
                {
                    title: "Precio"
                },
                {
                    title: "Cantidad"
                },
                {
                    title: "Total"
                }
                ],
                table: Array.from(Array(vItemsVta.length), (item, index) => ([
                    vItemsVta[index].idProducto,
                    vItemsVta[index].nombreProducto,
                    conversorColombia.format(vItemsVta[index].precioUnitario),
                    conversorColombia.format(vItemsVta[index].unidadesVendidas),
                    conversorColombia.format(parseInt(vItemsVta[index].precioUnitario) * parseInt(vItemsVta[index].unidadesVendidas))
                ])),
                additionalRows: [{
                    col1: 'Subtotal: $',
                    col2: conversorColombia.format(subtotal),
                    style: {
                        fontSize: 10 //optional, default 12
                    }
                },
                {
                    col1: 'Descuento: $',
                    col2: conversorColombia.format(vPDF[0].descuento),
                    style: {
                        fontSize: 10 //optional, default 12
                    }
                },
                {
                    col1: 'Total: $',
                    col2: conversorColombia.format(vPDF[0].vrTotal),
                    style: {
                        fontSize: 14 //optional, default 12
                    }
                }
                ],
                invDescLabel: "Total : $" + conversorColombia.format(vPDF[0].vrTotal),
                invDesc: "Subtotal : $" + conversorColombia.format(subtotal) + "      Descuento : $" + conversorColombia.format(vPDF[0].descuento),
            }
        };
    })


    var pdfObject = jsPDFInvoiceTemplate.default(props);
    console.log("Factura ", pdfObject);
}