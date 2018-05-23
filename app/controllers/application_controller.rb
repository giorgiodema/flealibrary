class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  protected
  def authenticate_user!
    if !user_signed_in?
      flash[:error] = "you must login"
      redirect_to root_path
    end
  end
end
