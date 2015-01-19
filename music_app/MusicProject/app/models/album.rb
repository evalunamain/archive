class Album < ActiveRecord::Base
  validates :band_id, presence: true
  validates :title, presence: true, uniqueness: true

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
