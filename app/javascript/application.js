// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


const items = document.querySelectorAll(".list-items__item .card .item__images img")

const myModal = new bootstrap.Modal(document.getElementById('exampleModal'), {})
const imageOfModal = document.querySelector('#exampleModal .modal-body img')


items.forEach(item => {
    item.addEventListener('click', () => {
        imageOfModal.src = item.src;
        myModal.show();
    })
})


const input1 = document.querySelector("#photo_image_url");
input1.addEventListener('change', () => {
    console.log(input1)
})