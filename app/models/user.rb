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
#

class User < ActiveRecord::Base

  #acts_as_easy_captcha
  has_many :user_training_courses

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum gender: {male: true, female: false}
  UserGender = {male: '男', female: '女'}

  validates :name, presence: true
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


  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

end
