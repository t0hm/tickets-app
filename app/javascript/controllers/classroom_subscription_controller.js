import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { classroomId: Number }
  static targets = ["tickets"]

  connect() {
    console.log(`Subscribe to the classroom with the id ${this.classroomIdValue}.`)
  }
}