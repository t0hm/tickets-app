class ClassroomsController < ApplicationController
    def show
        if !current_user.teacher?
            flash.alert = "Tu n'avais rien à faire ici, petit malin."
            redirect_to root_path
            return
        end
        @classroom = Classroom.find(params[:id])

        if @classroom.id != current_user.classroom_id
            flash.alert = "Tu voulais changer de campus ? :D"
            redirect_to root_path
            return
        end
        
        @tickets = @classroom.tickets.where(status: "pending")
    end
end
