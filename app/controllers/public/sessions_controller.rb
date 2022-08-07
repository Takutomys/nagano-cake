# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.

  before_action :customer_state, only: [:create]

  protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])

    return if !@customer

    if @customer.is_active && !@customer.valid_passward?(params[:customer][:password])
      redirect_to new_customer_session_path

    end
  end
  def after_sign_in_path_for(resource)
    root_path
  end
end
