Rails.application.routes.draw do
  devise_for :users, :skip => [:passwords]

  devise_scope :user do
    unauthenticated :user do
      root 'devise/sessions#new'
    end

    authenticated :user do
      root 'csv_books#new', as: :main
      resources :csv_books, only: [:new, :create, :index, :show]
    end
  end
end
