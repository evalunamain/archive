Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users
end
