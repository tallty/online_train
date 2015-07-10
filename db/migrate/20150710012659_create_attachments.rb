class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.attachment :avatar
      t.references :attachmentable, polymorphic: true

      t.timestamps null: false
    end

    add_index :attachments, [:attachmentable_id, :attachmentable_type], unique: true
  end
end
