# frozen_string_literal: true

module Admin
  module Api
    module V1
      class BankAccountsController < ApplicationController
        def show
          return bank_account_not_found unless bank_account

          json_success(data: bank_account)
        end

        def update
          return bank_account_not_found unless bank_account

          if bank_account.update(bank_account_update_params)
            json_success(msg: 'Bank Account updated successfully', data: bank_account)
          else
            json_failure(msg: bank_account.errors.full_messages.to_sentence)
          end
        end

        private

        def bank_account
          @bank_account ||= BankAccount.find(params[:id])
        end

        def bank_account_not_found
          json_failure(msg: 'Bank Account does not exists', error_code: 'record_not_found')
        end

        def bank_account_update_params
          params.require(:bank_account).permit(:account_number, :account_type, :ifsc, :micr, :bank, :branch, :city,
                                               :proof_type, :proof_url)
        end
      end
    end
  end
end
