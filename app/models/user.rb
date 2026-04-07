# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  validates :username, presence: true, uniqueness: true, length: { maximum: 15 }

  # Googleログイン時にユーザーを検索 or 新規作成するクラスメソッド
  # auth はGoogleから返ってくる認証情報（uid, email, nameなど）が入ったオブジェクト
  def self.from_omniauth(auth)
    # provider（"google_oauth2"）と uid（GoogleのユーザーID）の組み合わせで検索
    # 見つからなければ新しいレコードを作る
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # 新規作成時だけここが実行される
      user.email    = auth.info.email       # Googleアカウントのメールアドレス
      user.username = auth.info.name        # Googleアカウントの名前
      user.password = Devise.friendly_token # ランダムなパスワードを自動生成（Google認証なので使わない）
    end
  end

  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_restaurants, through: :bookmarks, source: :restaurant

  def bookmark(restaurant)
    bookmarked_restaurants << restaurant
  end

  def unbookmark(restaurant)
    bookmarked_restaurants.destroy(restaurant)
  end

  def bookmark?(restaurant)
    bookmarked_restaurants.include?(restaurant)
  end
end
