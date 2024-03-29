const btnDesplegarAjustes = document.getElementById('btnDesplegarAjustes')
const offcanvasAjustes = new bootstrap.Offcanvas(document.getElementById('offcanvasAjustes'))
let ajustes
const archivoInput = document.getElementById('archivoInput')
const urlBaseAjustes = 'http://localhost:3000'
const traerAjustes = async () => {
  // se consume el API de los ajustes
  const resAjustes = await fetch(`${urlBaseAjustes}/ajustes`)
  ajustes = await resAjustes.json()

  // se pone el nombre de la empresa en el header de la vista
  document.getElementById('pHeader').innerHTML = ajustes.nombreEmpresa
  document.getElementById('inpHoraApertura').value = ajustes.horaApertura
  document.getElementById('inpHoraCierre').value = ajustes.horaCierre
}

const downloadBackup = () => {
  fetch(`${urlBaseAjustes}/backup`)
    .then((response) => {
      if (!response.ok) {
        throw new Error('Error al descargar el archivo de copia de seguridad')
      }

      // Crea un objeto URL para el archivo descargado
      return response.blob()
    })
    .then((blob) => {
      const url = URL.createObjectURL(blob)

      // Crea un enlace para descargar el archivo
      const a = document.createElement('a')
      a.href = url
      a.download = 'cuentabytesEncriptado.sql'
      document.body.appendChild(a)

      // Descarga el archivo
      a.click()

      // Elimina el enlace y el objeto URL
      a.remove()
      URL.revokeObjectURL(url)
    })
    .catch((error) => {
      console.error(error)
      // Maneja el error en caso de que la descarga falle
    })
}

btnDesplegarAjustes.onclick = () => {
  offcanvasAjustes.show()
}

document.getElementById('btnSubirBackup').addEventListener('click', () => {
  const confirmBackup = window.confirm('Al subir el archivo toda la información se restaurará, ¿estás seguro de que quieres continuar?')
  if (confirmBackup) {
    archivoInput.addEventListener('change', () => {
      const archivo = archivoInput.files[0]
      const extension = archivo.name.split('.').pop().toLowerCase()

      if (extension === 'sql') {
        const formData = new FormData()
        formData.append('archivo', archivo)
        // El archivo es un archivo SQL, puedes proceder con las operaciones necesarias
        fetch(`${urlBaseAjustes}/subirBackup`, {
          method: 'POST',
          credentials: 'same-origin',
          body: formData
        })
          .then(response => {
            if (response.status == 200) {
              alert('La copia de datos se ha importado correctamente')
              location.reload()
            } else {

            }
          })
          .catch(error => {
            // Manejar el error
          })
      } else {
        // El archivo no es un archivo SQL, puedes mostrar un mensaje de error al usuario
        window.alert('El archivo no es válido')
      }
    })
    archivoInput.click()
  }
})

document.getElementById('btnCrearBackup').addEventListener('click', () => {
  downloadBackup()
})

document.getElementById('btnEnviarNuevoNombreEmpresa').addEventListener('click', async () => {
  try {
    if (confirm('¿Deseas cambiar el nombre?') == true) {
      const nombreEmpresa = document.getElementById('inpNuevoNombreEmpresa').value
      const horaApertura = ajustes.horaApertura
      const horaCierre = ajustes.horaCierre

      const ajustesEnv = {
        nombreEmpresa,
        horaApertura,
        horaCierre
      }
      const resNuevoNombre = await fetch('http://localhost:3000/cambiarNombre', {
        method: 'POST',
        credentials: 'same-origin',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(ajustesEnv)
      })

      console.log(resNuevoNombre)

      if (resNuevoNombre.status == 200) {
        window.alert('El nombre del negocio se ha actualizado correctamente.')
        location.reload()
      } else {
        window.alert('Ocurrió un error al actualizar el nombre del negocio.')
      }
    }
  } catch (error) {
    console.log(error)
  }
})

document.getElementById('btnEnviarNuevoHoraEmpresa').addEventListener('click', async () => {
  if (confirm('¿Deseas cambiar las horas de atencion?') == true) {
    const nombreEmpresa = ajustes.nombreEmpresa
    const horaApertura = document.getElementById('inpHoraApertura').value
    const horaCierre = document.getElementById('inpHoraCierre').value

    const ajustesEnv = {
      nombreEmpresa,
      horaApertura,
      horaCierre
    }
    const resNuevoHorario = await fetch('http://localhost:3000/cambiarHoras', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(ajustesEnv)
    })
    if (resNuevoHorario.status == 200) {
      window.alert('El horario de atención se ha actualizado correctamente.')
      location.reload()
    } else {
      window.alert('Ocurrió un error al actualizar el horario de atención.')
    }
  }
})

document.addEventListener('DOMContentLoaded', () => traerAjustes())
