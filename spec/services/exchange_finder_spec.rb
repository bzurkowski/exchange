require "shared/exchange_context"

describe ExchangeFinder do
  let(:graph) { SubjectGraphBuilder.build subject: test_subject }
  subject { described_class.new(graph: graph).exchanges }

  context "when there is one potential exchange" do
    include_context "simple offer context"

    before do
      a_bd_offer
      b_cd_offer
      c_a_offer
    end

    it "proposes valid exchange" do
      expect(subject.size).to eq 1
      expect(subject.map(&:valid?).all?).to eq true
    end
  end

  context "when there are multiple potential exchanges" do
    include_context "complex offer context"

    before do
      a_offer
      b_offer
      c_offer
    end

    it "proposes valid exchanges" do
      expect(subject.size).to eq 5
      expect(subject.map(&:valid?).all?).to eq true

      sorted_exchange_demand_ids = subject.map { |exchange| exchange.demand_ids.sort }
      expect(sorted_exchange_demand_ids).to match_array valid_proposed_exchanges.map { |exchange| exchange.demand_ids.sort }
    end
  end
end
