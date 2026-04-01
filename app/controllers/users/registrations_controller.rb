# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    # before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    def edit
      super
    end

    # PUT /resource
    def update
      if current_user.update_without_password(account_update_params)
        redirect_to root_path
      else
        render :edit, status: :unprocessable_content
      end
    end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    # end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end

    def edit_password
      self.resource = current_user
    end

    def update_password
      self.resource = current_user
      if current_user.update_with_password(password_update_params)
        redirect_to root_path
      else
        render :edit_password, status: :unprocessable_content
      end
    end

    private

    def account_update_params
      params.require(:user).permit(:username)
    end

    def password_update_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
  end
end
