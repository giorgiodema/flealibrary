# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # setto i parametri per la sign_in dell'utente
  before_action :configure_sign_in_params, only: [:create]
  #se non sono registrato posso accedere alla pagina di sign_in
  skip_before_action :authenticate_user!, only: [:new]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in)#, keys: [:name, :surname, :username, :role])
  end

  def after_sign_in_path_for(resource)
    profile_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
