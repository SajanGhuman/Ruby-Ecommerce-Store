# app/controllers/user/registrations_controller.rb

# module User
#   class RegistrationsController < Devise::RegistrationsController
#     protected

#     def after_sign_up_path_for(resource)
#       flash[:notice] = "Welcome! Your account has been successfully created."
#       session[:user_id] = resource.id
#       new_user_session_path
#     end
#   end
# end
