Rails.application.routes.draw do
  root to: 'cats#index'

  resource :session, only: [:new, :create, :destroy] do
      member do
        post 'logout/:token_id', action: "destroy"
      end
    end

  resources :users, only: [:new, :create, :show]

  resources :cats, only: [:index, :show, :new, :create, :edit, :update]

  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post 'approve', 'deny'
    end
  end

end
