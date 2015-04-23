class Term < ActiveRecord::Base
  has_many :assignations
  has_many :schedules, through: :assignations

  belongs_to :subject
  belongs_to :instructor

  validates :subject, :instructor, :starts_at, :ends_at, presence: true
  validates :starts_at, date: { before: :ends_at }
  validates :starts_at, uniqueness: { scope: [:subject_id, :instructor_id] }
  validates :description, length: { maximum: 100 }

  def display_name
    decorate.display_name
  end
end
