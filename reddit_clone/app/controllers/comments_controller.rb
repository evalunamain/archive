class CommentsController < ApplicationController

  before_action :require_signed_in, only: [:create]

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end


  def show
    @comment = Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:parent_comment_id, :content, :post_id)
  end

end
