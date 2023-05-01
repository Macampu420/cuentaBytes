import moment from './../moment.js'

export default class modeloGraficos {

	#hoy = moment();
	#ayer = moment().subtract(1, 'days');
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
	
	setGraficos(graficoProductos, graficoVentas, graficoCompras, graficoEgresos, graficoClientes) {
		this.graficoProductos = graficoProductos;
		this.graficoVentas = graficoVentas;
		this.graficoCompras = graficoCompras;
		this.graficoEgresos = graficoEgresos;
		this.graficoClientes = graficoClientes;
	}

	generarSeccionAccordion = (titulo, idCollapse, idDropdown, idSlcFecha, idpFecha, idCanvas, containerDropdown) => {
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
            <div class="row col-12 mb-4 d-flex align-items-center">

              <button id="${idSlcFecha}" class="col-8 col-md-3 mx-auto my-2 btn btn-secondary dropdown-toggle mx-lg-1"
                type="button" aria-expanded="false">Seleccionar fecha</button>

			  <div class="dropdown col-8 col-md-3 mx-auto my-2 mx-lg-1">
                <button class="btn btn-secondary dropdown-toggle" type="button"
                  id="${idDropdown}" data-bs-toggle="dropdown" aria-expanded="false">
                  Seleccionar reporte
                </button>
                <ul id="${containerDropdown}" class="dropdown-menu" aria-labelledby="${idDropdown}">
                </ul>
              </div>

			  <div id="pNoData${titulo}" class="d-none questrial col-8 col-md-5 mx-auto text-center">No hay datos para el reporte y/o fecha seleccionados!</div>

            </div>
            <div class="col-12">
              <canvas id="${idCanvas}"></canvas>
            </div>
            <div class="col-12 mt-2">
              <p id="${idpFecha}" class="text-center fs-3 questrial my-0"></p>
            </div>
          </div>
        </div>
      </div>
    `;
	}

	generarReportesDropdown = (vReportesSeccion, dropdown) => {
		vReportesSeccion.forEach(function(value) {
			document.getElementById(dropdown).insertAdjacentHTML("beforeend", `<li><a id="${value.replace(/ /g, "-")}" class="dropdown-item">${value}</a></li>`);
		});    
	}

	crearGraficos = () => {
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

	crearDatePickers(elemento, callback){
		$(`#${elemento}`).daterangepicker(this.#configDatePicker, callback);
	}

	// muestra desde hasta cuando se hara el PyG
	mostrarRango = (inicio, fin, parrafo) => document.querySelector(`#${parrafo}`).innerHTML = ('Estas viendo este reporte Desde: ' + inicio + ' - Hasta: ' + fin);


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

	//-----------METODOS DEL GRAFICO DE VENTAS---------------------

	traerDatosVentas = async (inicio, fin, tiempo) => {
		try {
			if (tiempo == "horas") {

				let resDatosVentas = await fetch(`http://localhost:3000/reportesVentas/${tiempo}`, {
					method: "POST",
					credentials: "same-origin",
					headers: {
						"Content-Type": "application/json",
					},
					body: JSON.stringify({
						dia: this.#hoy.date() == inicio.date() ? 'hoy' : 'ayer'
					})
				});
	
				let datosVentas = await resDatosVentas.json();
				return datosVentas;
			} else {
				let resDatosVentas = await fetch(`http://localhost:3000/reportesVentas/${tiempo}`, {
					method: "POST",
					credentials: "same-origin",
					headers: {
						"Content-Type": "application/json",
					},
					body: JSON.stringify({
						diaInicio: inicio,
						diaFin: fin
					})
				});
	
				let datosVentas = await resDatosVentas.json();
				return datosVentas;
			}
		} catch (error) {
			console.log(error);
			window.alert("Ha ocurrido un error consultando la informacion, por favor intentalos mas tarde");
		}
	}

	mostrarTextoNoData = (vector, idElementotexto) => {
		document.getElementById(idElementotexto).classList.add('d-none');

		if(vector. length == 0){
			document.getElementById(idElementotexto).classList.remove('d-none');
		}
	}

	mostrarDatosVentas = (vectorDatos, tipoBalance, propiedadData, propiedadLabels, labelGrafico) => {

		this.mostrarTextoNoData(vectorDatos[tipoBalance], 'pNoDataVentas');

		//se obtienen todos los valores de las horas correspondientes
		let horaVentas = vectorDatos[tipoBalance].map(elemento => elemento[propiedadLabels]);

		//se le dice al grafico que use las horas (convertidas a formato de 12 por el metodo) como etiquetas
		this.graficoVentas.data.labels = horaVentas;

		//se llenan y muestran los datos correspondientes a las compras
		this.graficoVentas.data.datasets[0].data = vectorDatos[tipoBalance].map(elemento => elemento[propiedadData]);

		//se setea el label de los datos que se estan mostrando
		this.graficoVentas.data.datasets[0].label = labelGrafico;

		this.graficoVentas.update();
	}

	//-----------FIN METODOS DEL GRAFICO DE VENTAS---------------------

	//-----------METODOS DEL GRAFICO DE Compras---------------------

	traerDatosCompras = async (inicio, fin, tiempo) => {
		try {
			if (tiempo == "horas") {

				let resDatosCompras = await fetch(`http://localhost:3000/reportesCompras/${tiempo}`, {
					method: "POST",
					credentials: "same-origin",
					headers: {
						"Content-Type": "application/json",
					},
					body: JSON.stringify({
						dia: this.#hoy.date() == inicio.date() ? 'hoy' : 'ayer'
					})
				});
	
				let datosCompras = await resDatosCompras.json();
				return datosCompras;
			} else {
				let resDatosCompras = await fetch(`http://localhost:3000/reportesCompras/${tiempo}`, {
					method: "POST",
					credentials: "same-origin",
					headers: {
						"Content-Type": "application/json",
					},
					body: JSON.stringify({
						diaInicio: inicio,
						diaFin: fin
					})
				});
	
				let datosCompras = await resDatosCompras.json();
				return datosCompras;
			}
		} catch (error) {
			console.log(error);
			window.alert("Ha ocurrido un error consultando la informacion, por favor intentalos mas tarde");
		}
	}

	mostrarDatosCompras = (vectorDatos, tipoBalance, propiedadData, propiedadLabels, labelGrafico) => {

		this.mostrarTextoNoData(vectorDatos[tipoBalance], 'pNoDataCompras');

		//se obtienen todos los valores de las horas correspondientes
		let horaCompras = vectorDatos[tipoBalance].map(elemento => elemento[propiedadLabels]);

		//se le dice al grafico que use las horas (convertidas a formato de 12 por el metodo) como etiquetas
		this.graficoCompras.data.labels = horaCompras;

		//se llenan y muestran los datos correspondientes a las compras
		this.graficoCompras.data.datasets[0].data = vectorDatos[tipoBalance].map(elemento => elemento[propiedadData]);

		//se setea el label de los datos que se estan mostrando
		this.graficoCompras.data.datasets[0].label = labelGrafico;

		this.graficoCompras.update();
	}
	
	//-----------FIN METODOS DEL GRAFICO DE VENTAS---------------------
	

}