class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @approved_rentals = @cat.cat_rentals.order(:start_date)
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save!
      redirect_to cats_url
    else
      redirect_to new_cat_url
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.save!
      redirect_to cats_url
    else
      render :edit
    end
  end




  private
  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :description, :birth_date)
  end
end
