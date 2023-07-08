const modalBootstrap = new bootstrap.Modal(document.getElementById('modalEgresos'))
const divModal = document.getElementById('modalEgresos')

traerTipoEgreso()
renderEgresos()

document.getElementById('btnAnadirVta').addEventListener('click', event => {
  if (event.target.tagName == 'H3' || event.target.tagName == 'IMG') {
    divModal.setAttribute('editar', false)

    desplegarModal(divModal)
  }
})

document.getElementById('btnAnadir').addEventListener('click', event => {
  if (event.target.tagName == 'H3' || event.target.tagName == 'IMG') {
    renderItem()
  }
})

document.getElementById('contItems').addEventListener('change', (event) => {
  const disparador = event.target

  if (disparador.tagName == 'SELECT' && divModal.getAttribute('editar') == 'false') {
    const item = vItemsEgreso.find(
      // busca en los elementos de la venta actual uno que coincida con el item modificado
      // si no existe se define como undefined
      element => element.idItem == disparador.parentElement.id
    )
    actualizarCrearItem(item, event.target, vItemsEgreso)
  } else if (disparador.tagName == 'SELECT' && divModal.getAttribute('editar') == 'true') {
    const item = vItemsEditar.find(
      // busca en los elementos de la venta actual uno que coincida con el item modificado
      // si no existe se define como undefined
      element => element.idItem == disparador.parentElement.id
    )

    actualizarCrearItem(item, event.target, vItemsEgreso)
  }
})
document.getElementById('rowItems').addEventListener('change', event => {
  vrTotalRegistar()
})

document.querySelector('form').addEventListener('submit', (event) => {
  // evita que la pagina se recargue
  event.preventDefault()

  detalleVenta(vItemsEditar)

  divModal.getAttribute('editar') == 'false' ? registrarEgreso(vItemsEgreso) : console.log('me tengo que actualizar')
  divModal.getAttribute('editar') == 'true' ? actualizarEgreso(vItemsEgreso, vItemsEditar) : console.log('me tengo que actualizar')
})

document.getElementById('contItems').addEventListener('click', (event) => {
  if (event.target.id.includes('dlt')) {
    divModal.getAttribute('editar') == 'true' ? eliminarItem(event.target, vItemsEditar) : eliminarItem(event.target, vItemsEgreso)
  }
})

document.getElementById('filaEgresos').addEventListener('click', async event => {
  if (event.target.hasAttribute('btnAcciones')) {
    divModal.setAttribute('editar', true)

    desplegarModal(divModal, event)
  }
})

document.getElementById('btnEditar').addEventListener('click', () => document.getElementById('btnGuardar').disabled = false)

document.getElementById('btnEliminar').addEventListener('click', async () => {
  idVenta = document.getElementById('btnEliminar').getAttribute('idventa')

  if (confirm('¿Deseas eliminar el egreso?') == true) {
    await fetch(`http://localhost:3000/eliminarEgreso${idVenta}`)
      .then(res => res.text())
      .then(data => console.log(data))

    location.reload()
  }
})

document.getElementById('buscadorEgresos').addEventListener('change', () => {
  const egresos = document.querySelectorAll('[cartaItem]')
  let swNoCoinc = false
  const alert = document.getElementById('alert')

  console.log(alert)

  egresos.forEach(element => {
    const tituloEgreso = element.firstElementChild.innerHTML.toLowerCase()

    if (!tituloEgreso.includes(document.getElementById('buscadorEgresos').value.toLowerCase())) {
      element.classList.add('d-none')
    } else {
      swNoCoinc = true
      element.classList.remove('d-none')
    }
  })

  console.log(egresos)

  if (swNoCoinc == false) {
    // hay coincidencias
    alert.classList.remove('d-none')
  } else {
    alert.classList.add('d-none')
  }
})
