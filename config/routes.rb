Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'auth', controller: :auth, action: :create
      resources :users
      post 'time-tracker-employees/in', controller: :time_tracker_employees, action: :in
      post 'time-tracker-employees/out', controller: :time_tracker_employees, action: :out
    end
  end
end
