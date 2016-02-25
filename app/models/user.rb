# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  name                   :string(255)
#  ID_number              :string(255)
#  gender                 :boolean          default(TRUE)
#  birth                  :date
#  school                 :string(255)
#  academy                :string(255)
#  certificate            :string(255)
#  nation                 :string(255)
#  position_name          :string(255)
#  position               :string(255)
#  address                :string(255)
#  zip_code               :string(255)
#  telephone              :string(255)
#  phone                  :string(255)
#  qq_no                  :string(255)
#  summary                :text(65535)
#  created_at             :datetime
#  updated_at             :datetime
#  country                :string(255)
#  his_train              :text(65535)
#  profession             :string(255)
#  role                   :integer
#

class User < ActiveRecord::Base

  #acts_as_easy_captcha
  has_many :user_training_courses, dependent: :destroy
  has_many :training_courses, through: :user_training_courses
  has_many :user_tasks, dependent: :destroy
  has_many :user_messages, dependent: :destroy
  has_many :messages, through: :user_messages
  has_many :appraises, dependent: :destroy
  has_many :journals, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  enum gender: {male: true, female: false}
  UserGender = {male: '男', female: '女'}

  enum role: { full_time: 1, part_time: 0 }
  ROLE = { full_time: "专职教师", part_time: "兼职教师" }

  #创建消息
  after_create do
    message = Message.create!(title: "注册成功", content: "#{self.name},欢迎你注册上海高等职业教育师资公共培训统一管理平台")
    UserMessage.create!(user_id: self.id, message_id: message.id)
  end

  attr_accessor :is_vaild

  validates :name, presence: true
  validates :password, presence: true, if: "is_vaild.blank?"
  validates :password, length: { minimum:4, maximum: 32 }, if: "password.present?"
  validates_confirmation_of :password
  validates :ID_number, presence: true
  validates :nation, presence: true
  validates :gender, presence: true
  validates :birth, presence: {message: :date_format }
  validates :school, presence: true
  validates :academy, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :telephone, presence: true
  validates :phone, presence: true
  validates :role, presence: true
  validates :position, presence: true
  validates :position_name, presence: true


  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def get_user_task_by_task task
    UserTask.where(user_id: self.id, task_id: task.id).first
  end

  #搜索功能
  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    where(
      'users.name LIKE ?
      OR users.email LIKE ?
      OR users.telephone LIKE ?',
      "%#{keyword}%",
      "%#{keyword}%",
      "%#{keyword}%"
    )
  end

end
