# == Schema Information
#
# Table name: training_courses
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  code                :string(255)
#  start_time          :datetime
#  end_time            :datetime
#  plan_number         :integer
#  grade_leader        :string(255)
#  training_agency     :string(255)
#  training_address    :string(255)
#  training_fee        :decimal(5, 2)
#  state               :string(255)
#  remark              :text(65535)
#  info                :string(255)
#  training_background :string(255)
#  training_target     :string(255)
#  training_content    :text(65535)
#  check_method        :text(65535)
#  project_leader      :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  contact             :string(255)
#

class TrainingCourse < ActiveRecord::Base
end
