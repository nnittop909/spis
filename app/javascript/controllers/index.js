import { application } from "controllers/application"

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import RemoteModalController from "./remote_modal_controller.js"
application.register("remote-modal", RemoteModalController)

import VisibilityController from "./visibility_controller.js"
application.register("visibility", VisibilityController)

import ToggleSelectController from "./toggle_select_controller.js"
application.register("toggle-select", ToggleSelectController)

import FilterFormController from "./filter_form_controller.js"
application.register("filter-form", FilterFormController)

// import HelloController from "./hello_controller.js"
// application.register("hello", HelloController)

// import StimulusSlimSelect from "stimulus-slimselect"
// application.register('slimselect', StimulusSlimSelect)