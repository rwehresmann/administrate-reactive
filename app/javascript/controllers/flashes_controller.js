import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  remove() {
    this.element.remove()
  }
}
