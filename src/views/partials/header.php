<header class="row col-12 col-md-8 mx-1 my-1 mx-lg-auto py-2 shadow d-flex justify-content-between rounded-bottom-3 rounded-bottom-lg-1">
	
	<p id="pHeader" class="col-8 fs-1 my-auto text-white"></p>
	<button class="col-4 btn btn-primary d-xl-none" type="button" data-bs-toggle="offcanvas"
		data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
		menu
	</button>

	<div class="col-2 row d-none d-lg-flex">

		<div id="btnDesplegarNotas" class="mt-3 mx-auto col-6 h-100">
			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-card-list"
				viewBox="0 0 16 16">
				<path
					d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z" />
				<path
					d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z" />
			</svg>
		</div>

		<div id="btnDesplegarAjustes" class="mt-3 mx-auto col-6 h-100">
			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-gear-fill"
				viewBox="0 0 16 16">
				<path
					d="M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 0 1-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 0 1 .872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 0 1 2.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 0 1 2.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 0 1 .872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 0 1-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 0 1-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 1 1 0-5.86 2.929 2.929 0 0 1 0 5.858z">
				</path>
			</svg>
		</div>

	</div>
</header>

<div class="contenedor">
	<button id="btnAgregarNota" class="botonF1">
		<span>+</span>
	</button>
</div>

<style>
    @media (min-width: 992px) {
    	header {
    		border-radius: 8px;
    		background: #218DA3;
    	}
    }

	.contenedor {
		width: 90px;
		height: 240px;
		position: fixed;
		right: 0px;
		bottom: 0px;
		z-index: 1;
	}

	.botonF1 {
		width: 60px;
		height: 60px;
		border-radius: 100%;
		background: #218DA3;
		right: 0;
		bottom: 0;
		position: absolute;
		margin-right: 16px;
		margin-bottom: 16px;
		border: none;
		outline: none;
		color: #FFF;
		font-size: 36px;
		box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23);
		transition: .3s;
	}
</style>