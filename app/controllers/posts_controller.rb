class PostsController < ApplicationController
  # Only permit people that are signed in to edit themselves
  #before_action :signed_in_user, except: [:index, :show]
  # Allow admins to access certain things
  #before_action :admin_user, except: [:index, :show]
  # Only allow admins to see drafts
  #before_action :post_visible, only: [:show]

  def index
    # All post that are not drafts, is_draft=false
    @posts = Post.where(:is_visible => true).paginate(:page => params[:page], :per_page => 5)
    # All draft post, for admins
    @post_all = Post.all.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    # Find the Post
    @post = Post.find_by_slug(params[:id])
    # Create new comment
    @comment = Comment.new
    # Pagination, no more then 10 per page
    @comments = @post.comments.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by_slug(params[:id])
  end

  def update
    # Update object
    @post = Post.find_by_slug(params[:id])
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
    Post.find_by_slug(params[:id]).destroy
    flash[:success] = "Post has been deleted."
    redirect_to posts_path
  end

private
    # Strong Parameters
    def post_params
      params.require(:post).permit(:title, :slug, :content, :thumbnail, :header, :is_visible)
    end
    # Before filters
    # Only allow admins to do things, if not send them away
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    # Only allow admins to see drafts
    def post_visible
      # If the post is not visible redirect unless you are an admin
      if !Post.find_by_slug(params[:id]).is_visible? && !(signed_in? && current_user.admin?)
        flash[:warning] = "Nothing is there anymore!"
        redirect_to(posts_path)
      end
    end
    # Email people subscribed
    def email_post_update(post)
      # Create a new thread
      Thread.new do
        #sleep(10)
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
