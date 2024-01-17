# frozen_string_literal: true

scope :referrals do
  namespace :interface do
    namespace :api do
      namespace :v1 do
        resources :referrals, only: [:create]
      end
    end
  end
end

namespace :interfaces do
  namespace :api do
    namespace :v1 do
      resources :payments do
        collection do
          post :hdfc_return_url
        end
      end
    end
  end
end
