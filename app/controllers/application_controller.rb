class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  def current_user
    User.find(session[:id]) if session[:id]
  end
  def logged_in?
    !current_user.nil?
  end
  helper_method :current_user
  helper_method :logged_in?

 
  private 
  
  def require_login
    unless logged_in?
      flash[:notice] = [ "You must be logged in to access this section" ]
      redirect_to '/sessions/new' # halts request cycle
    end
  end
end
  
