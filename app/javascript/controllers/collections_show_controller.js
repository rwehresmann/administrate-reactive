import ApplicationController from "./application_controller"

export default class extends ApplicationController {
  sort(event) {
    event.preventDefault();

    this.stimulate("CollectionShowReflex#sort", event.currentTarget);
  }
}
