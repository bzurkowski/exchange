class ProposedExchangeDemand < ActiveRecord::Base
  belongs_to :proposed_exchange
  belongs_to :demand

  validates :proposed_exchange, :demand, presence: true

  enum status: { proposed: 0, accepted: 1 }

  after_update :make_exchange, if: ->(demand) { demand.status_was == "proposed" and demand.status == "accepted" }

  def owner
    demand.offer.assignation.schedule.user
  end

  private

  def make_exchange
    Resque.enqueue ExchangeMakerJob, proposed_exchange_id
  end
end
