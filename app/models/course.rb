class Course < ApplicationRecord
  validates :name, :school_id, presence: true
  validates_uniqueness_of :name, scope: :school_id

  has_many :batches, dependent: :destroy
  belongs_to :school
end
