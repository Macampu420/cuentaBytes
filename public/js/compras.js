//trae todos los proveedores de la api y los devuelve
let traerProveedores = async () => {
    let resultado = await fetch("http://localhost/cuentabytes/src/controllers/proveedores/apiProveedor.php");

    let proveedores = await resultado.json();
    return proveedores["items"];
    
}

//pone todos los proveedores en el slc
let mostrarProveedores = async () => {
    let slcProveedores = document.getElementById("slcProveedor");
    vProveedores = await traerProveedores();

    vProveedores.forEach(proveedor => {
        slcProveedores.insertAdjacentHTML('beforeend', `<option value="${proveedor.idProveedor}">${proveedor.nombreProveedor}</option>`)
    })
};
