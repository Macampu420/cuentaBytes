<div class="offcanvas offcanvas-end" id="offcanvasAjustes" aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-header">
        <h4 class="offcanvas-title text-center" id="titulooffcanvasAjustes">Ajustes:</h4>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <hr>

        <div class="row">

            <div id="acordionAjustes" class="accordion">

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#cambiarNombreEmpresa" aria-expanded="false" aria-controls="cambiarNombreEmpresa">
                            Cambiar nombre empresa
                        </button>
                    </h2>
                    <div id="cambiarNombreEmpresa" class="accordion-body row">

                        <input id="inpNuevoNombreEmpresa" class="col-4 mx-auto form-control" type="text" name="inpNuevoNombreEmpresa" placeholder="Nuevo nombre empresa">
                        <button id="btnEnviarNuevoNombreEmpresa" class="btn btn-secondary col-4 mx-auto mt-4" type="button">Enviar</button>
                    
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#cambiarHorarioAtencion" aria-expanded="false" aria-controls="cambiarHorarioAtencion">
                            Cambiar horario de atención.
                        </button>
                    </h2>
                    <div id="cambiarHorarioAtencion" class="accordion-body row d-flex align-items-end">

                        <div class="col-5 mx-auto">
                            <label for="inpHoraApertura" class="form-label">Hora de apertura:</label>
                            <input id="inpHoraApertura" class="form-control" type="time" name="inpNuevoNombreEmpresa" placeholder="Nuevo nombre empresa">
                        </div>
                        <div class="col-5 mx-auto">
                            <label for="inpHoraCierre" class="form-label">Hora de cierre:</label>
                            <input id="inpHoraCierre" class="col-5 mx-auto form-control" type="time" name="inpNuevoNombreEmpresa" placeholder="Nuevo nombre empresa">
                        </div>
                        
                        <button id="btnEnviarNuevoNombreEmpresa" class="btn btn-secondary col-4 mx-auto mt-4" type="button">Enviar</button>

                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                            data-bs-target="#copiaSeguridad" aria-expanded="false" aria-controls="copiaSeguridad">
                            Copia de seguridad
                        </button>
                    </h2>
                    <div id="copiaSeguridad" class="accordion-body">

                                
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>