class Filters::Offer
  attr_accessor :subject_id, :user, :active, :user_subjects

  def initialize(user: nil, subject_id: nil, active: true)
    self.subject_id = subject_id
    self.user       = user
    self.active     = active
  end

  def scope
    result = Offer.all
    result = result.active                    if active
    result = result.by_subject(subject_id)    if subject_id.present?
    result = result.by_subject(user_subjects) if user
    result
  end

  def user_subjects
    Subject.where(id: user.schedules.joins(terms: :subject).select(:subject_id).map(&:subject_id)) if user
  end
end
