class CommentsController < ApplicationController
  # You have to be signed in to add a comment
  before_action :signed_in_user, only: [:create, :update, :destroy]
  # You need to have the right account
  before_action :correct_user, only: [:update, :destroy]
  # Only admins can delete comments
  before_action :admin_user, only: [:destroy]

  def create
    @post = Post.find_by_slug(params[:post_id])
    @comment = @post.comments.build(post_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Added a new comment"
      redirect_to post_path(@post)
    else
      # Show errors and redirect
      flash[:danger] = @comment.errors.full_messages.to_sentence
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find_by_slug(params[:post_id])
    @comment = Comment.find(params[:id])
    # You can only update if it is your comment, or admin, if so then update
    if @comment.update_attributes(post_params)
      flash[:success] = "Comment has been updated."
      redirect_to post_url(@post)
    else
      # Show errors and redirect
      flash[:danger] = @comment.errors.full_messages.to_sentence
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find_by_slug(params[:post_id])
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment has been deleted."
    redirect_to post_path(@post)
  end

private
    # Strong Parameters
    def post_params
      params.require(:comment).permit(:content)
    end
    # Before filters
    # You can only edit comments that you own
    def correct_user
      @comment = Comment.find(params[:id])
      # You have to own the comment, or be admin
      if @comment.user_id != current_user.id && !current_user.admin?
        flash[:warning] = "You are not logged into that account!"
        redirect_to post_url(@comment.post)
      end
    end
    # Only allow admins to do things, if not send them away
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
