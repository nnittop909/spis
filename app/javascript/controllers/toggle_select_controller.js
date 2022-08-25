import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["element", "select"]

  connect() {
    if (this.hasSelectTarget) {
      this.toggle(this.elementTarget, this.elementTarget.dataset.values, this.selectTarget.value);
    }
    if (this.hasSelectTargets) {
      for (let select of this.selectTargets) {
        this.toggle(this.elementTarget, this.elementTarget.dataset.values, select.value);
      }
    }
  }

  changed(event) {
    if (this.hasElementTarget) {
      this.toggle(this.elementTarget, this.elementTarget.dataset.values, event.target.value);
    }
    if (this.hasElementTargets) {
      for (let element of this.elementTargets) {
        this.toggle(element, element.dataset.values, event.target.value);
      }
    }
  }

  toggle(element, values, value) {
    if (element && values) {
      let hidden = true;
      for (let _value of values.split(",")) {
        if (_value === value) {
          hidden = false;
        }
      }
      element.hidden = hidden;
    }
  }

}