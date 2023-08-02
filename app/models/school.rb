class School < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :courses, dependent: :destroy
  belongs_to :user

  after_save :notify_school_admin, if: Proc.new{|user| user.saved_change_to_user_id? }

  private
  def notify_school_admin
    user_id_was = saved_change_to_user_id[0]
    NotificationWorker.perform_async({school_id: id, user_id_was: user_id_was, action: 'notify_old_school_admin'}) if user_id_was.present?
    NotificationWorker.perform_async({school_id: id, action: 'notify_school_admin'})
  end
end
