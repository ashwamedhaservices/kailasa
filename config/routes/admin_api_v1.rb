# frozen_string_literal: true

scope :referrals do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        resources :kycs, only: %i[index] do
          collection do # rubocop:disable Lint/EmptyBlock
          end
        end
        resources :referrals, only: %i[create update index]
        resources :users, only: [:index] do
          resources :referrals, only: %i[create index]
          resources :wallet, only: [:index] do
            resources :transactions, only: [:index]
          end
        end
      end
    end
  end
end
