import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.preview()
    }
    preview(){
        const fileInput = document.getElementById('photo_image_url')
        const labelFileInput = document.getElementById('label_photo_image_url')

        function addFile(){
            const imageContainer = document.querySelector('.edit_photo.image__container')
            const iconLabel1 = document.querySelector('.edit_photo.form-label i')
            let reader_edit_photo = new FileReader()
            if(fileInput.files.length === 1){
                reader_edit_photo.onload = () => {
                    let image_edit_photo = document.createElement("img")
                    image_edit_photo.setAttribute("src",reader_edit_photo.result)

                    let div_edit_photo = document.createElement("div")
                    div_edit_photo.classList.add("edit_photo","image__container","m-3","border")
                    if (iconLabel1 !== null) {
                        iconLabel1.remove()
                    }
                    imageContainer.remove()
                    labelFileInput.appendChild(div_edit_photo)

                    div_edit_photo.appendChild(image_edit_photo)
                    let button = document.createElement("button")
                    button.innerHTML = "X"
                    div_edit_photo.appendChild(button)
                    button.addEventListener('click',(e) =>{
                        let iconLabel = document.createElement("i");
                        iconLabel.classList.add("fa-solid", "fa-plus", "fa-2xl");
                        e.preventDefault();
                        div_edit_photo.remove()
                        labelFileInput.appendChild(iconLabel)

                        let div_edit_photo1 = document.createElement("div")
                        div_edit_photo1.classList.add("edit_photo","image__container","d-none","m-3","border")
                        labelFileInput.appendChild(div_edit_photo1)
                    })
                }
                reader_edit_photo.readAsDataURL(fileInput.files[0])
            }


        }
        fileInput.addEventListener('change', () =>{
            addFile()
        })

        const edit_photo_button = document.querySelector('.edit_photo.form-label button')

        edit_photo_button.addEventListener('click', (e) =>{
            const edit_photo_container = document.querySelector('.edit_photo.image__container')
            const edit_photo_icon_label = document.createElement("i");
            edit_photo_icon_label.classList.add("fa-solid", "fa-plus", "fa-2xl");
            e.preventDefault()
            edit_photo_container.remove()

            let div_edit_photo1 = document.createElement("div")
            div_edit_photo1.classList.add("edit_photo","image__container","d-none","m-3","border")
            labelFileInput.appendChild(edit_photo_icon_label)
            labelFileInput.appendChild(div_edit_photo1)

        })
    }
}
