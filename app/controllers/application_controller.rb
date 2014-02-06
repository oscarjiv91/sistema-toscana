class ApplicationController < ActionController::Base
  before_filter :logged_in?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in?
  	if !signed_in?
  		redirect_to "/sessions/new"
  	end
  end

end
