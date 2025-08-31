Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, path: "api/v1",
             controllers: {
               invitations: "api/v1/users/invitations"
             }
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        namespace :users do
          post "password_forgot", to: "passwords#forgot"
          post "password_reset", to: "passwords#reset"
        end
        resource :login, only: :create
        resource :logout, only: :create
        resource :signup, only: :create
        resource :refresh, only: :create
      end
      resources :users, only: %i[show update create index destroy] do
        resources :documents, controller: :user_documents, only: :index
        member do
          # get 'timesheets', to: 'users#timesheets'
          # get 'current_timesheet', to: 'users#current_timesheet'
          # put 'upload_document', to: 'users#upload_document'
          # put 'remove_document', to: 'users#remove_document'
          # put 'upload_avatar', to: 'users#upload_avatar'
          # put 'remove_avatar', to: 'users#remove_avatar'
          # put 'add_machine', to: 'users#add_machine'
          # put 'remove_machine', to: 'users#remove_machine'
        end
      end
    end
  end
end
