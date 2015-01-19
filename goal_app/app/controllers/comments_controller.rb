class CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.new(comment_params)
    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end

    if @comment.commentable_type == "User"
      redirect_to user_url(@comment.commentable_id)
    else
      redirect_to goal_url(@comment.commentable_id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
