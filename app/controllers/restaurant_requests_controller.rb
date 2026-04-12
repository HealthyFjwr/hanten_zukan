# frozen_string_literal: true

class RestaurantRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @restaurant_request = RestaurantRequest.new
  end

  def create
    @restaurant_request = current_user.restaurant_requests.build(request_params)
    if @restaurant_request.save
      redirect_to restaurants_path, notice: t('flash.restaurant_requests.created')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def request_params
    params.require(:restaurant_request).permit(:prefecture, :city, :name)
  end
end
