# frozen_string_literal: true

module Accounts
  module Api
    module V1
      class NomineesController < ApplicationController
        def index
          return json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc
          return json_failure(msg: 'Nominee does not exists', error_code: 'record_not_found') unless nominees_exists?

          json_success(data: nominees)
        end

        def create
          return json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc

          nominee = nominees.build(nominee_create_params)
          if nominee.save
            json_created(msg: 'Nominee created successfully', data: nominee)
          else
            json_failure(msg: nominee.errors.full_messages.to_sentence)
          end
        end

        def update
          return json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc
          return json_failure(msg: 'Nominee does not exists', error_code: 'record_not_found') unless nominee

          if nominee.update(nominee_update_params)
            json_success(msg: 'Nominee updated successfully', data: nominee)
          else
            json_failure(msg: nominee.errors.full_messages.to_sentence)
          end
        end

        private

        def kyc
          @kyc ||= current_user.kyc
        end

        def nominees
          @nominees ||= kyc&.nominees
        end

        def nominee
          @nominee ||= nominees.find_by(id: params[:id])
        end

        def nominees_exists?
          nominees.present?
        end

        def nominee_create_params
          params.require(:nominee).permit(:name, :nominee_type, :dob, :relationship,
                                          :kyc_id, :address_id, :guardian_id, :relationship_with_guardian)
        end

        def nominee_update_params
          params.require(:nominee).permit(:name, :nominee_type, :dob, :relationship,
                                          :kyc_id, :address_id, :guardian_id, :relationship_with_guardian)
        end
      end
    end
  end
end
