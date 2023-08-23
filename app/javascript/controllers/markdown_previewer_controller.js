import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="markdown-previewer"
export default class extends Controller {
  static targets = ['body', 'bodyPreview'];
  connect() {}
  async preview() {
    const markdown = this.bodyTarget.value;

    console.log({ markdown });

    const response = await fetch('/parse_markdown', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        // eslint-disable-next-line no-undef -- Rails is defined in application.js
        'X-CSRF-Token': Rails.csrfToken(),
      },
      body: JSON.stringify({ markdown }),
    });

    console.log({ response });

    const data = await response.json();
    const { parsed } = data;
    this.bodyPreviewTarget.innerHTML = parsed;

    // this.bodyPreviewTarget.innerText = this.bodyTarget.value;
  }
}

// ![My Feature Image](https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg)
