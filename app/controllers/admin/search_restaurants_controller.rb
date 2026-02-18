# frozen_string_literal: true

module Admin
  class SearchRestaurantsController < Admin::BaseController
    before_action :set_db_stats, only: %i[index search create]

    def index
      @query = ''
      @candidates = []
    end

    # text_search
    def search
      @query = build_query
      @candidates = @query.present? ? GooglePlaces::TextSearch.call(@query) : []
      @selected_place_ids = Array(params[:place_ids])
      render :index
    rescue StandardError => e
      @candidates = []
      @selected_place_ids = []
      flash.now[:alert] = e.message
      render :index
    end

    # details
    def create
      @query = session[:admin_search_query].to_s
      @candidates = session[:admin_search_candidates] || []

      @selected_place_ids = Array(params[:place_ids]).compact_blank.map(&:to_s)
      if @selected_place_ids.empty?
        # I18n 未設定 2026/02/18
        flash.now[:alert] = t('admin.search_restaurants.select_required')
        @saved_restaurants = []
        return render :index
      end

      result = Restaurants::ImportFromGoogleDetails.call(@selected_place_ids)

      @saved_restaurants = result.saved_restaurants

      flash.now[:notice] = "保存完了: #{result.saved_count}件" if result.saved_count.positive?
      flash.now[:alert] = "一部の取得/保存で失敗したで: #{result.errors.join(' / ')}" if result.failed?

      render :index
    end

    private

    def build_query
      [params[:prefecture],
       params[:city],
       params[:keyword]].compact_blank.join(' ')
    end

    def set_db_stats
      @restaurant_count = Restaurant.count
    end
  end
end
