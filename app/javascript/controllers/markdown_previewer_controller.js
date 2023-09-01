import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="markdown-previewer"
export default class extends Controller {
  static targets = ['body', 'bodyPreview', 'contentButton', 'previewButton'];
  connect() {
    this.preview();
    this.contentButtonTarget.setAttribute('data-active', true);
  }

  async toggle() {
    this.bodyPreviewTarget.classList.toggle('hidden');
    this.bodyTarget.classList.toggle('hidden');
  }

  async showPreview() {
    this.bodyPreviewTarget.classList.remove('hidden');
    this.bodyTarget.classList.add('hidden');
    this.previewButtonTarget.setAttribute('data-active', true);
    this.contentButtonTarget.setAttribute('data-active', false);
  }

  async hidePreview() {
    this.bodyPreviewTarget.classList.add('hidden');
    this.bodyTarget.classList.remove('hidden');
    this.previewButtonTarget.setAttribute('data-active', false);
    this.contentButtonTarget.setAttribute('data-active', true);
  }

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
