class CommentsController < ApplicationController

  def index
    @commentable = find_commentable
    @comments = @commentable.comments
    render json: @comments
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def comment_params
    comment_params = params.require(:comment).permit(:user_id, :contact_id, :body)

    if comment_params[:contact_id]
      comment_params[:commentable_id], comment_params[:commentable_type] = params[:contact_id], "Contact"
      comment_params.delete(:contact_id)
    else
      comment_params[:commentable_id], comment_params[:commentable_type] = params[:user_id], "User"
      comment_params.delete(:user_id)
    end

    comment_params
  end

end
