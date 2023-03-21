# frozen_string_literal: true

scope :users do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
      resources :courses
    end
  end
end
namespace :api do
  namespace :v1 do
    resources :courses
  end
end
