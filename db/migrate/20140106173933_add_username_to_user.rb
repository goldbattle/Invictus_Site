class AddUsernameToUser < ActiveRecord::Migration
  def change
    # We want users to have usernames
    add_column :users, :username, :string, :unique => true
  end
end
