# frozen_string_literal: true

namespace :accounts do
  namespace :api do
    namespace :v1 do
      resources :kycs, only: %i[index create update] do
        resources :bank_accounts, shallow: true, only: %i[index create update]
        resources :addresses, shallow: true, only: %i[index create update]
      end
    end
  end
end
