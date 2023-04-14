scope :accounts do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create index show] do
        collection do
          post 'verify'
          post 'login'
          post 'login_otp'
          post 'otp_verification'
          get 'registered'
        end
      end
    end
  end
end
