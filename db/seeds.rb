# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

return if Rails.env.test?

admin_email = ENV["ADMIN_USER"]
admin_password = ENV["ADMIN_PASSWORD"]

return if admin_email.blank? || admin_password.blank?

User.find_or_create_by!(email: admin_email) do |u|
  u.password = admin_password
  u.admin = true
  u.username = "admin"
end