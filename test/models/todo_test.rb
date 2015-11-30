# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  state      :boolean          default(FALSE)
#  admin_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
