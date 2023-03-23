scope :referrals do
  namespace :interface do
    namespace :api do
      namespace :v1 do
        resources :referrals, only: [:create]
      end
    end
  end
end
