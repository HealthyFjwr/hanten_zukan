# frozen_string_literal: true

class RestaurantRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @restaurant_request = RestaurantRequest.new
  end

  def create
    @restaurant_request = current_user.restaurant_requests.build(request_params)
    if @restaurant_request.save
      redirect_to restaurants_path, notice: '申請を送信しました。管理者が確認します。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def request_params
    params.require(:restaurant_request).permit(:prefecture, :city, :name)
  end
end
