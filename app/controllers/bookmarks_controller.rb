class BookmarksController < ApplicationController
  before_action :set_restaurant, only: %i[create destroy]

  def index
    @bookmarked_restaurants = current_user.bookmarked_restaurants
  end

  def create
    current_user.bookmark(@restaurant)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    current_user.unbookmark(@restaurant)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
