class AddColumnToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :rating, :decimal, precision: 2, scale: 1
    add_column :restaurants, :user_rating_count, :integer

    add_index :restaurants, :rating
  end
end
