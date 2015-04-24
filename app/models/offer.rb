class Offer < ActiveRecord::Base
  belongs_to :assignation
  has_many   :demands, inverse_of: :offer

  accepts_nested_attributes_for :demands, allow_destroy: true

  validates :assignation, :demands, presence: true

  enum status: { active: 0, accepted: 1, withdrawn: 2 }
end
