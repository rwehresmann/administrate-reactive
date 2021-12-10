import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  hide () {
    this.element.remove()
  }
}
