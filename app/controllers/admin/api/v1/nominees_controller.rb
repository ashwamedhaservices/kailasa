# frozen_string_literal: true

module Admin
  module Api
    module V1
      class NomineesController < ApplicationController
        def show
          return nominee_not_found unless nominee

          json_success(data: nominee)
        end

        def update
          return nominee_not_found unless nominee

          if nominee.update(nominee_update_params)
            json_success(msg: 'Nominee updated successfully', data: nominee)
          else
            json_failure(msg: nominee.errors.full_messages.to_sentence)
          end
        end

        private

        def nominee
          @nominee ||= Nominee.find(params[:id])
        end

        def nominee_not_found
          json_failure(msg: 'Nominee does not exists', error_code: 'record_not_found')
        end

        def nominee_update_params
          params.require(:nominee).permit(:name, :nominee_type, :dob, :relationship,
                                          :kyc_id, :address_id, :guardian_id, :relationship_with_guardian)
        end
      end
    end
  end
end
