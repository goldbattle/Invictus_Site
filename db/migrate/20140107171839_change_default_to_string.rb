class ChangeDefaultToString < ActiveRecord::Migration
  def change
    # Default user is registered
    change_column :users, :role, :string, :default => "registered"
  end
end
