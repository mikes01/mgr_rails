Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :maps, only: [:index]
  root 'maps#index'
  resources :places, only: [:index, :create] do
    get :search, on: :collection
    post :render_form, on: :collection
  end

  resources :lines, only: [:index, :create] do
    post :render_form, on: :collection
  end

  resources :polygons, only: [:index, :create] do
    post :render_form, on: :collection
  end
end
