import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.preview()
        const container = document.querySelector(".list-items");
        const observer = new MutationObserver((mutationsList) => {
            for (const mutation of mutationsList) {
                if (mutation.type === 'childList') {
                    // Các thay đổi trong DOM đã xảy ra (thêm hoặc xóa phần tử)
                    this.addClickEventToImage();
                }
            }
        });

        const observerOptions = {
            childList: true, // Giám sát thay đổi trong con của container
        };

        observer.observe(container, observerOptions);
    }
    preview () {
        // Add click event to show detail images
        this.addClickEventToImage()


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
    addClickEventToImage(){
        const items = document.querySelectorAll(".list-items__item .card .item__images img")
        const myModal = new bootstrap.Modal(document.querySelector('.feeds-photo__model'), {})
        const imageOfModal = document.querySelector('.feeds-photo__model .modal-body img')
        const myModalTitle = document.querySelector('.feeds-photo__model .modal-header h1')
        const myModalDescription = document.querySelector('.feeds-photo__model .modal-body p')
        const closeButton = document.getElementById('close__button-modal')
        closeButton.addEventListener('click', () => {
            myModal.hide()
        })

        items.forEach(item => {
            if(!item.hasAttribute('data-click-event-added')){
                item.setAttribute('data-click-event-added', 'true'); // Thêm thuộc tính để đánh dấu sự kiện đã được thêm
                item.addEventListener('click', (event) => {
                    const cardBody = item.closest('.card').querySelector('.card-body')
                    const text = cardBody.querySelectorAll('.card-text')
                    myModalTitle.innerHTML = text[0].innerHTML
                    myModalDescription.innerHTML = text[1].innerHTML
                    imageOfModal.src = item.src;
                    myModal.show();
                })
            }
        })
    }


}
