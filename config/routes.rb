Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    unauthenticated :user do
      root 'devise/sessions#new', as: :login
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
