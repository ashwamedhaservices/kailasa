# frozen_string_literal: true

require 'csv'

module Admin
  module Api
    module V1
      class CreditsController < ApplicationController
        def index
          json_success(msg: 'the credits are',
                       data: Credit.where(index_params.except(:page)).limit(100).offset(100 * index_params[:page].to_i))
        end

        def payout_report
          @leads = generate_payout
          Rails.logger.info("the leads on #{DateTime.current} are #{@leads}")
          respond_to do |format|
            format.json { render json: { status: 'success', data: @leads } }
            format.csv do
              response.headers['Content-Type'] = 'text/csv'
              response.headers['Content-Disposition'] = "attachment; filename=payout_#{DateTime.current}.csv"
              # render template: 'path/to/index.csv.erb'
            end
          end
        end

        private

        def generate_payout # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          hash = {}
          Credit.find_each do |rc|
            hash[rc.user_id] = hash.fetch(rc.user_id, 0) + rc.amount.to_i if rc.credited?
            hash[rc.user_id] = hash.fetch(rc.user_id, 0) - rc.amount.to_i if rc.paid?
          end

          res = [%w[sl id name mobile_number amount]]
          count = 1
          hash.each do |k, v|
            u = User.find_by(id: k)
            next unless u

            res << [count, u.id, u.full_name, u.mobile_number, v]
            count += 1
          end

          bank_details = BankAccount.joins(kyc: :user).pluck('users.id', 'kycs.id', 'users.referral_code', 'kycs.name',
                                                             :account_number, :ifsc)
          bank_details.each do |bank_detail|
            bank_detail << hash.fetch(bank_detail[0], 0)
          end
          bank_details
        end

        def index_params
          params.permit(:page, :user_id, :credit_type, :status)
        end
      end
    end
  end
end