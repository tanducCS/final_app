import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"; // Import Turbo object
export default class extends Controller {
    static targets = ["input","suggestions"];
    connect() {
        console.log("Connected")
        // Add event when change in DOM
        const container = document.querySelector('#suggestions')
        const observer = new MutationObserver((mutationsList) => {
            for (const mutation of mutationsList) {
                if (mutation.type === 'childList') {
                    // Các thay đổi trong DOM đã xảy ra (thêm hoặc xóa phần tử)
                    this.addClickEventToSearch();
                }
            }
        });

        const observerOptions = {
            childList: true, // Giám sát thay đổi trong con của container
        };

        observer.observe(container, observerOptions);


        document.addEventListener("click", (event) => {
            if (!this.element.contains(event.target)) {
                this.hideSuggestions();
            }
        });


    }
    suggestions(){
        const query = this.inputTarget.value
        const url = this.element.dataset.suggestionsUrl
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            this.requestSuggestions(query,url)
        }, 250)

    }
    async requestSuggestions(query, url){
        if(query.length === 0){
            this.hideSuggestions();
            return
        }
        this.showSuggestions()

        try {
            const response = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
                },
                body: JSON.stringify({ query: { title_or_description_cont: query },type: url === '/search/album/suggestions' ? 'album' : 'photo' }),
            });

            const html = await response.text();
            const suggestions = document.querySelector("#suggestions");
            suggestions.insertAdjacentHTML("beforeend", html);
            // Gán sự kiện click cho suggestion-container sau khi chèn vào DOM


        } catch (error) {
            console.error("Đã xảy ra lỗi:", error);
        }
    }

    childClicked(event) {
        this.childWasClicked = this.element.contains(event.target);
    }
    showSuggestions(){
        this.suggestionsTarget.classList.remove("visually-hidden")
    }
    hideSuggestions() {
        if (!this.childWasClicked) {
            this.suggestionsTarget.classList.add("visually-hidden");
        }
        this.childWasClicked = false;
    }

    // Click will show modal
    addClickEventToSearch(){
        const url = this.element.dataset.suggestionsUrl

        if(url === '/search/album/suggestions'){
            const items = document.querySelectorAll('.suggestion-container')
            const myModal = new bootstrap.Modal(document.querySelector('.feeds-album__modal'), {})
            const myModalTitle = document.querySelector('.feeds-album__modal .modal-header h1')
            const myModalDescription = document.querySelector('.feeds-album__modal .modal-body p')
            const carouselSlide = document.querySelector('.carousel.slide')
            const closeButton = document.getElementById('close__button-modal')
            closeButton.addEventListener('click', () => {
                myModal.hide()
            })
            items.forEach(item => {
                const title = item.querySelectorAll('.suggestion-container__detail p')[0]
                const description = item.querySelectorAll('.suggestion-container__detail p')[1]
                if(!item.hasAttribute('data-click-event-added')) {
                    item.setAttribute('data-click-event-added', 'true'); // Thêm thuộc tính để đánh dấu sự kiện đã được thêm
                    item.addEventListener('click', () => {
                        const carouselInner = document.querySelector('.carousel-inner')
                        // remove carousel container images
                        carouselInner.remove()
                        // create carousel container images
                        const carouselInnerNew = document.createElement("div")
                        carouselInnerNew.classList.add("carousel-inner")
                        // append new carousel inner in carousel slide
                        carouselSlide.insertBefore(carouselInnerNew,carouselSlide.children[0])

                        const images = item.querySelectorAll('.suggestion-container__img img')
                        console.log(images)
                        myModalTitle.innerHTML = title.innerHTML
                        myModalDescription.innerHTML = description.innerHTML

                        for(let index = 0; index < images.length; index++){
                            const carouselItem = document.createElement("div")
                            carouselItem.classList.add("carousel-item")
                            if (index === 0){
                                carouselItem.classList.add("active")
                            }
                            const img = document.createElement("img")
                            img.classList.add("d-block")
                            img.src = images[index].src

                            carouselItem.appendChild(img)
                            carouselInnerNew.appendChild(carouselItem)
                        }

                        myModal.show();
                    })

                }
            })
        }
        else{
            const myModal = new bootstrap.Modal(document.querySelector('.feeds-photo__model'), {})
            const imageOfModal = document.querySelector('.feeds-photo__model .modal-body img')
            const myModalTitle = document.querySelector('.feeds-photo__model .modal-header h1')
            const myModalDescription = document.querySelector('.feeds-photo__model .modal-body p')
            const items = document.querySelectorAll('.suggestion-container')
            const closeButton = document.getElementById('close__button-modal')
            closeButton.addEventListener('click', () => {
                myModal.hide()
            })
            items.forEach(item => {
                const title = item.querySelectorAll('.suggestion-container__detail p')[0]
                const description = item.querySelectorAll('.suggestion-container__detail p')[1]
                const image = item.querySelector('.suggestion-container__img img')
                if(!item.hasAttribute('click-event-search-item')){
                    item.setAttribute('click-event-search-item','true')
                    item.addEventListener('click',()=>{
                        myModalTitle.innerHTML = title.innerHTML
                        myModalDescription.innerHTML = description.innerHTML
                        imageOfModal.src = image.src
                        myModal.show()
                    })
                }
            })
        }

    }
}
