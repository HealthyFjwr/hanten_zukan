# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'associations' do
    it 'userに属していること' do
      bookmark = build(:bookmark)
      expect(bookmark.user).to be_present
    end

    it 'restaurantに属していること' do
      bookmark = build(:bookmark)
      expect(bookmark.restaurant).to be_present
    end
  end

  describe 'validations' do
    it 'userがないと無効' do
      bookmark = build(:bookmark, user: nil)
      expect(bookmark).not_to be_valid
    end

    it 'restaurantがないと無効' do
      bookmark = build(:bookmark, restaurant: nil)
      expect(bookmark).not_to be_valid
    end

    it '同じuserとrestaurantの組み合わせは重複できない' do
      user = create(:user)
      restaurant = create(:restaurant)

      create(:bookmark, user: user, restaurant: restaurant)
      duplicate = build(:bookmark, user: user, restaurant: restaurant)

      expect(duplicate).not_to be_valid
    end
  end
end
