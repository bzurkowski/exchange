require "rails_helper"

describe ScheduleFetcher do
  describe "#initialize" do
    context "when schedule_id not specified" do
      subject { described_class.new nil }

      it "raises an error" do
        expect { subject }.to raise_error ArgumentError, "Missing schedule_id"
      end
    end
  end

  describe "#fetch" do
    include_context "schedule"

    let(:schedule_fetcher) { described_class.new schedule.id }

    context "with default range" do
      subject { schedule_fetcher.fetch }

      let(:expected_schedule_hash) do
        {
          1 => [terms[0], terms[1]],
          2 => [terms[2], terms[3]],
          3 => [terms[4]],
          4 => [],
          5 => [terms[5]]
        }
      end

      it "fetches schedule days from monday to friday" do
        expect(subject).to eq expected_schedule_hash
      end
    end

    context "with given range" do
      subject { schedule_fetcher.fetch 2..4 }

      let(:expected_schedule_hash) do
        {
          2 => [terms[2], terms[3]],
          3 => [terms[4]],
          4 => []
        }
      end

      it "skips schedule days out of range" do
        expect(subject).to eq expected_schedule_hash
      end
    end
  end

  describe "#fetch_day" do
    include_context "schedule"

    let(:schedule_fetcher) { described_class.new schedule.id }

    subject { schedule_fetcher.fetch_day 2 }

    it "fetches proper schedule day" do
      expect(subject).to eq [terms[2], terms[3]]
    end
  end
end
