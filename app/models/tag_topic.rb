class TagTopic < ActiveRecord::Base

  has_many(
    :tags,
    :class_name => "Tagging",
    :foreign_key => :topic_id,
    :primary_key => :id
  )

  has_many(
    :tagged_urls,
    :through => :tags,
    :source => :url
  )

end
