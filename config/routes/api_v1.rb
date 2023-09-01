# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :referrals, only: %i[index]

    resources :users, only: %i[create] do
      collection do
        post 'verify'
        post 'login'
        post 'login_otp'
        post 'otp_verification'
        get 'registered'
        get 'subscribed'
        get 'referrer'
      end
    end
    resources :file_upload, only: %i[create]
    resources :profiles, only: [] do
      collection do
        get 'dashboard'
      end
    end
    resources :courses do
      collection do
        get 'bundle'
      end
      resources :subjects, shallow: true do
        resources :chapters, shallow: true do
          resources :topics, shallow: true do
            resources :enrollments, shallow: true
          end
        end
      end
    end
    resources :payments, only: %i[create] do
      collection do
        post 'callback'
        post 'return_url'
      end
    end
    resources :question_papers, only: %i[] do
      collection do
        get ':testable_type/:testable_id', action: :question_paper_for_testable
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
