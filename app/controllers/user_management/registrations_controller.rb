# app/controllers/user_management/registrations_controller.rb

module UserManagement
  class RegistrationsController < Devise::RegistrationsController
    def create
      build_resource(sign_up_params)

      resource_saved = resource.save
      yield resource if block_given?
      if resource_saved
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          redirect_to new_user_session_path
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          redirect_to new_user_session_path
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
    
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :province_id)
    end
    
  end
end
