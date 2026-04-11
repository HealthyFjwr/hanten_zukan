# frozen_string_literal: true

module Admin
  class RestaurantRequestsController < Admin::BaseController
    before_action :set_request, only: %i[approve reject destroy]

    def index
      # statusでタブ切り替えできるように全件取得
      @pending_requests  = RestaurantRequest.pending.recent.includes(:user)
      @approved_requests = RestaurantRequest.approved.recent.includes(:user)
      @rejected_requests = RestaurantRequest.rejected.recent.includes(:user)
    end

    # PATCH /admin/restaurant_requests/:id/approve
    def approve
      @restaurant_request.update!(status: 'approved')
      redirect_to admin_restaurant_requests_path, notice: '申請を承認しました'
    end

    # PATCH /admin/restaurant_requests/:id/reject
    def reject
      @restaurant_request.update!(status: 'rejected')
      redirect_to admin_restaurant_requests_path, notice: '申請を却下しました'
    end

    # DELETE /admin/restaurant_requests/:id
    def destroy
      @restaurant_request.destroy!
      redirect_to admin_restaurant_requests_path, notice: '申請を削除しました'
    end

    private

    def set_request
      @restaurant_request = RestaurantRequest.find(params[:id])
    end
  end
end
