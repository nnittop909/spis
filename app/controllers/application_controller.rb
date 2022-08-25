class ApplicationController < ActionController::Base

	# include Pundit
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :authenticate_user!, :configure_permitted_parameters
  # rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  helper_method :current_office

  def current_office
  	current_user.office
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  private
  def permission_denied
    redirect_to "/", alert: 'Sorry, you are not allowed to access this page.'
  end

  protected
  def configure_permitted_parameters
    if devise_controller?
      devise_parameter_sanitizer.permit(:sign_in,
        keys: [:login, :password, :remember_me])
      devise_parameter_sanitizer.permit(:account_update,
        keys: [:password_confirmation, :password])
    end
  end
end
