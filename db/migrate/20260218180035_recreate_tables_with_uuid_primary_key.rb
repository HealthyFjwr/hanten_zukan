# frozen_string_literal: true

class RecreateTablesWithUuidPrimaryKey < ActiveRecord::Migration[7.1]
  def up
    drop_table :restaurants, if_exists: true
    drop_table :users, if_exists: true
    drop_table :admin_users, if_exists: true

    create_table :admin_users, id: :uuid do |t|
      t.string :name, default: "", null: false
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps null: false
    end
    add_index :admin_users, :email, unique: true
    add_index :admin_users, :reset_password_token, unique: true

    create_table :restaurants, id: :uuid do |t|
      t.string :place_id, null: false
      t.string :name, null: false
      t.string :address
      t.decimal :latitude, precision: 10, scale: 7, null: false
      t.decimal :longitude, precision: 10, scale: 7, null: false
      t.string :phone_number
      t.string :website
      t.decimal :rating, precision: 2, scale: 1
      t.integer :user_rating_count
      t.jsonb :opening_hours, default: {}, null: false
      t.timestamps null: false
    end
    add_index :restaurants, :name
    add_index :restaurants, :place_id, unique: true
    add_index :restaurants, :rating

    create_table :users, id: :uuid do |t|
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.string :username, default: "", null: false
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :username, unique: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
