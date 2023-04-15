class ClassroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    classroom = Classroom.find(params[:id])
    stream_from classroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
