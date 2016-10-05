Rails.application.routes.draw do
  resources :cats
  resources :cat_rentals do
    member do
      post :approve
      post :deny
    end
  end
end
