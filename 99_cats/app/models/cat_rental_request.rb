class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, :user_id, presence: true
  validates :status, inclusion: { in: STATUSES }
  validate :cat_not_approved_twice_at_same_time

  belongs_to :cat

  belongs_to :user

  after_initialize do
    self.status ||= "PENDING"
  end

  def approve!
    CatRentalRequest.transaction do
      self.update!(status: "APPROVED")
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.update!(status: "DENIED")
  end

  private
  def cat_not_approved_twice_at_same_time
    if self.status == "APPROVED" && overlapping_approved_requests?
      errors[:status] << "can't check out same cat to two different places"
    end
  end

  def overlapping_requests
    overlap_where = "start_date <= ? OR ? >= end_date"
    identify_where = "#{id} IS NULL OR id != #{id}"
    CatRentalRequest.distinct.where(overlap_where, self.end_date, self.start_date).where(identify_where)
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def overlapping_approved_requests?
    overlapping_requests.any? { |request| request.status == "APPROVED" }
  end

end
