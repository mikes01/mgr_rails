Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :maps, only: [:index]
  root 'maps#index'
  resources :points, only: [:index, :create, :update, :destroy] do
    get :search, on: :collection
    post :render_form, on: :collection
  end

  resources :lines, only: [:index, :create, :update, :destroy] do
    post :render_form, on: :collection
  end

  resources :polygons, only: [:index, :create, :update, :destroy] do
    post :render_form, on: :collection
  end
end
