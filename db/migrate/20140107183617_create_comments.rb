class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      # Content
      t.text :content
      # Tracking
      t.integer :user_id
      t.integer :post_id
      # Dates
      t.timestamps
    end
    # Allow finding the index based on user ID, and created at
    add_index :comments, [:user_id, :created_at]
    # Allow getting of comments based on post ID
    add_index :comments, :post_id
  end
end
