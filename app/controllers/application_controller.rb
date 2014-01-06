class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Error catching
  if Rails.env.production?
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownController, :with => :render_404
    rescue_from Exception, :with => :render_500
  end 
  # Render a 404 page
  def render_404
    render 'errors/index_404'
  end
  # Render a 500 page
  def render_500
    render 'errors/index_500'
  end
end
