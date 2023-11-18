import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="markdown-previewer"
export default class extends Controller {
  static targets = ['body', 'bodyPreview', 'contentButton', 'previewButton'];

  static values = {
    postId: String,
  };

  connect() {
    this.preview();
    this.contentButtonTarget.setAttribute('data-active', true);
    this.bodyTarget.addEventListener('dragenter', this.dragEnter, false);
    this.bodyTarget.addEventListener('dragexit', this.dragExit, false);
    this.bodyTarget.addEventListener('dragover', this.dragOver, false);
    this.bodyTarget.addEventListener(
      'drop',
      (event) => this.drop(event, this.postIdValue),
      false,
    );
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
  dragEnter(event) {
    // console.log('dragEnter', event);
    event.preventDefault();
  }

  dragOver(event) {
    // console.log('dragOver', event);
    event.preventDefault();
  }

  dragExit(event) {
    // console.log('dragExit', event);
    event.preventDefault();
  }

  async drop(event, postId) {
    event.preventDefault();

    const file = event.dataTransfer.files[0];
    const formData = new FormData();
    formData.append('image', file);

    const response = await fetch(`/admin/drag_upload_image/${postId}`, {
      method: 'POST',
      headers: {
        // eslint-disable-next-line no-undef -- Rails is defined in application.js
        'X-CSRF-Token': Rails.csrfToken(),
      },
      body: formData,
    });

    const data = await response.json();

    console.log({ data });

    this.bodyTarget.value =
      this.bodyTarget.value += `\n\n${data.markdown_link}`;

    await this.preview();

    // const sidebar = this.document.getElementById('post-images-sidebar');
    // sidebar.reload();

    await fetch(`/admin/refresh_sidebar/${postId}`, {
      method: 'POST',
      headers: {
        // eslint-disable-next-line no-undef -- Rails is defined in application.js
        'X-CSRF-Token': Rails.csrfToken(),
      },
    });
  }
}
