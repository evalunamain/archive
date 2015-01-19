class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true

  belongs_to :author, class_name: "User", foreign_key: :author_id

  belongs_to :post

  has_many :child_comments, foreign_key: :parent_comment_id, class_name: "Comment"

  belongs_to :parent_comment, foreign_key: :parent_comment_id, class_name: "Comment"

end
