class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :place_id, presence: true, uniqueness: true
end
