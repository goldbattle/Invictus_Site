class Users::RegistrationsController < Devise::RegistrationsController
  def resource_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end
  private :resource_params
end