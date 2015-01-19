Rails.application.routes.draw do
  root to: 'cats#index'

  resource :session, only: [:new, :create, :destroy] do
      member do
        post '/destroy/:token_id', action: "destroy"
      end
    end

  resources :users, only: [:new, :create, :show] do
		collection do
			post '/destroy/:token_id', redirect_to: 'session/destroy/:token_id', action: "destroy"
		end
	end

  resources :cats, only: [:index, :show, :new, :create, :edit, :update]

  resources :cat_rental_requests, only: [:new, :create] do
    member do
      post 'approve', 'deny'
    end
  end

end
