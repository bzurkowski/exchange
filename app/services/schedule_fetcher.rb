class ScheduleFetcher
  attr_reader :schedule_id

  def initialize(schedule_id)
    raise ArgumentError.new "Missing schedule_id" unless schedule_id

    @schedule_id = schedule_id
  end

  def fetch(range = 1..5)
    Hash[range.map { |i| [i, fetch_day(i)] }]
  end

  def fetch_day(day_num)
    return [] unless schedule

    terms = schedule.terms.select { |term| term.starts_at.wday == day_num }
    terms.map(&:decorate)
  end

  private

  def schedule
    @schedule ||= Schedule.find_by_id(schedule_id)
  end
end
