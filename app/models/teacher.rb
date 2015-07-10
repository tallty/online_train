# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  id_card    :string(255)
#  province   :string(255)
#  position   :string(255)
#  sex        :string(255)
#  remark     :text(65535)
#  address    :string(255)
#  mobile     :string(255)
#  phone      :string(255)
#  qq         :string(255)
#  email      :string(255)
#  postcode   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Teacher < ActiveRecord::Base
end
