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
            users_all_data[:addresses] = kyc.addresses
            res << users_all_data
          end
          json_success(data: res)
        end

        def show
          return kyc_not_found unless kyc

          json_success(data: kyc)
        end

        def update
          return kyc_not_found unless kyc

          if kyc.update(kyc_update_params)
            json_success(msg: 'Kyc updated successfully', data: kyc)
          else
            json_failure(msg: kyc.errors.full_messages.to_sentence)
          end
        end

        private

        def kyc
          @kyc ||= Kyc.find(params[:id])
        end

        def all_kyc
          @all_kyc ||= Kyc.includes(:user, :bank_accounts, :nominees, :addresses).all
        end

        def kyc_not_found
          json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found')
        end

        def kyc_update_params
          params.require(:kyc).permit(:name, :status, :id_proof_no, :id_proof_url, :id_proof_type, :address_proof_no,
                                      :address_proof_url, :address_proof_type)
        end
      end
    end
  end
end
