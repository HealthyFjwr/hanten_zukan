# frozen_string_literal: true

module Restaurants
  class ImportFromGoogleDetails
    Result = Struct.new(:saved_restaurants, :errors, keyword_init: true) do
      def saved_count
        saved_restaurants.size
      end

      def failed?
        errors.any?
      end
    end

    def self.call(place_ids)
      new(place_ids).call
    end

    def initialize(place_ids)
      @place_ids = Array(place_ids).compact_blank.map(&:to_s)
    end

    def call
      saved_restaurants = []
      errors = []

      @place_ids.each do |place_id|
        detail = GooglePlaces::Details.fetch(place_id)
        restaurant = Restaurants::UpsertFromGoogleDetail.call(detail)
        saved_restaurants << restaurant
      rescue StandardError => e
        errors << "#{place_id}: #{e.message}"
      end

      Result.new(saved_restaurants:, errors:)
    end
  end
end
