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

document.addEventListener("DOMContentLoaded", () => traerAjustes());