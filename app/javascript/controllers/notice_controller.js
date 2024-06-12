import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="notice"
export default class extends Controller {
  targets = ['alertBox'];
  connect() {}

  alertBoxTargetConnected() {
    setTimeout(() => {
      this.element.remove();
    }, 2000);
  }
}
