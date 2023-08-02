module Pagination
  extend ActiveSupport::Concern

  included do
    before_action :build_page_offset

    # Build page offset for pagination
    def build_page_offset
      params[:page] ||= 1
      params[:per_page] ||= 10
      @page_offset = params[:per_page].to_i * (params[:page].to_i - 1)
      @page_limit = params[:per_page]
    end
  end

end