class AddEmailToUser < ActiveRecord::Migration
  def change
    # Have users follow emails
    add_column :users, :is_subscribed, :boolean, default: true
  end
end
