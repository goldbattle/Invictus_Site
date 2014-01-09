class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      # Content
      t.string :title
      t.text :content
      t.integer :weight_id
      t.boolean :is_public, default: false
      t.boolean :is_private, default: false
      # Dates
      t.timestamps
    end
    # Index on weight
    add_index  :downloads, :weight_id
  end
end
