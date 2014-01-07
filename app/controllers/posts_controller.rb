class PostsController < ApplicationController
  # Set the @post variable
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # Authentication
  load_and_authorize_resource

  def index
    # All post that are not drafts, is_draft=false
    @posts = Post.where(:is_visible => true).paginate(:page => params[:page], :per_page => 5)
    # All draft post, for admins
    @post_all = Post.all.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    # Update view count
    if @post.view_count
      @post.view_count += 1
    else
      @post.view_count = 1
    end
    @post.save
    # Create new comment
    @comment = Comment.new
    # Pagination, no more then 10 per page
    @comments = @post.comments.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    # Save the the post
    if @post.update_attributes(post_params)
      flash[:success] = "Post has been updated."
      # Send out emails if needed
      email_post_update(@post)
      # Redirect
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def create
    # Create object
    @post = Post.new(post_params)
    @post.user = current_user
    # Save the the post
    if @post.save
      flash[:success] = "Added a new post."
      # Send out emails if needed
      email_post_update(@post)
      # Redirect
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post has been deleted."
    redirect_to posts_path
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find_by_slug(params[:id])
  end
  # Strong Parameters
  def post_params
    params.require(:post).permit(:title, :slug, :content, :thumbnail, :header, :is_visible)
  end
  # Email people subscribed
  def email_post_update(post)
    # Create a new thread
    Thread.new do
      # sleep(10)
      if post.is_visible? && !post.is_mail_sent?
        users = User.where(:is_subscribed => true)
        # Send to users
        for user in users
          #UserMailer.subscription_email("Blog Update ##{post.id}", user, post).deliver
        end
        # Update variable
        post.is_mail_sent = true
        post.save
      end
      # Close the connection
      ActiveRecord::Base.connection.close
    end
  end
end
