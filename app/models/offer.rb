class Offer < ActiveRecord::Base
  belongs_to :assignation
  has_many   :demands, inverse_of: :offer, dependent: :destroy
  has_many   :requested_terms, through: :demands, source: :term

  accepts_nested_attributes_for :demands, allow_destroy: true

  validates :assignation, :demands, :requested_terms, presence: true
  validate  :active_offer_assignation_uniqueness

  enum status: { active: 0, accepted: 1, withdrawn: 2 }

  scope :by_subject, ->(subject) { joins(assignation: :term).where(terms: { subject_id: subject }) }

  private

  def active_offer_assignation_uniqueness
    return unless assignation.present?
    errors.add(:assignation, :taken) if Offer.where.not(id: id).where(assignation: assignation, status: 0).any?
  end
end
