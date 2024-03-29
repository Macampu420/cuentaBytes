const vObjsNotas = []
let vItemNota = []

const renderizarNotas = async () => {
  await fetch('http://localhost:3000/listarNotas')
    .then(res => res.json())
    .then(data => {
      // se da formato a la fecha y se empuja cada item en el vector indicado
      data.forEach(element => {
        vObjsNotas.push(element)
      })
    })
    .catch((error) => {
      console.log(error)
    })

  if (vObjsNotas.length > 0) {
    vObjsNotas.forEach(element => {
      document.getElementById('filaNotas').insertAdjacentHTML('beforeend', `

            <div id="${element.idNota}" cartaItemNota="true" class="card shadow col-6 mx-auto my-3 my-lg-3" style="width: 18rem;" role="button">
            <div class="card-body mt-2 mx-auto">
                <h5 btnAcciones idNota="${element.idNota}" class="puntosAcciones m-2 w-25">...</h5>
                <h5 class="text-center" idNota="${element.idNota}">${element.tituloNota}</h5>
                <h5 class="text-center" idNota="${element.idNota}">${element.contenidoNota}</h5>
            </div>
        </div>
    
            `)
    }

    )
  } else {
    document.getElementById('filaNotas').innerHTML = "<h2 class='text-center'>No hay Notas registradas.</h2/>"
  }
}

const registrarNota = async () => {
  const tituloNota = document.getElementById('inpTituloNota').value
  const cuerpoNota = document.getElementById('inpCuerpoNota').value

  const notaActual = {
    tituloNota,
    cuerpoNota
  }

  console.log(notaActual)

  await fetch('http://localhost:3000/registrarNota', {
    method: 'POST',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(notaActual)
  })
    .then(response => response.text())
    .then(mensaje => {
      alert(mensaje)
      location.reload()
    })
    .catch(err => {
      alert('Ha ocurrido un error registrando la nota, por favor intentalo mas tarde')
      location.reload()
    })
}

const desplegarModalNotas = (modal, event) => {
  // configura el modal dependiendo del estado editar
  if (modal.getAttribute('editar') == 'true') {
    modalEditarNota(event)
  }
  // se muestra el modal
  modalAgregarNota.show()
}

document.getElementById('buscadorNotas').addEventListener('change', () => {
  const notas = document.querySelectorAll('[cartaItemNota]')
  let swNoCoinc = false
  const alert = document.getElementById('alertNoNotas')

  console.log(alert)

  notas.forEach(element => {
    const tituloNota = element.firstElementChild.innerHTML.toLowerCase()

    if (!tituloNota.includes(document.getElementById('buscadorNotas').value.toLowerCase())) {
      element.classList.add('d-none')
    } else {
      swNoCoinc = true
      element.classList.remove('d-none')
    }
  })

  console.log(notas)

  if (swNoCoinc == false) {
    // hay coincidencias
    alert.classList.remove('d-none')
  } else {
    alert.classList.add('d-none')
  }
})

const modalEditarNota = async event => {
  document.getElementById('divAccionesNotas').classList.remove('d-none')
  // desabilita el btn guardar que se habilitara cuando el usuario clickee editar
  document.getElementById('btnGuardarNotas').disabled = true
  // cambia el valor del btn actualizar
  document.getElementById('btnGuardarNotas').innerHTML = 'Actualizar'

  const idNota = event.target.getAttribute('idNota')

  document.getElementById('btnGuardarNotas').setAttribute('idNota', idNota)
  document.querySelector('form').setAttribute('idNota', idNota)

  // trae la venta (enc y dets) para renderizarlos
  await fetch(`http://localhost:3000/listarUnaNota${idNota}`)
    .then(res => res.json())
    .then(data => {
      vItemNota = data
    })
    .catch(e => console.log(e))

  document.getElementById('inpTituloNota').value = vItemNota[0].tituloNota
  document.getElementById('inpCuerpoNota').value = vItemNota[0].contenidoNota

  document.getElementById('btnEliminarNotas').setAttribute('idNota', vItemNota[0].idNota)
}

const actualizarNota = async (idNota) => {
  const tituloNota = document.getElementById('inpTituloNota').value
  const cuerpoNota = document.getElementById('inpCuerpoNota').value
  const notaEditar = {
    idNota,
    tituloNota,
    cuerpoNota
  }

  await fetch('http://localhost:3000/actualizarNota', {
    method: 'POST',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(notaEditar)
  })
    .then(response => response.text())
    .then(mensaje => {
      alert(mensaje)
      location.reload()
    })
    .catch(err => {
      alert('Ha ocurrido un error registrando la nota, por favor intentalo mas tarde')
      location.reload()
    })
}
