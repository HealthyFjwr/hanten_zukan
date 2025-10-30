class StaticPagesController < ApplicationController
  before_action :set_q, only: [:top]
  def top
  end

  private
  def set_q
    @q = Restaurant.ransack(params[:q])
  end
end
