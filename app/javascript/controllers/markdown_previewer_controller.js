import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="markdown-previewer"
export default class extends Controller {
  static targets = ['body', 'bodyPreview'];
  connect() {}
  async preview() {
    const markdown = this.bodyTarget.value;

    // I could optionally have a JS package here -- but I already had something set in Rails Helpers
    const response = await fetch('/parse_markdown', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        // eslint-disable-next-line no-undef -- Rails is defined in application.js
        'X-CSRF-Token': Rails.csrfToken(),
      },
      body: JSON.stringify({ markdown }),
    });

    const data = await response.json();
    const { parsed } = data;
    this.bodyPreviewTarget.innerHTML = parsed;
  }
}

// ![My Feature Image](https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg)
