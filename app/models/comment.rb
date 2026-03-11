# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :body, presence: true, length: { in: 1..256 }

  belongs_to :restaurant
  belongs_to :user
end
