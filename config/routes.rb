Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :maps, only: [:index]
  root 'maps#index'
  resources :places, only: [:index] do
    get :search, on: :collection
  end
  resources :lines, only: [:index]
  resources :polygons, only: [:index]
end
