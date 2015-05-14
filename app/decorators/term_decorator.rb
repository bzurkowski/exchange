class TermDecorator < Draper::Decorator
  delegate_all

  TIME_UNIT   = Settings.schedule.time_unit
  CELL_HEIGHT = Settings.schedule.cell_height

  START_HOUR  = Settings.schedule.start_hour

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
    minutes_from_beginning / TIME_UNIT * CELL_HEIGHT
  end

  def height
    duration_in_minutes / TIME_UNIT * CELL_HEIGHT
  end

  private

  def duration_in_minutes
    duration = (object.ends_at - object.starts_at) / 1.minute
    duration.round
  end

  def minutes_from_beginning
    start_time = object.starts_at

    (start_time.hour - START_HOUR) * 60 + start_time.min
  end
end
