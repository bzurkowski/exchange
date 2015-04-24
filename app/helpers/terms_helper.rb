module TermsHelper
  def day_name(day_num)
    t(:"date.day_names")[day_num].to_s
  end

  def term_position(term)
    start_time = term.starts_at
    minutes = (start_time.hour - 6) * 60 + start_time.min

    (minutes / 5) * 5
  end

  def term_time_range(term)
    "#{term.starts_at.strftime("%H:%M")} - #{term.ends_at.strftime("%H:%M")}"
  end
end
