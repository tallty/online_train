class Material < ActiveRecord::Base
  has_one :attachment, as: :attachmentable
end
