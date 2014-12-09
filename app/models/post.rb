class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to :author, class_name: "User"

  has_many :post_subs, inverse_of: :post, dependent: :destroy

  has_many :subs, through: :post_subs, source: :sub

  has_many :comments, inverse_of: :post

  def comments_by_parent_id
    all_comments = self.comments.includes(:author)
    hash_comments = Hash.new { [] }

    all_comments.each do |comment|
      hash_comments[comment.parent_comment_id] += [comment]
    end
    hash_comments
  end

end
#
# post_params
#
# post_sub_params
#
# post = Post.new(post_params)
# post_sub = post.post_subs.new(post_sub_params)
# post.save
#
#
# post_sub.post #
#
# class PostSub
#
#   validates :post, presence: true
#
# end
#
