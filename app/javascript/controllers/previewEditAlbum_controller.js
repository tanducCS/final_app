import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.preview()
    }
    preview(){
        let fileInput = document.getElementById('album_images')
        let imagesContainer = document.getElementById("album__images")
        let hiddenField = document.getElementsByClassName("abc")
        const labelFileInput = document.getElementById("new_album__label")
        const listImage = []
        function addFile(){
            for(let i of fileInput.files){
                // push file into list image
                listImage.push(i)
                let reader1 = new FileReader()

                reader1.onload = () => {

                    let image = document.createElement("img")
                    image.setAttribute("src",reader1.result)

                    let div = document.createElement("div")
                    div.classList.add("album","image__container","m-3","border")
                    imagesContainer.insertBefore(div,labelFileInput)

                    div.appendChild(image)
                    let button = document.createElement("button")
                    button.innerHTML = "DELETE"
                    div.appendChild(button)
                    button.addEventListener('click',() =>{
                        div.remove()
                        deleteImageInList(i)
                    })
                }
                reader1.readAsDataURL(i)
            }
        }
        function deleteImageInList(file){
            const index = listImage.findIndex(item => item === file)
            if(index > -1){
                listImage.splice(index,1)
            }
            console.log(listImage)
        }
        fileInput.addEventListener('change', () => {
            addFile()
        })
        let form = document.getElementById("form")
        form.addEventListener('submit',() =>{
            const listFile = fileToInput(listImage)
            fileInput.files = listFile
        })
        function fileToInput(files){
            const b = new ClipboardEvent("").clipboardData || new DataTransfer()
            for (const file of files) b.items.add(file)
            return b.files
        }

        const buttons = document.querySelectorAll('.delete-button')
        console.log(buttons)
        buttons.forEach(button => {
            button.addEventListener('click', () =>{
                const imageContainer = button.closest(".image__container")
                imageContainer.remove()
            })
        })




    }
}
