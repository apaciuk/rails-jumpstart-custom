class ApplicationController < ActionController::Base
  impersonates :user
  include Pundit

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  before_action :set_current_user, :set_current_request_id, if: :user_signed_in?

  before_action :set_current_request_id

  private 

        def set_current_user
		Current.user = current_user
	end

	def set_current_request_id
		Current.request_id = request.uuid
	end



  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
    end
end
