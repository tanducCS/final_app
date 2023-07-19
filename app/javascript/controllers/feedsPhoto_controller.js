import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.preview()
    }
    preview () {
        // Add click event to show detail images
        const items = document.querySelectorAll(".list-items__item .card .item__images img")
        const myModal = new bootstrap.Modal(document.querySelector('.feeds-photo__model'), {})
        const imageOfModal = document.querySelector('.feeds-photo__model .modal-body img')
        const myModalTitle = document.querySelector('.feeds-photo__model .modal-header h1')
        const myModalDescription = document.querySelector('.feeds-photo__model .modal-body p')
        items.forEach(item => {
            item.addEventListener('click', (event) => {
                const cardBody = item.closest('.card').querySelector('.card-body')
                const text = cardBody.querySelectorAll('.card-text')

                myModalTitle.innerHTML = text[0].innerHTML
                myModalDescription.innerHTML = text[1].innerHTML
                imageOfModal.src = item.src;

                myModal.show();
            })
        })

        //Loading animation
        document.addEventListener('turbo:before-fetch-request', function() {
            const spinner = document.getElementById('feeds_photo_loading');
            spinner.style.display = 'block';
        });

        document.addEventListener('turbo:before-fetch-response', function() {
            const spinner = document.getElementById('feeds_photo_loading');
            spinner.style.display = 'none';
        });
    }
}
