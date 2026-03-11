# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーション' do
    it 'body、user、restaurantがあれば有効である' do
      comment = build(:comment)
      expect(comment).to be_valid
    end

    it 'bodyが空なら無効である' do
      comment = build(:comment, body: nil)

      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include("can't be blank")
    end

    it 'userがなければ無効である' do
      comment = build(:comment, user: nil)

      expect(comment).to be_invalid
      expect(comment.errors[:user]).to be_present
    end

    it 'restaurantがなければ無効である' do
      comment = build(:comment, restaurant: nil)

      expect(comment).to be_invalid
      expect(comment.errors[:restaurant]).to be_present
    end
  end

  describe '関連' do
    it 'userに紐づいている' do
      user = create(:user)
      comment = create(:comment, user: user)

      expect(comment.user).to eq(user)
    end

    it 'restaurantに紐づいている' do
      restaurant = create(:restaurant)
      comment = create(:comment, restaurant: restaurant)

      expect(comment.restaurant).to eq(restaurant)
    end
  end
end
