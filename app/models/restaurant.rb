class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :place_id, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name address]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
