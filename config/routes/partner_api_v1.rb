# frozen_string_literal: true

namespace :partner do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: %i[index newtork]
    end
  end
end
