require "shared/exchange_context"

describe ExchangeFinder do
  include_context "simple offer context"

  let(:graph) { SubjectGraphBuilder.build subject: test_subject }
  subject { described_class.new(graph: graph).exchanges }

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
