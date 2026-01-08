# frozen_string_literal: true

# 改修予定
class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :place_id, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name address]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
