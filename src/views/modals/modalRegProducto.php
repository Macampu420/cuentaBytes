<div class="modal" id="modalReg" tabindex="-1" editar="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content text-white" style="background-color: #A0D2D8;">
            <div class="modal-body pb-lg-5 px-lg-5 mx-3">
<<<<<<< HEAD
<<<<<<< HEAD
            <form action="./../controllers/regProducto.php" method="post" enctype="multipart/form-data">
=======
            <form action="./../controllers/regProducto.php" method="post">
>>>>>>> sebas
=======
            <form action="./../controllers/regProducto.php" method="post">
>>>>>>> Jota
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

                <h1 class="text-center mt-3 questrial">Registrar Producto</h1>
                <div class="row">
                <div class="form-group col-sm-12 col-md-12 col-lg-6 col-xl-6 mb-3">
                    <label for="nombreProducto" class="form-label">Nombre del producto</label>
                    <input type="text" class="form-control" name="nombreProducto" id="nombreProducto" placeholder="nombre" aria-describedby="basic-addon3">
                </div>

                
                <div class="form-group col-sm-12 col-md-12 col-lg-6 col-xl-6 mb-3">
                    <label for="costoProducto" class="form-label">Costo del producto</label>
                    <input type="number" class="form-control" name="costoProducto" id="costoProducto" placeholder="Costo" aria-describedby="basic-addon3">
                </div>
                
                <div class="form-group col-sm-12 col-md-12 col-lg-6 col-xl-6 mb-3">
                    <label for="precioVenta" class="form-label">Precio de venta</label>
                    <input type="number" class="form-control" name="precioVenta" id="precioVenta" placeholder="Precio" aria-describedby="basic-addon3">
                </div>  
                
                <div class="form-group col-sm-12 col-md-12 col-lg-6 col-xl-6 mb-3">
                    <label for="porcentajeIva" class="form-label">Iva</label>
                    <input type="number" class="form-control" name="porcentajeIva" id="porcentajeIva" placeholder="%" aria-describedby="basic-addon3">
                </div>
                                    
                <div class="form-group col-sm-12 col-md-12 col-lg-6 col-xl-6 mb-3">
                    <label for="stockProducto" class="form-label">Stock del producto</label>
                    <input type="number" class="form-control" name="stockProducto" id="stockProducto" placeholder="stock" aria-describedby="basic-addon3">
                </div>

                <div class="form-group col-sm-12 col-md-12 col-lg-6 col-xl-6 mb-3">
                    <div class="form-group">
                        <label for="idImagen" class="form-label">Imagen</label>
<<<<<<< HEAD
<<<<<<< HEAD
                        <input type="file" class="form-control" name="imgProducto" id="idImagen" aria-describedby="basic-addon3">
=======
                        <input type="file" class="form-control" name="idImagen" id="idImagen" aria-describedby="basic-addon3">
>>>>>>> sebas
=======
                        <input type="file" class="form-control" name="idImagen" id="idImagen" aria-describedby="basic-addon3">
>>>>>>> Jota
                    </div>
                </div>

                <div class="form-group col-sm-12 col-md-12 col-lg-12 col-xl-12 mb-5">
                    <label for="descripcionProducto" class="form-label">Descripción</label>
                    <textarea type="number" class="form-control" name="descripcionProducto" id="descripcionProducto" rows="3" placeholder="..." aria-describedby="basic-addon3"></textarea>
                </div>

                <div class="row col-8 p-0 m-0 justify-content-end">
                    <button id="btnGuardar" type="submit" class="btn-secondary btn col-6 mt-3">Guardar</button>
                 </div>
            </div>
</div>

                        <!-- <div class="col-6 mt-3 mt-lg-0 mx-auto col-lg-4">
                            <label for="inpFecha" class="form-label quicksand ">Valor total:</label>
                            <input required type="text" name="inpVrTotal" id="inpVrTotal" class="w-75 " value="0">
                        </div> -->

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

.inpProduct{
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