# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ApplicationSerializer
      attribute :id, :referral_code, :type, :mobile_number

      attribute :full_name, &:full_name

      attribute :referral_url, &:referral_url
      attribute :wallet_info, &:earnings

      attribute :token, if: proc { |user, params|
        # We will be creating a session and returning session ID inside token
        user.token if params[:issue_token]
      }
    end
  end
end
