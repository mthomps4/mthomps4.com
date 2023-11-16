import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="markdown-previewer"
export default class extends Controller {
  static targets = ['body', 'bodyPreview', 'contentButton', 'previewButton'];
  connect() {
    this.preview();
    this.contentButtonTarget.setAttribute('data-active', true);
    this.postId = this.data.get('postId');
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

  // Drag n Drop Image Spike
  dragOver(event) {
    event.preventDefault();
  }

  dragLeave(event) {
    event.preventDefault();
  }

  async drop(event) {
    event.preventDefault();
    const file = event.dataTransfer.files[0];
    const formData = new FormData({id: this.postId});
    formData.append('file', file);

    const response = await fetch('admin/posts/upload_image', {
      method: 'POST',
      headers: {
        // eslint-disable-next-line no-undef -- Rails is defined in application.js
        'X-CSRF-Token': Rails.csrfToken(),
      },
      body: formData,
    });

    const data = await response.json();
    const { url } = data;
    const image = `![${file.name}](${url})`;
    const { selectionStart, selectionEnd } = this.bodyTarget;
    const text = this.bodyTarget.value;
    const before = text.substring(0, selectionStart);
    const after = text.substring(selectionEnd, text.length);
    this.bodyTarget.value.append = `${before}${image}${after}`;
    this.preview();
  }
}
