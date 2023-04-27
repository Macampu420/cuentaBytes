let btnDesplegarAjustes = document.getElementById('btnDesplegarAjustes');
var offcanvasAjustes = new bootstrap.Offcanvas(document.getElementById('offcanvasAjustes'));

btnDesplegarAjustes.onclick = () => {
    offcanvasAjustes.show();
}

let traerAjustes = async () => {
    let resAjustes = await fetch('http://localhost:3000/ajustes');
    let ajustes = await resAjustes.json();

    document.getElementById("pHeader").innerHTML = ajustes.nombreEmpresa;
}

document.addEventListener("DOMContentLoaded", () => {traerAjustes()});