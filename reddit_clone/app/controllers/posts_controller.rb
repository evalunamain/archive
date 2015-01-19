class PostsController < ApplicationController
  before_action :require_signed_in
  before_action :require_author, only: [:edit, :update]

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.sub_ids = params[:post][:sub_ids]
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.sub_ids = params[:post][:sub_ids]
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @hash_comments = @post.comments_by_parent_id
    end

  def index

  end

  def destroy

  end



  private
  def post_params
    params.require(:post).permit(:title, :content, :url)
  end

  def require_author
    @post = Post.find(params[:id])
    redirect_to :back unless @post.author == current_user
  end

end
