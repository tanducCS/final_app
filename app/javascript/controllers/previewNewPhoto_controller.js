import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.preview()
    }
    preview(){
        const fileInput = document.getElementById('photo_image_url')
        const labelFileInput = document.getElementById('label_photo_image_url')
        function addFile(){
            const imageContainer = document.querySelector('.new_photo.image__container')
            const iconLabel = document.querySelector('#label_photo_image_url i')
            if(fileInput.files.length === 1){
                let reader_new_photo = new FileReader()
                reader_new_photo.onload = () => {
                    let image_new_photo = document.createElement("img")
                    image_new_photo.setAttribute("src",reader_new_photo.result)

                    let div_new_photo = document.createElement("div")
                    div_new_photo.classList.add("new_photo","image__container","m-3","border")
                    if (iconLabel !== null) {
                        iconLabel.remove()
                    }
                    imageContainer.remove()
                    labelFileInput.appendChild(div_new_photo)

                    div_new_photo.appendChild(image_new_photo)
                    let button = document.createElement("button")
                    button.innerHTML = "X"
                    div_new_photo.appendChild(button)
                    button.addEventListener('click',(event) =>{
                        event.preventDefault();
                        div_new_photo.remove()
                        labelFileInput.appendChild(iconLabel)

                        let div_new_photo1 = document.createElement("div")
                        div_new_photo1.classList.add("new_photo","image__container","d-none","m-3","border")
                        labelFileInput.appendChild(div_new_photo1)
                    })
                }
                reader_new_photo.readAsDataURL(fileInput.files[0])
            }


        }
        fileInput.addEventListener('change', () =>{
            addFile()
        })

    }
}
