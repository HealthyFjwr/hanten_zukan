class RestaurantsController < ApplicationController
  before_action :set_q, only: [:index]

  def index
    @restaurants = @q.result(distinct: true).order(:name)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def set_q
    @q = Restaurant.ransack(params[:q])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :latitude, :longitude, :is_chain, :is_machi_chuka)
  end
end