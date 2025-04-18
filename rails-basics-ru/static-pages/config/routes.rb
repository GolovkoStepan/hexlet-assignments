# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  root to: 'home#index'

  resources :pages, only: :show, param: :page_name
  # END
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
