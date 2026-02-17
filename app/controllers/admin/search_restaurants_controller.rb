# frozen_string_literal: true

module Admin
  class SearchRestaurantsController < Admin::BaseController
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

      @selected_place_ids = Array(params[:place_ids]).reject(&:blank?).map(&:to_s)
      if @selected_place_ids.empty?
        flash.now[:alert] = '店舗を選択していません'
        @fetched_details = []
        @saved_restaurants = []
        return render :index
      end

      @fetched_details = []
      @saved_restaurants = []
      errors = []

      @selected_place_ids.each do |place_id|
        begin
          detail = GooglePlaces::Details.fetch(place_id) # ← 既存 details.rb を使う
          @fetched_details << detail

          restaurant = Restaurants::UpsertFromGoogleDetail.call(detail) # ← upsertだけを別サービスへ
          @saved_restaurants << restaurant
        rescue StandardError => e
          errors << "#{place_id}: #{e.message}"
          next
        end
      end

      flash.now[:alert] = "一部の取得/保存で失敗したで: #{errors.join(' / ')}" if errors.any?
      render :index
    end

    private

    def build_query
      [params[:prefecture],
       params[:city],
       params[:keyword]].compact_blank.join(' ')
    end
  end
end
