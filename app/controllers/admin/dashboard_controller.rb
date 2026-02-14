# frozen_string_literal: true

module Admin
  class DashboardController < Admin::BaseController
    def index
      @restaurant_count = Restaurant.count
      @recent_restaurants = Restaurant.order(create_at: :desc).limit(10)
    end
  end
end
