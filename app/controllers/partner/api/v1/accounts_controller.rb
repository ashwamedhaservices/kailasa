# frozen_string_literal: true

module Partner
  module Api
    module V1
      class AccountsController < ApplicationController
        # GET /partner/api/v1/accounts
        # {
        #   payout_completed: 1000000,
        #   payout_pending: 1000000,
        #   payout_in_review: 1000000,
        #   payouts: [
        #     { amount: 500000, level: "0", frquency: "Weekly payout" },
        #     { amount: 500000, level: "1", frquency: "Weekly payout" },
        #     { amount: 300000, level: "2", frquency: "Weekly payout" },
        #   ],
        #   top_performers: [
        #     { name: "XYX", earnings: 30000, level: "level 1" },
        #     { name: "XYX", earnings: 30000, level: "level 2" },
        #     { name: "XYX", earnings: 30000, level: "level 1" },
        #     { name: "XYX", earnings: 30000, level: "level 1" },
        #     { name: "XYX", earnings: 30000, level: "level 3" },
        #   ],
        #   bottom_performers: [
        #     { name: "XYX", earnings: 30000, level: "level 1" },
        #     { name: "XYX", earnings: 30000, level: "level 1" },
        #     { name: "XYX", earnings: 30000, level: "level 2" },
        #     { name: "XYX", earnings: 30000, level: "level 1" },
        #     { name: "XYX", earnings: 30000, level: "level 8" },
        #   ];
        # }
        def index
          # TODO: this should be devided into payout service and network service
          resp = payout_info.merge(performance_info)
          render json: success(data: resp), status: :ok
        end

        # GET /partner/api/v1/accounts/partners
        # NOTE: no pagination as of now.
        # no filter by level, its plane dirct referral list of an user
        def newtork; end

        # # GET /partner/api/v1/accounts/earning
        # def earning
        # end

        private

        def payout_info
          {
            payout_completed: 0,
            payout_pending: 0,
            payout_in_review: ReferralCredit.where(date: DateTime.now.all_week, user_id: current_user.id).sum(:amount),
            payouts: []
          }
          # payouts: []
          # TODO: calculation to be done later
          # { amount: 500000, level: "0", frquency: "Weekly payout" },
          # { amount: 500000, level: "1", frquency: "Weekly payout" },
          # { amount: 300000, level: "2", frquency: "Weekly payout" },
        end

        def performance_info
          {
            top: top_performers,
            bottom: bottom_performers
          }
        end

        def top_performers
          all_referees.first(5).map do |id, count|
            user = User.find_by(id:).select(:name)
            { name: user.name, earnings: count * 60.0, level: 'level 1' }
          end
        end

        # NOTE: to calculate bottom performance there must be at least one user in the partners network
        def bottom_performers
          all_referees.last(5).map do |id, count|
            user = User.find_by(id:).select(:name)
            { name: user.name, earnings: count * 60.0, level: 'level 1' }
          end
        end

        def all_referees
          @all_referees ||= referees
        end

        def referees
          return [] unless level_1_ids.size > 20

          hash = User.where(referrer_id: level_1_ids).where(created_at: DateTime.now.all_week).group(:referrer_id).count
          hash.sort_by { |_k, v| v }
        end

        def level_1_ids
          User.where(referrer_id: current_user.id, created_at: DateTime.now.all_week).pluck(:id)
        end
      end
    end
  end
end