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
        resources :credits, only: %i[index] do
          collection do
            get :payout_report
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
          resources :answers, only: %i[index create update show], shallow: true
        end

        resources :question_papers, only: %i[create show] do
          member do
            post :question
            delete 'question/:question_id', action: :remove_question
          end
          collection do
            get 'list/:testable_type/:testable_id', action: :list_questions
          end
        end
        resources :meetings, only: %i[index create]
      end
    end
  end
end
scope :accounts do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        resources :kycs, only: %i[index show update]
        resources :addresses, only: %i[show update]
        resources :nominees, only: %i[show update]
        resources :bank_accounts, only: %i[show update]
        resources :reports, only: %i[index]
        resources :users, only: %i[index show update] do
          member do
            get :details
          end
        end
      end
    end
  end
end
