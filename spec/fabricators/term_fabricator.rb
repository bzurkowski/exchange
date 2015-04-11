Fabricator(:term) do
  subject
  instructor
  starts_at   Faker::Time.between(2.days.ago, Time.now, :day).beginning_of_hour
  ends_at     { |attrs| attrs[:starts_at] + 2.hours }
  description Faker::Lorem.sentence
end
