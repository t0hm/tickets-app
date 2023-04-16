import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { classroomId: Number };
  static targets = ["tickets"];

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ClassroomChannel", id: this.classroomIdValue },
      { received: data => process(data, this) }
    );
    console.log(`Subscribed to the classroom with the id ${this.classroomIdValue}.`);
  }

  disconnect() {
    this.channel.unsubscribe();
    console.log(`Unsubscribed from the classroom with the id ${this.classroomIdValue}.`);
  }
}

function process(data, lui){
  if (data[0] == "create"){
    console.log(data[1]);
    lui.ticketsTarget.insertAdjacentHTML("beforeend", data[1]);
    location.reload();
  }
  else if (data[0] == "cancel"){
    console.log(data[1]);
    document.querySelector(`#ticket-${data[1]}`).remove();
  }
  else if (data[0] == "valid"){
    console.log(data[1]);
    document.querySelector(`#ticket-${data[1]}`).remove();
  }
}