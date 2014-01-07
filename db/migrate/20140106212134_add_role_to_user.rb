class AddRoleToUser < ActiveRecord::Migration
  def change
    # Add a role column
    add_column :users, :role, :string
  end
end
