# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  id_card    :string(255)
#  position   :string(255)
#  sex        :boolean          default(TRUE)
#  remark     :text(65535)
#  address    :string(255)
#  mobile     :string(255)
#  phone      :string(255)
#  qq         :string(255)
#  email      :string(255)
#  postcode   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  school_id  :integer
#  job_title  :string(255)
#

require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
