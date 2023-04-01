# frozen_string_literal: true

scope :accounts do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create index show] do
        collection do
          post 'verify'
          post 'login'
          post 'login_otp'
          post 'otp_verification'
        end
      end
    end
  end
end
namespace :api do
  namespace :v1 do
    resources :profiles do
      collection do
        get 'dashboard'
      end
    end
    resources :courses do
      resources :subjects, shallow: true do
        resources :chapters, shallow: true
      end
    end
  end
end
