import Rails from "@rails/ujs"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form" ]
  onPostSuccess(event) {
    console.log("success!");
  }

  formSubmit() {
    Rails.fire(this.formTarget, 'submit');
    console.log("success!");
  }
}