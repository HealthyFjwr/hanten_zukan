# frozen_string_literal: true

# 改修予定
class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :place_id, presence: true, uniqueness: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_many :comments, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[name address]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def self.suggest(keyword)
    front = select(:id, :name).where('name LIKE ?', "#{keyword}%")
    partial = select(:id, :name)
              .where('name LIKE ?', "%#{keyword}%")
              .where.not(id: front.ids)
              .limit(10)
    front + partial
  end
end
