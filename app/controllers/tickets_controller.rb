class TicketsController < ApplicationController
    def redirect
        classroom_id = current_user.classroom_id
        redirect_to new_classroom_ticket_path(classroom_id) if current_user.student?
        redirect_to classroom_path(classroom_id) if current_user.teacher?
    end

    def new
        if !current_user.student?
            flash.alert = "Tu voulais retourner à l'école ? :D"
            redirect_to root_path
            return
        end
        
        @classroom = Classroom.find(params["classroom_id"])
        @tickets = @classroom.tickets.where(status: "pending")

        if @classroom.id != current_user.classroom_id
            flash.alert = "Tu voulais changer de campus ? :D"
            redirect_to root_path
            return
        end

        @last_ticket = current_user.tickets.where(status: "pending").last
        @ticket = Ticket.new
    end

    def create
        if current_user.tickets.last.nil?
            # rien mais on passe, ça évite l'erreur du "no method pending? for nilclass"
        elsif current_user.tickets.last.pending?
            flash.alert = "Annule d'abord ton ticket avant d'en recréer un STP"
            redirect_to root_path    
            return
        end

        @classroom = Classroom.find(params[:classroom_id])
        @ticket = Ticket.new(ticket_params)
        @ticket.classroom = @classroom
        @ticket.user = current_user
        @ticket.status = 0
        if @ticket.save

            ClassroomChannel.broadcast_to(
                @classroom, 
                ["create", render_to_string(partial: "myticket", locals: {last_ticket: @ticket}), render_to_string(partial: "ticket", locals: {ticket: @ticket}), current_user.fullname]
            )   
            head :ok
            #render_to_string(partial: "myticket", locals: {ticket: @ticket})
            #redirect_to new_classroom_ticket_path(@classroom)
        else
            render new_classroom_ticket_path(@classroom), status: :unprocessable_entity
        end
    end

    def ending_ticket
        if !current_user.teacher?
            redirect_to root_path 
            return
        end

        ticket = Ticket.find(params[:id])

        if !ticket.pending?
            flash.alert = "#{ticket.user.prenom.capitalize} a annulé son ticket."
            redirect_to root_path 
            return
        end

        ticket.status = 1
        if ticket.save
            ClassroomChannel.broadcast_to(
                ticket.classroom, 
                ["valid", ticket.id, current_user.fullname]
            )
            head :ok
            #redirect_to classroom_path(ticket.classroom)
        end
    end

    def cancel_ticket
        if !current_user.student?
            redirect_to root_path 
            return
        end
        
        ticket = Ticket.find(params[:id])
        
        if current_user != ticket.user
            flash.alert = "Petit malin.. :p"
            redirect_to root_path 
            return
        end

        if !ticket.pending?
            flash.alert = "Ce ticket a été validé par un formateur"
            redirect_to root_path 
            return
        end

        ticket.status = 2
        if ticket.save
            ClassroomChannel.broadcast_to(
                ticket.classroom, 
                ["cancel", ticket.id, current_user.fullname_tojs]
            )
            head :ok
            #redirect_to root_path 
        end
    end

    private

    def ticket_params
        params.require(:ticket).permit(:content)
    end
end
