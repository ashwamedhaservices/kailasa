scope :users do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
    end
  end
end
