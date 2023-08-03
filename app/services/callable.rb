# frozen_string_literal: true

module Callable
  def call(*)
    new(*).call
  end
end
