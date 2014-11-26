class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :presence => true
  validates :submitter_id, :presence => true
  validates :short_url, :presence => true, :uniqueness => true

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
    ShortenedUrl.create!( submitter_id: user.id, long_url: long_url, short_url: short_url)
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

end
