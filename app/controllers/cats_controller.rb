class CatsController < ApplicationController

  before_action :check_ownership, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @cat_rental_requests = @cat.cat_rental_requests.order(:start_date)

    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to(cat_url(@cat))
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to(cat_url(@cat))
    else
      render :edit
    end
  end

  private

  def cat_params
    cat_params = params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
    cat_params[:user_id] = current_user.id
    cat_params
  end

  def check_ownership
    unless Cat.find(params[:id]).is_owner?(current_user)
      redirect_to cats_url
    end
  end

end
