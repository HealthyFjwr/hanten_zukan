# frozen_string_literal: true

module Admin
  class RestaurantsController < Admin::BaseController
    before_action :set_q, only: [:index]
    before_action :set_restaurant, only: %i[show destroy]

    def index
      @restaurants = @q.result(distinct: true).order(created_at: :desc)
    end

    def show; end

    def destroy
      @restaurant.destroy!
      redirect_to admin_restaurants_path, notice: t('flash.deleted')
    end

    private

    def set_q
      @q = Restaurant.ransack(params[:q])
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end
  end
end
