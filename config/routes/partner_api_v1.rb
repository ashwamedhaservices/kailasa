# frozen_string_literal: true

namespace :partner do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: %i[index] do
        collection do
          get :network
        end
      end
    end
  end
end
