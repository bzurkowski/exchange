def demand_for_term(offer:, term:)
  offer.demands.select { |demand| demand.term == term }.first
end

shared_context "simple offer context" do
  # Here is defined simple situation with four terms and three offers
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

shared_context "complex offer context" do
  # Here is defined situation with three terms and with three offers, each demanding other
  # two terms.
  # If we name available terms as A..C (terms[0..2]), following offers are defined:
  #   A -> B or C      -  a_offer
  #   B -> A or C      -  b_offer
  #   C -> A or B      -  c_offer
  # Graph created for this subject contains five cycles:
  #   A -> B
  #   B -> C
  #   C -> A
  #   A -> B -> C
  #   A -> C -> B

  let!(:test_subject) { Fabricate(:subject) }
  let!(:terms) { Fabricate.times(3, :term, subject: test_subject) }
  let(:assignations) do
    terms.map { |term| Fabricate(:assignation, term: term) }
  end

  let(:a_offer) { Fabricate(:offer, assignation: assignations[0], requested_terms: [terms[1], terms[2]]) }
  let(:b_offer) { Fabricate(:offer, assignation: assignations[1], requested_terms: [terms[0], terms[2]]) }
  let(:c_offer) { Fabricate(:offer, assignation: assignations[2], requested_terms: [terms[0], terms[1]]) }

  let(:valid_proposed_exchanges) do
    [
      [{ offer: a_offer, term: terms[1] }, { offer: b_offer, term: terms[0] }],
      [{ offer: b_offer, term: terms[2] }, { offer: c_offer, term: terms[1] }],
      [{ offer: c_offer, term: terms[0] }, { offer: a_offer, term: terms[2] }],
      [{ offer: a_offer, term: terms[1] }, { offer: b_offer, term: terms[2] }, { offer: c_offer, term: terms[0] }],
      [{ offer: a_offer, term: terms[2] }, { offer: c_offer, term: terms[1] }, { offer: b_offer, term: terms[0] }],
    ].map do |exchange_contents|
      exchange = ProposedExchange.new subject: test_subject
      exchange_contents.each do |pair|
        exchange.demands << demand_for_term(offer: pair[:offer], term: pair[:term])
      end
      exchange
    end
  end
end
