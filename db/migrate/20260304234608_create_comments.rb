class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :restaurant, null: false, foreign_key: true, type: :uuid
      t.text :body, null: false

      t.timestamps
    end
  end
end
