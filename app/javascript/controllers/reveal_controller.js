//Copied from https://github.com/stimulus-components/stimulus-reveal-controller/blob/master/src/index.ts
// rails g stimulus would hijack imports from yarn packages... :shrug:

import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['item'];
  static classes = ['hidden'];

  connect() {
    this.class = this.hasHiddenClass ? this.hiddenClass : 'hidden';
  }

  toggle() {
    this.itemTargets.forEach((item) => {
      item.classList.toggle(this.class);
    });
  }

  show() {
    this.itemTargets.forEach((item) => {
      item.classList.remove(this.class);
    });
  }

  hide() {
    this.itemTargets.forEach((item) => {
      item.classList.add(this.class);
    });
  }
}
