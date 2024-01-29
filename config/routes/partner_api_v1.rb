# frozen_string_literal: true

namespace :partner do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: %i[index] do
        collection do
          get :network
          get :network_report
        end
      end

      resources :users do
        resources :product_referrals, shallow: true
      end
    end
  end
end
