Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :things
    resources :users
    put 'basic_upload', to: 'users#basic_upload'
    put 'update_user_image', to: 'users#update_user_image'
  end

end
