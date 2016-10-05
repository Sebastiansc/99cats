class CatRental < ActiveRecord::Base
  STATUSES = ["PENDING", "APPROVED", "DENIED"]
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
  validate :overlapping_approved_requests

  belongs_to :cat

  def overlapping_requests
    CatRental.where(start_date: self.start_date..self.end_date)
  end

  def overlapping_approved_requests
    if overlapping_requests.exists?(status: "APPROVED")
      self.errors[:unavailable] << "dates requested for this cat"
    end
  end

  def approve!
    CatRental.transaction do
      self.update_attributes(status: "APPROVED")
      deny!
    end
  end

  def deny!
    overlapping_requests.where(status: "PENDING").
    update_all(status: "DENIED")
  end

  def pending?
    CatRental.exists?(status: "PENDING", cat_id: self.cat_id)
  end

end
