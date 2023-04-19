<div class="modal" id="modalVtas" tabindex="-1" editar="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content text-dark">
            <div class="modal-body pb-lg-5 px-lg-5 mx-3">
            <form class="">
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
            
                

                <h1 class="text-center mt-3 questrial">Registrar venta</h1>

                
                    <div class="row p-2 mb-5">
                        <div class="col-6 mx-auto col-lg-3">
                            <label for="inpFecha" class="form-label quicksand">Fecha:</label>
                            <input disabled type="date" class="form-control" id="inpFecha" aria-describedby="basic-addon3">
                        </div>
                        <div class="col-6 mx-auto col-lg-3">
                            <label for="inpFecha" class="form-label quicksand">Metodo de pago:</label>
                            <input required type="text" class="form-control" id="inpMetPago" aria-describedby="basic-addon3">
                        </div>
                        <div class="col-6 mt-3 mt-md-0 mx-auto col-lg-3">
                            <label for="inpFecha" class="form-label quicksand">Concepto:</label>
                            <input required type="text" class="form-control" id="inpTitulo" aria-describedby="basic-addon3">
                        </div>
                        <div class="col-6 mt-3 mt-md-0 mx-auto col-lg-3">
                            <label for="inpFecha" class="form-label quicksand">Cliente:</label>
                            <select required id="slcClientes" class="form-select" aria-label="Default select example">

                                <option value=""> Selecciona el cliente </option>

                            </select>
                        </div>
                    </div>

                    <div id="btnAnadir" class="row mb-3">
                        <h3 class="my-auto mx-auto col-10 col-lg-4 p-0 quicksand"><img
                                src="../../public/img/iconoMas.png" class="">
                            Añadir item</h3>
                    </div>

                    <table class="table table-secondary table-striped">

                        <thead>
                            <tr>
                                <th>imagen</th>
                                <th>Producto</th>
                                <th>Cantidad</th>
                                <th>Precio Unitario</th>
                                <th>Subtotal</th>
                            </tr>
                        </thead>

                        <tbody>
                            <tr>
                                <td><img src="https://via.placeholder.com/70" alt="Producto 1" class="img-size"></td>
                                <td class="align-middle">Producto 1</td>
                                <td class="align-middle">$10</td>
                                <td class="align-middle">2</td>
                                <td class="align-middle">$20</td>
                            </tr>
                        </tbody>

                        <tfoot class="table-secondary">
                            <tr>
                                <td colspan="4" class="text-end"><strong>Total:</strong></td>
                                <td>$95</td>
                            </tr>
                            <tr>
                                <td colspan="4" class="text-end"><strong>Descuento:</strong></td>
                                <td>$5</td>
                            </tr>
                        </tfoot>
                    </table>

                    <div id="contTotDcto" class="row mt-3 px-2 d-none">

                        <div class="col-6 mx-auto col-lg-4">
                            <label for="inpFecha" class="form-label quicksand ">Valor IVA:</label>
                            <input readonly required type="text" id="inpVrIva" class="w-75 " value="0">
                        </div>

                        <div class="col-6 mx-auto col-lg-4">
                            <label for="inpFecha" class="form-label quicksand mx-auto">Valor descuento:</label>
                            <input required type="number" id="inpDto" class="w-75 " value="0">
                        </div>

                        <div class="col-6 mt-3 mt-lg-0 mx-auto col-lg-4">
                            <label for="inpFecha" class="form-label quicksand ">Valor total:</label>
                            <input readonly required type="text" id="inpVrTotal" class="w-75 " value="0">
                        </div>

                    </div>

                    <div class="row d-flex px-4 mt-3">
                        <button id="btnFactura" class="btn-dark btn col-4 mt-3 ms-0">Factura</button>

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

.item{
    background: #E5ECEC;
}

.modal-content{
    background: #A0D2D8;
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

/* Define la altura de la imagen en "rem" */
.img-size {
        height: 5rem;
}
</style>