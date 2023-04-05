let nombresSecciones = ['Mejores clientes', 'Productos mas vendidos', "Productos menos vendidos", "Productos mas rentables",
    "Mayor egreso", "Menor egreso", "Producto con mayor stock", "Producto con menor stock"];

nombresSecciones.forEach((elemento, i) => {
   if(i == 0){
        document.getElementById('acordeonBalances').insertAdjacentHTML('beforeend', `
        <div class="accordion-item">
            <h2 class="accordion-header" id="titulo${i}">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#item${i}" aria-expanded="true" aria-controls="item${i}">
                ${elemento}
            </button>
            </h2>
            <div id="item${i}" class="accordion-collapse collapse show" aria-labelledby="titulo${i}" data-bs-parent="#accordionExample">
            <div class="accordion-body">
                <strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
            </div>
            </div>
        </div>
        `);
   } else {
        document.getElementById('acordeonBalances').insertAdjacentHTML('beforeend', `
        <div class="accordion-item">
            <h2 class="accordion-header" id="titulo${i}">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#item${i}" aria-expanded="true" aria-controls="item${i}">
                ${elemento}
            </button>
            </h2>
            <div id="item${i}" class="accordion-collapse collapse" aria-labelledby="titulo${i}" data-bs-parent="#accordionExample">
            <div class="accordion-body">
                <strong>This is the first item's accordion body.</strong> It is shown by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
            </div>
            </div>
        </div>
        `);
   }
});
