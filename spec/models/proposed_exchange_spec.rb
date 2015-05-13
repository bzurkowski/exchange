require "shared/exchange_context"

describe ProposedExchange do
  describe "associations" do
    it { should have_many :proposed_exchange_demands }
    it { should have_many(:demands).through(:proposed_exchange_demands) }
  end

  describe "valid exchange validation" do
    include_context "simple offer context"

    subject { described_class.new subject: test_subject }

    context "when exchange includes incompatible demands" do
      before do
        [a_bd_offer, b_cd_offer].each do |offer|
          subject.demands << demand_for_term(offer: offer, term: terms[3])
        end
      end

      it { should_not be_valid }
    end

    context "when exchange includes compatible demands" do
      subject { valid_proposed_exchange }
      it { should be_valid }
    end
  end

  describe "#accept" do
    include_context "simple offer context"

    let(:exchange) { valid_proposed_exchange }
    let(:associated_user) { a_bd_offer.assignation.schedule.user }
    let(:associated_demand) { demand_for_term(offer: a_bd_offer, term: terms[1]) }
    let(:proposed_exchange_demand) { exchange.proposed_exchange_demands.where(demand: associated_demand).first }
    let(:other_user) { Fabricate(:user) }

    before do
      a_bd_offer
      b_cd_offer
      c_a_offer
      exchange.save
    end

    context "when user participates in exchange" do
      subject { exchange.accept(user: associated_user) }
      it "should change status of associated_user's demand" do
        expect { subject }.to change { proposed_exchange_demand.reload.status }.from("proposed").to("accepted")
      end
    end

    context "when user doesn't participates in exchange" do
      subject { exchange.accept(user: other_user) }
      it "should change status of associated_user's demand" do
        expect { subject }.to raise_error
      end
    end
  end

  describe "#accept?", pending: true do
    # TODO: #accept? spec
  end

  def demand_for_term(offer:, term:)
    offer.demands.select { |demand| demand.term == term }.first
  end
end
