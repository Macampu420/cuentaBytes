const renderNotas = async () => {
    await fetch("http://localhost:3000/listarNotas")
        .then(res => res.json())
        .then(data => {

            //se da formato a la fecha y se empuja cada item en el vector indicado
            data[0].forEach(element => {

                element.fechaEgreso = element.fechaEgreso.slice(0, 10);

                vObjsEncEgreso.push(element);
            })
        })
        .catch((error) => {
            console.log(error)
        });
}

const registrarNota = async () =>{
    let tituloNota = document.getElementById("inpTituloNota").value;
    let cuerpoNota = document.getElementById("inpCuerpoNota").value;

    let notaActual = {
        tituloNota,
        cuerpoNota
    };

    console.log(notaActual);

    await fetch('http://localhost:3000/registrarNota', {
        method: "POST",
        credentials: "same-origin",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(notaActual)
    })
        .then(response => response.text())
        .then(mensaje => {
            alert(mensaje);
            location.reload();
        })
        .catch(err => {
            alert("Ha ocurrido un error registrando la nota, por favor intentalo mas tarde");
            location.reload();
        });

}