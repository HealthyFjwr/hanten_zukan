# frozen_string_literal: true

# AdminUser作成（test以外）
unless Rails.env.test?
  admin_email = ENV.fetch('ADMIN_USER', nil)
  admin_password = ENV.fetch('ADMIN_PASS', nil)

  if admin_email.present? && admin_password.present?
    AdminUser.find_or_create_by!(email: admin_email) do |a|
      a.password = admin_password
    end
  else
    puts "⚠️ ADMIN_USER / ADMIN_PASS が未設定やから AdminUser は作らへんで"
  end
end

# ダミーの店舗作成
if Rails.env.development?
  puts "🌱 Creating dummy restaurants..."

  Restaurant.where("place_id LIKE 'dummy_%'").delete_all

  100.times do
    Restaurant.create!(
      place_id: "dummy_#{SecureRandom.uuid}",
      name: "#{Faker::Name.last_name}飯店",
      address: Faker::Address.full_address,
      latitude: Faker::Address.latitude,
      longitude: Faker::Address.longitude,
      phone_number: Faker::PhoneNumber.phone_number
    )
  end

  puts "🌱 Done!"
end