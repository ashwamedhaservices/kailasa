scope :referrals do
  namespace :admin do
    namespace :api do
      namespace :v1 do
        resources :referrals, only: [:create, :update, :index]
        resources :users, only: [:index] do
          resources :referrals, only: [:create, :index]
          resources :wallet, only: [:index] do
            resources :transactions, only: [:index]
          end  
        end
      end
    end
  end
end