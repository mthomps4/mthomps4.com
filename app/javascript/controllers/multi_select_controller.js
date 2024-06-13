import { Controller } from '@hotwired/stimulus';
import TomSelect from 'tom-select';

// Connects to data-controller="multi-select"
export default class extends Controller {
  connect() {
    this.initializeTomSelect();
  }

  initializeTomSelect() {
    if (!this.element) return;

    this.element.setAttribute('multiple', true);
    this.select = new TomSelect(this.element, {
      sortField: {
        field: 'text',
        direction: 'asc',
      },
      hideSelected: true,
      plugins: ['remove_button', 'clear_button'],
      placeholder: 'Select options...',
      valueField: 'value',
      labelField: 'name',
      searchField: ['name'],
    });
  }
}
