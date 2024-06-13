import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="nav-select"
export default class extends Controller {
  connect() {
    this.element.addEventListener('change', this.routeToSelected);
  }

  routeToSelected(event) {
    const selected = event.target.value;
    console.log({ selected });
    if (selected) {
      window.location.href = selected;
    }
  }
}
