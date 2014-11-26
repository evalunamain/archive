class Visit < ActiveRecord::Base
  validates :visitor_id, :short_url_id, :presence => true

  def self.record_visit!(user, shortened_url)
    Visit.create!(:visitor_id => user.id, :short_url_id => shortened_url.id)
  end
end
