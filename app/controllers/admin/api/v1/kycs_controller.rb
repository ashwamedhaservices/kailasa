# frozen_string_literal: true

module Admin
  module Api
    module V1
      class KycsController < ApplicationController
        def index
          res = []
          all_kyc.each do |kyc|
            users_all_data = {}
            users_all_data[:user] = kyc.user
            users_all_data[:kyc] = kyc
            users_all_data[:bank_accounts] = kyc.bank_accounts
            users_all_data[:nominees] = kyc.nominees
            res << users_all_data
          end
          json_success(data: res)
        end

        def show
          @kyc = Kyc.find(params[:id])
          render json: success(data: @kyc), status: :ok
        end

        private

        def all_kyc
          @all_kyc ||= Kyc.includes(:user, :bank_accounts, :nominees, :addresses).all
        end
      end
    end
  end
end
