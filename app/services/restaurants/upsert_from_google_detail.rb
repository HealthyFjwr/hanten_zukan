# frozen_string_literal: true

module Restaurants
  class UpsertFromGoogleDetail
    def self.call(detail)
      new(detail).call
    end

    def initialize(detail)
      @detail = detail
    end

    def call
      place_id = @detail['id'].to_s
      raise 'place_id が取得できませんでした' if place_id.blank?

      restaurant = Restaurant.find_or_initialize_by(place_id: place_id)
      restaurant.assign_attributes(build_attributes(@detail))
      restaurant.save!
      restaurant
    end

    private

    def build_attributes(detail)
      {
        name: detail.dig('displayName', 'text').to_s,
        address: detail['formattedAddress'].to_s,
        latitude: detail.dig('location', 'latitude'),
        longitude: detail.dig('location', 'longitude'),
        phone_number: detail['internationalPhoneNumber'],
        website: detail['websiteUri'],
        rating: detail['rating'],
        user_rating_count: detail['userRatingCount'],
        opening_hours: detail['regularOpeningHours']
      }
    end
  end
end
