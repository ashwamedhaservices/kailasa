# frozen_string_literal: true

module Partner
  module Api
    module V1
      class ProductReferralsController < ApplicationController
        def index
          return json_failure(msg: 'category not present') unless index_params[:category]
          return json_success(data: product_referrals) if invalidate_page_no

          json_success(data: product_referrals.limit(page_no).offset(per_page * page_no))
        end

        private

        def index_params
          params.permit(:category)
        end

        def product_referrals
          @product_referrals ||= current_user.product_referrals.joins(:product_subscription)
                                             .where(product_subscriptions: { category: index_params[:category] })
        end
      end
    end
  end
end
