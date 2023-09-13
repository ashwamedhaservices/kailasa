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
        def network
          render json: success(data: partner_users_network), status: :ok
        end

        # # GET /partner/api/v1/accounts/earning
        # def earning
        # end

        def network_report
          [2, 3, 4, 5, 6, 7].each do |i|
            break unless users_network_report[i - 1]

            users_network_report[i - 1].each do |user|
              users_network_report[i] = users_network_report.fetch(i, []).concat(user.referees)
            end
          end
          json_success(msg: 'the report is generated', data: users_network_report)
        end

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

        def partner_user
          @partner_user ||= params[:id] ? User.find(params[:id]) : current_user
        end

        def network_details(user)
          {
            id: user.id,
            name: user.full_name,
            mobile: user.mobile_number,
            earnings: ReferralCredit.where(user_id: user.id).sum(:amount),
            network_width: user.referees.size,
            referral_link: user.referral_url,
            last_payout: 0
          }
        end

        def partner_users_network
          network = []
          partner_user_referees.find_each do |user|
            network << network_details(user)
          end
          network_details(partner_user).merge(network:)
        end

        def partner_user_referees
          @partner_user_referees ||= partner_user.referees
        end

        def users_network_report
          {
            0 => [current_user],
            1 => current_user.referees.to_a
          }
        end
      end
    end
  end
end
