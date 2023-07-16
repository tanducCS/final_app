import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.preview()
    }
    preview () {
        const fileInput = document.getElementById('user_avatar_url')
        const labelInput = document.getElementById('input__label')
        const imageInput = document.getElementById('input__image')

        fileInput.addEventListener('change', () => {
            let reader = new FileReader()
            reader.onload = () => {
                imageInput.setAttribute("src", reader.result)
            }
            console.log(fileInput.files)
            reader.readAsDataURL(fileInput.files[0])
        })
}
}
