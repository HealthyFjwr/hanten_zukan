# frozen_string_literal: true

class RestaurantsController < ApplicationController
  before_action :set_q, only: [:index]

  def index
    @restaurants = @q.result(distinct: true).order(:name).page(params[:page])
    @bookmarked_restaurant_ids = current_user.bookmarks.pluck(:restaurant_id) if user_signed_in?
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def autocomplete
    @suggest_keyword = Restaurant.suggest(params[:keyword])
    render json: @suggest_keyword
  end

  private

  def set_q
    @q = Restaurant.ransack(params[:q])
  end

  # update, newアクション追加時に使用
  # def restaurant_params
  #   params.require(:restaurant).permit(:name, :address, :latitude, :longitude, :phone_number)
  # end
end
