# == Schema Information
#
# Table name: admins
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
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  role                   :integer
#  qq                     :string(255)
#  mobile                 :string(255)
#  state                  :string(255)
#  phone                  :string(255)
#  address                :string(255)
#  postcode               :string(255)
#  remark                 :text(65535)
#  username               :string(255)
#  adminable_id           :integer
#  adminable_type         :string(255)
#  school_id              :integer
#

class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable

  belongs_to :adminable, polymorphic: true
  belongs_to :school
  has_many :todos
  has_many :training_courses
  has_many :admin_user_tasks
  has_many :appraises

  attr_accessor :province
  attr_accessor :agency

  validates_presence_of     :username
  validates_uniqueness_of   :username
  validates :password, presence: true, length: { minimum:4, maximum: 32 }, on: [:create]
  validates_confirmation_of :password, on: [:create]
  validates_presence_of :province, if: "self.system? || self.trainer?", on: [:create]
  validate :province_uniqueness, if: "self.system?", on: [:create]  #省厅唯一
  validates_presence_of :agency, if: "self.trainer?", on: [:create]
  validate :agency_uniqueness, if: "self.trainer?", on: [:create] #培训机构唯一
  validates_presence_of :school_id, if: "self.management?", on: [:create] #班级负责人所属培训机构
  validates_presence_of :name, if: "self.education? || self.specialist? || self.management?"
  validates_presence_of :email
  validates_presence_of :mobile
  validates_presence_of :phone


  enum role: { system: 0, education: 1, trainer: 2, specialist: 3, management: 4 }
  Role = {  system: "秘书处",
            education: "教育部门",
            trainer: "培训机构",
            specialist: "评审专家",
            management: "班级负责人"
          }

  def province_uniqueness
    if province.present? && Province.where(name: province).limit(1).present?
      errors.add(:province, :repeat)
    end
  end

  def agency_uniqueness
    if agency.present? && School.where(name: agency).limit(1).present?
      errors.add(:agency, :repeat)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup

   login = conditions.delete(:email)

   where(conditions).where(["username = :value", { value: login }]).first
  end

  #登录下拉菜单使用该返回值
  def admin_name
    self.try(:adminable).try(:name)
  end
end
