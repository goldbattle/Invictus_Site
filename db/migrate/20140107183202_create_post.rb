class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      # Content
      t.string :title
      t.string :slug
      t.text :content
      # Tracking
      t.integer :user_id
      t.integer :view_count
      # Booleans
      t.boolean :is_visible, default: false
      t.boolean :is_mail_sent, default: false
      # Dates
      t.timestamps
    end
    # Allow finding the index based on user ID, and created at
    add_index :posts, [:user_id, :created_at]
    # Allow fast getting of urls
    add_index  :posts, :slug
  end
end
