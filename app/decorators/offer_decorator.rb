class OfferDecorator < Draper::Decorator
  delegate_all

  def display_name
    assignation.display_name
  end

  def user
    assignation.schedule.user
  end

  def assignation
    object.assignation.decorate
  end

  def subject
    term.subject
  end

  def term
    object.assignation.term.decorate
  end
end
