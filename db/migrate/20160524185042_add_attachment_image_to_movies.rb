class AddAttachmentImageToMovies < ActiveRecord::Migration
  def self.up
    remove_column :movies, :image
    change_table :movies do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :movies, :image
  end
end
