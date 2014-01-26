class UsersController < ApplicationController
  # Set the @user variable
  before_action :set_user, only: [:edit, :update, :destroy]
  # Authentication
  load_and_authorize_resource

  # Main user index, list all users
  def index
    # Main content
    @users_all = User.all.order("created_at DESC")
    @users = User.paginate(:page => params[:page], :per_page => 100).order('created_at DESC')
  end

  # Edit user profile
  def edit
  end

  # Update the user after edit
  def update
    # Main content
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile has been updated"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  # Delete the user
  def destroy
    # Main content
    @user.destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :is_subscribed, :role)
    end
end
