class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string  :place_id, null: false #プレイスID(PlacesAPIのID)
      t.string  :name, null: false #店名
      t.string  :address #住所
      t.decimal :latitude, precision: 10, scale: 7, null: false #緯度
      t.decimal :longitude, precision: 10, scale: 7, null: false #経度
      t.string  :phone_number #電話番号
      t.string  :website #ウェブサイト
      t.text    :opening_hours #営業時間
      t.boolean :is_chain, default: false
      t.boolean :is_machi_chuka, default: false

      t.timestamps
    end

    add_index :restaurants, :place_id, unique: true
    add_index :restaurants, :name
  end
end