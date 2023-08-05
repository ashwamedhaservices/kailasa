# frozen_string_literal: true

module Onboarding
  class Status
    extend Callable
    include Service

    attr_reader :user, :status, :flow

    ONBOARDING_FLOW = %i[id_proof address address_proof bank_account nominee].freeze

    def initialize(user)
      @user = user
      @status = true
      @flow = []
    end

    def call
      checklist
      result
    end

    private

    def checklist
      ONBOARDING_FLOW.each do |step|
        if send(step)
          flow << checklist_item_success(step)
        else
          @status = false
          flow << checklist_item_failure(step)
        end
      end
    end

    def kyc
      @kyc ||= user.kyc
    end

    def address
      @address ||= kyc&.addresses&.first
    end

    def bank_account
      @bank_account ||= kyc&.bank_accounts&.first
    end

    def nominee
      @nominee ||= kyc&.nominees&.first
    end

    def id_proof
      kyc.present? && kyc.id_proof_no.present? && kyc.id_proof_type.present? && kyc.id_proof_url.present?
    end

    def address_proof
      kyc.present? && kyc.address_proof_no.present? && kyc.address_proof_type.present? && kyc.address_proof_url.present?
    end

    def checklist_item_success(item)
      {
        status: true,
        page: item
      }
    end

    def checklist_item_failure(item)
      {
        status: false,
        page: item
      }
    end

    def result
      {
        status:,
        flow:
      }
    end
  end
end
