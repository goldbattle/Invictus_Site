class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # Error catching
  if Rails.env.production?
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownController, :with => :render_404
    rescue_from Exception, :with => :render_500
  end 
  # Catch Perm Error
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
  # Render a 404 page
  def render_404
    render 'errors/index_404'
  end
  # Render a 500 page
  def render_500
    render 'errors/index_500'
  end
  # Strong Parm, let username through
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit :username, :email, :password, :password_confirmation
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit :username, :email, :is_subscribed, :password, :password_confirmation, :current_password
      end
    end
end
