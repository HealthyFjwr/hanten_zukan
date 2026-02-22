# frozen_string_literal: true


module Admin
  class RestaurantsController < Admin::BaseController
    before_action :set_q, only: [:index]

    def index
      @restaurants = @q.result(distinct: true).order(created_at: :desc)
    end

    def show
      @restaurant = Restaurant.find(params[:id])
    end

    def destroy

    end

    private

    def set_q
      @q = Restaurant.ransack(params[:q])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :latitude, :longitude)
    end
  end
end
