    import { Controller } from "@hotwired/stimulus"

    export default class extends Controller {
        connect() {
            this.preview_and_delete()
        }
        preview_and_delete() {
            let fileInput = document.getElementById("album_images")
            let imagesContainer = document.getElementById("album__images")
            const labelFileInput = document.getElementById("new_album__label")
            const listImage = []
            function preview(){
                for (let i of fileInput.files){
                    listImage.push(i)
                    let reader = new FileReader()
                    reader.onload = () => {
                        let img = document.createElement("img")
                        img.setAttribute("src",reader.result)

                        let div = document.createElement("div")
                        div.classList.add("album","image__container","m-3","border")
                        imagesContainer.insertBefore(div,labelFileInput)

                        div.appendChild(img)
                        let button = document.createElement("button")
                        button.innerHTML = "X"
                        div.appendChild(button)
                        button.addEventListener('click',() =>{
                            div.remove()
                            deleteImageInList(i)
                        })
                        // push file into list image
                    }
                    reader.readAsDataURL(i)
                }
            }
            function deleteImageInList(file){
                const index = listImage.findIndex(item => item === file)
                if(index > -1){
                    listImage.splice(index,1)
                }
            }
            fileInput.addEventListener('change', () => {
                preview()
            })

            let form = document.getElementById("form1")
            form.addEventListener('submit',() =>{
                const listFile = fileToInput(listImage)
                fileInput.files = listFile
            })
            function fileToInput(files){
                const b = new ClipboardEvent("").clipboardData || new DataTransfer()
                for (const file of files) b.items.add(file)
                return b.files

            }

        }

    }
