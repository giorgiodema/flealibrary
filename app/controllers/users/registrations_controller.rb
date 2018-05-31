# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # setto parametri per sign_up e account_update
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # quando non sono registrato posso accedere alla pagina di registrazione e registrarmi
  skip_before_action :authenticate_user!, only: [:new, :create]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  #cancancan -> ability
  def banned_user
    User.setRole(params[:id], User::ROLES[1])
    redirect_to root_path
  end
  
  def admin_user
    User.setRole(params[:id], User::ROLES[2])
    redirect_to root_path
  end

  def booklover_user
    User.setRole(params[:id], User::ROLES[0])
    redirect_to root_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :name, :surname, :username, :role, :image, :image_cache, :remove_image])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :name, :surname, :username, :role, :image, :image_cache, :remove_image])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    profile_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    #super(resource)
    root_path
  end
end
