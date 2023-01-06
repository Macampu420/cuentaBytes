<div class="modal" id="modalProvee" tabindex="-1" editar="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content text-black" style="background-color:#A0D2D8">
            <div class="modal-body pb-lg-5 px-lg-5 mx-3">
            <form method="post">
                <div class="row">

                    <button type="button" class="btn-close m-3 col-1" data-bs-dismiss="modal"
                        aria-label="Close"></button>

                    <div id="divAcciones" class="row col-11 d-flex justify-content-end">
                        <div class="btnAccion mx-4 row p-1 bg-success" id="btnEditar">
                            <a class="col-12 btnEditar mx-auto"></a>
                        </div>
                        <div class="btnAccion row p-1 bg-danger" id="btnEliminar">
                            <a class="col-12 btnEliminar mx-auto"></a>
                        </div>
                    </div>
                </div>
            
                
                <h1 class="text-center mt-3 questrial">Registrar Proveedor</h1>
                
                    <div class="row p-2 mb-5">
                        <div class="col-12 mx-auto col-lg-8">
                            <label for="inpNombreProvee" class="form-label quicksand">Nombres Proveedor:</label>
                            <input required type="text" class="form-control" name="inpNombreProveedor" id="inpNombreProvee" name="nombreProveedor" aria-describedby="basic-addon3">
                        </div>
                        <div class="col-12 mx-auto col-lg-8">
                            <label for="inpDireccion" class="form-label quicksand">Dirección:</label>
                            <input required type="text" class="form-control" name="inpDireccionProveedor" id="inpDireccion" aria-describedby="basic-addon3">
                        </div>
                        <div class="col-12 mt-3 mt-md-0 mx-auto col-lg-8">
                            <label for="inpTelefono" class="form-label quicksand">Teléfono:</label>
                            <input required type="text" class="form-control" name="inpTelefonoProveedor" id="inpTelefono" aria-describedby="basic-addon3">
                        </div>

                    </div>
                        <div class="row col-8 p-0 m-0 justify-content-end">
                            <button id="btnGuardar" type="submit" class="btn-dark btn col-6 mt-3">Guardar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<style>
    * {
    box-sizing: border-box !important;
    margin: 0; 
    font-family: 'Questrial', sans-serif;
}

.img {
    width: 70px;
    height: 50px;
}

.quicksand{
    font-family: 'Quicksand', sans-serif;
}

#contItems{
    height: 15.625rem;
}

.inpVta{
    width: 6.5rem;
}

#btnAnadir{
    cursor: pointer;
}

.containerBtn{
    height: 25px;
    width: 100%;
    display: flex;
    justify-content: right;
    align-items: center;
}

.btnEliminar{
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

.btnEditar{
    background-image: url(../../public/img/edit.png);
    background-repeat: no-repeat;
    background-position: center center;
    background-size: contain;
    border: none;
    color: #fff;
    font-size: 30px;
    cursor: pointer;
}

.btnEliminar{
    background-image: url(../../public/img/trashIcon.svg);
    background-repeat: no-repeat;
    background-position: center center;
    background-size: contain;
    border: none;
    color: #fff;
    font-size: 30px;
    cursor: pointer;
}
</style>