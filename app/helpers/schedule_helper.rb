module ScheduleHelper
  def day_name(day_num)
    t(:"date.day_names")[day_num].to_s
  end
end
