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
                        <button id="btnEnviarNuevoHoraEmpresa" class="btn btn-secondary" type="button">Enviar</button>
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
                    <div class="accordion-body row d-flex justify-content-center">
                        <div id="btnSubirBackup" class="col-5 d-flex justify-content-center align-items-center border border-1 rounded-2 border-dark mx-1" role="button">
                            <p class="questrial">Subir copia de seguridad</p>
                            <input type="file" id="archivoInput" style="display: none;">
                            <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-database-fill-up" viewBox="0 0 16 16">
                                <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7Zm.354-5.854 1.5 1.5a.5.5 0 0 1-.708.708L13 11.707V14.5a.5.5 0 0 1-1 0v-2.793l-.646.647a.5.5 0 0 1-.708-.708l1.5-1.5a.5.5 0 0 1 .708 0ZM8 1c-1.573 0-3.022.289-4.096.777C2.875 2.245 2 2.993 2 4s.875 1.755 1.904 2.223C4.978 6.711 6.427 7 8 7s3.022-.289 4.096-.777C13.125 5.755 14 5.007 14 4s-.875-1.755-1.904-2.223C11.022 1.289 9.573 1 8 1Z"/>
                                <path d="M2 7v-.839c.457.432 1.004.751 1.49.972C4.722 7.693 6.318 8 8 8s3.278-.307 4.51-.867c.486-.22 1.033-.54 1.49-.972V7c0 .424-.155.802-.411 1.133a4.51 4.51 0 0 0-4.815 1.843A12.31 12.31 0 0 1 8 10c-1.573 0-3.022-.289-4.096-.777C2.875 8.755 2 8.007 2 7Zm6.257 3.998L8 11c-1.682 0-3.278-.307-4.51-.867-.486-.22-1.033-.54-1.49-.972V10c0 1.007.875 1.755 1.904 2.223C4.978 12.711 6.427 13 8 13h.027a4.552 4.552 0 0 1 .23-2.002Zm-.002 3L8 14c-1.682 0-3.278-.307-4.51-.867-.486-.22-1.033-.54-1.49-.972V13c0 1.007.875 1.755 1.904 2.223C4.978 15.711 6.427 16 8 16c.536 0 1.058-.034 1.555-.097a4.507 4.507 0 0 1-1.3-1.905Z"/>
                            </svg>
                        </div>
                        <div id="btnCrearBackup" class="col-5 d-flex justify-content-center align-items-center border border-1 rounded-2 border-dark mx-1" role="button"> 
                            <p class="questrial">Descargar copia de seguridad</p>
                            <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-database-fill-down" viewBox="0 0 16 16">
                                <path d="M12.5 9a3.5 3.5 0 1 1 0 7 3.5 3.5 0 0 1 0-7Zm.354 5.854 1.5-1.5a.5.5 0 0 0-.708-.708l-.646.647V10.5a.5.5 0 0 0-1 0v2.793l-.646-.647a.5.5 0 0 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0ZM8 1c-1.573 0-3.022.289-4.096.777C2.875 2.245 2 2.993 2 4s.875 1.755 1.904 2.223C4.978 6.711 6.427 7 8 7s3.022-.289 4.096-.777C13.125 5.755 14 5.007 14 4s-.875-1.755-1.904-2.223C11.022 1.289 9.573 1 8 1Z"/>
                                <path d="M2 7v-.839c.457.432 1.004.751 1.49.972C4.722 7.693 6.318 8 8 8s3.278-.307 4.51-.867c.486-.22 1.033-.54 1.49-.972V7c0 .424-.155.802-.411 1.133a4.51 4.51 0 0 0-4.815 1.843A12.31 12.31 0 0 1 8 10c-1.573 0-3.022-.289-4.096-.777C2.875 8.755 2 8.007 2 7Zm6.257 3.998L8 11c-1.682 0-3.278-.307-4.51-.867-.486-.22-1.033-.54-1.49-.972V10c0 1.007.875 1.755 1.904 2.223C4.978 12.711 6.427 13 8 13h.027a4.552 4.552 0 0 1 .23-2.002Zm-.002 3L8 14c-1.682 0-3.278-.307-4.51-.867-.486-.22-1.033-.54-1.49-.972V13c0 1.007.875 1.755 1.904 2.223C4.978 15.711 6.427 16 8 16c.536 0 1.058-.034 1.555-.097a4.507 4.507 0 0 1-1.3-1.905Z"/>
                            </svg>
                        </div>
                    </div>
                    </div>
                </div>

            </div>

            <a class="col-5 mx-auto mt-5 btn btn-secondary" href="./../controllers/cerrarSesion.php">Cerrar sesion</a>
        </div>

    </div>
</div>