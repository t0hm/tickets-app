import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static values = { classroomId: Number };
  static targets = ["tickets", "myTicket"];

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
    
    console.log("1er : " + lui.myTicketTarget.childElementCount);
    if ((lui.myTicketTarget.childElementCount == 0) && (document.querySelector("#fullname").innerText == data[3])) {
      lui.myTicketTarget.insertAdjacentHTML("beforeend", data[1]);
    }
    console.log("2eme : " + lui.myTicketTarget.childElementCount);
    lui.ticketsTarget.insertAdjacentHTML("beforeend", data[2]);
    console.log(data[0]);
    console.log(data[1]);
    console.log(data[2]);
    console.log(data[3]);
  }
  else if (data[0] == "cancel"){
    console.log(data[0]);
    console.log(data[1]);
    console.log(data[2]);
    console.log(data[3]);
    if (document.querySelector(`#${data[2]}`).id == data[2]) {
      document.querySelector(`#ticket-${data[1]}`).remove();
    }
  }
  else if (data[0] == "valid"){
    console.log(data[1]);
    document.querySelector(`#ticket-${data[1]}`).remove();
  }
}