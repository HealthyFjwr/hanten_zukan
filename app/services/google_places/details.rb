# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

module GooglePlaces
  class Details
    BASE_URL = 'https://places.googleapis.com/v1/places'

    FIELD_MASK = %w[
      id
      displayName
      formattedAddress
      location
      internationalPhoneNumber
      websiteUri
      rating
      userRatingCount
      regularOpeningHours
    ].join(',')

    def self.fetch(place_id, language: 'ja', region: 'JP')
      new(place_id, language:, region:).fetch
    end

    def initialize(place_id, language:, region:)
      @place_id = place_id
      @language = language
      @region = region
      @api_key = ENV.fetch('GOOGLE_PLACES_API_KEY', nil)
    end

    def fetch
      raise 'GOOGLE_PLACES_API_KEY is missing' if @api_key.to_s.strip.empty?

      uri = URI("#{BASE_URL}/#{@place_id}")

      request = Net::HTTP::Get.new(uri)
      request['Content-Type'] = 'application/json'
      request['X-Goog-Api-Key'] = @api_key
      request['X-Goog-FieldMask'] = FIELD_MASK

      request['Accept-Language'] = @language

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.open_timeout = 5
      http.read_timeout = 10

      res = http.request(request)
      raise "HTTP #{res.code} #{res.message} #{res.body}" unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body)
    end
  end
end
