# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'テスト太郎' }
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
  end
end
