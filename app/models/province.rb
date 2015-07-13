# == Schema Information
#
# Table name: provinces
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Province < ActiveRecord::Base
  has_one :admin, as: :adminable #一个省厅有一个账户

  validates_presence_of     :username
  validates_uniqueness_of   :username
  validates_presence_of     :name
  validates_uniqueness_of   :name
end
