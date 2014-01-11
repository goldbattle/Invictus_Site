class AddOldPasswordsToUsers < ActiveRecord::Migration
  def change
    # Old password
    add_column :users, :legacy_password_hash, :string
  end
end
