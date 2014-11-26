class ShortenedUrl < ActiveRecord::Base

  validates :long_url, :presence => true, :length => { maximum: 1024 }
  validates :submitter_id, :presence => true
  validates :short_url, :presence => true, :uniqueness => true
  validate :check_for_frequent_submissions


  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => :submitter_id,
    :primary_key => :id)

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :short_url_id,
    :primary_key => :id
    )

  has_many(
    :visitors,
    -> { distinct },
    :through => :visits,
    :source => :visitor
    )

  has_many(
    :tags,
    :class_name => "Tagging",
    :foreign_key => :url_id,
    :primary_key => :id
  )

  has_many(
    :tagged_topics,
    :through => :tags,
    :source => :topic
  )

  def self.random_code
    unique = false

    until unique
      random_string = SecureRandom.urlsafe_base64[0...16]
      unique = !ShortenedUrl.exists?(short_url: random_string)
    end

    random_string
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = random_code
    user.submitted_urls.create!(long_url: long_url, short_url: short_url)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select(:visitor_id).where("created_at > ?", 10.minutes.ago).distinct.count
  end

  private

  def check_for_frequent_submissions
    if (5 <= ShortenedUrl.select(:id).where("submitter_id = ? AND created_at > ?", submitter_id, 5.minutes.ago).count)
      errors[:frequency] << "user has submitted too much too recently!"
    end
  end

end
