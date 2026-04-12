# frozen_string_literal: true

class CreateRestaurantRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_requests, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :name, null: false
      t.string :status, null: false, default: 'pending'

      t.timestamps
    end

    add_index :restaurant_requests, :status
  end
end
