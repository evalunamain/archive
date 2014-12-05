class CatRentalRequestsController < ApplicationController

  before_action :check_ownership, only: [:approve, :deny]


  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      render :new
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  private
  def cat_rental_request_params
    rental_params = params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
    rental_params[:user_id] = current_user.id
    rental_params
  end

  def check_ownership
    unless CatRentalRequest.find(params[:id]).cat.is_owner?(current_user)
      redirect_to cats_url
    end
  end


end
