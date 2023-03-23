scope :accounts do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create index show] do
        collection do
          post 'verify'
        end
      end
    end
  end
end
