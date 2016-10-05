class CatRentalsController < ApplicationController
  def index
    @cat_rentals = CatRental.all
    render :index
  end

  def new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental = CatRental.new(cat_rental_params)
    if @cat_rental.save!

    else
    end
  end

  def show
    @cat_rental = CatRental.find(params[:id])
    render :show
  end

  def approve
    @cat_rental = CatRental.find(params[:id])
    @cat_rental.approve!

    redirect_to cat_url(@cat_rental.cat.id)
  end


  private
  def cat_rental_params
    params.require(:cat_rental).permit(:start_date, :end_date, :cat_id)
  end
end
