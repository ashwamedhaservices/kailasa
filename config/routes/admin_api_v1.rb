# frozen_string_literal: true

scope :referrals do
  namespace :admin do
    namespace :api do
      namespace :v1 do
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
scope :learnings do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        resources :questions, only: %i[index create update show] do
          collection do
            post :add_answer
          end
        end
        resources :answers, only: %i[index create update show]
      end
    end
  end
end
scope :accounts do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        resources :kycs, only: %i[index show]
        resources :addresses, only: %i[show]
        resources :nominees, only: %i[show]
        resources :bank_accounts, only: %i[show]
      end
    end
  end
end
