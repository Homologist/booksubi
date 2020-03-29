Rails.application.routes.draw do
  resources :csv_books
  devise_for :users
  devise_scope :user do
    unauthenticated :user do
      root 'devise/sessions#new', as: :main_auth
    end
    authenticated :user do
      root 'csv_books#new', as: :main
    end
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'devise/sessions#new'
end
