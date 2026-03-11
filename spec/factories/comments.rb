# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :user
    association :restaurant
    body { '天津飯がうまかったです' }
  end
end
