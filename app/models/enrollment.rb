class Enrollment < ApplicationRecord
  validates :batch_id, :user_id, presence: true
  validates_uniqueness_of :batch_id, scope: :user_id

  belongs_to :batch
  belongs_to :user

  enum status: [:pending, :accepted, :rejected]

  delegate :course_id, to: :batch, allow_nil: true
  delegate :school_id, to: :batch, allow_nil: true

  before_create :set_status
  after_save :status_update_notification, if: Proc.new{|enrollment| enrollment.saved_change_to_status? }

  private
  def set_status
    self.status = 'pending'
  end

  def status_update_notification
    NotificationWorker.perform_async({enrollment_id: id, action: 'enrollment_status_update'})
  end
end
