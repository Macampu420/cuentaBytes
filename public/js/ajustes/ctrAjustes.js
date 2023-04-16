let btnDesplegarAjustes = document.getElementById('btnDesplegarAjustes');
var offcanvasAjustes = new bootstrap.Offcanvas(document.getElementById('offcanvasAjustes'));

btnDesplegarAjustes.onclick = () => {
    offcanvasAjustes.show();
}