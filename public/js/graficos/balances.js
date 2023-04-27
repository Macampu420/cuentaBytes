// const ctx = document.getElementById('myChart');
// let inicio, fin;
// let hoy = moment();
// let ayer = moment().subtract(1, 'days');

// // inicializacion del grafico, solo estructura a usar, datos vacios
// let chart = new Chart(ctx, {
//     type: 'line',
//     data: {
//         labels: [],
//         datasets: [{
//                 data: []
//             },
//             {
//                 data: []
//             },
//             {
//                 data: []
//             },
//         ]
//     },
//     options: {
//         scales: {
//             y: {
//                 beginAtZero: true
//             }
//         },
//         plugins: {
//             tooltip: {
//                 callbacks: {
//                     title: function (tooltipItem) {
//                         return tooltipItem[0].dataset.conceptos[tooltipItem[0].dataIndex];
//                     }
//                 }
//             }
//         },
//         elements: {
//             line: {
//                 tension: 0.4,
//                 borderWidth: 3
//             },
//             point: {
//                 radius: 7.3,
//                 pointStyle: 'circle',
//                 borderWidth: 2
//             }
//         }
//     }
// });

// //convierte las horas de formato 24 a 12
// let convertirHora12 = (horas24) => {
//     return horas24.map(hora => {
//         // Para cada hora, calculamos su equivalente en formato 12 horas con "hora % 12"
//         // si esto da 0 quiere decir que son las 12.00
//         let hora12 = (hora % 12) || 12;
//         // Usamos un operador ternario para determinar si es "am" o "pm"
//         let ampm = hora < 12 ? 'am' : 'pm';
//         return `${hora12}${ampm}`;
//     });
// }



// let mostrarDatosGraficoDia = (vectorDatos) => {

//     //se le dice al grafico que use las dias (convertidas a formato de 12 por el metodo) como etiquetas
//     chart.data.labels = vectorDatos.compras.map(elemento => elemento.Dia);

//     //se llenan y muestran los datos correspondientes a las compras
//     chart.data.datasets[0].data = vectorDatos.compras.map(elemento => elemento.VrTotalDia);
//     chart.data.datasets[0].label = 'Compras';
//     chart.data.datasets[0].conceptos = vectorDatos.compras.map(elemento => elemento.Dia);

//     //se llenan y muestran los datos correspondientes a los egresos
//     chart.data.datasets[1].data = vectorDatos.egresos.map(elemento => elemento.VrTotalDia);
//     chart.data.datasets[1].label = 'Egresos';
//     chart.data.datasets[1].conceptos = vectorDatos.egresos.map(elemento => elemento.Dia);

//     //se llenan y muestran los datos correspondientes a las ventas
//     chart.data.datasets[2].data = vectorDatos.ventas.map(elemento => elemento.VrTotalDia);
//     chart.data.datasets[2].label = 'Ventas';
//     chart.data.datasets[2].conceptos = vectorDatos.ventas.map(elemento => elemento.Dia);
// }



// // muestra desde hasta cuando se hara el PyG
// let mostrarRango = (inicio, fin) => document.querySelector('#spanFechaGrafico').innerHTML = ('Generar gráfico movimiento de efectivo: <br/> Desde: ' + inicio + '. Hasta: ' + fin);

// //jquery necesario para el funcionamiento del date picker
// $(function () {
//     mostrarRango(hoy.format('YYYY-MM-DD'), hoy.format('YYYY-MM-DD'));
//     actualizarGrafico(hoy.format('YYYY-MM-DD'), hoy.format('YYYY-MM-DD'), 'horas');

//     //creacion y configuracion del rangepicker sobre el elemento #reportrange
//     $('#reportrange').daterangepicker({
//             locale: {
//                 format: "YYYY-MM-DD"
//             },
//             ranges: {
//                 'Hoy': [moment(), moment()],
//                 'Ayer': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
//                 'Ultimos 7 dias': [moment().subtract(6, 'days'), moment()],
//                 'Ultimos 30 dias': [moment().subtract(29, 'days'), moment()],
//                 'Ultimo mes': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
//             }
//         },
//         //callback para cada vez que se ejecute  un cambio de fecha
//         async function (pInicio, pFin) {
//             inicio = pInicio.format('YYYY-MM-DD');
//             fin = pFin.format('YYYY-MM-DD');

//             let fechaSeleccionada = pInicio.clone().startOf('day');

//             // Compara la fecha seleccionada con las fechas de hoy y ayer
//             if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
//                 actualizarGrafico(inicio, fin, "horas");
//             } else {
//                 actualizarGrafico(inicio, fin, "dias");
//             }
//             mostrarRango(inicio, fin);
//         });
// });