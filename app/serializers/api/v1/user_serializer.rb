module Api
  module V1
    class UserSerializer < ApplicationSerializer
      attribute :id

      attribute :full_name do |user|
        user.full_name
      end

      attribute :token, if: Proc.new { |user, params|
        # We will be creating a session and returning session ID inside token
        user.token if params[:issue_token]
      }

    end
  end
end
