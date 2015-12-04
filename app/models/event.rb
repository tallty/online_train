# == Schema Information
#
# Table name: events
#
#  id                       :integer          not null, primary key
#  title                    :string(255)
#  content                  :text(65535)
#  classify                 :integer          default(1)
#  picture_url              :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  picture_url_file_name    :string(255)
#  picture_url_content_type :string(255)
#  picture_url_file_size    :integer
#  picture_url_updated_at   :datetime
#  is_competition           :boolean
#

class Event < ActiveRecord::Base
	has_attached_file :picture_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/lunbo.png"

	validates_attachment_content_type :picture_url, content_type: /\Aimage\/.*\Z/

	enum classify: { bulletin: 1, headline: 2, activity: 3, work: 4, intro: 5, contact: 6, teaching: 7 }
	EVENTCLASSIFY = { bulletin: '通知公告', headline: '新闻动态', activity: '活动简报', work: '秘书处事务', intro: '研究会简介', contact: '联系我们', teaching: "教学研究" }
  validates :title, presence: {message: '标题不能空' }
  validates :content, presence: {message: '内容不能空' }

  scope :is_competition, -> { where(is_competition: true) }

  scope :is_contact, -> {where(classify: 6)}
  scope :is_business, -> {where(classify: 4)}
  scope :is_info, -> {where(classify: 5)}
  scope :is_teaching, -> {where(classify: 7)}
  scope :is_activity, -> {where(classify: 3)}
  scope :is_headline, -> {where(classify: 2)}

  scope :keyword, -> (keyword) do
    return all if keyword.blank?
    where("events.title like ?", "%#{keyword}%")
  end
end
