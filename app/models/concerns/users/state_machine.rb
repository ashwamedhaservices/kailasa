# frozen_string_literal: true

module Users
  module StateMachine
    extend ActiveSupport::Concern

    included do
      include AASM

      aasm column: :state do
        state :created, initial: true
        state :verified
        state :active, :inactive, :blocked
        event :mark_verified do
          transitions from: :created, to: :verified # , :if => :created?
        end
      end
    end
  end
end
