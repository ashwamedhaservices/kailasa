# frozen_string_literal: true

module Admin
  module Api
    module V1
      class BankAccountsController < ApplicationController
        def show
          @bank_account = BankAccount.find(params[:id])
          render json: success(data: @bank_account), status: :ok
        end
      end
    end
  end
end
