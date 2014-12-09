class PostSub < ActiveRecord::Base
  validates :post, :sub_id, presence: true
  belongs_to :post
  belongs_to :sub
end
