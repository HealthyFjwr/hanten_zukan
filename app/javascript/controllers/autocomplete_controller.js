import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]

  search(){
    clearTimeout(this.timer)

    this.timer = setTimeout(() => {
      const keyword = this.inputTarget.value

      // 空のときは処理しない
      if (keyword === "") {
        this.listTarget.innerHTML = ""
        this.listTarget.classList.add("hidden")
        return
      }

      fetch(`/restaurants/autocomplete?keyword=${keyword}`)
        .then(res => res.json())
        .then(data => {
          this.listTarget.innerHTML = ""

          data.forEach(restaurant => {
            const li = document.createElement("li")
            li.textContent = restaurant.name
            li.classList.add("px-4", "py-2", "hover:bg-gray-100", "cursor-pointer")
            this.listTarget.appendChild(li)
          })

          this.listTarget.classList.remove("hidden")
        })
    }, 300);
  }
}