<div class="offcanvas offcanvas-end" id="offcanvasAjustes" aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-header mt-3">
        <h3 class="offcanvas-title fs-3 text-center" id="titulooffcanvasAjustes">Ajustes:</h3>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body pt-0">
        <div class="row">


            <div class="accordion" id="accordionAjustes">

                <div class="accordion-item border-0">
                    <h2 class="accordion-header" id="headingOne">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                        Cambiar nombre empresa
                    </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionAjustes">
                    <div class="accordion-body row">
                        <div class="col-9 mx-auto">
                        <input id="inpNuevoNombreEmpresa" class="form-control" type="text" name="inpNuevoNombreEmpresa" placeholder="Nuevo nombre empresa">
                        </div>
                            <button id="btnEnviarNuevoNombreEmpresa" class="btn btn-secondary col-5 mx-auto mt-4" type="button">Enviar</button>
                    </div>
                    </div>
                </div>

                <div class="accordion-item border-0">
                    <h2 class="accordion-header" id="headingTwo">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Cambiar horario de atención.
                    </button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionAjustes">
                    <div class="accordion-body row d-flex align-items-end">
                        <div class="col-5 mx-auto">
                        <label for="inpHoraApertura" class="form-label">Hora de apertura:</label>
                        <input id="inpHoraApertura" class="form-control" type="time" name="inpNuevoNombreEmpresa" placeholder="Nuevo nombre empresa">
                        </div>
                        <div class="col-5 mx-auto">
                        <label for="inpHoraCierre" class="form-label">Hora de cierre:</label>
                        <input id="inpHoraCierre" class="form-control" type="time" name="inpNuevoNombreEmpresa" placeholder="Nuevo nombre empresa">
                        </div>
                        <div class="col-4 mx-auto mt-4">
                        <button id="btnEnviarNuevoNombreEmpresa" class="btn btn-secondary" type="button">Enviar</button>
                        </div>
                    </div>
                    </div>
                </div>

                <div class="accordion-item border-0">
                    <h2 class="accordion-header" id="headingThree">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        Seleccionar tipo de grafico
                    </button>
                    </h2>
                    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionAjustes">
                    <div class="accordion-body row">
                        <!-- Contenido de la copia de seguridad -->
                        <div class="btn-group mx-auto" role="group" aria-label="Tipo de gráfico">
                            <input type="radio" class="btn-check" name="tipoGrafico" id="btnGraficoBarras" autocomplete="off">
                            <label class="btn btn-outline-secondary" for="btnGraficoBarras">Barras</label>

                            <input type="radio" class="btn-check" name="tipoGrafico" id="btnGraficoLineas" autocomplete="off">
                            <label class="btn btn-outline-secondary" for="btnGraficoLineas">Líneas</label>
                        </div>

                    </div>
                    </div>
                </div>

                <div class="accordion-item border-0">
                    <h2 class="accordion-header" id="headingFour">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                       Copia de seguridad 
                    </button>
                    </h2>
                    <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionAjustes">
                    <div class="accordion-body">
                        <!-- Contenido de la copia de seguridad -->
                    </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
</div>