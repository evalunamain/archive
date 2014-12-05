class Cat < ActiveRecord::Base
  COLORS = %w(purple mosaic turtle aquamarine spotted_aquamarine)

  validates :color, inclusion: { in: COLORS }, presence: true
  validates :sex, inclusion: { in: %w( M F )}, presence: true
  validates :name, :user_id, presence: true

  has_many :cat_rental_requests, dependent: :destroy
  belongs_to :user

  def age
    ((Date.today - birth_date) / 365).to_i
  end


  def is_owner?(owner)
    self.user_id == owner.id
  end

end
