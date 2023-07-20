import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.preview()
    }
    preview () {
        // Add click event to show detail images
        const albumContainer = document.querySelectorAll(".list-items__item .card .item__images")
        const myModal = new bootstrap.Modal(document.querySelector('.feeds-album__modal'), {})
        const myModalTitle = document.querySelector('.feeds-album__modal .modal-header h1')
        const myModalDescription = document.querySelector('.feeds-album__modal .modal-body p')
        const carouselSlide = document.querySelector('.carousel.slide')

        albumContainer.forEach(items => {
            items.addEventListener('click', (event) => {
                const carouselInner = document.querySelector('.carousel-inner')
                // remove carousel container images
                carouselInner.remove()
                // create carousel container images
                const carouselInnerNew = document.createElement("div")
                carouselInnerNew.classList.add("carousel-inner")
                // append new carousel inner in carousel slide
                carouselSlide.insertBefore(carouselInnerNew,carouselSlide.children[0])

                const cardBody = items.closest('.card').querySelector('.card-body')
                const text = cardBody.querySelectorAll('.card-text')
                myModalTitle.innerHTML = text[0].innerHTML
                myModalDescription.innerHTML = text[1].innerHTML
                console.log(items.children[0].src)
                for(let index = 0; index < items.children.length; index++){
                    const carouselItem = document.createElement("div")
                    carouselItem.classList.add("carousel-item")
                    if (index === 0){
                        carouselItem.classList.add("active")
                    }
                    const img = document.createElement("img")
                    img.classList.add("d-block")
                    img.src = items.children[index].src

                    carouselItem.appendChild(img)
                    carouselInnerNew.appendChild(carouselItem)
                }

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
