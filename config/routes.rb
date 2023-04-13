Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tickets#redirect"
  # get "/:classroom/:prenomnom/ticket", to: 'tickets#new'
  # get "/:classroom/tickets", to: 'tickets#index'
  resources :classrooms, only: :show do
    resources :tickets, only: [:index, :create, :new]
  end

  post "tickets/:id/done", to: "tickets#ending_ticket", as: "ending_ticket"
  post "tickets/:id/cancel", to: "tickets#cancel_ticket", as: "cancel_ticket"
end
