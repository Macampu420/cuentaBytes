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
                    
                    <hr>

                    <div id="btnAnadir" class="row mb-3">
                        <h3 class="my-auto mx-auto col-10 col-lg-4 p-0 quicksand"><img
                                src="../../public/img/iconoMas.png" class="">
                            Añadir item</h3>
                    </div>

                    <div class="div h-75 overflow-auto">
                        <table class="table rounded-3 border border-dark border-3 rounded">

                        <thead class="bg-light">
                            <tr>
                                <th class="text-center">imagen</th>
                                <th class="text-center">Producto</th>
                                <th class="text-center">Cantidad</th>
                                <th class="text-center">Precio Unitario</th>
                                <th class="text-center">Subtotal</th>
                                <th class="text-center">Eliminar</th>
                            </tr>
                        </thead>

                        <tbody id="tblItemsVta">

                        </tbody>

                        <tfoot class="table bg-light">
                            <tr>
                                <td colspan="4" class="text-end col-5"><strong>Descuento:</strong></td>
                                <td colspan="3" class="col-7">
                                <div class="col-12">
                                    <input id="inpCantidad" class="form-control w-75 mb-2" type="number" value="0">
                                </div>                                    
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="text-end col-4"><strong>Total:</strong></td>
                                <td colspan="2">$95</td>
                            </tr>                           
                        </tfoot>

                        </table>
                    </div>

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