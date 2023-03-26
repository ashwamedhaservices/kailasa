# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ApplicationSerializer
      attribute :id

      attribute :full_name, &:full_name

      attribute :token, if: proc { |user, params|
        # We will be creating a session and returning session ID inside token
        user.token if params[:issue_token]
      }
    end
  end
end
