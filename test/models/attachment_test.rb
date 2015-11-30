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

require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
