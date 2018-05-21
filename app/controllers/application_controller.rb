class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

=begin
  def get_current_user
    unless session[:current_user].nil?
      return User.find(session[:current_user])
    else
      return None

    end
  end
=end
  def current_user
    return unless session[:current_user]
    @current_user ||= User.find(session[:current_user])
  end

end
