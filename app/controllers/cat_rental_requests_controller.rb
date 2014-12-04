class CatRentalRequestsController < ApplicationController

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to(cat_rental_request_url(@cat_rental_request))
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
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end


end
