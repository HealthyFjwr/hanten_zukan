# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

module GooglePlaces
  class TextSearch
    ENDPOINT = 'https://places.googleapis.com/v1/places:searchText'

    # 返したいフィールドだけ指定（これ超重要）
    FIELD_MASK = [
      'places.id',
      'places.displayName',
      'places.formattedAddress',
      'places.location'
    ].join(',')

    def self.call(query, language: 'ja')
      new(query, language:).call
    end

    def initialize(query, language:)
      @query = query
      @language = language
      @api_key = ENV.fetch('GOOGLE_PLACES_API_KEY', nil)
    end

    def call
      return [] if @query.to_s.strip.empty?
      raise 'GOOGLE_PLACES_API_KEY is missing' if @api_key.blank?

      uri = URI(ENDPOINT)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json'
      req['X-Goog-Api-Key'] = @api_key
      req['X-Goog-FieldMask'] = FIELD_MASK
      req['Accept-Language'] = @language

      req.body = {
        textQuery: @query,
        languageCode: @language,
        regionCode: 'JP'
      }.to_json

      res = http.request(req)
      raise "HTTP #{res.code} #{res.message} #{res.body}" unless res.is_a?(Net::HTTPSuccess)

      body = JSON.parse(res.body)
      normalize(body['places'] || [])
    end

    private

    def normalize(places)
      places.map do |p|
        {
          place_id: p['id'],
          name: p.dig('displayName', 'text'),
          address: p['formattedAddress'],
          latitude: p.dig('location', 'latitude'),
          longitude: p.dig('location', 'longitude'),

          # TextSearch段階では取らない（Detailsで取る）
          phone_number: nil,
          website: nil,
          opening_hours: nil
        }
      end
    end
  end
end
