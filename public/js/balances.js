const ctx = document.getElementById('myChart');
let inicio, fin, dias;

let chart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: [],
        datasets: [{
            data: [],
            borderWidth: 1
        }, 
        {
            data: [],
            borderWidth: 1
        },
        {
            data: [],
            borderWidth: 1
        },]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        },
        plugins: {
            tooltip: {
                callbacks: {
                    title: function (tooltipItem) {
                        return tooltipItem[0].dataset.conceptos[tooltipItem[0].dataIndex];
                    }
                }
            }
        }
    }
});

$(function () {

    let start = moment().subtract(29, 'days');
    let end = moment();
    let mostrarCompras = (vector) => {
        let vAux = vector[0].map(elemento => elemento.fechaCompra.slice(0, 10));
            chart.data.labels = chart.data.labels.concat(vAux);
            chart.data.datasets[0].data = vector[0].map(elemento => elemento.total);
            chart.data.datasets[0].label = 'Compra materia prima';
            chart.data.datasets[0].conceptos = vector[0].map(elemento => elemento.conceptoCompra)
    }

    let mostrarEgresos = (vector) => {
            chart.data.datasets[1].labels = vector[1].map(elemento => elemento.fechaEgreso.slice(0, 10));
            chart.data.datasets[1].data = vector[1].map(elemento => elemento.total);
            chart.data.datasets[1].label = 'Egresos';
            chart.data.datasets[1].conceptos = vector[1].map(elemento => elemento.tituloVenta)
    }

    let mostrarVentas = (vectorDatos) => {

            console.log(vectorDatos.ventas.map(elemento => elemento));

            chart.data.labels = vectorDatos.ventas.map(elemento => elemento.hora);

            chart.data.datasets[0].data = vectorDatos.compras.map(elemento => elemento.vrTotalHora);
            chart.data.datasets[0].label = 'Compras';
            chart.data.datasets[0].conceptos = vectorDatos.compras.map(elemento => elemento.hora)

            chart.data.datasets[2].data = vectorDatos.ventas.map(elemento => elemento.vrTotalHora);
            chart.data.datasets[2].label = 'Ventas';
            chart.data.datasets[2].conceptos = vectorDatos.ventas.map(elemento => elemento.hora);

            console.log(chart.data.datasets[2]);
    }

    let actualizarGrafico = async (inicio, fin, tiempo) => {
        
        let resGraficos = await fetch(`http://localhost:3000/graficos${tiempo}`, {
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

        mostrarVentas(datosGraficos);
        
        chart.update();

    }

    let mostrarRango = (start, end) => {
        document.querySelector('#spanFechaGrafico').innerHTML = ('Generar Estado PyG desde: ' + start + '. Hasta: ' + end);
    }

    mostrarRango(start.format('YYYY-MM-DD'), end.format('YYYY-MM-DD'));
    actualizarGrafico(start.format('YYYY-MM-DD'), end.format('YYYY-MM-DD'));

    $('#reportrange').daterangepicker({
        startDate: start,
        endDate: end,
        locale: {
            format: "YYYY-MM-DD"
        },
        ranges: {
            'Hoy': [moment(), moment()],
            'Ayer': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Ultimos 7 dias': [moment().subtract(6, 'days'), moment()],
            'Ultimos 30 dias': [moment().subtract(29, 'days'), moment()],
            'Este mes': [moment().startOf('month'), moment().endOf('month')],
            'Ultimo mes': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    }, async function (start, end) {
        inicio = start.format('YYYY-MM-DD');
        fin = end.format('YYYY-MM-DD');

        let hoy = moment();
        let ayer = moment().subtract(1, 'days');
        let fechaSeleccionada = start.clone().startOf('day');
        
        // Compara la fecha seleccionada con las fechas de hoy y ayer
        if (fechaSeleccionada.isSame(hoy, 'd') || fechaSeleccionada.isSame(ayer, 'd')) {
            actualizarGrafico(inicio, fin, "horas");
        } else {
            actualizarGrafico(inicio, fin, "dias");
        }
        mostrarRango(inicio, fin);
    });
});