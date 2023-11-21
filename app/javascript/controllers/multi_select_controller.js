import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

// Connects to data-controller="multi-select"
export default class extends Controller {
  static targets = ['search', 'option', 'list', 'item'];

  static values = {
    searchUrl: String,
  };

  connect() {}

  async search(e) {
    e.preventDefault();

    const search = this.searchTarget.value;

    if (search.length > 0) {
      this.listTarget.classList.remove('hidden');
    } else {
      this.listTarget.classList.add('hidden');
    }

    const request = get(`${this.searchUrlValue}?search=${search}`, {
      responseKind: 'turbo-stream',
    });

    await request.perform();
  }

  addItem() {}

  removeItem() {}
}

// if (response.ok) {
//   const text = (await response.isTurboStream())
//     ? response.getTurboStream().getInnerHTML()
//     : await response.text();
//   console.log({ text });
//   return text;
// }

// const response = await fetch(`/play/fetch_tags?search=${search}`, {
//   method: 'GET',
//   headers: {
//     // eslint-disable-next-line no-undef -- Rails is defined in application.js
//     'X-CSRF-Token': Rails.csrfToken(),
//   },
// });

// this.listTarget.innerHTML = await response.text();

// const tag_options = await response.json();

// this.listTarget.innerHTML = '';

// tag_options.forEach((tag) => {
//   const item = document.createElement('li');
//   item.classList.add('search-option');
//   item.innerText = tag.name;
//   item.id = tag.id;
//   item.dataset.action = 'click->multi-select#addItem';
//   this.listTarget.appendChild(item);
// });
