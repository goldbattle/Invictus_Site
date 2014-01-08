class CommentsController < ApplicationController
  # Set the @post variable
  before_action :set_post, only: [:create, :update, :destroy]
  # Authentication
  load_and_authorize_resource

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    # Save comment
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
    @comment = Comment.find(params[:id])
    # Update comment
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment has been updated."
      redirect_to post_url(@post)
    else
      # Show errors and redirect
      flash[:danger] = @comment.errors.full_messages.to_sentence
      redirect_to post_path(@post)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment has been deleted."
    redirect_to post_path(@post)
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find_by_slug(params[:post_id])
  end
  # Strong Parameters
  def comment_params
    params.require(:comment).permit(:content)
  end
end
