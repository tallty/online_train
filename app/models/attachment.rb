# == Schema Information
#
# Table name: attachments
#
#  id                  :integer          not null, primary key
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  attachmentable_id   :integer
#  attachmentable_type :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Attachment < ActiveRecord::Base
  belongs_to :attachmentable, polymorphic: true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type =>  %w()
end
