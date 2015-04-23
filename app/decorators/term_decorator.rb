class TermDecorator < Draper::Decorator
  delegate_all

  def display_name
    "#{object.subject.name}: #{starts_at} - #{ends_at}"
  end

  def starts_at
    I18n.l(object.starts_at, format: "%A, %H:%M")
  end

  def ends_at
    I18n.l(object.ends_at, format: "%A, %H:%M")
  end
end
