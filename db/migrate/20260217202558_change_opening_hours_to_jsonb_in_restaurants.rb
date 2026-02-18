class ChangeOpeningHoursToJsonbInRestaurants < ActiveRecord::Migration[7.1]
  def change
    remove_column :restaurants, :opening_hours
    add_column :restaurants, :opening_hours, :jsonb, default: {}, null: false
  end
end
