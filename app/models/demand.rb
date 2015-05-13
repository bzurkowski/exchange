class Demand < ActiveRecord::Base
  belongs_to :offer, inverse_of: :demands
  belongs_to :term

  validates :offer, :term, presence: true

  scope :owned_by, ->(user) { joins(offer: { assignation: { schedule: :user } }).where(schedules: { user_id: user }) }
end
