class ProposedExchange < ActiveRecord::Base
  has_many :proposed_exchange_demands, dependent: :delete_all
  has_many :demands, through: :proposed_exchange_demands
  belongs_to :subject

  before_validation :set_demands_hash

  validates :demands_hash, presence: true, uniqueness: true
  validates :subject, presence: true
  validate  :all_demands_are_for_proper_subject
  validate  :demands_match_offers

  scope :only_involved_with, ->(user) { joins(demands: { offer: { assignation: { schedule: :user } } }).where(schedules: { user_id: user }) }

  def accept(user:)
    proposed_user_demands = proposed_exchange_demands.where(demand: demands.owned_by(user))
    raise "No demands owned by this user" if proposed_user_demands.empty?

    proposed_user_demands.update_all status: ProposedExchangeDemand.statuses[:accepted]

    Resque.enqueue ExchangeMakerJob, id
  end

  def accepted?
    proposed_exchange_demands.select("DISTINCT status").map(&:status) == ["accepted"]
  end

  def set_demands_hash
    self.demands_hash = demand_ids.sort.hash
  end

  def accepted_count
    proposed_exchange_demands.accepted.count
  end

  def needed_acceptances_count
    proposed_exchange_demands.count
  end

  private

  def all_demands_are_for_proper_subject
    return if subject.nil?

    errors.add(:demands, :invalid_subject) unless demands.joins(:term).where("term.subject_id <> ?", subject_id).empty?
  end

  def demands_match_offers
    requested_term_ids = demands.map(&:term_id)
    offered_term_ids   = demands.map { |demand| demand.offer.assignation.term_id }

    errors.add(:demands, :invalid_exchange) unless requested_term_ids.sort == offered_term_ids.sort
  end
end
