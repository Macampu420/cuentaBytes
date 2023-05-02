<div class="offcanvas offcanvas-end" id="offcanvasNotas" aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-header">
        <h4 class="offcanvas-title text-center" id="tituloOffcanvasNotas">Notas:</h4>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <div class="row">
            <input id="buscadorNotas" class="col-12 col-lg-10 mx-auto h-auto search__input" type="text" placeholder="Buscar nota">
        </div>

        <div id="filaNotas" class="row">

            <div id="alertNoNotas" class="d-none alert alert-danger alert-dismissible fade show w-50 mx-auto mt-3" role="alert">
                No se encontraron coincidencias
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

        </div>
        
    </div>
</div>