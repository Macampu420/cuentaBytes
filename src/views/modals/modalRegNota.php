<div class="modal" id="modalAgregarNota" tabindex="-1" editar="false">
    <div class="modal-dialog">
        <div class="modal-content text-dark" style="background-color: #A0D2D8;">
            <div class="modal-body pb-lg-5 px-lg-5 mx-3">

                <form id="formNotas">
                    <div class="row">

                        <button type="button" class="btn-close m-3 col-1" data-bs-dismiss="modal" aria-label="Close"></button>

                        <div id="divAcciones" class="d-none row col-11 d-flex justify-content-end">
                            <div class="btnAccion mx-4 row p-1 bg-success" id="btnEditar">
                                <a class="col-12 btnEditar mx-auto"></a>
                            </div>
                            <div class="btnAccion row p-1 bg-danger" id="btnEliminar">
                                <a class="col-12 btnEliminar mx-auto"></a>
                            </div>
                        </div>
                    </div>

                    <h1 class="text-center mt-3 questrial">Crear nota</h1>

                    <div class="row mt-5 mb-5">

                        <div class="row col-10 mx-auto card border border- border-dark">

                            <div class="m-3 mx-auto col-11">
                                <input id="inpTituloNota" class="form-control" name="tituloNota" type="text" placeholder="Titulo:">
                            </div>

                            <div class="m-3 mx-auto col-11">
                                <textarea id="inpCuerpoNota" class="form-control" name="cuerpoNota" cols="30" rows="5">Cuerpo:</textarea>
                            </div>
                        </div>


                        <div class="row px-4 mt-3">
                            <button id="btnGuardar" type="submit" class="btn-secondary btn col-6 mx-auto mt-3">Guardar</button>
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