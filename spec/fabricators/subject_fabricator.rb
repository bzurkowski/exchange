SUBJECT_NAMES = %w(Math Physics Distributed\ systems OS Erlang Internet\ of\ Things)

Fabricator(:subject) do
  name { sequence(:subject_name) { |i| "#{SUBJECT_NAMES.sample} #{i}" } }
end
