shared_context "simple offer context" do
  # In this file is defined simple situation with four terms and three offers
  # If we name available terms as A..D (terms[0..3]), following offers are defined:
  #   A -> B or D      -  a_bd_offer
  #   B -> C or D      -  b_cd_offer
  #   C -> A           -  c_a_offer
  # Graph created for this subject contains one cycle, and thus one possible exchange:
  #   A -> B -> C

  let!(:test_subject) { Fabricate(:subject) }
  let!(:terms) { Fabricate.times(4, :term, subject: test_subject) }
  let(:assignations) do
    terms.map { |term| Fabricate(:assignation, term: term) }
  end

  let(:a_bd_offer) { Fabricate(:offer, assignation: assignations[0], requested_terms: [terms[1], terms[3]]) }
  let(:b_cd_offer) { Fabricate(:offer, assignation: assignations[1], requested_terms: [terms[2], terms[3]]) }
  let(:c_a_offer)  { Fabricate(:offer, assignation: assignations[2], requested_terms: [terms[0]]) }

  let(:valid_proposed_exchange) do
    proposed_exchange = ProposedExchange.new subject: test_subject
    proposed_exchange.demands << demand_for_term(offer: a_bd_offer, term: terms[1])
    proposed_exchange.demands << demand_for_term(offer: b_cd_offer, term: terms[2])
    proposed_exchange.demands << demand_for_term(offer: c_a_offer,  term: terms[0])
    proposed_exchange
  end
end
