Fabricator(:schedule) do
end

Fabricator(:schedule_with_terms, from: :schedule) do
  transient num_terms: 3

  after_create do |schedule, transients|
    transients[:num_terms].to_i.times do
      Fabricate(:assignation, schedule: schedule)
    end
  end
end
