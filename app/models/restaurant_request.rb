# frozen_string_literal: true

class RestaurantRequest < ApplicationRecord
  belongs_to :user

  validates :prefecture, presence: true
  validates :city, presence: true
  validates :name, presence: true
  validates :status, inclusion: { in: %w[pending approved rejected] }

  scope :pending, -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }
  scope :rejected, -> { where(status: 'rejected') }
  scope :recent, -> { order(created_at: :desc) }
end
