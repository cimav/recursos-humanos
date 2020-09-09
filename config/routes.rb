Rails.application.routes.draw do

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get '/logout' => 'sessions#destroy'
  get '/login' => 'sessions#login'

  root to: 'holidays#index'

  get '/holidays/set_employee/:employee_id', to: 'holidays#set_employee', defaults: { format: 'js' }
  post '/holidays/reschedule_day', to: 'holidays#reschedule_day', defaults: { format: 'js' }

end
