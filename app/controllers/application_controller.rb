class ApplicationController < ActionController::Base
  # before_action :authenticate_user!, unless: :devise_controller?
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_current_user, if: :user_signed_in?

  private 

    def set_current_user
        Current.user = current_user
    end



  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
    end 
    
end
