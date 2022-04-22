Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create]
  post '/send_otp_code', as: 'user_send_otp_code', to: 'users#send_code'
  post '/checkauth', as: 'check_auth', to: 'users#checkAuth'
end
