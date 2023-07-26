// hello_controller.js
import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['name', 'output'];

  greet() {
    console.log('HERE');
    this.outputTarget.textContent = `Hello, ${this.nameTarget.value}!`;
  }
}
