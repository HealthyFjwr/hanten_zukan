# frozen_string_literal: true

return if Rails.env.test?

admin_email = ENV.fetch('ADMIN_USER', nil)
admin_password = ENV.fetch('ADMIN_PASS', nil)

return if admin_email.blank? || admin_password.blank?

if AdminUser.none?
  AdminUser.create!(
    email: admin_email,
    password: admin_password,
    password_confirmation: admin_password,
    name: '管理者'
  )
end
