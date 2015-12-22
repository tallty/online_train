class Material < ActiveRecord::Base
  has_one :attachment, as: :attachmentable

  scope :order_desc, -> {order("updated_at DESC")}

  enum catalog: {
    material: 1,
    professional: 2
  }

  ListCatalog = {
    material: '资料下载',
    professional: '专业人才培养方案'
  }

  scope :is_materials, -> {where(catalog: 1)}
  scope :is_professional, -> {where(catalog: 2)}
end
