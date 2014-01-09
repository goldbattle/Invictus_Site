class DownloadsController < ApplicationController
  # Set the @download variable
  before_action :set_download, only: [:edit, :update, :destroy]
  # Authentication
  load_and_authorize_resource

  def index
    # All downloads that the public can see
    @download_public = Download.where(:is_public => true).order("weight_id ASC")
    # All downloads the login'in people can see
    @download_private = Download.where(:is_private => true).order("weight_id ASC")
    # All draft post, for admins
    @download_all = Download.all.order("weight_id ASC")
  end

  def new
    @download = Download.new
  end

  def edit
  end

  def update
    if @download.update_attributes(download_params)
      flash[:success] = "Your download has been updated."
      # Redirect
      redirect_to downloads_path
    else
      render 'edit'
    end
  end

  def create
    @download = Download.new(download_params)
    # Save the the post
    if @download.save
      flash[:success] = "Added a new download."
      # Redirect
      redirect_to downloads_path
    else
      render 'new'
    end
  end

  def destroy
    @download.destroy
    flash[:success] = "Download has been deleted."
    redirect_to downloads_path
  end


private
  # Use callbacks to share common setup or constraints between actions.
  def set_download
    @download = Download.find(params[:id])
  end
  # Strong Parameters
  def download_params
    params.require(:download).permit(:title, :content, :weight_id, :is_public, :is_private)
  end
end
