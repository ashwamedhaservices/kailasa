# frozen_string_literal: true

module Accounts
  module Api
    module V1
      class BankAccountsController < ApplicationController
        def index
          return json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc
          unless bank_account_exists?
            return json_failure(msg: 'Bank Account does not exists', error_code: 'record_not_found')
          end

          json_success(data: bank_accounts)
        end

        # TODO: Encrypt bank account
        def create
          return json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc

          bank_account = bank_accounts.build(bank_account_create_params)
          if bank_account.save
            json_created(msg: 'Bank Account created successfully', data: bank_account)
          else
            json_failure(msg: bank_account.errors.full_messages.to_sentence)
          end
        end

        def update
          json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc
          json_failure(msg: 'Bank Account does not exists', error_code: 'record_not_found') unless bank_account

          if bank_account.update(bank_account_update_params)
            json_success(msg: 'Bank Account updated successfully', data: bank_account)
          else
            json_failure(msg: bank_account.errors.full_messages.to_sentence)
          end
        end

        private

        def kyc
          @kyc ||= current_user.kyc
        end

        def bank_accounts
          @bank_accounts ||= kyc&.bank_accounts
        end

        def bank_account
          @bank_account ||= bank_accounts.find_by(id: params[:id])
        end

        def bank_account_exists?
          bank_accounts.present?
        end

        def bank_account_create_params
          params.require(:bank_account).permit(:account_number, :account_type, :ifsc, :micr, :bank, :branch, :city,
                                               :proof_type, :proof_url)
        end

        def bank_account_update_params
          params.require(:bank_account).permit(:account_number, :account_type, :ifsc, :micr, :bank, :branch, :city,
                                               :proof_type, :proof_url)
        end
      end
    end
  end
end
