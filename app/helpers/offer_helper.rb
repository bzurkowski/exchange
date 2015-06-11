module OfferHelper
  def user_assignations(user)
    assignations = Assignation.joins(schedule: :user).where(schedules: { user_id: user }).includes(term: :subject)
    assignations.map { |a| [a.term.decorate.display_name, a.id, { subject_id: a.term.subject_id}] }
  end

  def available_terms(user)
    user_subjects = Subject.select(:id).joins(terms: { assignations: :schedule }).where(schedules: { user_id: user.id })
    terms = Term.joins(assignations: :schedule)
      .where(subject_id: user_subjects)
      .where.not(schedules: { user_id: user.id })
      .includes(:subject)
    terms.decorate

    terms.map { |term| [term.display_name, term.id, { subject_id: term.subject_id }]}
  end
end
