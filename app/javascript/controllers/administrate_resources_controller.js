import ApplicationController from "./application_controller";
import consumer from "../channels/consumer";
import CableReady from "cable_ready";

export default class extends ApplicationController {
  destroy(event) {
    event.preventDefault();
    const confirmation = confirm("Are you sure?");

    if (confirmation) {
      this.stimulate("AdminResourceReflex#destroy", event.currentTarget);
    }
  }
}
