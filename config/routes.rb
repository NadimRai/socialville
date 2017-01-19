Rails.application.routes.draw do
  devise_for :users
  resources :statuses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'statuses#index'
  # Making Friends ---------------------
  resources :users, only: [:index, :show]    
   resources :friendships, only: [:create, :destroy, :accept] do 
    member do 
      put :accept
    end
  end
    # Making Friends ---------------------
end
