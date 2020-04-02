Rails.application.routes.draw do
  resources :resumes, only: [:index, :new, :create, :destroy]
  root "resumes#index"
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
