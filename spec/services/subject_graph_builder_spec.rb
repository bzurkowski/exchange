require "rails_helper"

describe SubjectGraphBuilder do
  subject { described_class.build subject: test_subject }

  let(:test_subject) { Fabricate(:subject, name: "Testowy") }
  let!(:terms) { Fabricate.times(3, :term, subject: test_subject) }

  before do
    other_subject = Fabricate(:subject)
    other_terms = Fabricate.times(2, :term, subject: other_subject)
    assignations = Fabricate.times(3, :assignation, term: other_terms.sample)
    assignations.each do |assignation|
      available_terms = other_terms - [assignation.term]
      Fabricate(:offer, assignation: assignation, wanted_terms: available_terms)
    end
  end

  context "when there are no offers for particular subject" do
    it "chooses correct terms" do
      expect(subject.vertices).to match_array terms
    end

    it "finds no possible edges" do
      expect(subject.edges).to eq []
    end
  end

  context "when there are two complimentary offers" do
    let!(:first_assignation) { Fabricate(:assignation, term: terms[0]) }
    let!(:first_offer) { Fabricate(:offer, assignation: first_assignation, wanted_terms: [terms[1]]) }
    let!(:second_assignation) { Fabricate(:assignation, term: terms[1]) }
    let!(:second_offer) { Fabricate(:offer, assignation: second_assignation, wanted_terms: [terms[0]]) }

    it "finds two opposite edges" do
      expect(subject.edges).to match_array [
        { demand: first_offer.demands[0], head: terms[0], tail: terms[1] },
        { demand: second_offer.demands[0], head: terms[1], tail: terms[0] }
      ]
    end
  end
end
