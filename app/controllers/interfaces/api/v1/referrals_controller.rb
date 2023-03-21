# frozen_string_literal: true

module Interfaces
  module Api
    module V1
      class ReferralsController < ApplicationController
        # def create
        #   ::Referrals::Process.call(referrall_params)
        # end

        # private
        # def referrall_params
        #   params.require(:referrals).permit(:plan, referrer: [:phone, :name], referee: [:phone, :name])
        # end
      end
    end
  end
end
