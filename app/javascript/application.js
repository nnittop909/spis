import "@hotwired/turbo-rails"
Turbo.session.drive = false
// require("@rails/activestorage").start();
import "controllers"
import "@popperjs/core"
import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap
import {far} from "@fortawesome/free-regular-svg-icons"
import {fas} from "@fortawesome/free-solid-svg-icons"
import {fab} from "@fortawesome/free-brands-svg-icons"
import {library} from "@fortawesome/fontawesome-svg-core"
import "@fortawesome/fontawesome-free"
library.add(far, fas, fab)

// new SlimSelect({
//   select: '#committee-merge-from'
// })

// new SlimSelect({
//   select: '#committee-merge-to'
// })