class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_back fallback_location: root_url }
    end
  end
end
