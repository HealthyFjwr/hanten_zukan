# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true, length: { maximum: 15 }

  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_restaurants, through: :bookmarks

  def bookmark(restaurant)
    bookmarked_restaurants << restaurant
  end

  def unbookmark(restaurant)
    bookmarked_restaurants.destroy(restaurant)
  end

  def bookmark?(restaurant)
    bookmarked_restaurants.include?(restaurant)
  end
end
