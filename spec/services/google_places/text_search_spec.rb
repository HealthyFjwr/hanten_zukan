# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GooglePlaces::TextSearch do
  describe '.call' do
    it 'Places-API-TextSearch をPOSTして候補を返す' do
      ENV['GOOGLE_PLACES_API_KEY'] = 'test-key'

      address = '〒543-0001 大阪府大阪市天王寺区上本町6丁目3-31-231'

      stub_request(:post, 'https://places.googleapis.com/v1/places:searchText')
        .to_return(
          status: 200,
          body: {
            places: [
              {
                id: 'abc123',
                displayName: { text: '南海飯店 本店' },
                formattedAddress: address,
                location: { latitude: 34.0, longitude: 135.0 }
              }
            ]
          }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      result = described_class.call('大阪府 大阪市 南海飯店')

      expect(result).to eq([
                             {
                               place_id: 'abc123',
                               name: '南海飯店 本店',
                               address: address,
                               latitude: 34.0,
                               longitude: 135.0,
                               phone_number: nil,
                               website: nil,
                               opening_hours: nil
                             }
                           ])
    end

    it 'queryが空なら空配列' do
      ENV['GOOGLE_PLACES_API_KEY'] = 'test-key'
      expect(described_class.call('   ')).to eq([])
    end
  end
end
