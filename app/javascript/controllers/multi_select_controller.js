import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="multi-select"
export default class extends Controller {
  static targets = ['search', 'options', 'list', 'item']
  
  connect() {

  }

  search(e) {
    e.preventDefault(); 
    console.log(e);
  }
  
  addItem() {

  }

  removeItem() {

  }
}
