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

  def most_popular_urls(n)

    tagged_urls
      .joins('JOIN visits ON shortened_urls.id = visits.short_url_id')
      .group("shortened_urls.id")
      .order('count(visits.id) desc')
      .limit(n)
      .pluck(:long_url)
    #
    # most_popular = ShortenedUrl.find_by_sql(<<-SQL)
    # SELECT
    #   shortened_urls.long_url
    # FROM
    #   shortened_urls
    # JOIN
    #   taggings ON (taggings.url_id = shortened_urls.id)
    # JOIN
    #   tag_topics ON (tag_topics.id = taggings.topic_id)
    # JOIN
    #   visits ON (shortened_urls.id = visits.short_url_id)
    # WHERE
    #   tag_topics.id = 1
    # GROUP BY
    #   shortened_urls.id
    # ORDER BY
    #   COUNT(visits.id) DESC
    # LIMIT
    #   5
    # SQL

  end
end
