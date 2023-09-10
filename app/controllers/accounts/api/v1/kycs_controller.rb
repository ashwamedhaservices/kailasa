# frozen_string_literal: true

module Accounts
  module Api
    module V1
      class KycsController < ApplicationController
        def index
          return json_failure(msg: 'Kyc doesnot exists', error_code: 'record_not_found') unless kyc

          json_success(data: kyc)
        end

        def create
          return json_failure(msg: 'Kyc already exists') if kyc

          if current_user.build_kyc(kyc_create_params).save
            json_created(msg: 'Kyc created successfully', data: kyc)
          else
            json_failure(msg: kyc.errors.full_messages.to_sentence)
          end
        end

        def update
          return json_failure(msg: 'Kyc doesnot exists', error_code: 'record_not_found') unless kyc

          if kyc.update(kyc_update_params)
            json_success(msg: 'Kyc updated successfully', data: kyc)
          else
            json_failure(msg: kyc.errors.full_messages.to_sentence)
          end
        end

        private

        def kyc
          @kyc ||= current_user.kyc
        end

        def kyc_create_params
          params.require(:kyc).permit(:name, :id_proof_no, :id_proof_url, :id_proof_type, :address_proof_no,
                                      :address_proof_url, :address_proof_type)
        end

        def kyc_update_params
          params.require(:kyc).permit(:name, :status, :id_proof_no, :id_proof_url, :id_proof_type, :address_proof_no,
                                      :address_proof_url, :address_proof_type)
        end
      end
    end
  end
end
