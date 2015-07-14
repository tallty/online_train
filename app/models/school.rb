# == Schema Information
#
# Table name: schools
#
#  id          :integer          not null, primary key
#  username    :string(255)
#  name        :string(255)
#  province_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class School < ActiveRecord::Base
	has_many :training_courses
  belongs_to :province
end
