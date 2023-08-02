class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :name, :email, presence: true

  has_many :enrollments, dependent: :destroy
  has_many :schools

  enum kind: [:student, :school_admin, :admin]

  after_create :send_welcome_email
  after_save :role_update_notification, if: Proc.new{|user| user.saved_change_to_kind? }
  after_destroy :reset_school_admin, if: Proc.new{|user| user.school_admin? }

  delegate :can?, :cannot?, to: :ability

  def ability
    @ability ||= Ability.new(self)
  end

  private

  def reset_school_admin
    schools.update_all(user_id: nil)
  end

  def send_welcome_email
    NotificationWorker.perform_async({user_id: id, action: 'welcome'})
  end

  def role_update_notification
    NotificationWorker.perform_async({user_id: id, action: 'user_role_update'}) if (admin? or school_admin?)
  end
end
