class RenameAdminsToAdminUsers < ActiveRecord::Migration[7.1]
  def change
    return unless table_exists?(:admins)
    return if table_exists?(:admin_users)

    rename_table :admins, :admin_users
  end
end
