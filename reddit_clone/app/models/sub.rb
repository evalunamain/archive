class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :moderator_id, numericality: true

  has_many :post_subs, dependent: :destroy

  has_many :posts, through: :post_subs, source: :post

  belongs_to :moderator, class_name: "User", foreign_key: :moderator_id
end
