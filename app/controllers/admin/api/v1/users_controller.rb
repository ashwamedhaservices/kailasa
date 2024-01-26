# frozen_string_literal: true

module Admin
  module Api
    module V1
      class UsersController < ApplicationController
        def index
          users = User.where(index_params)
          return json_success(data: users.to_a) if invalidate_page_no

          json_success(data: users.limit(record_count).offset(record_count * page_no))
        end

        def show
          user = User.find_by(id: show_params[:id])
          return json_notfound(msg: 'User not found with the given id') unless user

          json_success(data: user)
        end

        def details
          user = User.includes(:product_subscriptions,
                               :profiles,
                               kyc: %i[bank_accounts addresses nominees])
                     .find_by(id: show_params[:id])
          return json_notfound(msg: 'User not found with the given id') unless user

          json_success(data: detail_success_response(user))
        end

        def update
          user = User.find_by(id: update_params[:id])
          return json_notfound(msg: 'User not found with the given id') unless user
          return json_failure(msg: 'Unable to update the user') unless user.update(update_params.except(:id))

          json_success(msg: 'User updated successfully', data: user)
        end

        private

        # page_no, record_count
        def index_params
          params.permit(:id, :mobile_number, :referral_code)
        end

        def show_params
          params.permit(:id)
        end

        def update_params
          params.permit(:id, :fname, :mname, :lname, :email, :mobile_number, :state, :type, :referral_code,
                        :referrer_id)
        end

        def detail_success_response(user)
          {
            user:,
            kyc: user.kyc,
            profiles: user.profiles,
            bank_accounts: user.kyc.bank_accounts,
            addresses: user.kyc.addresses,
            nominees: user.kyc.nominees,
            product_subscriptions: user.product_subscriptions
          }
        end
      end
    end
  end
end
