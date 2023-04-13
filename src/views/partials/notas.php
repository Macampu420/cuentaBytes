<div class="offcanvas offcanvas-end" id="offcanvasNotas" aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-header">
        <h4 class="offcanvas-title text-center" id="tituloOffcanvasNotas">Notas:</h4>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <div class="row">
            <input id="buscadorVtas" class="col-12 col-lg-10 mx-auto h-auto search__input" type="text" placeholder="Buscar nota">
        </div>

        <hr>

        <div id="${element.idVenta}" cartaItem="true" class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
            <div class="card-body mt-2 mx-auto">
                <h5 btnAcciones idventa="${element.idVenta}" class="puntosAcciones m-2 w-25">...</h5>
                <h5 class="text-center">Titulo</h5>
                <h5 class="text-center">Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur nostrum facere aliquid veniam blanditiis.</h5>
            </div>
        </div>

    </div>
</div>