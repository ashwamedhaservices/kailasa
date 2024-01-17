# frozen_string_literal: true

namespace :api do
  namespace :v2 do
    resources :payments, only: %i[create] do
      collection do
        post 'configs'
      end
    end
  end
end
