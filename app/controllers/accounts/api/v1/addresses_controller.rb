# frozen_string_literal: true

module Accounts
  module Api
    module V1
      class AddressesController < ApplicationController
        def index
          return json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc
          return json_failure(msg: 'Address does not exists', error_code: 'record_not_found') unless addresses_exists?

          json_success(data: addresses)
        end

        def create
          return json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc

          address = addresses.build(address_create_params)
          if address.save
            json_created(msg: 'Address created successfully', data: address)
          else
            json_failure(msg: address.errors.full_messages.to_sentence)
          end
        end

        def update
          return json_failure(msg: 'Kyc does not exists', error_code: 'record_not_found') unless kyc
          return json_failure(msg: 'Address does not exists', error_code: 'record_not_found') unless address

          if address.update(address_update_params)
            json_success(msg: 'Address updated successfully', data: address)
          else
            json_failure(msg: address.errors.full_messages.to_sentence)
          end
        end

        private

        def kyc
          @kyc ||= current_user.kyc
        end

        def addresses
          @addresses ||= kyc&.addresses
        end

        def address
          @address ||= addresses.find_by(id: params[:id])
        end

        def addresses_exists?
          addresses.present?
        end

        def address_create_params
          params.require(:address).permit(:name, :address_type, :address_line_one, :address_line_two,
                                          :address_line_three, :city, :state, :country, :postal_code)
        end

        def address_update_params
          params.require(:address).permit(:name, :address_type, :address_line_one, :address_line_two,
                                          :address_line_three, :city, :state, :country, :postal_code)
        end
      end
    end
  end
end
