class GoalsController < ApplicationController
  before_action :ensure_signed_in, except: :show

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    if @goal.privacy == "Private" &&
      @goal.author != current_user
      redirect_to user_url(@goal.user_id)
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    goal = Goal.find(params[:id]).destroy
    redirect_to user_url(goal.author)
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :body, :privacy, :completed)
  end
end
