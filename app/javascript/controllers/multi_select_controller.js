import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

// Connects to data-controller="multi-select"
export default class extends Controller {
  static targets = [
    'search',
    'option',
    'list',
    'selectedTag',
    'selectedTagIds',
  ];

  static values = {
    searchUrl: String,
    updateSelectedUrl: String,
  };

  connect() {
    document.addEventListener('click', this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener('click', this.handleClickOutside.bind(this));
  }

  handleClickOutside(e) {
    if (!this.element.contains(e.target)) {
      this.listTarget.classList.add('hidden');
    }
  }

  async search(e) {
    e.preventDefault();

    const search = this.searchTarget.value;

    if (search.length > 0) {
      this.listTarget.classList.remove('hidden');
    } else {
      this.listTarget.classList.add('hidden');
    }

    const selectedIds = this.selectedOptionTargets
      ? this.selectedOptionTargets.map((options) => options.id)
      : [];

    const request = get(
      `${this.searchUrlValue}?search=${search}?selected=${[selectedIds]}`,
      {
        responseKind: 'turbo-stream',
      },
    );

    await request.perform;
  }

  async addItem(e) {
    e.preventDefault();

    const selectedId = this.optionTarget.dataset.id;
    const previouslySelectedIds = this.selectedTagTargets.map(
      (options) => options.id,
    );
    const selectedIds = [selectedId, ...previouslySelectedIds];
    const arrayString = selectedIds.join(',');

    // UPDATE THE REAL FORM VALUE
    this.selectedTagIdsTarget.value = arrayString;
    // UPDATE THE UI
    this.listTarget.classList.add('hidden');
    this.searchTarget.value = '';

    const request = get(
      `${this.updateSelectedUrlValue}?selected=${arrayString}`,
      {
        responseKind: 'turbo-stream',
      },
    );

    await request.perform;
  }

  async removeItem(e) {
    e.preventDefault();
    const selectedId = this.selectedTagTarget.dataset.id;
    const previouslySelectedIds = this.selectedTagTargets.map(
      (options) => options.id,
    );

    const selectedIds = previouslySelectedIds.filter((id) => id !== selectedId);
    const arrayString = selectedIds.join(',');

    // UPDATE THE REAL FORM VALUE
    this.selectedTagIdsTarget.value = arrayString;

    const request = get(
      `${this.updateSelectedUrlValue}?selected=${arrayString}`,
      {
        responseKind: 'turbo-stream',
      },
    );
    await request.perform;
  }
}
