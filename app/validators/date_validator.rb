class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_date_range?(value, record.try(options[:before]))
      record.errors.add(attribute, options[:message] || :invalid)
    end
  end

  private

  def valid_date_range?(start_date, end_date)
    start_date && end_date && start_date < end_date
  end
end
