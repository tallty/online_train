# == Schema Information
#
# Table name: events
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  content                  :text(65535)
#  classify                 :integer          default(1)
#  picture_url              :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  picture_url_file_name    :string(255)
#  picture_url_content_type :string(255)
#  picture_url_file_size    :integer
#  picture_url_updated_at   :datetime
#  is_competition           :boolean
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
