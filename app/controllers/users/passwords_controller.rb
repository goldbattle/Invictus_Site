class Users::PasswordsController < Devise::PasswordsController
  def resource_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :reset_password_token)
  end
  private :resource_params
end
