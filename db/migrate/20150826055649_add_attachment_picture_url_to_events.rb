class AddAttachmentPictureUrlToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :picture_url
    end
  end

  def self.down
    remove_attachment :events, :picture_url
  end
end
