import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  hide () {
    console.log("object")
    this.element.remove()
  }
}
