class Demand < ActiveRecord::Base
  belongs_to :offer, inverse_of: :demands
  belongs_to :term

  validates :offer, :term, presence: true
end
