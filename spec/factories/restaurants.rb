# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    sequence(:place_id) { |n| "place_#{n}" }
    sequence(:name) { |n| "南海飯店#{n}" }
    address { '大阪府大阪市' }
    latitude { BigDecimal('34.6937') }
    longitude { BigDecimal('135.5023') }
    phone_number { '06-0000-0000' }
    website { 'https://example.com' }
    rating { BigDecimal('4.2') }
    user_rating_count { 123 }
    opening_hours { { 'weekday_text' => ['月: 11:00-20:00'] } }
  end
end
