Rails.application.routes.draw do
  root :to => "root#root"

  resources :posts, only: [:index, :new, :create, :show, :destroy, :update]
end
