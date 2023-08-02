class Batch < ApplicationRecord
  validates :name, :course_id, :start_date, :end_date, presence: true
  validates_numericality_of :size, greater_than_or_equal_to: 1
  validates_uniqueness_of :name, scope: [:course_id], if: :dates_overlap?
  validate :course_duration

  has_many :enrollments, dependent: :destroy
  belongs_to :course

  scope :overlaps, ->(start_date, end_date) do
    where("(date(start_date) between ? and ?) or (date(end_date) between ? and ?)", start_date, end_date, start_date, end_date)
  end

  enum status: [:started, :completed, :active, :inactive]

  private
  def dates_overlap?
    Batch.overlaps(start_date, end_date).present?
  end

  def course_duration
    if start_date and (start_date < Date.today)
      errors.add(:start_date, 'must be future date')
    end

    if end_date and (end_date < Date.today)
      errors.add(:end_date, 'must be future date')
    end

    if start_date and end_date and (start_date >= end_date)
      errors.add(:start_date, 'must be less then end_date')
    end
  end
end
