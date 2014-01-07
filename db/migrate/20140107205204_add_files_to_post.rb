class AddFilesToPost < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      # Adding two attachments for the post pictures
      t.attachment :thumbnail
      t.attachment :header
    end
  end

  def self.down
    drop_attached_file :posts, :thumbnail
    drop_attached_file :posts, :header
  end
end
