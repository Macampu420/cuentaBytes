<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="./../../public/css/bootstrap.css">
    <link rel="stylesheet" href="./../../public/css/ventas.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Barlow+Semi+Condensed:wght@100;300;700;900&family=Questrial&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500&display=swap" rel="stylesheet">
    <title>Egresos</title>
</head>

<body>
    <div class="container-fluid">
        <div class="row">

            <!-- navbar  -->
            <div class="col-2 d-none d-xl-block nav vh-100 py-5 overflow-hidden">
                <?php include 'partials/navbar.php' ?>
            </div>

            <!-- contenido principal -->
            <main class="col-12 col-xl-9 mx-auto header pt-lg-4">

                <div class="row">
                    <!-- importacion del header -->
                    <?php include 'partials/header.php' ?>

                </div>

                <!-- titulo y barra de busqueda -->
                <div class="row col-12 mx-auto pt-3">

                    <h2 class="text-center fs-2 mt-5">Egresos</h2>

                    <input id="buscadorVtas" class="col-12 col-lg-7 mx-auto search__input" type="text" placeholder="Buscar egreso">

                </div>

                <!-- btn añadir item y cartas con las ventas -->
                <div class="row col-12 mx-auto pt-5">

                    <!-- btn añadir -->
                    <div class="row mt-5 mb-2 text-center">
                        <div class="col-12 col-lg-5 mx-auto">
                            <h3 id="btnAnadirVta" class="quicksand mx-5"><img src="../../public/img/iconoMas.png" class="mx-2">Añadir</h3>
                        </div>
                    </div>

                    <!-- cartas con todas las ventas registradas -->
                    <div class="col-12 col-lg-7 mx-auto p-3 border border-dark divVtas overflow-scroll">

                        <div id="filaVentas" class="row">



                        </div>

                    </div>

                </div>
            </main>
        </div>

        <?php include './modals/modalRegEgreso.php' ?>

        <script src="./../../public/js/bootstrap.js"></script>
        <script src="./../../public/js/egresos.js"></script>
        <script>
            const modalBootstrap = new bootstrap.Modal(document.getElementById('modalEgresos'));
            const divModal = document.getElementById('modalEgresos');

            traerTipoEgreso();
            renderEgresos();

            document.getElementById('btnAnadirVta').addEventListener('click', event => {

                if (event.target.tagName == "H3" || event.target.tagName == "IMG") {

                    divModal.setAttribute('editar', false);

                    desplegarModal(divModal);
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

                    let item = vItemsEgreso.find(
                        //busca en los elementos de la venta actual uno que coincida con el item modificado
                        //si no existe se define como undefined
                        element => element.idItem == disparador.parentElement.id
                    );
                    actualizarCrearItem(item, event.target, vItemsEgreso);


                } else if (disparador.tagName == "SELECT" && divModal.getAttribute('editar') == "true") {

                    let item = vItemsEditar.find(
                        //busca en los elementos de la venta actual uno que coincida con el item modificado
                        //si no existe se define como undefined
                        element => element.idItem == disparador.parentElement.id
                    );

                    actualizarCrearItem(item, event.target, vItemsEgreso);


                }

            });
            document.getElementById('rowItems').addEventListener('change', event =>{
                vrTotalRegistar();
            })


            document.querySelector("form").addEventListener("submit", (event) => {

                //evita que la pagina se recargue
                event.preventDefault();

                detalleVenta(vItemsEditar);
                

                divModal.getAttribute("editar") == "false" ? registrarEgreso(vItemsEgreso) : console.log("me tengo que actualizar");
                divModal.getAttribute("editar") == "true" ? actualizarEgreso(vItemsEgreso, vItemsEditar) : console.log("me tengo que actualizar");

            });

            document.getElementById("contItems").addEventListener("click", (event) => {

                if (event.target.id.includes("dlt")) {

                    divModal.getAttribute("editar") == "true" ? eliminarItem(event.target, vItemsEditar) : eliminarItem(event.target, vItemsEgreso);

                }
            });

            document.getElementById("filaVentas").addEventListener("click", async event => {

                if (event.target.hasAttribute("cartaitem") || event.target.tagName == "H5") {

                    divModal.setAttribute('editar', true);

                    desplegarModal(divModal, event);

                }
            })

            document.getElementById("btnEditar").addEventListener("click", () => document.getElementById('btnGuardar').disabled = false)

            document.getElementById("btnEliminar").addEventListener("click", async () => {

                idVenta = document.getElementById("btnEliminar").getAttribute("idventa");

                if (confirm("¿Deseas eliminar el egreso?") == true) {

                    await fetch(`http://localhost:3000/eliminarEgreso${idVenta}`)
                        .then(res => res.text())
                        .then(data => console.log(data));

                    location.reload();

                }
            })

            document.getElementById("buscadorVtas").addEventListener("change", () => {

                var ventas = document.querySelectorAll("[cartaItem]");
                let swNoCoinc = true;
                var alert = document.getElementById("alert");

                console.log(alert);

                ventas.forEach(element => {

                    let tituloVta = element.firstElementChild.innerHTML.toLowerCase();

                    if (!tituloVta.includes(document.getElementById("buscadorVtas").value)) {
                        element.classList.add("d-none");
                        swNoCoinc = false;
                    } else if (tituloVta.includes(document.getElementById("buscadorVtas").value)) {

                        if (alert != null) {
                            alert.remove()
                        }
                        swNoCoinc = true;
                        element.classList.remove("d-none");
                    }

                })

                if (!swNoCoinc && alert != null) {

                    alert.remove()

                    document.getElementById("filaVentas").insertAdjacentHTML('afterbegin', `
                        <div id="alert" class="alert alert-danger alert-dismissible fade show w-50 mx-auto" role="alert">
                            No se encontraron coincidencias
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        `)
                } else if (!swNoCoinc) {
                    document.getElementById("filaVentas").insertAdjacentHTML('afterbegin', `
                        <div id="alert" class="alert alert-danger alert-dismissible fade show w-50 mx-auto" role="alert">
                            No se encontraron coincidencias
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        `)
                }
            })
        </script>
</body>

</html>