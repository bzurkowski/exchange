Fabricator(:offer) do
  transient :wanted_terms
  assignation

  after_build do |offer, transients|
    if transients[:wanted_terms].present?
      transients[:wanted_terms].each do |term|
        offer.demands << Fabricate.build(:demand, offer: offer, term: term)
      end
    else
      offer.demands << Fabricate.build(:demand, offer: offer, term: Fabricate(:term, subject: offer.assignation.term.subject))
    end
  end
end
