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

  def subject_name
    object.subject.name
  end

  def instructor_name
    object.instructor.name
  end

  def time_range
    [object.starts_at, object.ends_at].map { |time| time.strftime("%H:%M") }.join(" - ")
  end

  def color
    object.subject.color
  end

  def position
    start_time = object.starts_at

    minutes = (start_time.hour - 6) * 60 + start_time.min

    (minutes / 5) * 5
  end

  def height
      duration_in_minutes / 5 * 5  # TODO: config for cell height & time unit
  end

  private

  def duration_in_minutes
      duration = (object.ends_at - object.starts_at) / 1.minute
      duration.round
  end
end
