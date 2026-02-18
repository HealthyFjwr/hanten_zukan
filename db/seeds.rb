# frozen_string_literal: true

return if Rails.env.test?

admin_email = ENV["ADMIN_USER"]
admin_password = ENV["ADMIN_PASS"]

return if admin_email.blank? || admin_password.blank?

if AdminUser.count.zero?
  AdminUser.create!(
    email: admin_email,
    password: admin_password,
    password_confirmation: admin_password,
    name: "管理者"
  )
end
