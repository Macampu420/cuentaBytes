<div class="modal" id="modalCl" tabindex="-1" editar="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content text-white">
            <div class="modal-body pb-lg-5 px-lg-5 mx-3">
                <form action="../../controllers/clientes.php" method="post">
                    <div class="row">

                        <button type="button" class="btn-close m-3 col-1" data-bs-dismiss="modal" aria-label="Close"></button>

                        <div id="divAcciones" class="row col-11 d-flex justify-content-end">
                            <div class="btnAccion mx-4 row p-1 bg-success" id="btnEditar">
                                <a class="col-12 btnEditar mx-auto"></a>
                            </div>
                            <div class="btnAccion row p-1 bg-danger" id="btnEliminar">
                                <a class="col-12 btnEliminar mx-auto"></a>
                            </div>
                        </div>
                    </div>



                    <h1 class="text-center mt-3 questrial">Registrar Cliente</h1>

                    <div class="row mt-5 mb-5">
                        <label for="cedulaCliente" class="form-label col-9 mx-auto">Cedula Cliente</label>
                        <input type="number" required name="cedulaCliente" class="input col-9 mx-auto" id="cedulacliente" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="10">


                        <label for="nombresCliente" class="form-label col-9 mx-auto">Nombre Cliente</label>
                        <input type="text" required name="nombresCliente" class="input col-9 mx-auto" id="nombresCliente" maxlength="30">


                        <label for="apellidoClientes" class="form-label col-9 mx-auto">Apellido Cliente</label>
                        <input type="text" required name="apellidosCliente" class="input col-9 mx-auto" id="apellidosCliente" maxlength="30">

                        <label for="telefonoCliente" class="form-label col-9 mx-auto">Telefono</label>
                        <input type="text" required name="telefonoCliente" class="input col-9 mx-auto" id="telefonoCliente" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);" maxlength="10">
                            <div class="row col-8 p-0 m-0 justify-content-end">
                                <button id="btnGuardar" type="submit" class="btn-secondary btn col-6 mt-3">Guardar</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<style>
    .modal-content {
    background: #A0D2D8;
}
    * {
        box-sizing: border-box !important;
        margin: 0;
        font-family: 'Questrial', sans-serif;
    }

    .img {
        width: 70px;
        height: 50px;
    }

    .quicksand {
        font-family: 'Quicksand', sans-serif;
    }

    #contItems {
        height: 15.625rem;
    }

    .inpVta {
        width: 6.5rem;
    }

    #btnAnadir {
        cursor: pointer;
    }

    .containerBtn {
        height: 25px;
        width: 100%;
        display: flex;
        justify-content: right;
        align-items: center;
    }

    .btnEliminar {
        background-image: url(../../public/img/trashIcon.svg);
        background-repeat: no-repeat;
        background-position: center center;
        background-size: contain;
        border: none;
        color: #fff;
        font-size: 30px;
        width: 20px;
        height: 100%;
        cursor: pointer;
    }

    .btnAccion {

        width: 3.4rem;
        height: 3.4rem;

        border: 2px solid #000;

        border-radius: 15px;

    }

    .btnEditar {
        background-image: url(../../public/img/edit.png);
        background-repeat: no-repeat;
        background-position: center center;
        background-size: contain;
        border: none;
        color: #fff;
        font-size: 30px;
        cursor: pointer;
    }

   
</style>