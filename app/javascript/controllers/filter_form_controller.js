import Rails from "@rails/ujs"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "filterForm" ]
  onPostSuccess(event) {
    console.log("success!");
  }

  formSubmit() {
    this.filterFormTarget.submit();
    console.log("success!");
  }
}