class BookmarksController < ApplicationController
  def index
    @bookmarked_restaurants = current_user.bookmarked_restaurants
  end

  def create
    current_user.bookmark(@restaurant)
  end

  def destroy
    current_user.unbookmark(@restaurant)
  end
end
