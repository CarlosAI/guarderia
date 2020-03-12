Rails.application.routes.draw do
  get 'activity_logs', to: 'activity_logs#index'

  root 'activity_logs#other_page'
  post 'consultar_info', to: 'activity_logs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
