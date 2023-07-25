import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input","suggestions"];
    connect() {
        console.log("Connected?");
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
}
