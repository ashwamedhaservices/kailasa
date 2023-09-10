# frozen_string_literal: true

module Admin
  module Api
    module V1
      class AddressesController < ApplicationController
        def show
          return address_not_found unless address

          json_success(data: address)
        end

        def update
          return address_not_found unless address

          if address.update(address_update_params)
            json_success(msg: 'Address updated successfully', data: address)
          else
            json_failure(msg: address.errors.full_messages.to_sentence)
          end
        end

        private

        def address
          @address ||= Address.find(params[:id])
        end

        def address_update_params
          params.require(:address).permit(:name, :address_type, :address_line_one, :address_line_two,
                                          :address_line_three, :city, :state, :country, :postal_code)
        end

        def address_not_found
          json_failure(msg: 'Address does not exists', error_code: 'record_not_found')
        end
      end
    end
  end
end
