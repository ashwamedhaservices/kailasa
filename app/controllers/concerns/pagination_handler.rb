# frozen_string_literal: true

module PaginationHandler
  extend ActiveSupport::Concern
  def page_no
    @page_no ||= (params[:page_no] || 0).to_i
  end

  def invalidate_page_no
    page_no.eql?(-1)
  end

  def record_count
    @record_count ||= (params[:record_count] || 20).to_i
  end
end
