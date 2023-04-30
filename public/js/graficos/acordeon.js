export default class modeloGraficos {
	constructor() {
		this.graficoProductos = undefined;
		this.graficoVentas = undefined;
		this.graficoCompras = undefined;
		this.graficoEgresos = undefined;
		this.graficoClientes = undefined;
	}

	#configDatePicker = {
		locale: {
			format: "YYYY-MM-DD"
		},
		ranges: {
			'Hoy': [moment(), moment()],
			'Ayer': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
			'Ultimos 7 dias': [moment().subtract(6, 'days'), moment()],
			'Ultimos 30 dias': [moment().subtract(29, 'days'), moment()],
			'Ultimo mes': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
		}
	}

	generarSeccionAccordion = (titulo, idCollapse, idDropdown, idFecha, idCanvas, idFechaGrafico, containerDropdown) => {
		return `
      <div class="accordion-item">
        <h2 class="accordion-header" id="${titulo}">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
            data-bs-target="#${idCollapse}" aria-expanded="true" aria-controls="${idCollapse}">
            ${titulo}
          </button>
        </h2>
        <div id="${idCollapse}" class="accordion-collapse collapse" aria-labelledby="${titulo}"
          data-bs-parent="#acordeonBalances">
          <div class="accordion-body">
            <div class="row col-12 mb-4">
              <div class="dropdown col-8 col-md-3 mx-auto my-2 mx-lg-1">
                <button class="btn btn-secondary dropdown-toggle" type="button"
                  id="${idDropdown}" data-bs-toggle="dropdown" aria-expanded="false">
                  Seleccionar reporte
                </button>
                <ul id="${containerDropdown}" class="dropdown-menu" aria-labelledby="${idDropdown}">
                </ul>
              </div>
              <button id="${idFecha}" class="col-8 col-md-3 mx-auto my-2 btn btn-secondary dropdown-toggle mx-lg-1"
                type="button" aria-expanded="false">Seleccionar fecha</button>
            </div>
            <div class="col-12">
              <canvas id="${idCanvas}"></canvas>
            </div>
            <div class="col-12 mt-2">
              <p id="${idFechaGrafico}" class="text-center fs-3 questrial my-0">Estas viendo este reporte desde hoy hasta ayer</p>
            </div>
          </div>
        </div>
      </div>
    `;
	}

	generarReportesDropdown = (vSecciones, dropdown) => {
		vSecciones.forEach(function(value) {
			document.getElementById(dropdown).insertAdjacentHTML("beforeend", `<li><a id="${value.replace(/ /g, "-")}" class="dropdown-item" href="#">${value}</a></li>`);
		});    
	}

	crearGraficos = () => {

		this.graficoProductos = new Chart(document.getElementById('canvaProductos'), {
			type: 'bar',
			data: {
				labels: [],
				datasets: [{
					data: [],
				}]
			},
			options: {
				plugins: {
					legend: {
						display: false
					}
				}
			}
		});

		this.graficoVentas = new Chart(document.getElementById('canvaVentas'), {
			type: 'bar',
			data: {
				labels: [],
				datasets: [{
					label: "Ventas",
					data: [],
				}]
			}
		});

		this.graficoCompras = new Chart(document.getElementById('canvaCompras'), {
			type: 'bar',
			data: {
				labels: [],
				datasets: [{
					label: "Compras",
					data: [],
				}]
			}
		});

		this.graficoEgresos = new Chart(document.getElementById('canvaEgresos'), {
			type: 'bar',
			data: {
				labels: [],
				datasets: [{
					label: "",
					data: [],
				}]
			}
		});

		this.graficoClientes = new Chart(document.getElementById('canvaClientes'), {
			type: 'bar',
			data: {
				labels: [],
				datasets: [{
					label: "",
					data: [],
				}]
			}
		});
	}

	convertirACamelCase = (str) => {
		//se separan las palabras (convertidas a minuscula) en un array para poderlas trabajar
		const palabras = str.toLowerCase().split(" ");

		//se itera desde la segunda palabra
		for (let i = 1; i < palabras.length; i++) {
			//se hace la primera letra mayuscula y se concatena con el resto de la palabra
			palabras[i] = palabras[i].charAt(0).toUpperCase() + palabras[i].slice(1);
		}
		//se retorna el array pero como string ya formateado
		return palabras.join("");
	}

	//callback para cada vez que se ejecute  un cambio de fecha
	async callbackDatePicker (pInicio, pFin) {
		inicio = pInicio.format('YYYY-MM-DD');
		fin = pFin.format('YYYY-MM-DD');

		let fechaSeleccionada = pInicio.clone().startOf('day');

		// Compara la fecha seleccionada con las fechas de hoy y ayer
		if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
			actualizarGrafico(inicio, fin, "horas");
		} else {
			actualizarGrafico(inicio, fin, "dias");
		}
		mostrarRango(inicio, fin);
	};

	crearDatePickers(elemento){
		$(`#${elemento}`).daterangepicker(this.callbackDatePicker, this.#configDatePicker);
	}

	// muestra desde hasta cuando se hara el PyG
	mostrarRango = (inicio, fin) => document.querySelector('#pFechaGraficoProductos').innerHTML = ('Estas viendo este reporte Desde: ' + inicio + '. - Hasta: ' + fin);


	//-----------METODOS DEL GRAFICO DE PRODUCTOS---------------------

	traerDatosProductos = async (inicio, fin, tiempo) => {
		// se consumen los datos de la API y se le pasan al metodo para que los setee,
		//  despues se invoca al metodo update del grafico para que los cambios se vean reflejados
		let resGraficos = await fetch(`http://localhost:3000/reportesProductos${tiempo}`, {
			method: "POST",
			credentials: "same-origin",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				inicio,
				fin
			})
		});

		let datosProductos = await resGraficos.json();

		return datosProductos;

		// if(tiempo == 'horas'){
		//     mostrarDatosGraficoHora(datosGraficos);
		// } else {
		//     mostrarDatosGraficoDia(datosGraficos);
		// }

		// chart.update();

	}

	mostrarDatosProductoHora = (vectorDatos, tipoBalance, propiedadData) => {

		//se obtienen todos los valores de las horas correspondientes
		let nombresProductos = vectorDatos[tipoBalance].map(elemento => elemento.nombreProducto);

		//se le dice al grafico que use las horas (convertidas a formato de 12 por el metodo) como etiquetas
		this.graficoProductos.data.labels = nombresProductos;

		//se llenan y muestran los datos correspondientes a las compras
		this.graficoProductos.data.datasets[0].data = vectorDatos[tipoBalance].map(elemento => elemento[propiedadData]);

		this.graficoProductos.update();
	}

	actualizarGraficoProductos = async (inicio, fin, tiempo) => {

		// se consumen los datos de la API y se le pasan al metodo para que los setee,
		//  despues se invoca al metodo update del grafico para que los cambios se vean reflejados
		let resGraficos = await fetch(`http://localhost:3000/reportesProductos${tiempo}`, {
			method: "POST",
			credentials: "same-origin",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify({
				inicio,
				fin
			})
		});

		let datosGraficos = await resGraficos.json();

		console.log(datosGraficos);

		// if(tiempo == 'horas'){
		//     mostrarDatosGraficoHora(datosGraficos);
		// } else {
		//     mostrarDatosGraficoDia(datosGraficos);
		// }

		// chart.update();

	}

	//-----------FIN METODOS DEL GRAFICO DE PRODUCTOS---------------------

}