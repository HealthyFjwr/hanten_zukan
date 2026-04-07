class AddOmniauthToUsers < ActiveRecord::Migration[7.1]
  def change
    # どのサービスでログインしたか（例: "google_oauth2"）
    add_column :users, :provider, :string

    # Google側のユーザーID（Googleが発行する一意の識別子）
    add_column :users, :uid, :string

    # provider と uid の組み合わせで高速検索できるようにインデックスを追加
    add_index :users, [:provider, :uid], unique: true
  end
end
