class Post < ActiveRecord::Base
  validates :body, :title, presence: true
end
