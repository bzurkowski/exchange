class ProposedExchangeDemand < ActiveRecord::Base
  belongs_to :proposed_exchange
  belongs_to :demand

  validates :proposed_exchange, :demand, presence: true

  enum status: { proposed: 0, accepted: 1 }

  def owner
    demand.offer.assignation.schedule.user
  end
end
