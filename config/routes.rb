Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root to: 'landing#index'
  get :about, to: 'static_pages#about'
  resources :topics, except: [:show] do
    resources :posts, except: [:show] do
      resources :comments, except: [:show]
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :edit, :create, :update]
  resources :password_resets, only: [:new, :edit, :create, :update]
end
