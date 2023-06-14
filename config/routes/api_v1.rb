# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    resources :users, only: %i[create index show] do
      collection do
        post 'verify'
        post 'login'
        post 'login_otp'
        post 'otp_verification'
        get 'registered'
        get 'subscribed'
      end
    end
    resources :file_upload, only: %i[create]
    resources :profiles do
      collection do
        get 'dashboard'
      end
    end
    resources :courses do
      resources :subjects, shallow: true do
        resources :chapters, shallow: true do
          resources :topics, shallow: true do
            resources :enrollments, shallow: true
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
