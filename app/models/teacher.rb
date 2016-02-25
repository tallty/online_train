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

class Teacher < ActiveRecord::Base
  has_many :training_course_teachers, dependent: :destroy
  belongs_to :school
  has_many :appraises, dependent: :destroy

  enum sex: {male: true, female: false}
  Sex = {male: '男', female: '女'}

  validates :name, presence: true
  validates :id_card, presence: true
  validates :school_id, presence: true
  validates :sex, presence: true
  validates :phone, presence: true
  validates :mobile, presence: true
  validates :email, presence: true
end
