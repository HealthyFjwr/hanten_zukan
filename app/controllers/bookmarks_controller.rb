class BookmarksController < ApplicationController
  def index
    @restaurants = current_user.bookmarked_restaurants.include(:user).order(created_ad: :desc)
  end

  def create
    current_user.bookmark(@restaurant)
  end

  def destroy
    current_user.unbookmark(@restaurant)
  end
end
