let btnDesplegarAjustes = document.getElementById('btnDesplegarAjustes');
var offcanvasAjustes = new bootstrap.Offcanvas(document.getElementById('offcanvasAjustes'));
let ajustes;
btnDesplegarAjustes.onclick = () => {
    offcanvasAjustes.show();
}

let traerAjustes = async () => {
    //se consume el API de los ajustes
    let resAjustes = await fetch('http://localhost:3000/ajustes');
    ajustes = await resAjustes.json();

    //se pone el nombre de la empresa en el header de la vista
    document.getElementById("pHeader").innerHTML = ajustes.nombreEmpresa;
}

document.getElementById('btnEnviarNuevoNombreEmpresa').addEventListener('click', async () => {

    if (confirm("¿Deseas cambiar el nombre?") == true) {
        let nombreEmpresa = document.getElementById('inpNuevoNombreEmpresa').value;
        let horaApertura = ajustes.horaApertura;
        let horaCierre = ajustes.horaCierre;

        let ajustesEnv = {
            nombreEmpresa,
            horaApertura,
            horaCierre
        }
        let resNuevoNombre = await fetch(`http://localhost:3000/cambiarNombre`, {
            method: "POST",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(ajustesEnv)
        });

        if (resNuevoNombre.status == 200) {
            window.alert("El nombre del negocio se ha actualizado correctamente.");
            location.reload();
        }
        else {
            window.alert("Ocurrió un error al actualizar el nombre del negocio.");
        }     
    }
})

document.getElementById('btnEnviarNuevoHoraEmpresa').addEventListener('click', async () => {

    if (confirm("¿Deseas cambiar las horas de atencion?") == true) {
        let nombreEmpresa = ajustes.nombreEmpresa
        let horaApertura = document.getElementById('inpHoraApertura').value;
        let horaCierre = document.getElementById('inpHoraCierre').value;

        let ajustesEnv = {
            nombreEmpresa,
            horaApertura,
            horaCierre
        }
        let resNuevoHorario = await fetch(`http://localhost:3000/cambiarHoras`, {
            method: "POST",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(ajustesEnv)
        });
        if(resNuevoHorario.status == 200){
            window.alert("El horario de atención se ha actualizado correctamente.");
            location.reload();
        }
        else{
            window.alert("Ocurrió un error al actualizar el horario de atención.");
        }
    }
})

document.addEventListener("DOMContentLoaded", () => traerAjustes());