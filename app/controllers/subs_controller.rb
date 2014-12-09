class SubsController < ApplicationController
  before_action :require_moderator, except: [:show, :index]

  def new
    @sub = current_user.subs.new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def require_moderator
    redirect_to :back unless current_user.moderator_status?
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end


end
