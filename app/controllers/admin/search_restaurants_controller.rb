# frozen_string_literal: true

module Admin
  class SearchRestaurantsController < Admin::BaseController
    def index
      @query = ''
      @candidates = []
    end

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

    private

    def build_query
      [params[:prefecture],
       params[:city],
       params[:keyword]].compact_blank.join(' ')
    end
  end
end
