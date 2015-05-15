class AssignationDecorator < Draper::Decorator
  delegate_all

  def display_name
    "#{object.schedule.user.username}: #{object.term.display_name}"
  end

  def term
    object.term.decorate
  end
end
