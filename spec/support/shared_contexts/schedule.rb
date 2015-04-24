shared_context "schedule" do
  let!(:schedule) { Fabricate(:schedule) }

  let!(:terms) do
    [
      Fabricate(:term, starts_at: Time.new(2015, 4, 6, 8, 0)),
      Fabricate(:term, starts_at: Time.new(2015, 4, 6, 14, 40)),
      Fabricate(:term, starts_at: Time.new(2015, 4, 7, 9, 0)),
      Fabricate(:term, starts_at: Time.new(2015, 4, 7, 9, 35)),
      Fabricate(:term, starts_at: Time.new(2015, 4, 8, 12, 50)),
      Fabricate(:term, starts_at: Time.new(2015, 4, 10, 16, 10))
    ]
  end

  before do
    schedule.terms = terms
    schedule.save!
  end
end
